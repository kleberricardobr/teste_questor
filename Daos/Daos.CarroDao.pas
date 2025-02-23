unit Daos.CarroDao;

interface

uses Generics.Collections,
     Models.Carro;

type
  TCarroDao = class
  private
    FListaCarros: TObjectList<TCarro>;
  public
    procedure InserirDadosBD(ACarro: TCarro);
    function ExecutarSQL: TObjectList<TCarro>;  overload;
    function ExecutarSQL(AModelo: string; ADtLancto: TDate): TCarro; overload;
    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TCarroDado }

uses System.SysUtils;

constructor TCarroDao.Create;
begin
  Self.FListaCarros := TObjectList<TCarro>.Create;
end;

destructor TCarroDao.Destroy;
begin
  FreeAndNil(Self.FListaCarros);
  inherited;
end;

// Simula a recuperação de todos os carros do banco de dados
function TCarroDao.ExecutarSQL: TObjectList<TCarro>;
var
  I: Integer;
begin
  Result := TObjectList<TCarro>.Create;
  for I := 0 to Pred(Self.FListaCarros.Count) do
    Result.Add(TCarro.Create(Self.FListaCarros.Items[I]))
end;


// Simula a pesquisa de um carro no banco de dados com base no Modelo e DtLancamento
function TCarroDao.ExecutarSQL(AModelo: string; ADtLancto: TDate): TCarro;
var
  I: Integer;
begin
  Result := nil;

  for I := 0 to Pred(Self.FListaCarros.Count) do
  begin
    if (AnsiUpperCase(Self.FListaCarros.Items[I].Modelo.Modelo) =
        AnsiUpperCase(AModelo)) and
       (Self.FListaCarros.Items[I].DtLancamento = ADtLancto)
    then
    begin
      Result := TCarro.Create(Self.FListaCarros.Items[I]);
      Break;
    end;
  end;
end;

// Simular a gravação dos dados no banco de dados
procedure TCarroDao.InserirDadosBD(ACarro: TCarro);
begin
  Self.FListaCarros.Add(TCarro.Create(ACarro));
end;

end.
