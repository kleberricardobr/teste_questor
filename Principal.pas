unit Principal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Services.ClienteService,
  Services.CarroService, Services.VendaService;

type
  TFrmQuestor = class(TForm)
    btnInserirClientes: TButton;
    lbInserirClientes: TLabel;
    lblInserirCarros: TLabel;
    btnInserirCarros: TButton;
    Label1: TLabel;
    btnLancarVendas: TButton;
    sdLog: TSaveDialog;
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnInserirClientesClick(Sender: TObject);
    procedure btnInserirCarrosClick(Sender: TObject);
    procedure btnLancarVendasClick(Sender: TObject);
  private
    { Private declarations }
    FClienteService: TClienteService;
    FCarroService: TCarroService;
    FVendaService: TVendaService;
    function GravarLog: string;
  public
    { Public declarations }
  end;

var
  FrmQuestor: TFrmQuestor;

implementation

{$R *.dfm}

uses System.UITypes,
     Generics.Collections,
     Models.Carro,
     Models.Cliente,
     Models.Venda;

procedure TFrmQuestor.btnInserirCarrosClick(Sender: TObject);
begin
  Self.FCarroService.CadastrarCarros(QUANTIDADE_VENDAS);
end;

procedure TFrmQuestor.btnInserirClientesClick(Sender: TObject);
begin
  Self.FClienteService.CadastrarClientes(QUANTIDADE_VENDAS);
end;

procedure TFrmQuestor.btnLancarVendasClick(Sender: TObject);
var
  LClientes: TObjectList<TCliente>;
  LCarros: TObjectList<TCarro>;
  LFileLog: string;
begin
  LClientes := Self.FClienteService.ConsultarClientes;
  if LClientes.Count < QUANTIDADE_VENDAS then
  begin
    FreeAndNil(LClientes);
    ShowMessage('Finalize o cadastro de todos os clientes antes de prosseguir!');
    btnInserirClientes.SetFocus;
    Exit;
  end;

  LCarros := Self.FCarroService.ConsutarCarros;
  if LCarros.Count < QUANTIDADE_VENDAS then
  begin
    FreeAndNil(LCarros);
    ShowMessage('Finalize o cadastro de todos os carros antes de prosseguir!');
    btnInserirCarros.SetFocus;
    Exit;
  end;

  try
    Self.FVendaService.CadastrarVendas(QUANTIDADE_VENDAS, LClientes, LCarros);

    if MessageDlg('Deseja salvar um log das vendas realizadas?',
               TMsgDlgType.mtConfirmation, [mbYes, mbNo], 0, mbNo) = mrYes then
    begin
      LFileLog := Self.GravarLog;
      if LFileLog = EmptyStr then
        Exit;

      ShowMessage(string.Format('Log salvo com sucesso! (%s)', [LFileLog]));
    end;

  finally
    FreeAndNil(LClientes);
    FreeAndNil(LCarros);
  end;
end;

function TFrmQuestor.GravarLog: string;
var
  LVendas: TObjectList<TVenda>;
  I: Integer;
  Log: TStringList;
  LDhVenda: string;
  LTotal: string;
  LCliente: string;
  LCarro: string;
begin
  Result := '';
  if not sdLog.Execute then
    Exit;

  LVendas := Self.FVendaService.ConsultarVendas;
  Log := TStringList.Create;

  try
    for I := 0 to Pred(LVendas.Count) do
    begin
      Log.Add('######################################');

      LDhVenda := FormatDateTime('dd/mm/yyyy hh:nn', LVendas.Items[I].DhVenda);
      LTotal := FormatFloat('#,0.00', LVendas.Items[I].Total);
      LCliente := LVendas.Items[I].Cliente.Nome + ' - ' +
                  LVendas.Items[I].Cliente.CPF;
      LCarro := LVendas.Items[I].Carro.Modelo.Modelo + ' - Dt. Lcto. ' +
                FormatDateTime('dd/mm/yyyy', LVendas.Items[I].Carro.DtLancamento);

      Log.Add(string.Format('Dt. Venda: %s; Total: R$ %s',
                            [LdhVenda, LTotal]));
      Log.Add(string.Format('Cliente: %s', [LCliente]));
      Log.Add(string.Format('Carro: %s', [LCarro]));
      Log.Add('######################################');
    end;

    Log.SaveToFile(sdLog.FileName);
    Result := sdLog.FileName;
  finally
    FreeAndNil(Log);
  end;
end;

procedure TFrmQuestor.FormCreate(Sender: TObject);
begin
  Self.FClienteService := TClienteService.Create;
  Self.FCarroService := TCarroService.Create;
  Self.FVendaService := TVendaService.Create;
end;

procedure TFrmQuestor.FormDestroy(Sender: TObject);
begin
  FreeAndNil(Self.FClienteService);
  FreeAndNil(Self.FCarroService);
  FreeAndNil(Self.FVendaService);
end;

end.
