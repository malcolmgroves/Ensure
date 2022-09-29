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
    procedure TestNilObjectParameterAssigned;
    procedure TestNonNilObjectParameterAssigned;
    procedure TestObjectIsA;
    procedure testObjectIsSameType;
    procedure TestObjectIsAFails;
    procedure TestStringEmptyParameterFails;
    procedure TestStringNonEmptyParameterFails;
    procedure TestStringHasLength;
    procedure TestStringHasLengthFails;
    procedure TestStringHasLengthAtLeast;
    procedure TestStringHasLengthAtLeastFails;
    procedure TestStringHasLengthAtMost;
    procedure TestStringHasLengthAtMostFails;
    procedure TestStringStartsWith;
    procedure TestStringStartsWithFails;
    procedure TestStringStartsWithEmptyString;
    procedure TestStringStartsWithIgnoreCase;
    procedure TestStringStartsWithIgnoreCaseFails;
    procedure TestStringContains;
    procedure TestStringContainsFails;
    procedure TestStringContainsEmptyString;
    procedure TestStringContainsIgnoreCase;
    procedure TestStringContainsIgnoreCaseFails;
    procedure TestStringEndsWith;
    procedure TestStringEndsWithFails;
    procedure TestStringEndsWithEmptyString;
    procedure TestStringEndsWithIgnoreCase;
    procedure TestStringEndsWithIgnoreCaseFails;
    procedure TestDateTimeNotLaterThanEarlier;
    procedure TestDateTimeNotLaterThan;
    procedure TestDateTimeNotLaterThanSame;
    procedure TestDateTimeInThePast;
    procedure TestDateTimeDateInTheFuture;
    procedure TestDateTimeTimeInTheFuture;
    procedure TestDateTimeSame;
    procedure TestDateTimeSameFails;
    procedure TestDateNotLaterThanEarlier;
    procedure TestDateNotLaterThan;
    procedure TestDateNotLaterThanSame;
    procedure TestDateNotLaterThanSameDateDifferentTime;
    procedure TestDateInThePast;
    procedure TestDateInTheFuture;
    procedure TestDateSame;
    procedure TestDateSameFails;
    procedure TestTimeNotLaterThanEarlier;
    procedure TestTimeNotLaterThan;
    procedure TestTimeNotLaterThanSame;
    procedure TestTimeNotLaterThanSameTimeDifferentDate;
    procedure TestTimeInThePast;
    procedure TestTimeInTheFuture;
    procedure TestTimeSame;
    procedure TestTimeSameFails;
    procedure TestNilInterfaceIsAssigned;
    procedure TestNonNilInterfaceIsAssigned;
    procedure TestIntegerInRange;
    procedure TestIntegerInRangeFails;
    procedure TestIntegerEquals;
    procedure TestIntegerEqualsFails;
    procedure TestIntegerLessThan;
    procedure TestIntegerLessThanFails;
    procedure TestIntegerLessThanOrEqualTo;
    procedure TestIntegerLessThanOrEqualToFails;
    procedure TestIntegerGreaterThan;
    procedure TestIntegerGreaterThanFails;
    procedure TestIntegerGreaterThanOrEqualTo;
    procedure TestIntegerGreaterThanOrEqualToFails;
    procedure TestIntegerIsZero;
    procedure TestIntegerIsZeroFails;
    procedure TestIntegerNotZero;
    procedure TestIntegerNotZeroFails;
    procedure TestIntegerIsPositive;
    procedure TestIntegerIsPositiveFails;
    procedure TestIntegerZeroIsPositive;
    procedure TestIntegerIsNegative;
    procedure TestIntegerIsNegativeFails;
    procedure TestIntegerZeroIsNegative;
    procedure TestListIsNotEmpty;
    procedure TestListIsEmpty;
    procedure TestListIsNotEmptyFails;
    procedure TestListIsEmptyFails;
    procedure TestTStringsIsNotEmpty;
    procedure TestTStringsIsEmpty;
    procedure TestTStringsIsNotEmptyFails;
    procedure TestTStringsIsEmptyFails;
    procedure TestBooleanIsTrue;
    procedure TestBooleanIsTrueFails;
    procedure TestBooleanIsFalse;
    procedure TestBooleanIsFalseFails;

  end;


implementation
uses
  DateUtils, Classes, Generics.Collections;

type
  IFoo = interface
    procedure Bar;
  end;
  TFoo = class (TInterfacedObject, IFoo)
  public
    procedure Bar;
  end;

procedure TestTEnsure.testObjectIsSameType;
var
  LPersistent : TPersistent;
begin
  LPersistent := TPersistent.Create;
  try
    TEnsure.Object<TPersistent>(LPersistent).IsA<TPersistent>;
    CheckTrue(True);
  finally
    LPersistent.Free;
  end;
end;

procedure TestTEnsure.TestObjectIsA;
var
  LPersistent : TPersistent;
begin
  LPersistent := TPersistent.Create;
  try
    TEnsure.Object<TPersistent>(LPersistent, 'LPersistent').IsA<TObject>;
    CheckTrue(True);
  finally
    LPersistent.Free;
  end;
end;

procedure TestTEnsure.TestObjectIsAFails;
var
  LObject : TObject;
begin
  LObject := TObject.Create;
  try
    ExpectedException := EEnsureObjectException;
    TEnsure.Object<TObject>(LObject, 'LObject').IsA<TPersistent>;
    StopExpectingException;
  finally
    LObject.Free;
  end;
end;

procedure TestTEnsure.TestBooleanIsFalse;
begin
  TEnsure.Boolean(False).IsFalse;
  CheckTrue(True);
end;

procedure TestTEnsure.TestBooleanIsFalseFails;
begin
  ExpectedException := EEnsureBooleanException;
  TEnsure.Boolean(True).IsFalse;
  StopExpectingException;
end;

procedure TestTEnsure.TestBooleanIsTrue;
begin
  TEnsure.Boolean(True).IsTrue;
  CheckTrue(True);
end;

procedure TestTEnsure.TestBooleanIsTrueFails;
begin
  ExpectedException := EEnsureBooleanException;
  TEnsure.Boolean(False).IsTrue;
  StopExpectingException;
end;

procedure TestTEnsure.TestDateInTheFuture;
begin
  TEnsure.Date(Now + 1).InTheFuture;
  CheckTrue(True);
end;

procedure TestTEnsure.TestDateInThePast;
begin
  TEnsure.Date(Now - 1).InThePast;
  CheckTrue(True);
end;

procedure TestTEnsure.TestDateNotLaterThan;
begin
  TEnsure.Date(Now).NotLaterThan(Now + 0.1);
  CheckTrue(True);
end;

procedure TestTEnsure.TestDateNotLaterThanEarlier;
begin
  ExpectedException := EEnsureDateTimeException;
  TEnsure.Date(IncDay(Now)).NotLaterThan(Now);
  StopExpectingException;
end;

procedure TestTEnsure.TestDateNotLaterThanSame;
var
  LNow : TDate;
begin
  LNow := Now;
  TEnsure.Date(LNow).NotLaterThan(LNow);
  CheckTrue(True);
end;

procedure TestTEnsure.TestDateNotLaterThanSameDateDifferentTime;
begin
  TEnsure.Date(Now).NotLaterThan(Now + 0.1);
  CheckTrue(True);
end;

procedure TestTEnsure.TestDateSame;
var
  LNow : TDate;
begin
  LNow := Now;
  TEnsure.Date(LNow).Same(LNow);
  CheckTrue(True);
end;

procedure TestTEnsure.TestDateSameFails;
var
  LNow : TDate;
begin
  LNow := Now;
  ExpectedException := EEnsureDateTimeException;
  TEnsure.Date(IncDay(LNow, 1)).Same(LNow);
  StopExpectingException;
end;

procedure TestTEnsure.TestDateTimeDateInTheFuture;
begin
  TEnsure.DateTime(Now + 1).InTheFuture;
  CheckTrue(True);
end;


procedure TestTEnsure.TestDateTimeInThePast;
begin
  TEnsure.DateTime(Now - 1).InThePast;
  CheckTrue(True);
end;

procedure TestTEnsure.TestDateTimeNotLaterThan;
begin
  TEnsure.DateTime(Now).NotLaterThan(IncDay(Now, 1));
  CheckTrue(True);
end;

procedure TestTEnsure.TestDateTimeNotLaterThanEarlier;
begin
  ExpectedException := EEnsureDateTimeException;
  TEnsure.DateTime(IncDay(Now, 1)).NotLaterThan(Now);
  StopExpectingException;
end;

procedure TestTEnsure.TestDateTimeNotLaterThanSame;
var
  LDate : TDateTime;
begin
  LDate := Now;
  TEnsure.DateTime(LDate).NotLaterThan(LDate);
  CheckTrue(True);
end;

procedure TestTEnsure.TestDateTimeSame;
var
  LNow : TDate;
begin
  LNow := Now;
  TEnsure.Date(LNow).Same(LNow);
  CheckTrue(True);
end;

procedure TestTEnsure.TestDateTimeSameFails;
var
  LNow : TDateTime;
begin
  LNow := Now;
  ExpectedException := EEnsureDateTimeException;
  TEnsure.DateTime(IncDay(LNow, 1)).Same(LNow);
  StopExpectingException;
end;

procedure TestTEnsure.TestDateTimeTimeInTheFuture;
begin
  TEnsure.DateTime(Now + 0.1).InTheFuture;
  CheckTrue(True);
end;

procedure TestTEnsure.TestStringContains;
begin
  TEnsure.String('Hello').Contains('ell');
  CheckTrue(True);
end;

procedure TestTEnsure.TestStringContainsEmptyString;
begin
  ExpectedException := EEnsureStringException;
  TEnsure.String('Hello').Contains('');
  StopExpectingException;
end;

procedure TestTEnsure.TestStringContainsFails;
begin
  ExpectedException := EEnsureStringException;
  TEnsure.String('Hello').Contains('Elo');
  StopExpectingException;
end;

procedure TestTEnsure.TestStringContainsIgnoreCase;
begin
  TEnsure.String('Hello').Contains('Ell', IgnoreCase);
  CheckTrue(True);
end;

procedure TestTEnsure.TestStringContainsIgnoreCaseFails;
begin
  ExpectedException := EEnsureStringException;
  TEnsure.String('Hello').Contains('world', IgnoreCase);
  StopExpectingException;
end;

procedure TestTEnsure.TestStringEmptyParameterFails;
  procedure Foo(const MyString : String);
  begin
    TEnsure.String(MyString).NotEmpty;
  end;
begin
  ExpectedException := EEnsureStringException;
  Foo('');
  StopExpectingException;
end;

procedure TestTEnsure.TestStringEndsWith;
begin
  TEnsure.String('Hello').EndsWith('llo');
  CheckTrue(True);
end;

procedure TestTEnsure.TestStringEndsWithEmptyString;
begin
  TEnsure.String('Hello').EndsWith('');
  CheckTrue(True);
end;

procedure TestTEnsure.TestStringEndsWithFails;
begin
  ExpectedException := EEnsureStringException;
  TEnsure.String('Hello').EndsWith('Llo');
  StopExpectingException;
end;

procedure TestTEnsure.TestStringEndsWithIgnoreCase;
begin
  TEnsure.String('Hello').EndsWith('lLo', True);
  CheckTrue(True);
end;

procedure TestTEnsure.TestStringEndsWithIgnoreCaseFails;
begin
  ExpectedException := EEnsureStringException;
  TEnsure.String('Hello').EndsWith('world', True);
  StopExpectingException;
end;

procedure TestTEnsure.TestStringHasLength;
begin
  TEnsure.String('Hello').LengthEqualTo(5);
  CheckTrue(True);
end;

procedure TestTEnsure.TestStringHasLengthAtLeast;
begin
  TEnsure.String('Hello').LengthGreaterThanOrEqualsTo(3);
  CheckTrue(True);
end;

procedure TestTEnsure.TestStringHasLengthAtLeastFails;
begin
  ExpectedException := EEnsureStringException;
  TEnsure.String('Hello').LengthGreaterThanOrEqualsTo(6);
  StopExpectingException;
end;

procedure TestTEnsure.TestStringHasLengthAtMost;
begin
  TEnsure.String('Hello').LengthLessThanOrEqualsTo(5);
  CheckTrue(True);
end;

procedure TestTEnsure.TestStringHasLengthAtMostFails;
begin
  ExpectedException := EEnsureStringException;
  TEnsure.String('Hello').LengthLessThanOrEqualsTo(4);
  StopExpectingException;
end;

procedure TestTEnsure.TestStringHasLengthFails;
begin
  ExpectedException := EEnsureStringException;
  TEnsure.String('Hello').LengthEqualTo(6);
  StopExpectingException;
end;

procedure TestTEnsure.TestIntegerEquals;
begin
  TEnsure.Integer(5).EqualTo(5);
  CheckTrue(True);
end;

procedure TestTEnsure.TestIntegerEqualsFails;
begin
  ExpectedException := EEnsureIntegerException;
  TEnsure.Integer(5).EqualTo(6);
  StopExpectingException;
end;

procedure TestTEnsure.TestIntegerGreaterThan;
begin
  TEnsure.Integer(5).GreaterThan(4);
  CheckTrue(True);
end;

procedure TestTEnsure.TestIntegerGreaterThanFails;
begin
  ExpectedException := EEnsureIntegerException;
  TEnsure.Integer(5).GreaterThan(6);
  StopExpectingException;
end;

procedure TestTEnsure.TestIntegerGreaterThanOrEqualTo;
begin
  TEnsure.Integer(5).GreaterThanOrEqualTo(5);
  CheckTrue(True);
end;

procedure TestTEnsure.TestIntegerGreaterThanOrEqualToFails;
begin
  ExpectedException := EEnsureIntegerException;
  TEnsure.Integer(5).GreaterThanOrEqualTo(6);
  StopExpectingException;
end;

procedure TestTEnsure.TestIntegerInRange;
begin
  TEnsure.Integer(5).Between(3, 6);
  CheckTrue(True);
end;

procedure TestTEnsure.TestIntegerInRangeFails;
begin
  ExpectedException := EEnsureIntegerException;
  TEnsure.Integer(5).Between(6, 10);
  StopExpectingException;
end;

procedure TestTEnsure.TestIntegerIsNegative;
begin
  TEnsure.Integer(-5).IsNegative;
  CheckTrue(True);
end;

procedure TestTEnsure.TestIntegerIsNegativeFails;
begin
  ExpectedException := EEnsureIntegerException;
  TEnsure.Integer(1).IsNegative;
  StopExpectingException;
end;

procedure TestTEnsure.TestIntegerIsPositive;
begin
  TEnsure.Integer(5).IsPositive;
  CheckTrue(True);
end;

procedure TestTEnsure.TestIntegerIsPositiveFails;
begin
  ExpectedException := EEnsureIntegerException;
  TEnsure.Integer(-1).IsPositive;
  StopExpectingException;
end;

procedure TestTEnsure.TestIntegerIsZero;
begin
  TEnsure.Integer(0).IsZero;
  CheckTrue(True);
end;

procedure TestTEnsure.TestIntegerIsZeroFails;
begin
  ExpectedException := EEnsureIntegerException;
  TEnsure.Integer(1).IsZero;
  StopExpectingException;
end;

procedure TestTEnsure.TestIntegerLessThan;
begin
  TEnsure.Integer(5).LessThan(6);
  CheckTrue(True);
end;

procedure TestTEnsure.TestIntegerLessThanFails;
begin
  ExpectedException := EEnsureIntegerException;
  TEnsure.Integer(5).LessThan(4);
  StopExpectingException;
end;

procedure TestTEnsure.TestIntegerLessThanOrEqualTo;
begin
  TEnsure.Integer(5).LessThanOrEqualTo(5);
  CheckTrue(True);
end;

procedure TestTEnsure.TestIntegerLessThanOrEqualToFails;
begin
  ExpectedException := EEnsureIntegerException;
  TEnsure.Integer(5).LessThanOrEqualTo(4);
  StopExpectingException;
end;

procedure TestTEnsure.TestIntegerNotZero;
begin
  TEnsure.Integer(-5).IsNotZero;
  CheckTrue(True);
end;

procedure TestTEnsure.TestIntegerNotZeroFails;
begin
  ExpectedException := EEnsureIntegerException;
  TEnsure.Integer(0).IsNotZero;
  StopExpectingException;
end;

procedure TestTEnsure.TestIntegerZeroIsNegative;
begin
  ExpectedException := EEnsureIntegerException;
  TEnsure.Integer(0).IsNegative;
  StopExpectingException;
end;

procedure TestTEnsure.TestIntegerZeroIsPositive;
begin
  ExpectedException := EEnsureIntegerException;
  TEnsure.Integer(0).IsPositive;
  StopExpectingException;
end;

procedure TestTEnsure.TestListIsEmpty;
var
  LList : TList<Integer>;
begin
  LList := TList<Integer>.Create;
  try
    TEnsure.List<Integer>(LList).IsEmpty;
    CheckTrue(True);
  finally
    LList.Free;
  end;
end;

procedure TestTEnsure.TestListIsEmptyFails;
var
  LList : TList<Integer>;
begin
  LList := TList<Integer>.Create;
  try
    LList.Add(5);
    ExpectedException := EEnsureListException;
    TEnsure.List<Integer>(LList).IsEmpty;
    StopExpectingException;
  finally
    LList.Free;
  end;
end;

procedure TestTEnsure.TestListIsNotEmpty;
var
  LList : TList<Integer>;
begin
  LList := TList<Integer>.Create;
  try
    LList.Add(5);
    TEnsure.List<Integer>(LList).IsNotEmpty;
    CheckTrue(True);
  finally
    LList.Free;
  end;
end;

procedure TestTEnsure.TestListIsNotEmptyFails;
var
  LList : TList<Integer>;
begin
  LList := TList<Integer>.Create;
  try
    ExpectedException := EEnsureListException;
    TEnsure.List<Integer>(LList).IsNotEmpty;
    StopExpectingException;
  finally
    LList.Free;
  end;
end;

procedure TestTEnsure.TestNilObjectParameterAssigned;
  procedure Foo(MyObject : TObject);
  begin
    TEnsure.Object<TObject>(MyObject, 'MyObject').IsAssigned;
  end;
begin
  ExpectedException := EEnsureObjectException;
  Foo(nil);
  StopExpectingException;
end;


procedure TestTEnsure.TestNilInterfaceIsAssigned;
var
  LFoo : IFoo;
begin
  LFoo := nil;
  ExpectedException := EEnsureInterfaceException;
  TEnsure.Interface<IFoo>(LFoo).IsAssigned;
  StopExpectingException;
end;

procedure TestTEnsure.TestStringNonEmptyParameterFails;
  procedure Foo(const MyString : String);
  begin
    TEnsure.String(MyString, 'MyString').NotEmpty;
  end;
begin
  Foo('Hello');
  CheckTrue(True);
end;

procedure TestTEnsure.TestStringStartsWith;
begin
  TEnsure.String('Hello').StartsWith('Hel');
  CheckTrue(True);
end;

procedure TestTEnsure.TestStringStartsWithEmptyString;
begin
  TEnsure.String('Hello').StartsWith('');
  CheckTrue(True);
end;

procedure TestTEnsure.TestStringStartsWithFails;
begin
  ExpectedException := EEnsureStringException;
  TEnsure.String('Hello').StartsWith('hel');
  StopExpectingException;
end;

procedure TestTEnsure.TestStringStartsWithIgnoreCase;
begin
  TEnsure.String('Hello').StartsWith('hel', True);
  CheckTrue(True);
end;

procedure TestTEnsure.TestStringStartsWithIgnoreCaseFails;
begin
  ExpectedException := EEnsureStringException;
  TEnsure.String('Hello').StartsWith('Foo');
  StopExpectingException;
end;

procedure TestTEnsure.TestNonNilObjectParameterAssigned;
  procedure Foo(MyObject : TObject);
  begin
    TEnsure.&Object<TObject>(MyObject, 'MyObject').IsAssigned;
  end;
var
  MyObj : TObject;
begin
  MyObj := TObject.Create;
  try
    Foo(MyObj);
    CheckTrue(True);
  finally
    MyObj.Free;
  end;
end;


procedure TestTEnsure.TestNonNilInterfaceIsAssigned;
var
  LFoo : IFoo;
begin
  LFoo := TFoo.Create;
  TEnsure.Interface<IFoo>(LFoo).IsAssigned;
  CheckTrue(True);
end;

procedure TestTEnsure.TestTimeInTheFuture;
begin
  TEnsure.Time(Now + 0.1).InTheFuture;
  CheckTrue(True);
end;

procedure TestTEnsure.TestTimeInThePast;
begin
  TEnsure.Time(Now - 0.1).InThePast;
  CheckTrue(True);
end;

procedure TestTEnsure.TestTimeNotLaterThan;
begin
  TEnsure.Time(IncDay(Now, -1)).NotLaterThan(Now);
  CheckTrue(True);
end;

procedure TestTEnsure.TestTimeNotLaterThanEarlier;
var
  LNow : TDateTime;
begin
  LNow := Now;
  ExpectedException := EEnsureDateTimeException;
  TEnsure.Time(IncDay(LNow, -1) + 0.1).NotLaterThan(LNow);
  StopExpectingException;
end;

procedure TestTEnsure.TestTimeNotLaterThanSame;
var
  LNow : TDateTime;
begin
  LNow := Now;
  TEnsure.Time(LNow -0.1).NotLaterThan(LNow);
  CheckTrue(True);
end;

procedure TestTEnsure.TestTimeNotLaterThanSameTimeDifferentDate;
var
  LNow : TDateTime;
begin
  LNow := Now;
  TEnsure.Time(IncDay(LNow, -1)).NotLaterThan(LNow);
  CheckTrue(True);
end;

procedure TestTEnsure.TestTimeSame;
var
  LNow : TTime;
begin
  LNow := Now;
  TEnsure.Time(IncDay(LNow)).Same(LNow);
  CheckTrue(True);
end;

procedure TestTEnsure.TestTimeSameFails;
var
  LNow : TTime;
begin
  LNow := Now;
  ExpectedException := EEnsureDateTimeException;
  TEnsure.Time(LNow + 0.1).Same(LNow);
  StopExpectingException;
end;

procedure TestTEnsure.TestTStringsIsEmpty;
var
  LList : TStrings;
begin
  LList := TStringList.Create;
  try
    TEnsure.TStrings(LList).IsEmpty;
    CheckTrue(True);
  finally
    LList.Free;
  end;
end;

procedure TestTEnsure.TestTStringsIsEmptyFails;
var
  LList : TStrings;
begin
  LList := TStringList.Create;
  try
    LList.Add('Hello');
    ExpectedException := EEnsureTStringsException;
    TEnsure.TStrings(LList).IsEmpty;
    StopExpectingException;
  finally
    LList.Free;
  end;
end;

procedure TestTEnsure.TestTStringsIsNotEmpty;
var
  LList : TStrings;
begin
  LList := TStringList.Create;
  try
    LList.Add('Hello');
    TEnsure.TStrings(LList).IsNotEmpty;
    CheckTrue(True);
  finally
    LList.Free;
  end;
end;

procedure TestTEnsure.TestTStringsIsNotEmptyFails;
var
  LList : TStrings;
begin
  LList := TStringList.Create;
  try
    ExpectedException := EEnsureTStringsException;
    TEnsure.TStrings(LList).IsNotEmpty;
    StopExpectingException;
  finally
    LList.Free;
  end;
end;

{ TFoo }

procedure TFoo.Bar;
begin
  //
end;

initialization
  // Register any test cases with the test runner
  RegisterTest(TestTEnsure.Suite);
end.


