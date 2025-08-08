program Activator;

{$APPTYPE CONSOLE}

{$R 'Resources.res' 'Resources.rc'}

uses
  Licensing in 'Licensing.pas';

var
  EMail: String;

begin
  WriteLn('Bandicam Activator [by RadiXX11]');
  WriteLn('================================');
  WriteLn;
  WriteLn('IMPORTANT: Close Bandicam before activate and block the program with a firewall');
  WriteLn('before use!');
  WriteLn;

  Write('EMail: ');
  ReadLn(EMail);
  WriteLn;

  if EMail <> '' then
  begin
    if Length(EMail) >= 10 then
    begin
      if ActivateApp(EMail) then
        WriteLn('Application activated sucessfully.')
      else
        WriteLn('Cannot activate the application!');
    end
    else
      WriteLn('EMail must have at least 10 characters!');
  end;

  ReadLn;
end.
