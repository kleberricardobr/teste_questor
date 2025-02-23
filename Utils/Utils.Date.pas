unit Utils.Date;

interface

type
  TDateUtils = class
  public
    class function MesAnoStrToDate(AMesAnoStr: string): TDate;
  end;

implementation

{ TDateUtils }

uses System.SysUtils, Dialogs;

class function TDateUtils.MesAnoStrToDate(AMesAnoStr: string): TDate;
var
  LSep: Byte;
  LMes: Word;
  LAno: Word;
  LAnoStr: string;
begin
  Result := 0;

  LSep := Pos('/', AMesAnoStr);
  if LSep <= 0 then
    Exit;

  LMes := StrToIntDef(Copy(AMesAnoStr, 0, LSep - 1), 0);
  if LMes = 0 then
    Exit;

  LAnoStr := Copy(AMesAnoStr, LSep + 1);
  if Length(LAnoStr) <> 4 then
    Exit;

  LAno := StrToIntDef(LAnoStr, 0);
  if LAno = 0 then
    Exit;

  try
    Result := EncodeDate(LAno, LMes, 1);
  except
  end;
end;

end.
