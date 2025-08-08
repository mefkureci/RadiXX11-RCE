program Keygen;

{$APPTYPE CONSOLE}

uses
  SysUtils;

function GenerateLicenseKey: String;
const
  Charset = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ';
var
  I: Integer;
begin
  SetLength(Result, 19);

  for I := 1 to Length(Result) do
    Result[I] := Charset[Random(Length(Charset)) + 1];

  Result[7] := '3';
  Result[13] := 'P';
  Result[17] := 'D';
end;

begin
  // https://www.best-pdf-tools.com
  
  Randomize;

  WriteLn('AlterPDF 3.x Keygen [by RadiXX11]');
  WriteLn('=================================');
  WriteLn;
  WriteLn('License Key: ', GenerateLicenseKey);

  Readln;
end.
 