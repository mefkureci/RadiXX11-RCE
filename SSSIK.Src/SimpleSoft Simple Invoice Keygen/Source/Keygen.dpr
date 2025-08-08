program Keygen;

{$R 'Resources\Resources.res' 'Resources\Resources.rc'}

uses
  Forms,
  FormMain in 'Forms\FormMain.pas' {MainForm},
  Licensing in 'Units\Licensing.pas',
  HashUtils in 'Units\HashUtils.pas',
  MD5 in 'Units\MD5.pas';

{$R *.res}

begin
  Randomize;
  Application.Initialize;
  Application.Title := 'SimpleSoft Simple Invoice Keygen';
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
