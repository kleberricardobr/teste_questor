unit Services.ClienteService;

interface

uses Generics.Collections,
     Models.Cliente,
     Daos.ClienteDao,
     Services.VendaService;

type
  TClienteService = class
  private
    FClienteDao: TClienteDao;
    function ClienteJaCadastrado(ACPF: string): Boolean;
  public
    constructor Create;
    destructor Destroy; override;
    procedure CadastrarClientes(AQuantidade: Integer);
    function ConsultarClientes: TObjectList<TCliente>;
  end;

const
  QUANTIDADE_CLIENTES = QUANTIDADE_VENDAS;

implementation

{ TClienteService }

uses System.SysUtils,
     Vcl.Dialogs,
     Utils.Input;

procedure TClienteService.CadastrarClientes(AQuantidade: Integer);
var
  I: Integer;
  LCliente: TCliente;
  LListaClientes: TObjectList<TCliente>;
  LQtdJaCadastrada: Integer;

  function SolicitaDadosCliente(AIndex: Integer): TCliente;
  var
    LCPF: string;
    LNome: string;
    LTelefone: string;
  begin
    Result := nil;

    repeat
      LCPF := Trim(TInputUtils.SolicitarDados(string.Format('%d de %d - Cliente ',
                                                 [AIndex, QUANTIDADE_CLIENTES]),
                                    'Informe o CPF'));
    until not ClienteJaCadastrado(LCPF);

    if LCPF = EmptyStr then
      Exit;

    LNome := Trim(TInputUtils.SolicitarDados(string.Format('%d de %d - Cliente ',
                                                [AIndex, QUANTIDADE_CLIENTES]),
                                   'Informe o Nome'));
    if LNome = EmptyStr then
      Exit;

    LTelefone := Trim(TInputUtils.SolicitarDados(string.Format('%d de %d - Cliente ',
                                        [AIndex, QUANTIDADE_CLIENTES]),
                                       'Informe o Telefone'));
    if LTelefone = EmptyStr then
      Exit;

    Result := TCliente.Create(LCPF, LNome, LTelefone);
  end;

begin
  LListaClientes := FClienteDao.ExecutarSQL;
  try
    LQtdJaCadastrada := LListaClientes.Count;
    if LQtdJaCadastrada = QUANTIDADE_CLIENTES then
    begin
      ShowMessage('Quantidade máxima de cadastro excedida!');
      Exit;
    end;
  finally
    FreeAndNil(LListaClientes);
  end;

  for I := LQtdJaCadastrada to Pred(AQuantidade) do
  begin
    LCliente := SolicitaDadosCliente(I + 1);
    if not Assigned(LCliente) then
      Break;

    try
      FClienteDao.InserirDadosBD(LCliente);
    finally
      FreeAndNil(LCliente);
    end;
  end;
end;

function TClienteService.ClienteJaCadastrado(ACPF: string): Boolean;
var
  LCliente: TCliente;
begin
  Result := False;

  LCliente := FClienteDao.ExecutarSQL(ACPF);
  if Assigned(LCliente) then
  begin
    Result := True;
    ShowMessage('CPF já foi utilizado em outro cadastro!');
    FreeAndNil(LCliente);
  end;
end;

function TClienteService.ConsultarClientes: TObjectList<TCliente>;
begin
  Result := Self.FClienteDao.ExecutarSQL;
end;

constructor TClienteService.Create;
begin
  FClienteDao := TClienteDao.Create;
end;

destructor TClienteService.Destroy;
begin
  FreeAndNil(FClienteDao);
  inherited;
end;

end.
