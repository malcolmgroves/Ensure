unit Ensure.Exceptions;

interface
uses
  SysUtils;

type
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


implementation

{ EEnsurePathNotFound }

constructor EEnsurePathException.Create(Path: string);
begin
  inherited Create('Path not found : ' + Path);
  FPath := Path;
end;


end.
