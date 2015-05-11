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
  TestFramework, Ensure.Core, SysUtils;

type
  TestTEnsure = class(TTestCase)
  published
    procedure TestNilClassParameterAssigned;
    procedure TestNonNilClassParameterAssigned;
    procedure TestEmptyStringParameterNotEmpty;
    procedure TestNonEmptyStringParameterNotEmpty;
    procedure TestDateTimeNotLaterThanLaterThan;
    procedure TestDateTimeNotLaterThan;
    procedure TestDateTimeNotLaterThanSame;
  end;

implementation
uses
  Ensure.Exceptions, DateUtils;

procedure TestTEnsure.TestDateTimeNotLaterThan;
begin
  TEnsure.DateTime(Now).NotLaterThan(IncDay(Now, 1));
end;

procedure TestTEnsure.TestDateTimeNotLaterThanLaterThan;
begin
  ExpectedException := EEnsureDateException;
  TEnsure.DateTime(IncDay(Now, 1)).NotLaterThan(Now);
  StopExpectingException;
end;

procedure TestTEnsure.TestDateTimeNotLaterThanSame;
var
  LDate : TDateTime;
begin
  LDate := Now;
  TEnsure.DateTime(LDate).NotLaterThan(LDate);
end;

procedure TestTEnsure.TestEmptyStringParameterNotEmpty;
  procedure Foo(const MyString : String);
  begin
    TEnsure.String(MyString).NotEmpty;
  end;
begin
  ExpectedException := EEnsureStringException;
  Foo('');
  StopExpectingException;
end;

procedure TestTEnsure.TestNilClassParameterAssigned;
  procedure Foo(MyObject : TObject);
  begin
    TEnsure.InstanceOf<TObject>(MyObject, 'MyObject').IsAssigned;
  end;
begin
  ExpectedException := EEnsureInstanceException;
  Foo(nil);
  StopExpectingException;
end;


procedure TestTEnsure.TestNonEmptyStringParameterNotEmpty;
  procedure Foo(const MyString : String);
  begin
    TEnsure.String(MyString, 'MyString').NotEmpty;
  end;
begin
  Foo('Hello');
end;

procedure TestTEnsure.TestNonNilClassParameterAssigned;
  procedure Foo(MyObject : TObject);
  begin
    TEnsure.InstanceOf<TObject>(MyObject, 'MyObject').IsAssigned;
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


