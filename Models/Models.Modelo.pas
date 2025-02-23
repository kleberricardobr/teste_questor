unit Models.Modelo;

interface

type
  TModelo = class
  private
    FModelo: string;
    FID: Integer;
  public
    constructor Create(AModelo: string);
    property ID: Integer read FID write FID;
    property Modelo: string read FModelo write FModelo;
  end;

implementation

{ TModelo }

constructor TModelo.Create(AModelo: string);
begin
  Self.FModelo := AModelo;
end;

end.
