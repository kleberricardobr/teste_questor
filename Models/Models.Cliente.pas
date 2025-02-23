unit Models.Cliente;

interface

type
  TCliente = class
  private
    FCPF: string;
    FID: Integer;
    FNome: string;
    FTelefone: string;
  public
    constructor Create(ACPF: string; ANome: string; ATelefone: string;
      AID: Integer = 0); overload;
    constructor Create(ACliente: TCliente); overload;
    property ID: Integer read FID write FID;
    property Nome: string read FNome write FNome;
    property Telefone: string read FTelefone write FTelefone;
    property CPF: string read FCPF write FCPF;
  end;

implementation

{ TCliente }

constructor TCliente.Create(ACPF, ANome, ATelefone: string; AID: Integer = 0);
begin
  Self.FCPF := ACPF;
  Self.FNome := ANome;
  Self.FTelefone := ATelefone;
  Self.FID := AID;
end;

constructor TCliente.Create(ACliente: TCliente);
begin
  Self.Create(ACliente.CPF, ACliente.FNome, ACliente.FTelefone, ACliente.FID);
end;

end.
