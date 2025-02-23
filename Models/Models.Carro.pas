unit Models.Carro;

interface

uses Models.Modelo;

type
  TCarro = class
  private
    FModelo: TModelo;
    FID: Integer;
    FDtLancamento: TDate;
    FPreco: Double;
  public
    constructor Create(AModelo: string; ADtLancamento: TDate;
      APreco: Double; AID: Integer = 0); overload;
    constructor Create(ACarro: TCarro); overload;
    destructor Destroy; override;
    property ID: Integer read FID write FID;
    property Preco: Double read FPreco write FPreco;
    property DtLancamento: TDate read FDtLancamento write FDtLancamento;
    property Modelo: TModelo read FModelo write FModelo;
  end;

implementation

{ TCarro }

uses System.SysUtils;

constructor TCarro.Create(AModelo: string; ADtLancamento: TDate; APreco: Double;
  AID: Integer = 0);
begin
  Self.FModelo := TModelo.Create(AModelo);
  Self.FDtLancamento := ADtLancamento;
  Self.FPreco := APreco;
end;

constructor TCarro.Create(ACarro: TCarro);
begin
  Self.Create(ACarro.Modelo.Modelo, ACarro.DtLancamento,
    ACarro.Preco, ACarro.ID);
end;

destructor TCarro.Destroy;
begin
  FreeAndNil(FModelo);
  inherited;
end;

end.
