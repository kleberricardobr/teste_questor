unit Services.VendaService;

interface

uses Generics.Collections,
     Daos.VendaDao,
     Models.Carro,
     Models.Cliente,
     Models.Venda;

type
  TVendaService = class
  private
    FVendaDao: TVendaDao;
  public
    constructor Create;
    destructor Destroy; override;
    procedure CadastrarVendas(AQuantidade: Integer;
      AClientes: TObjectList<TCliente>; ACarros: TObjectList<TCarro>);
    function ConsultarVendas: TObjectList<TVenda>;
  end;

const
  QUANTIDADE_VENDAS = 5;


implementation

{ TVendaService }

uses System.SysUtils,
     Vcl.Dialogs;

procedure TVendaService.CadastrarVendas(AQuantidade: Integer;
  AClientes: TObjectList<TCliente>; ACarros: TObjectList<TCarro>);
var
  I: Integer;
  LVenda: TVenda;
  LListaVendas: TObjectList<TVenda>;
begin
  LListaVendas := Self.ConsultarVendas;
  try
    if LListaVendas.Count >= QUANTIDADE_VENDAS then
    begin
      ShowMessage('Todas as vendas já foram cadastradas!');
      Exit;
    end;
  finally
    FreeAndNil(LListaVendas);
  end;

  for I := 0 to Pred(AQuantidade) do
  begin
    LVenda := TVenda.Create(AClientes.Items[I],
                            ACarros.Items[I],
                            ACarros.Items[I].Preco);
    try
      Self.FVendaDao.InserirDadosBD(LVenda);
    finally
      FreeAndNil(LVenda);
    end;
  end;

  ShowMessage('Vendas gravadas com sucesso!');
end;

function TVendaService.ConsultarVendas: TObjectList<TVenda>;
begin
  Result := Self.FVendaDao.ExecutarSQL;
end;

constructor TVendaService.Create;
begin
  Self.FVendaDao := TVendaDao.Create;
end;

destructor TVendaService.Destroy;
begin
  FreeAndNil(Self.FVendaDao);
  inherited;
end;

end.
