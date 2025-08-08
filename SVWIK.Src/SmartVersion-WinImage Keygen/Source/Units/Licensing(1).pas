unit Licensing;

interface

type
  TCodeValues = array[0..8] of LongWord;

  TProductInfo = record
    Name: String;
    Values: TCodeValues;
    BlackList: String;
  end;

const
  ProductCount = 2;
  ProductList: array[0..ProductCount - 1] of TProductInfo = (
    (
      Name: 'SmartVersion';
      Values: (
        $12091999,
        $31121999,
        $02062000,
        $13062004,
        $21032004,
        $28032004,
        $05052005,
        $29052005,
        $01122004
      );
      BlackList: '';
    ),
    (
      Name: 'WinImage';
      Values: (
        $10051981,
        $02061997,
        $16062004,
        $13062004,
        $24112005,
        0,
        0,
        0,
        0
      );
      BlackList: 'B8DCDD26';
    )
  );

function GenerateRegCode(const ProductInfo: TProductInfo; const Name: String; var RegCode: String): Integer;

implementation

uses
  Classes,
  SysUtils;

function GenerateRegCode(const ProductInfo: TProductInfo; const Name: String; var RegCode: String): Integer;
var
  S: String;
  I: Integer;
  J, K: LongWord;
begin
  // A name is required!
  if Trim(Name) = '' then
  begin
    Result := 1;
    Exit;
  end;

  // Name cannot begin or end with spaces.
  if Name <> Trim(Name) then
  begin
    Result := 2;
    Exit;
  end;

  // Calculate a checksum of the name.
  S := UpperCase(Name);
  J := Length(S);
  K := $47694C;

  for I := 0 to Length(S) - 1 do
  begin
    if (I mod 14) = 0 then
      J := 39;

    Inc(K, Ord(S[I+1]) * J);

    if ((I + 3) mod 14) <> 0 then
      J := J * 3
    else
      J := J * 7;
  end;

  // Verify if the checksum is blacklisted.
  with TStringList.Create do
  try
    CommaText := ProductInfo.BlackList;

    if IndexOf(IntToHex(K, 0)) >= 0 then
    begin
      Result := 3;
      Exit;
    end;
  finally
    Free;
  end;

  // Take a random special value for this product and add it to the checksum.
  repeat
    J := ProductInfo.Values[Random(9)];
  until J > 0;

  Inc(K, J);

  // Convert the checksum to hex and replace some special chars.
  S := IntToHex(K, 0);

  for I := 1 to Length(S) do
  begin
    if S[I] = '8' then
      S[I] := 'B'
    else if S[I] = 'B' then
      S[I] := '8';
  end;

  // The resulting string from the checksum is the regcode.
  RegCode := S;
  Result := 0;
end;

end.
