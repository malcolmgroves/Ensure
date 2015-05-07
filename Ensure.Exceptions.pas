unit Ensure.Exceptions;

interface
uses
  SysUtils;

type
  EEnsureException = class(Exception);
  EEnsureParameterException = class(EEnsureException);
  EEnsureParameterNilException = class(EEnsureParameterException);
  EEnsureParameterEmptyException = class(EEnsureParameterException);
  EEnsureFileException = class(EEnsureException)
  private
    FPath : string;
  public
    constructor Create(Path : string); reintroduce;
    property Path : string read FPath;
  end;
  EEnsurePathNotFound = class(EEnsureFileException);
  EEnsurePathNotEmpty = class(EEnsureFileException);


implementation

{ EEnsurePathNotFound }

constructor EEnsureFileException.Create(Path: string);
begin
  inherited Create('Path not found : ' + Path);
  FPath := Path;
end;


end.
