unit Licensing;

interface

type
  TProductInfo = record
    Name: String;
    Value1: Word;
    Value2: Word;
    Value3: Word;
    Value4: Word;
    Value5: Word;
  end;

const
  ProductCount = 5;
  ProductList: array[0..ProductCount - 1] of TProductInfo = (
    (
      Name: 'Asoftis 3D Box Creator';
      Value1: $0002;
      Value2: $00DD;
      Value3: $0010;
      Value4: $000A;
      Value5: $01BD;
    ),
    (
      Name: 'Asoftis Burning Studio';
      Value1: $0003;
      Value2: $00BF;
      Value3: $0010;
      Value4: $000E;
      Value5: $026D;
    ),
    (
      Name: 'Asoftis PC Cleaner';
      Value1: $0002;
      Value2: $00F1;
      Value3: $000C;
      Value4: $000A;
      Value5: $01C1;
    ),
    (
      Name: 'Asoftis IP Changer';
      Value1: $0002;
      Value2: $011E;
      Value3: $0011;
      Value4: $000C;
      Value5: $0319;
    ),
    (
      Name: 'Asoftis Start Menu';
      Value1: $0002;
      Value2: $00D2;
      Value3: $0013;
      Value4: $000C;
      Value5: $014E;
    )
  );

function GetRegKey(const ProductInfo: TProductInfo; const RegNum: String): String;

implementation

uses
  SysUtils;

function GetRegKey(const ProductInfo: TProductInfo; const RegNum: String): String;
var
  I, J, K: Integer;
  S: String;
begin
  Result := '';
  S := Trim(RegNum);

  if S <> '' then
  begin
    K := 0;

    for I := 0 to Length(S) do
    begin
      if I > 0 then
      begin
        for J := 0 to 255 do
        begin
          if Byte(S[I]) = J then
            Inc(K, ProductInfo.Value1 * J);
        end;
      end;

      Inc(K, Length(S) * ProductInfo.Value2);
    end;

    Result := IntToStr(K * ProductInfo.Value3) +
              IntToStr(not (K * ProductInfo.Value4 - ProductInfo.Value5));
  end;
end;

end.
