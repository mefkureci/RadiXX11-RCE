program Activator;

{$R 'Resources\Resources.res' 'Resources\Resources.rc'}

uses
  Forms,
  FormMain in 'Forms\FormMain.pas' {MainForm},
  DCPbase64 in 'Units\DCPbase64.pas',
  DCPblockciphers in 'Units\DCPblockciphers.pas',
  DCPconst in 'Units\DCPconst.pas',
  DCPcrypt2 in 'Units\DCPcrypt2.pas',
  DCPmd5 in 'Units\DCPmd5.pas',
  DCPrijndael in 'Units\DCPrijndael.pas',
  HostsFile in 'Units\HostsFile.pas',
  License in 'Units\License.pas';

{$R *.res}

begin
  Randomize;
  Application.Initialize;
  Application.Title := 'HitPaw Products Activator';
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
