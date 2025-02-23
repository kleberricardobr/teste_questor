unit Utils.Input;

interface

type
  TInputUtils = class
  public
    class function SolicitarDados(ATitulo, AMensagem: string): string;
  end;

implementation

{ TInput }

uses Vcl.Dialogs,
     System.SysUtils;

class function TInputUtils.SolicitarDados(ATitulo, AMensagem: string): string;
begin
  Result := '';
  repeat
    if not InputQuery(ATitulo, AMensagem, Result) then
      Break;
  until Result <> EmptyStr;
end;
end.
