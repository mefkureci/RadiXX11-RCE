program Keygen;

{$R 'Resources\Resources.res' 'Resources\Resources.rc'}

uses
  Forms,
  FormMain in 'Forms\FormMain.pas' {MainForm},
  License in 'Units\License.pas',
  HostsFile in 'Units\HostsFile.pas',
  HashUtils in 'Units\HashUtils.pas',
  MD5 in 'Units\MD5.pas';

{$R *.res}

begin
  Randomize;
  Application.Initialize;
  Application.Title := 'Aurora3D Software Keygen';
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
