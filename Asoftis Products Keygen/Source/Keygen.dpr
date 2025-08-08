program Keygen;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  Licensing in 'Licensing.pas';

var
  RegNum: String;
  I: Integer;

begin
  WriteLn('Asoftis Products Keygen [by RadiXX11]');
  WriteLn('=====================================');
  WriteLn;

  for I := Low(ProductList) to High(ProductList) do
    WriteLn(I, '. ', ProductList[I].Name);

  WriteLn;

  Write('Product Number............: ');
  ReadLn(I);

  if (I >= Low(ProductList)) and (I <= High(ProductList)) then
  begin
    Write('Registration Number (name): ');
    ReadLn(RegNum);

    RegNum := Trim(RegNum);

    if RegNum <> '' then
      WriteLn('Registration Key..........: ', GetRegKey(ProductList[I], RegNum));
  end;

  ReadLn;
end.
