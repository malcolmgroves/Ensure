program EnsureTests;


{$IFDEF CONSOLE_TESTRUNNER}
{$APPTYPE CONSOLE}
{$ENDIF}

uses
// Only one of the next two lines should be uncommented.
  DUnitTestRunner, // uncomment to use DUnit, or
//  TestInsight.Dunit, // uncomment to use TestInsight
  Ensure in '..\Ensure.pas',
  TestEnsure in 'TestEnsure.pas';

{$R *.RES}

begin
  ReportMemoryLeaksOnShutdown := True;
  RunRegisteredTests;
end.

