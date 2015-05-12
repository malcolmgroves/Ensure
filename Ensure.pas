{****************************************************}
{                                                    }
{  Ensure                                            }
{                                                    }
{  Copyright (C) 2014 Malcolm Groves                 }
{                                                    }
{  http://www.malcolmgroves.com                      }
{                                                    }
{****************************************************}
{                                                    }
{  This Source Code Form is subject to the terms of  }
{  the Mozilla Public License, v. 2.0. If a copy of  }
{  the MPL was not distributed with this file, You   }
{  can obtain one at                                 }
{                                                    }
{  http://mozilla.org/MPL/2.0/                       }
{                                                    }
{****************************************************}

unit Ensure;

interface
uses
  SysUtils;

type
  // Exceptions
  EEnsureException = class(Exception);
  EEnsureInstanceException = class(EEnsureException);
  EEnsureStringException = class(EEnsureException);
  EEnsurePathException = class(EEnsureException)
  private
    FPath : string;
  public
    constructor Create(Path : string); reintroduce;
    property Path : string read FPath;
  end;
  EEnsureDateException = class(EEnsureException);
  EEnsureIntegerException = class(EEnsureException);

  TClassInstanceTests<T : class> = record
  private
    FSubject : T;
    FSubjectName : string;
  public
    constructor Create(const Subject : T; const Name : string);
    function IsAssigned : T;
  end;

  TInterfaceInstanceTests<T : IInterface> = record
  private
    FSubject : T;
    FSubjectName : string;
  public
    constructor Create(const Subject : T; const Name : string);
    function IsAssigned : T;
  end;

  TStringTests = record
  private
    FSubject : string;
    FSubjectName : string;
  public
    constructor Create(const Subject : string; const Name : string);
    function NotEmpty : string;
  end;

  TIntegerTests = record
  private
    FSubject : Integer;
    FSubjectName : string;
  public
    constructor Create(const Subject : Integer; const Name : string);
    function InRange(const Low, High : Integer) : Integer;
  end;

  TDateTimeTests = record
  private
    FSubject : TDateTime;
    FSubjectName : string;
  public
    constructor Create(const DateTime : TDateTime; const Name : string);
    function NotLaterThan(const Comparitor : TDateTime; const Name : string = 'Comparitor'): TDateTime;
  end;

  TDirectoryTests = record
  private
    FSubject : string;
    FSubjectName : string;
  public
    constructor Create(const Path : string; const Name : string);
    function Exists : string;
    function IsEmpty : string;
  end;

  TEnsure = class
  public
    class function ClassInstanceOf<T : class>(Subject : T; const Name : string = '') : TClassInstanceTests<T>;
    class function InterfaceInstanceOf<T : IInterface>(Subject : T; const Name : string = 'Subject') : TInterfaceInstanceTests<T>;
    class function &String(const Subject : string; const Name : string = 'Subject'): TStringTests;
    class function DateTime(const Subject : TDateTime; const Name : string = 'Subject') : TDateTimeTests;
    class function Directory(const Path : string; const Name : string = 'Subject'): TDirectoryTests;
    class function Integer(const Subject : Integer; const Name : string = 'Subject'): TIntegerTests;
  end;

implementation
uses
  IOUtils, System.DateUtils, System.Types;


{ Ensure }


class function TEnsure.ClassInstanceOf<T>(Subject : T; const Name : string) : TClassInstanceTests<T>;
var
  LName : string;
begin
  if Name = '' then
    LName := T.Classname
  else
    LName := Name;
  Result := TClassInstanceTests<T>.Create(Subject, LName);
end;

class function TEnsure.&String(const Subject : string; const Name : string) : TStringTests;
begin
  Result := TStringTests.Create(Subject, Name);
end;

class function TEnsure.DateTime(const Subject : TDateTime; const Name : string) : TDateTimeTests;
begin
  Result := TDateTimeTests.Create(Subject, Name);
end;

class function TEnsure.Directory(const Path : string; const Name : string): TDirectoryTests;
begin
  Result := TDirectoryTests.Create(Path, Name);
end;


class function TEnsure.Integer(const Subject: Integer;
  const Name: string): TIntegerTests;
begin
  Result := TIntegerTests.Create(Subject, Name);
end;

class function TEnsure.InterfaceInstanceOf<T>(Subject: T;
  const Name: string): TInterfaceInstanceTests<T>;
begin
  Result := TInterfaceInstanceTests<T>.Create(Subject, Name);
end;

constructor TClassInstanceTests<T>.Create(const Subject: T; const Name: string);
begin
  FSubject := Subject;
  FSubjectName := Name;
end;


{ TStringTests }

constructor TStringTests.Create(const Subject: string; const Name : string);
begin
  FSubject := Subject;
  FSubjectName := Name;
end;

function TStringTests.NotEmpty: string;
begin
  if FSubject = '' then
    raise EEnsureStringException.Create(Format('%s is an empty string', [FSubjectName]));

  Result := FSubject;
end;

{ TPathTests }

constructor TDirectoryTests.Create(const Path, Name: string);
begin
  FSubject := Path;
  FSubjectName := Name;
end;

function TDirectoryTests.Exists: string;
begin
  if not TDirectory.Exists(FSubject) then
    raise EEnsurePathException.Create(Format('%s does not exist : %s', [FSubjectName, FSubject]));

  Result := FSubject;
end;

{ TInstanceTests }


function TDirectoryTests.IsEmpty: string;
begin
  if not TDirectory.Exists(FSubject) then
    raise EEnsurePathException.Create(Format('%s is not empty : %s', [FSubjectName, FSubject]));

  Result := FSubject;

end;

{ TDateTimeTests }

constructor TDateTimeTests.Create(const DateTime: TDateTime; const Name : string);
begin
  FSubject := DateTime;
  FSubjectName := Name;
end;


function TDateTimeTests.NotLaterThan(const Comparitor: TDateTime; const Name: string): TDateTime;
begin
  if CompareDate(FSubject, Comparitor) = GreaterThanValue then
    raise EEnsureDateException.Create(Format('%s (%s) is Later Than %s (%s)',
                                           [FSubjectName,  DateToStr(FSubject),
                                           Name, DateToStr(Comparitor)]));

  Result := FSubject;
end;

function TClassInstanceTests<T>.IsAssigned: T;
begin
  if not Assigned(FSubject) then
    raise EEnsureInstanceException.Create(Format('%s is nil', [FSubjectName]));

  Result := FSubject;
end;

{ EEnsurePathException }

constructor EEnsurePathException.Create(Path: string);
begin
  inherited Create('Path not found : ' + Path);
  FPath := Path;
end;

{ TInterfaceInstanceTests<T> }

constructor TInterfaceInstanceTests<T>.Create(const Subject: T;
  const Name: string);
begin
  FSubject := Subject;
  FSubjectName := Name;
end;

function TInterfaceInstanceTests<T>.IsAssigned: T;
begin
  if not Assigned(FSubject) then
    raise EEnsureInstanceException.Create(Format('%s is nil', [FSubjectName]));

  Result := FSubject;
end;

{ TIntegerTests }

constructor TIntegerTests.Create(const Subject: Integer; const Name: string);
begin
  FSubject := Subject;
  FSubjectName := Name;
end;

function TIntegerTests.InRange(const Low, High: Integer): Integer;
begin
  if (Low > FSubject) or (High < FSubject) then
    raise EEnsureIntegerException.Create(Format('%s(%d) is outside range Low(%d) to High(%d)',
                                                [FSubjectName, FSubject, Low, High]));

  Result := FSubject;
end;

end.
