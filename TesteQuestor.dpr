program TesteQuestor;

uses
  Vcl.Forms,
  Principal in 'Principal.pas' {FrmQuestor},
  Models.Cliente in 'Models\Models.Cliente.pas',
  Models.Carro in 'Models\Models.Carro.pas',
  Models.Modelo in 'Models\Models.Modelo.pas',
  Models.Venda in 'Models\Models.Venda.pas',
  Services.ClienteService in 'Services\Services.ClienteService.pas',
  Daos.ClienteDao in 'Daos\Daos.ClienteDao.pas',
  Utils.Input in 'Utils\Utils.Input.pas',
  Daos.CarroDao in 'Daos\Daos.CarroDao.pas',
  Services.CarroService in 'Services\Services.CarroService.pas',
  Utils.Date in 'Utils\Utils.Date.pas',
  Daos.VendaDao in 'Daos\Daos.VendaDao.pas',
  Services.VendaService in 'Services\Services.VendaService.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmQuestor, FrmQuestor);
  Application.Run;
end.
