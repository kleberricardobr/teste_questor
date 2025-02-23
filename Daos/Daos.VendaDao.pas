unit Daos.VendaDao;

interface

uses Generics.Collections,
     Models.Venda;

type
  TVendaDao = class
  private
    FListaVendas: TObjectList<TVenda>;
  public
    procedure InserirDadosBD(AVenda: TVenda);
    function ExecutarSQL: TObjectList<TVenda>;
    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TVendaDao }

uses System.SysUtils;

constructor TVendaDao.Create;
begin
  FListaVendas := TObjectList<TVenda>.Create;
end;

destructor TVendaDao.Destroy;
begin
  FreeAndNil(FListaVendas);
  inherited;
end;

// Simular a consulta das vendas existentes no banco de dados
function TVendaDao.ExecutarSQL: TObjectList<TVenda>;
var
  I: Integer;
begin
  Result := TObjectList<TVenda>.Create;

  for I := 0 to Pred(Self.FListaVendas.Count) do
    Result.Add(TVenda.Create(Self.FListaVendas.Items[I]));
end;

// Simula a inclusão de uma nova venda no banco de dados
procedure TVendaDao.InserirDadosBD(AVenda: TVenda);
begin
  Self.FListaVendas.Add(TVenda.Create(AVenda));
end;

end.
