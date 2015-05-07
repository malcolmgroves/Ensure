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
  IInstanceTests<T : class> = interface
    function IsAssigned(Subject : T; const Name : string = '') : T;
  end;

  IStringTests = interface
    function NotEmpty(const Subject : string; const Name : String = '') : string;
  end;

  IDirectoryTests = interface(IStringTests)
    function Exists(const Path : string; const Description : string = '') : string;
  end;

  TEnsure = class
  public
    class function InstanceOf<T : class> : IInstanceTests<T>;
    class function &String : IStringTests;
    // file related
    class function DirExists(const Path : string): string; overload;
  end;

  TInstanceTests<T : class> = class(TInterfacedObject, IInstanceTests<T>)
  public
    function IsAssigned(Subject : T; const Name : string = '') : T;
  end;

  TStringTests = class(TInterfacedObject, IStringTests)
  public
    function NotEmpty(const Subject: string; const Name: string = ''): string;
  end;

  TDirectoryTests = class(TStringTests, IDirectoryTests)
  public
    function Exists(const Path: string; const Description: string = ''): string;
  end;

  EEnsureException = class(Exception);
    EEnsureParameterException = class(EEnsureException);
      EEnsureParameterNilException = class(EEnsureParameterException);
      EEnsureParameterEmptyException = class(EEnsureParameterException);
    EEnsureFileException = class(EEnsureException);
      EEnsurePathNotFound = class(EEnsureFileException)
      private
        FPath : string;
      public
        constructor Create(Path : string); reintroduce;
        property Path : string read FPath;
      end;

implementation
uses
  IOUtils;


{ Ensure }


class function TEnsure.InstanceOf<T> : IInstanceTests<T>;
begin
  Result := TInstanceTests<T>.Create;
end;

class function TEnsure.&String: IStringTests;
begin
  Result := TStringTests.Create;
end;

class function TEnsure.DirExists(const Path : string): string;
begin
  if not TDirectory.Exists(Path) then
    raise EEnsurePathNotFound.Create(Path);

  Result := Path;
end;

{ EEnsurePathNotFound }

constructor EEnsurePathNotFound.Create(Path: string);
begin
  inherited Create('Path not found : ' + Path);
  FPath := Path;
end;

function TInstanceTests<T>.IsAssigned(Subject: T; const Name: string): T;
begin
  if not Assigned(Subject) then
    raise EEnsureParameterNilException.Create(T.ClassName +  ' parameter is nil : ' + Name);

  Result := Subject;
end;


{ TStringTests }

function TStringTests.NotEmpty(const Subject, Name: string): string;
begin
  if Subject = '' then
    raise EEnsureParameterEmptyException.Create('String parameter is empty : ' + Name);

  Result := Subject;
end;

{ TPathTests }

function TDirectoryTests.Exists(const Path, Description: string): string;
begin
  if not TPath.Exists(Path) then
    raise EEnsurePathNotFound.Create(Path);

  Result := Path;
end;

end.
