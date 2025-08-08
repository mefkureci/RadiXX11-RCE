
program Keygen;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  Licensing in 'Licensing.pas';

var
  Option: String;
  I: Integer;

begin
  Randomize;

  repeat
    WriteLn(StringOfChar('=', 27));
    WriteLn('AIDA64 Keygen [by RadiXX11]');
    WriteLn(StringOfChar('-', 27));

    for I := 1 to ProductCount do
      WriteLn(I, '. ', ProductList[I - 1].Name);

    WriteLn(StringOfChar('-', 27));
    WriteLn('0. Exit');
    WriteLn(StringOfChar('=', 27));
    WriteLn;

    repeat
      Write('Select an option and press ENTER: ');
      ReadLn(Option);
      TryStrToInt(Option, I);
    until (I >= 0) and (I <= ProductCount);

    if I > 0 then
    begin
      WriteLn;
      WriteLn(StringOfChar('-', 34));
      WriteLn('Product: ', ProductList[I - 1].Name);
      WriteLn('Serial.: ', GenerateSerial(ProductList[I - 1]));
      WriteLn(StringOfChar('-', 34));
      WriteLn;
    end;
  until I = 0;
end.
