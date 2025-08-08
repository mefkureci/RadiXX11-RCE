unit Licensing;

interface

type
  TProductInfo = record
    Name: String;
    Id: Byte;
    Year: Word;
    LicenseLevel: Byte;
  end;

const
  ProductCount = 8;
  ProductList: array[0..ProductCount - 1] of TProductInfo = (
    (
      Name: 'ez1099';
      Id: 4;
      Year: 2022;
      LicenseLevel: 4;
    ),
    (
      Name: 'ezAccounting';
      Id: 13;
      Year: 2023;
      LicenseLevel: 4;
    ),
    (
      Name: 'ezAch';
      Id: 8;
      Year: 2023;
      LicenseLevel: 4;
    ),
    (
      Name: 'ezCheckPrinting';
      Id: 2;
      Year: 2023;
      LicenseLevel: 4;
    ),
    (
      Name: 'ezCheckPersonal';
      Id: 6;
      Year: 2021;
      LicenseLevel: 4;
    ),
    (
      Name: 'ezPayCheck';
      Id: 1;
      Year: 2023;
      LicenseLevel: 4;
    ),
    (
      Name: 'ezW2';
      Id: 3;
      Year: 2022;
      LicenseLevel: 6;
    ),
    (
      Name: 'ezW2Correction';
      Id: 5;
      Year: 2022;
      LicenseLevel: 6;
    )
  );

function GenerateLicenseKey(const ProductInfo: TProductInfo; const RefNo: String): String;

implementation

uses
  MD5,
  SysUtils;

//--------------------------------------------------------------------------------------------------

function IsHexStr(const S: String): Boolean;
var
  I: Integer;
begin
  for I := 1 to Length(S) do
  begin
    if Pos(UpCase(S[I]), '0123456789ABCDEF') = 0 then
    begin
      Result := False;
      Exit;
    end;
  end;
  Result := True;
end;

//--------------------------------------------------------------------------------------------------

function RandomStr(const Charset: String; Len: Integer): String;
var
  I: Integer;
begin
  SetLength(Result, Len);
  for I := 1 to Len do
    Result[I] := Charset[Random(Length(Charset)) + 1];
end;

//--------------------------------------------------------------------------------------------------

function GenerateLicenseKey(const ProductInfo: TProductInfo; const RefNo: String): String;
const
  Digits = '0123456789';
var
  RefId: String;
begin
  Result := '';
  RefId := StringReplace(UpperCase(Trim(RefNo)), '-', '', [rfReplaceAll]);

  if (Length(RefId) <> 16) or (not IsHexStr(RefId)) then
    Exit;

  Insert('-', RefId, 5);
  Insert('-', RefId, 10);
  Insert('-', RefId, 15);

  Result := Copy(Format('%.4d', [ProductInfo.Year]), 3, 2);
  Result := Result + Result + Format('%.2d', [ProductInfo.Id]) + RandomStr(Digits, 2) + IntToStr(ProductInfo.LicenseLevel) + '001' + RefId + RandomStr(Digits, 18);
  Result := Result + RandomStr(Digits, 1) + Copy(MD5ToString(MD5FromString(Result), True), 1, 4);
end;

end.
