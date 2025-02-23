unit Daos.ClienteDao;

interface

uses Generics.Collections,
     Models.Cliente;

type
  TClienteDao = class
  private
    FListaClientes: TObjectList<TCliente>;
  public
    procedure InserirDadosBD(ACliente: TCliente);
    function ExecutarSQL: TObjectList<TCliente>;  overload;
    function ExecutarSQL(ACPF: string): TCliente; overload;
    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TClienteDao }

uses System.SysUtils;

constructor TClienteDao.Create;
begin
  Self.FListaClientes := TObjectList<TCliente>.Create;
end;

destructor TClienteDao.Destroy;
begin
  FreeAndNil(Self.FListaClientes);
  inherited;
end;

// Simula a busca de todos os clientes no banco de dados
function TClienteDao.ExecutarSQL: TObjectList<TCliente>;
var
  I: Integer;
begin
  Result := TObjectList<TCliente>.Create;
  for I := 0 to Pred(Self.FListaClientes.Count) do
    Result.Add(TCliente.Create(Self.FListaClientes.Items[I]))
end;

// Simula a busca de um determinado cliente no banco de dados
function TClienteDao.ExecutarSQL(ACPF: string): TCliente;
var
  I: Integer;
begin
  Result := nil;

  for I := 0 to Pred(Self.FListaClientes.Count) do
  begin
    if Self.FListaClientes.Items[I].CPF = ACPF then
    begin
      Result := TCliente.Create(Self.FListaClientes.Items[I]);
      Break;
    end;
  end;
end;

// Simular a inserção de um cliente no banco de dados
procedure TClienteDao.InserirDadosBD(ACliente: TCliente);
begin
  Self.FListaClientes.Add(TCliente.Create(ACliente));
end;

end.
