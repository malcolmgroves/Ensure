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
  SysUtils, Generics.Collections, System.Classes;

type
  // Exceptions
  EEnsureException = class(Exception);
  EEnsureObjectException = class(EEnsureException);
  EEnsureListException = class(EEnsureException);
  EEnsureInterfaceException = class(EEnsureException);
  EEnsureStringException = class(EEnsureException);
  EEnsureFileSystemException = class(EEnsureException)
  private
    FPath : string;
  public
    constructor Create(Path : string); reintroduce;
    property Path : string read FPath;
  end;
  EEnsureDateTimeException = class(EEnsureException);
  EEnsureIntegerException = class(EEnsureException);
  EEnsureTStringsException = class(EEnsureException);
  EEnsureBooleanException = class(EEnsureException);

{$RTTI EXPLICIT METHODS([]) PROPERTIES([]) FIELDS([])}
  TObjectTests<T : class> = record
  private
    FSubject : T;
    FSubjectName : string;
  public
    constructor Create(const Subject : T; const Name : string);
    function IsAssigned : T;
    function IsA<TSuperType : class> : T;
  end;

{$RTTI EXPLICIT METHODS([]) PROPERTIES([]) FIELDS([])}
  TInterfaceTests<T : IInterface> = record
  private
    FSubject : T;
    FSubjectName : string;
  public
    constructor Create(const Subject : T; const Name : string);
    function IsAssigned : T;
  end;

{$RTTI EXPLICIT METHODS([]) PROPERTIES([]) FIELDS([])}
  TStringTests = record
  private
    FSubject : string;
    FSubjectName : string;
  public
    constructor Create(const Subject : string; const Name : string);
    function NotEmpty : string;
    function LengthEqualTo(Length : Integer) : string;
    function LengthGreaterThanOrEqualsTo(Length : Integer) : string;
    function LengthGreaterThan(Length : Integer) : string;
    function LengthLessThanOrEqualsTo(Length : Integer) : string;
    function LengthLessThan(Length : Integer) : string;
    function LengthBetween(const Low, High : Integer) : string;
    function StartsWith(const Prefix : string; const IgnoreCase : boolean = False) : string;
    function EndsWith(const Suffix : string; const IgnoreCase : boolean = False) : string;
    function Contains(const Substring : string; const IgnoreCase : boolean = False) : string;
  end;

{$RTTI EXPLICIT METHODS([]) PROPERTIES([]) FIELDS([])}
  TIntegerTests = record
  private
    FSubject : Integer;
    FSubjectName : string;
  public
    constructor Create(const Subject : Integer; const Name : string);
    function IsZero : Integer;
    function IsNotZero : Integer;
    function IsPositive : Integer;
    function IsNegative : Integer;
    function Between(const Low, High : Integer) : Integer;
    function LessThan(const Comparitor : Integer) : Integer;
    function LessThanOrEqualTo(const Comparitor : Integer) : Integer;
    function GreaterThan(const Comparitor : Integer) : Integer;
    function GreaterThanOrEqualTo(const Comparitor : Integer) : Integer;
    function EqualTo(const Comparitor : Integer) : Integer;
  end;

{$RTTI EXPLICIT METHODS([]) PROPERTIES([]) FIELDS([])}
  TBooleanTests = record
  private
    FSubject : Boolean;
    FSubjectName : string;
  public
    constructor Create(const Subject : Boolean; const Name : string);
    function IsTrue : Boolean;
    function IsFalse : Boolean;
  end;


{$RTTI EXPLICIT METHODS([]) PROPERTIES([]) FIELDS([])}
  TDateTimeTests = record
  private
    FSubject : TDateTime;
    FSubjectName : string;
  public
    constructor Create(const DateTime : TDateTime; const Name : string);
    function NotLaterThan(const Comparitor : TDateTime; const Name : string = 'Comparitor'): TDateTime;
    function Same(const Comparitor : TDateTime; const Name : string = 'Comparitor'): TDateTime;
    function InThePast : TDateTime;
    function InTheFuture : TDateTime;
  end;

{$RTTI EXPLICIT METHODS([]) PROPERTIES([]) FIELDS([])}
  TDateTests = record
  private
    FSubject : TDate;
    FSubjectName : string;
  public
    constructor Create(const Date : TDate; const Name : string);
    function NotLaterThan(const Comparitor : TDate; const Name : string = 'Comparitor'): TDate;
    function Same(const Comparitor : TDate; const Name : string = 'Comparitor'): TDate;
    function InThePast : TDate;
    function InTheFuture : TDate;
  end;

{$RTTI EXPLICIT METHODS([]) PROPERTIES([]) FIELDS([])}
  TTimeTests = record
  private
    FSubject : TTime;
    FSubjectName : string;
  public
    constructor Create(const Time : TTime; const Name : string);
    function Same(const Comparitor : TTime; const Name : string = 'Comparitor'): TTime;
    function NotLaterThan(const Comparitor : TTime; const Name : string = 'Comparitor'): TTime;
    function InThePast : TTime;
    function InTheFuture : TTime;
  end;

{$RTTI EXPLICIT METHODS([]) PROPERTIES([]) FIELDS([])}
  TDirectoryTests = record
  private
    FSubject : string;
    FSubjectName : string;
  public
    constructor Create(const Path : string; const Name : string);
    function Exists : string;
    function IsEmpty : string;
    function NotEmpty : string;
  end;

{$RTTI EXPLICIT METHODS([]) PROPERTIES([]) FIELDS([])}
  TFileTests = record
  private
    FSubject : string;
    FSubjectName : string;
  public
    constructor Create(const Path : string; const Name : string);
    function Exists : string;
    function HasExtension(const Extension : string): string;
    function IsEmpty : string;
    function NotEmpty : string;
  end;

{$RTTI EXPLICIT METHODS([]) PROPERTIES([]) FIELDS([])}
  TListTests<T> = record
  private
    FSubject : TList<T>;
    FSubjectName : string;
  public
    constructor Create(const Subject : TList<T>; const Name : string);
    function IsEmpty : TList<T>;
    function IsNotEmpty : TList<T>;
  end;

{$RTTI EXPLICIT METHODS([]) PROPERTIES([]) FIELDS([])}
  TTStringsTests = record
  private
    FSubject : TStrings;
    FSubjectName : string;
  public
    constructor Create(const Subject : TStrings; const Name : string);
    function IsEmpty : TStrings;
    function IsNotEmpty : TStrings;
  end;

{$RTTI EXPLICIT METHODS([]) PROPERTIES([]) FIELDS([])}
  TEnsure = class
  public
    class function &Object<T : class>(Subject : T; const Name : string = 'Class') : TObjectTests<T>;
    class function &Interface<T : IInterface>(Subject : T; const Name : string = 'Interface') : TInterfaceTests<T>;
    class function &String(const Subject : string; const Name : string = 'String'): TStringTests;
    class function DateTime(const Subject : TDateTime; const Name : string = 'DateTime') : TDateTimeTests;
    class function Date(const Subject : TDate; const Name : string = 'Date') : TDateTests;
    class function Time(const Subject : TTime; const Name : string = 'Time') : TTimeTests;
    class function Directory(const Path : string; const Name : string = 'Directory'): TDirectoryTests;
    class function &File(const Path : string; const Name : string = 'File'): TFileTests;
    class function Integer(const Subject : Integer; const Name : string = 'Integer'): TIntegerTests;
    class function List<T>(Subject : TList<T>; const Name : string = 'List') : TListTests<T>;
    class function TStrings(const Subject : TStrings; const Name : string = 'TStrings'): TTStringsTests;
    class function Boolean(const Subject : Boolean; const Name : string = 'Boolean'): TBooleanTests;
  end;

const
  RespectCase = False;
  IgnoreCase = True;


implementation
uses
  IOUtils, System.DateUtils, System.Types;


{ Ensure }


class function TEnsure.&Object<T>(Subject : T; const Name : string) : TObjectTests<T>;
var
  LName : string;
begin
  if Name = '' then
    LName := T.Classname
  else
    LName := Name;
  Result := TObjectTests<T>.Create(Subject, LName);
end;

class function TEnsure.&String(const Subject : string; const Name : string) : TStringTests;
begin
  Result := TStringTests.Create(Subject, Name);
end;

class function TEnsure.Time(const Subject: TTime;
  const Name: string): TTimeTests;
begin
  Result := TTimeTests.Create(Subject, Name);
end;

class function TEnsure.TStrings(const Subject: TStrings;
  const Name: string): TTStringsTests;
var
  LName : string;
begin
  if Name = '' then
    LName := Subject.Classname
  else
    LName := Name;
  Result := TTStringsTests.Create(Subject, LName);
end;

class function TEnsure.Boolean(const Subject: Boolean;
  const Name: string): TBooleanTests;
begin
  Result := TBooleanTests.Create(Subject, Name);
end;

class function TEnsure.Date(const Subject: TDate;
  const Name: string): TDateTests;
begin
  Result := TDateTests.Create(Subject, Name);
end;

class function TEnsure.DateTime(const Subject : TDateTime; const Name : string) : TDateTimeTests;
begin
  Result := TDateTimeTests.Create(Subject, Name);
end;

class function TEnsure.Directory(const Path : string; const Name : string): TDirectoryTests;
begin
  Result := TDirectoryTests.Create(Path, Name);
end;

class function TEnsure.&File(const Path : string; const Name : string): TFileTests;
begin
  Result := TFileTests.Create(Path, Name);
end;

class function TEnsure.Integer(const Subject: Integer;
  const Name: string): TIntegerTests;
begin
  Result := TIntegerTests.Create(Subject, Name);
end;

class function TEnsure.&Interface<T>(Subject: T;
  const Name: string): TInterfaceTests<T>;
begin
  Result := TInterfaceTests<T>.Create(Subject, Name);
end;

class function TEnsure.List<T>(Subject: TList<T>; const Name: string): TListTests<T>;
var
  LName : string;
begin
  if Name = '' then
    LName := Subject.Classname
  else
    LName := Name;
  Result := TListTests<T>.Create(Subject, LName);
end;

constructor TObjectTests<T>.Create(const Subject: T; const Name: string);
begin
  FSubject := Subject;
  FSubjectName := Name;
end;


{ TStringTests }

function TStringTests.StartsWith(const Prefix: string; const IgnoreCase : boolean): string;
begin
  if not (FSubject.StartsWith(Prefix, IgnoreCase)) then
    raise EEnsureStringException.Create(Format('%s does not start with %s (Ignore Case = %s)', [FSubjectName, Prefix, IgnoreCase.ToString]));

  Result := FSubject;
end;

function TStringTests.Contains(const Substring: string; const IgnoreCase : boolean): string;
begin
  if IgnoreCase then
  begin
    if not (UpperCase(FSubject).Contains(UpperCase(Substring))) then
      raise EEnsureStringException.Create(Format('%s does not contain with %s (Ignore Case = True)', [FSubjectName, Substring]));
  end
  else
    if not (FSubject.Contains(Substring)) then
      raise EEnsureStringException.Create(Format('%s does not contain with %s (Ignore Case = False)', [FSubjectName, Substring]));

  Result := FSubject;
end;

constructor TStringTests.Create(const Subject: string; const Name : string);
begin
  FSubject := Subject;
  FSubjectName := Name;
end;

function TStringTests.EndsWith(const Suffix: string; const IgnoreCase : boolean): string;
begin
  if not (FSubject.EndsWith(Suffix, IgnoreCase)) then
    raise EEnsureStringException.Create(Format('%s does not end with %s (Ignore Case = %s)', [FSubjectName, Suffix, IgnoreCase.ToString]));

  Result := FSubject;
end;

function TStringTests.LengthBetween(const Low, High: Integer): string;
begin
  if not ((Low <= FSubject.Length) and (High >= FSubject.Length)) then
    raise EEnsureStringException.Create(Format('%s(%d) is not between Low(%d) to High(%d)',
                                                [FSubjectName, FSubject, Low, High]));

  Result := FSubject;
end;

function TStringTests.LengthEqualTo(Length: Integer): string;
begin
  if not (FSubject.Length = Length) then
    raise EEnsureStringException.Create(Format('%s is not length %d', [FSubjectName, Length]));

  Result := FSubject;
end;

function TStringTests.LengthGreaterThan(Length: Integer): string;
begin
  if not (FSubject.Length > Length) then
    raise EEnsureStringException.Create(Format('%s is not at least length %d', [FSubjectName, Length]));

  Result := FSubject;
end;

function TStringTests.LengthGreaterThanOrEqualsTo(Length: Integer): string;
begin
  if not (FSubject.Length >= Length) then
    raise EEnsureStringException.Create(Format('%s is not at least length %d', [FSubjectName, Length]));

  Result := FSubject;
end;

function TStringTests.LengthLessThan(Length: Integer): string;
begin
  if not (FSubject.Length < Length) then
    raise EEnsureStringException.Create(Format('%s is not at most length %d', [FSubjectName, Length]));

  Result := FSubject;
end;

function TStringTests.LengthLessThanOrEqualsTo(Length: Integer): string;
begin
  if not (FSubject.Length <= Length) then
    raise EEnsureStringException.Create(Format('%s is not at most length %d', [FSubjectName, Length]));

  Result := FSubject;
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
    raise EEnsureFileSystemException.Create(Format('%s does not exist : %s', [FSubjectName, FSubject]));

  Result := FSubject;
end;

{ TInstanceTests }


function TDirectoryTests.IsEmpty: string;
begin
  if not TDirectory.IsEmpty(FSubject) then
    raise EEnsureFileSystemException.Create(Format('%s is not empty : %s', [FSubjectName, FSubject]));

  Result := FSubject;
end;

function TDirectoryTests.NotEmpty: string;
begin
  if TDirectory.IsEmpty(FSubject) then
    raise EEnsureFileSystemException.Create(Format('%s is empty : %s', [FSubjectName, FSubject]));

  Result := FSubject;
end;

{ TDateTimeTests }

constructor TDateTimeTests.Create(const DateTime: TDateTime; const Name : string);
begin
  FSubject := DateTime;
  FSubjectName := Name;
end;


function TDateTimeTests.InTheFuture: TDateTime;
begin
  if FSubject <= Now then
    raise EEnsureDateTimeException.Create(Format('%s (%s) is not in the future',
                                           [FSubjectName,  DateTimeToStr(FSubject)]));

  Result := FSubject;
end;

function TDateTimeTests.InThePast: TDateTime;
begin
  if FSubject >= Now then
    raise EEnsureDateTimeException.Create(Format('%s (%s) is not in the past',
                                           [FSubjectName,  DateTimeToStr(FSubject)]));

  Result := FSubject;
end;

function TDateTimeTests.NotLaterThan(const Comparitor: TDateTime; const Name: string): TDateTime;
begin
  if CompareDate(FSubject, Comparitor) = GreaterThanValue then
    raise EEnsureDateTimeException.Create(Format('%s (%s) is Later Than %s (%s)',
                                           [FSubjectName,  DateTimeToStr(FSubject),
                                           Name, DateTimeToStr(Comparitor)]));

  Result := FSubject;
end;

function TDateTimeTests.Same(const Comparitor: TDateTime;
  const Name: string): TDateTime;
begin
  if not SameDateTime(FSubject, Comparitor) then
    raise EEnsureDateTimeException.Create(Format('%s (%s) is not the same as %s (%s)',
                                           [FSubjectName,  DateTimeToStr(FSubject),
                                           Name, DateTimeToStr(Comparitor)]));

  Result := FSubject;
end;

function TObjectTests<T>.IsA<TSuperType>: T;
begin
  if not T.InheritsFrom(TSuperType) then
    raise EEnsureObjectException.Create(Format('%s(%s) does not descend from %s',
                                                 [FSubjectName,
                                                  T.ClassName,
                                                  TSuperType.ClassName]));

  Result := FSubject;
end;

function TObjectTests<T>.IsAssigned: T;
begin
  if not Assigned(FSubject) then
    raise EEnsureObjectException.Create(Format('%s is nil', [FSubjectName]));

  Result := FSubject;
end;

{ EEnsurePathException }

constructor EEnsureFileSystemException.Create(Path: string);
begin
  inherited Create('Path not found : ' + Path);
  FPath := Path;
end;

{ TInterfaceInstanceTests<T> }

constructor TInterfaceTests<T>.Create(const Subject: T;
  const Name: string);
begin
  FSubject := Subject;
  FSubjectName := Name;
end;

function TInterfaceTests<T>.IsAssigned: T;
begin
  if not Assigned(FSubject) then
    raise EEnsureInterfaceException.Create(Format('%s is nil', [FSubjectName]));

  Result := FSubject;
end;

{ TIntegerTests }

constructor TIntegerTests.Create(const Subject: Integer; const Name: string);
begin
  FSubject := Subject;
  FSubjectName := Name;
end;

function TIntegerTests.EqualTo(const Comparitor: Integer): Integer;
begin
  if not (FSubject = Comparitor) then
    raise EEnsureIntegerException.Create(Format('%s(%d) is not equal to %d',
                                                [FSubjectName, FSubject, Comparitor]));

  Result := FSubject;
end;

function TIntegerTests.GreaterThan(const Comparitor: Integer): Integer;
begin
  if not (FSubject > Comparitor) then
    raise EEnsureIntegerException.Create(Format('%s(%d) is not greater than %d',
                                                [FSubjectName, FSubject, Comparitor]));

  Result := FSubject;
end;

function TIntegerTests.GreaterThanOrEqualTo(const Comparitor: Integer): Integer;
begin
  if not (FSubject >= Comparitor) then
    raise EEnsureIntegerException.Create(Format('%s(%d) is not greater than or equal to %d',
                                                [FSubjectName, FSubject, Comparitor]));

  Result := FSubject;
end;

function TIntegerTests.IsNegative: Integer;
begin
  if not(FSubject < 0) then
    raise EEnsureIntegerException.Create(Format('%s(%d) is not Negative',
                                                [FSubjectName, FSubject]));

  Result := FSubject;
end;

function TIntegerTests.IsNotZero: Integer;
begin
  if not(FSubject <> 0) then
    raise EEnsureIntegerException.Create(Format('%s(%d) is Zero',
                                                [FSubjectName, FSubject]));

  Result := FSubject;
end;

function TIntegerTests.IsPositive: Integer;
begin
  if not(FSubject > 0) then
    raise EEnsureIntegerException.Create(Format('%s(%d) is not Positive',
                                                [FSubjectName, FSubject]));

  Result := FSubject;
end;

function TIntegerTests.IsZero: Integer;
begin
  if not(FSubject = 0) then
    raise EEnsureIntegerException.Create(Format('%s(%d) is not Zero',
                                                [FSubjectName, FSubject]));

  Result := FSubject;
end;

function TIntegerTests.Between(const Low, High: Integer): Integer;
begin
  if not((Low <= FSubject) and (High >= FSubject)) then
    raise EEnsureIntegerException.Create(Format('%s(%d) is not between Low(%d) to High(%d)',
                                                [FSubjectName, FSubject, Low, High]));

  Result := FSubject;
end;

function TIntegerTests.LessThan(const Comparitor: Integer): Integer;
begin
  if not (FSubject < Comparitor) then
    raise EEnsureIntegerException.Create(Format('%s(%d) is not less than %d',
                                                [FSubjectName, FSubject, Comparitor]));

  Result := FSubject;
end;

function TIntegerTests.LessThanOrEqualTo(const Comparitor: Integer): Integer;
begin
  if not (FSubject <= Comparitor) then
    raise EEnsureIntegerException.Create(Format('%s(%d) is not less than or equal to %d',
                                                [FSubjectName, FSubject, Comparitor]));

  Result := FSubject;
end;

{ TFileTests }

constructor TFileTests.Create(const Path, Name: string);
begin
  FSubject := Path;
  FSubjectName := Name;
end;

function TFileTests.Exists: string;
begin
  if not TFile.Exists(FSubject) then
    raise EEnsureFileSystemException.Create(Format('%s does not exist : %s', [FSubjectName, FSubject]));

  Result := FSubject;
end;

function TFileTests.HasExtension(const Extension: string): string;
begin
  if not (TPath.GetExtension(FSubject).ToUpper = Extension.ToUpper) then
    raise EEnsureFileSystemException.Create(Format('%s is does not have extension %s : %s', [FSubjectName, Extension, FSubject]));

  Result := FSubject;
end;

function TFileTests.IsEmpty: string;
begin
//  if not TFile.GetSize(FSubject) = 0 then
//    raise EEnsureFileSystemException.Create(Format('%s is not empty: %s', [FSubjectName, FSubject]));

  Result := FSubject;
end;

function TFileTests.NotEmpty: string;
begin
//  if TFile.GetSize(FSubject) = 0 then
//    raise EEnsureFileSystemException.Create(Format('%s is empty: %s', [FSubjectName, FSubject]));

  Result := FSubject;
end;

{ TListTests<T> }

constructor TListTests<T>.Create(const Subject: TList<T>; const Name: string);
begin
  FSubject := Subject;
  FSubjectName := Name;
end;

function TListTests<T>.IsEmpty: TList<T>;
begin
  if FSubject.Count > 0 then
    raise EEnsureListException.Create(Format('%s is not Empty', [FSubjectName]));

  Result := FSubject;
end;

function TListTests<T>.IsNotEmpty: TList<T>;
begin
  if FSubject.Count = 0 then
    raise EEnsureListException.Create(Format('%s is Empty', [FSubjectName]));

  Result := FSubject;
end;

{ TTStringsTests }

constructor TTStringsTests.Create(const Subject: TStrings; const Name: string);
begin
  FSubject := Subject;
  FSubjectName := Name;
end;

function TTStringsTests.IsEmpty: TStrings;
begin
  if FSubject.Count > 0 then
    raise EEnsureTStringsException.Create(Format('%s is not Empty', [FSubjectName]));

  Result := FSubject;
end;

function TTStringsTests.IsNotEmpty: TStrings;
begin
  if FSubject.Count = 0 then
    raise EEnsureTStringsException.Create(Format('%s is Empty', [FSubjectName]));

  Result := FSubject;
end;

{ TTimeTests }

constructor TTimeTests.Create(const Time: TTime; const Name: string);
begin
  FSubject := Time;
  FSubjectName := Name;
end;

function TTimeTests.InTheFuture: TTime;
begin
  if FSubject <= Now then
    raise EEnsureDateTimeException.Create(Format('%s (%s) is not in the future',
                                           [FSubjectName,  TimeToStr(FSubject)]));

  Result := FSubject;
end;

function TTimeTests.InThePast: TTime;
begin
  if FSubject >= Now then
    raise EEnsureDateTimeException.Create(Format('%s (%s) is not in the past',
                                           [FSubjectName,  TimeToStr(FSubject)]));

  Result := FSubject;
end;

function TTimeTests.NotLaterThan(const Comparitor: TTime;
  const Name: string): TTime;
begin
  if CompareTime(FSubject, Comparitor) = GreaterThanValue then
    raise EEnsureDateTimeException.Create(Format('%s (%s) is Later Than %s (%s)',
                                           [FSubjectName,  TimeToStr(FSubject),
                                           Name, TimeToStr(Comparitor)]));

  Result := FSubject;
end;

function TTimeTests.Same(const Comparitor: TTime;
  const Name: string): TTime;
begin
  if not SameTime(FSubject, Comparitor) then
    raise EEnsureDateTimeException.Create(Format('%s (%s) is not the same as %s (%s)',
                                           [FSubjectName,  TimeToStr(FSubject),
                                           Name, TimeToStr(Comparitor)]));

  Result := FSubject;
end;

{ TDateTests }

constructor TDateTests.Create(const Date: TDate; const Name: string);
begin
  FSubject := Date;
  FSubjectName := Name;
end;

function TDateTests.InTheFuture: TDate;
begin
  if FSubject <= Now then
    raise EEnsureDateTimeException.Create(Format('%s (%s) is not in the future',
                                           [FSubjectName,  DateToStr(FSubject)]));

  Result := FSubject;
end;

function TDateTests.InThePast: TDate;
begin
  if FSubject >= Now then
    raise EEnsureDateTimeException.Create(Format('%s (%s) is not in the past',
                                           [FSubjectName,  DateToStr(FSubject)]));

  Result := FSubject;
end;

function TDateTests.NotLaterThan(const Comparitor: TDate;
  const Name: string): TDate;
begin
  if CompareDate(FSubject, Comparitor) = GreaterThanValue then
    raise EEnsureDateTimeException.Create(Format('%s (%s) is Later Than %s (%s)',
                                           [FSubjectName,  DateToStr(FSubject),
                                           Name, DateToStr(Comparitor)]));

  Result := FSubject;
end;

function TDateTests.Same(const Comparitor: TDate;
  const Name: string): TDate;
begin
  if not SameDate(FSubject, Comparitor) then
    raise EEnsureDateTimeException.Create(Format('%s (%s) is not the same as %s (%s)',
                                           [FSubjectName,  DateToStr(FSubject),
                                           Name, DateToStr(Comparitor)]));

  Result := FSubject;
end;

{ TBooleanTests }

constructor TBooleanTests.Create(const Subject: Boolean;
  const Name: string);
begin
  FSubject := Subject;
  FSubjectName := Name;
end;

function TBooleanTests.IsFalse: Boolean;
begin
  if FSubject then
    raise EEnsureBooleanException.Create(Format('%s (%s) is True',
                                           [FSubjectName,  BoolToStr(FSubject)]));

  Result := FSubject;
end;

function TBooleanTests.IsTrue: Boolean;
begin
  if not FSubject then
    raise EEnsureBooleanException.Create(Format('%s (%s) is False',
                                           [FSubjectName,  BoolToStr(FSubject)]));

  Result := FSubject;
end;

end.
