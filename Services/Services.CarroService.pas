unit Services.CarroService;

interface

uses Generics.Collections,
     Models.Carro,
     Daos.CarroDao,
     Services.VendaService;

type
  TCarroService = class
  private
    FCarroDao: TCarroDao;
    function CarroJaCadastrado(AModelo: string; ADtLancto: TDate): Boolean;
  public
    constructor Create;
    destructor Destroy; override;
    procedure CadastrarCarros(AQuantidade: Integer);
    function ConsutarCarros: TObjectList<TCarro>;
  end;

const
  QUANTIDADE_CARROS = QUANTIDADE_VENDAS;

implementation

{ TCarroService }

uses Utils.Input,
     Utils.Date,
     System.SysUtils,
     Vcl.Dialogs;

procedure TCarroService.CadastrarCarros(AQuantidade: Integer);
var
  I: Integer;
  LCarro: TCarro;
  LListaCarros: TObjectList<TCarro>;
  LQtdJaCadastrada: Integer;

  function SolicitaDadosCarro(AIndex: Integer): TCarro;
  var
    LDtLancamentoStr: string;
    LDtLancamento: TDate;
    LModelo: string;
    LPrecoStr: string;
    LPreco: Double;
  begin
    Result := nil;

    // Solicita Modelo e Data Lançamento
    repeat
      LModelo := Trim(TInputUtils.SolicitarDados(string.Format(
                   '%d / %d - Carro', [AIndex, QUANTIDADE_CARROS]),
                   'Informe o modelo'));

      if LModelo = EmptyStr then
        Exit;

      repeat
        LDtLancamentoStr := TInputUtils.SolicitarDados(string.Format(
                            '%d / %d - Carro', [AIndex, QUANTIDADE_CARROS]),
                            'Informe mês/ano de lançamento. Exemplo: 1/2022');
        if Trim(LDtLancamentoStr) = EmptyStr then
          Exit;

        LDtLancamento := TDateUtils.MesAnoStrToDate(LDtLancamentoStr);
        if LDtLancamento = 0 then
          ShowMessage(
           'Formato de data inválido. Informe apenas Mês e Ano (Ex: 1/2022)');

      until LDtLancamento > 0;

    until not CarroJaCadastrado(LModelo, LDtLancamento);

    // Solicita o preço
    repeat
      LPrecoStr := Trim(TInputUtils.SolicitarDados(string.Format(
                       '%d / %d - Carro', [AIndex, QUANTIDADE_CARROS]),
                       'Informe o Preço'));
      LPreco := StrToFloatDef(LPrecoStr, 0);

      if LPreco <= 0 then
        ShowMessage('Preço inválido!');
    until LPreco > 0;

    Result := TCarro.Create(LModelo, LDtLancamento, LPreco);
  end;

begin
  LListaCarros := FCarroDao.ExecutarSQL;
  try
    LQtdJaCadastrada := LListaCarros.Count;
    if LQtdJaCadastrada = QUANTIDADE_CARROS then
    begin
      ShowMessage('Quantidade máxima de cadastro excedida!');
      Exit;
    end;
  finally
    FreeAndNil(LListaCarros);
  end;

  for I := LQtdJaCadastrada to Pred(AQuantidade) do
  begin
    LCarro := SolicitaDadosCarro(I + 1);
    if not Assigned(LCarro) then
      Break;

    try
      FCarroDao.InserirDadosBD(LCarro);
    finally
      FreeAndNil(LCarro);
    end;
  end;
end;

function TCarroService.CarroJaCadastrado(AModelo: string;
  ADtLancto: TDate): Boolean;
var
  LCarro: TCarro;
begin
  Result := False;

  LCarro := Self.FCarroDao.ExecutarSQL(AModelo, ADtLancto);
  if Assigned(LCarro) then
  begin
    Result := True;
    ShowMessage('Carro (Modelo/Dt. Lançamento) já cadastrado');
    FreeAndNil(LCarro);
  end;
end;

function TCarroService.ConsutarCarros: TObjectList<TCarro>;
begin
  Result := Self.FCarroDao.ExecutarSQL;
end;

constructor TCarroService.Create;
begin
  Self.FCarroDao := TCarroDao.Create;
end;

destructor TCarroService.Destroy;
begin
  FreeAndNil(Self.FCarroDao);
  inherited;
end;

end.
