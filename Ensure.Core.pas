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

unit Ensure.Core;

interface
uses
  SysUtils;

type
  IInstanceTests<T : class> = interface
    function IsAssigned(Subject : T; const Name : string = '') : T;
  end;

  TInstanceTests<T : class> = class(TInterfacedObject, IInstanceTests<T>)
  public
    function IsAssigned(Subject : T; const Name : string = '') : T;
  end;

  TStringTests = class
    class function NotEmpty(const Subject : string; const Name : String = '') : string;
  end;
  TStringTestsClass = class of TStringTests;


  TDirectoryTests = class(TStringTests)
    class function Exists(const Path : string; const Description : string = '') : string;
    class function IsEmpty(const Path : string; const Description : string = '') : string;
  end;
  TDirectoryTestsClass = class of TDirectoryTests;

  TEnsure = class
  public
    class function InstanceOf<T : class> : IInstanceTests<T>;
    class function &String : TStringTestsClass;
    // file related
    class function Directory: TDirectoryTestsClass;
  end;


implementation
uses
  IOUtils, Ensure.Exceptions;


{ Ensure }


class function TEnsure.InstanceOf<T> : IInstanceTests<T>;
begin
  Result := TInstanceTests<T>.Create;
end;

class function TEnsure.&String: TStringTestsClass;
begin
  Result := TStringTests;
end;

class function TEnsure.Directory: TDirectoryTestsClass;
begin
  Result := TDirectoryTests;
end;


function TInstanceTests<T>.IsAssigned(Subject: T; const Name: string): T;
begin
  if not Assigned(Subject) then
    raise EEnsureParameterNilException.Create(T.ClassName +  ' parameter is nil : ' + Name);

  Result := Subject;
end;


{ TStringTests }

class function TStringTests.NotEmpty(const Subject, Name: string): string;
begin
  if Subject = '' then
    raise EEnsureParameterEmptyException.Create('String parameter is empty : ' + Name);

  Result := Subject;
end;

{ TPathTests }

class function TDirectoryTests.Exists(const Path, Description: string): string;
begin
  if not TDirectory.Exists(Path) then
    raise EEnsurePathNotFound.Create(Path);

  Result := Path;
end;

{ TInstanceTests }


class function TDirectoryTests.IsEmpty(const Path, Description: string): string;
begin
  if not TDirectory.Exists(Path) then
    raise EEnsurePathNotEmpty.Create(Path);

  Result := Path;

end;

end.
