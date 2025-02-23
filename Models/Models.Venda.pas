unit Models.Venda;

interface

uses System.SysUtils,
     Models.Carro,
     Models.Cliente;

type
  TVenda = class
  private
    FCarro: TCarro;
    FCliente: TCliente;
    FTotal: Double;
    FID: Integer;
    FDhVenda: TDateTime;
  public
    constructor Create(ACliente: TCliente; ACarro: TCarro; ATotal: Double;
      ADhVenda: TDateTime = 0); overload;
    constructor Create(AVenda: TVenda); overload;
    destructor Destroy; override;
    property ID: Integer read FID write FID;
    property Cliente: TCliente read FCliente write FCliente;
    property Carro: TCarro read FCarro write FCarro;
    property Total: Double read FTotal write FTotal;
    property DhVenda: TDateTime read FDhVenda write FDhVenda;
  end;

implementation

{ TVenda }

constructor TVenda.Create(ACliente: TCliente; ACarro: TCarro; ATotal: Double;
  ADhVenda: TDateTime);
begin
  Self.FCliente := TCliente.Create(ACliente);
  Self.FCarro := TCarro.Create(ACarro);
  Self.FTotal := ATotal;
  Self.FDhVenda := ADhVenda;

  if Self.FDhVenda = 0 then
    Self.FDhVenda := Now;
end;

constructor TVenda.Create(AVenda: TVenda);
begin
  Self.Create(AVenda.Cliente, AVenda.Carro, AVenda.Total, AVenda.DhVenda);
end;

destructor TVenda.Destroy;
begin
  FreeAndNil(Self.FCliente);
  FreeAndNil(Self.FCarro);
  inherited;
end;

end.
