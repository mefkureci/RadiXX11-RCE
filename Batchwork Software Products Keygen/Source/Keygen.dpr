program Keygen;

{$R 'Resources\Resources.res' 'Resources\Resources.rc'}

uses
  Forms,
  FormMain in 'Forms\FormMain.pas' {MainForm},
  Licensing in 'Units\Licensing.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Batchwork Software Products Keygen';
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
