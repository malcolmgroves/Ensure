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

unit TestEnsure;

interface

uses
  TestFramework, Ensure, SysUtils;

type
  TestTEnsure = class(TTestCase)
  published
    procedure TestNilClassParameterAssigned;
    procedure TestNonNilClassParameterAssigned;
    procedure TestEmptyStringParameterNotEmpty;
    procedure TestNonEmptyStringParameterNotEmpty;
  end;

implementation

procedure TestTEnsure.TestEmptyStringParameterNotEmpty;
  procedure Foo(const MyString : String);
  begin
    TEnsure.ParameterNotEmpty(MyString, 'MyString');
  end;
begin
  ExpectedException := EEnsureParameterEmptyException;
  Foo('');
  StopExpectingException;
end;

procedure TestTEnsure.TestNilClassParameterAssigned;
  procedure Foo(MyObject : TObject);
  begin
    TEnsure.ParameterAssigned<TObject>(MyObject, 'MyObject');
  end;
begin
  ExpectedException := EEnsureParameterNilException;
  Foo(nil);
  StopExpectingException;
end;


procedure TestTEnsure.TestNonEmptyStringParameterNotEmpty;
  procedure Foo(const MyString : String);
  begin
    TEnsure.ParameterNotEmpty(MyString, 'MyString');
  end;
begin
  Foo('Hello');
end;

procedure TestTEnsure.TestNonNilClassParameterAssigned;
  procedure Foo(MyObject : TObject);
  begin
    TEnsure.ParameterAssigned<TObject>(MyObject, 'MyObject');
  end;
var
  MyObj : TObject;
begin
  MyObj := TObject.Create;
  try
    Foo(MyObj);
  finally
    MyObj.Free;
  end;
end;


initialization
  // Register any test cases with the test runner
  RegisterTest(TestTEnsure.Suite);
end.

