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
  TEnsure = class
  public
    class function ParameterAssigned<T : class>(Parameter : T; const Description : string = '') : T; overload;
    class function ParameterNotEmpty(const Parameter : string; const Description : string = '') : string; overload;
  end;

  EEnsureException = class(Exception);
    EEnsureParameterException = class(EEnsureException);
      EEnsureParameterNilException = class(EEnsureParameterException);
      EEnsureParameterEmptyException = class(EEnsureParameterException);

implementation

{ Ensure }

class function TEnsure.ParameterAssigned<T>(Parameter: T; const Description : string): T;
begin
  if not Assigned(Parameter) then
    raise EEnsureParameterNilException.Create(T.ClassName +  ' parameter is nil : ' + Description);

  Result := Parameter;
end;

class function TEnsure.ParameterNotEmpty(const Parameter,
  Description: string): string;
begin
  if Parameter = '' then
    raise EEnsureParameterEmptyException.Create('String parameter is empty : ' + Description);

  Result := Parameter;
end;

end.
