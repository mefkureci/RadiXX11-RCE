program Keygen;

{$R 'Resources\Resources.res' 'Resources\Resources.rc'}

uses
  Forms,
  FormMain in 'Forms\FormMain.pas' {MainForm},
  License in 'Units\License.pas',
  Utils in 'Units\Utils.pas',
  DCPbase64 in 'Units\DCPbase64.pas',
  DCPblockciphers in 'Units\DCPblockciphers.pas',
  DCPblowfish in 'Units\DCPblowfish.pas',
  DCPconst in 'Units\DCPconst.pas',
  DCPmd5 in 'Units\DCPmd5.pas',
  DCPrc6 in 'Units\DCPrc6.pas',
  DCPrijndael in 'Units\DCPrijndael.pas',
  DCPripemd160 in 'Units\DCPripemd160.pas',
  DCPsha512 in 'Units\DCPsha512.pas',
  DCPtiger in 'Units\DCPtiger.pas',
  DCPcrypt2 in 'Units\DCPcrypt2.pas';

{$R *.res}

begin
  Randomize;
  Application.Initialize;
  Application.Title := 'APP Helmond Products LicGen';
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
