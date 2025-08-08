unit Licensing;

interface

//------------------------------------------------------------------------------

type
  TProductInfo = record
    Name: String;
    Value: Integer;
  end;

const
  ProductCount = 3;
  ProductList: array[0..ProductCount - 1] of TProductInfo = (
    (
      Name: 'AIDA64 Business Edition';
      Value: 1;
    ),
    (
      Name: 'AIDA64 Engineer Edition';
      Value: 3;
    ),
    (
      Name: 'AIDA64 Extreme Edition';
      Value: 2;
    )
  );

//------------------------------------------------------------------------------

function GenerateSerial(const ProductInfo: TProductInfo): String;

//------------------------------------------------------------------------------

implementation

uses
  Math;

//------------------------------------------------------------------------------

const
  CharSet = 'DY14UF3RHWCXLQB6IKJT9N5AGS2PM8VZ7E';

//------------------------------------------------------------------------------

function EncodeString1(Value, Len: Integer): String;
var
  I: Integer;
begin
  for I := 1 to Len do
  begin
    Result := CharSet[(Value mod 34) + 1] + Result;
    Value := Value div 34;
  end;
end;

//------------------------------------------------------------------------------

function EncodeString2(const S: String): String;
var
  I, J: Integer;
  K: Word;
begin
  K := 0;

  for I := 1 to Length(S) do
  begin
    K := K xor (Byte(S[I]) shl 8);

    for J := 1 to 8 do
    begin
      if ((K shr 8) and $80) = $80 then
        K := (2 * K) xor $8201
      else
        K := K * 2;
    end;
  end;

  K := K mod $9987;
  Result := CharSet[(K mod $484 div $22) + 1];
end;

//------------------------------------------------------------------------------

function GenerateSerial(const ProductInfo: TProductInfo): String;
var
  S1, S2, S3, S4, S5, S6, S7, S8, S9: String;
  Value1, Value2: Integer;
begin
  Value1 := RandomRange($100, $400);
  Value2 := RandomRange($1A98, $1A99);
  S1 := EncodeString1(Value1, 2);
  S2 := EncodeString1(Byte(Value1) xor ProductInfo.Value xor $BF, 2);
  S3 := EncodeString1(Byte(Value1) xor $330, 2);
  S4 := EncodeString1(Byte(Value1) xor $3F, 2);
  S5 := EncodeString1(Byte(Value1) xor $88, 2);
  S6 := EncodeString1(Word(Value1) xor $47AA, 4);
  S7 := EncodeString1(Word(Value1) xor Value2 xor $7CC1, 4);
  S8 := EncodeString1(Byte(Value1) xor $3FD, 3);
  S9 := EncodeString1(Byte(Value1) xor $C79, 3);
  Result := S2 + S3 + S4 + S5 + S6 + S7 + S8 + S9 + S1;
  Result := Result + EncodeString2(Result);
end;

end.
