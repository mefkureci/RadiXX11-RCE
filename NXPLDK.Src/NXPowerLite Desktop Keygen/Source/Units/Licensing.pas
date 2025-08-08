unit Licensing;

interface

function GenerateRegCode: String;

implementation

uses
  MD5,
  SysUtils;

//--------------------------------------------------------------------------------------------------

procedure BufferToBinary(Value: Byte; var Result: array of Byte);
const
  BitMask: array[0..7] of Byte = ($80, $40, $20, $10, $08, $04, $02, $01);
var
  I: Integer;
begin
  if Value > 0 then
  begin
    for I := 0 to 7 do
      Result[I] := Byte((Value and BitMask[I]) <> 0);
  end
  else
    FillChar(Result, 8, 0);
end;

//--------------------------------------------------------------------------------------------------

function GenerateRegCode: String;
const
  Charset = '3V8W4M56F9ABZUCKDSEYG2HJLN7PQRTX';
var
  Arr6: array[0..127] of Byte;
  Arr3, Arr4: array[0..63] of Byte;
  Arr1, Arr2, Arr5: array[0..7] of Byte;
  Hash: TMD5Digest;
  I, J, K, L, M, N: Integer;
begin
  Result := '';

  for I := 0 to 7 do
    Arr1[I] := Random(256);

  Arr1[0] := $FF;
  Arr1[2] := 3;
  Arr1[7] := Arr1[7] and $FE;

  Hash := MD5FromBuffer(Arr1, SizeOf(Arr1));

  for I := 0 to 7 do
    Arr2[I] := Hash.Bytes[I + 8] xor Hash.Bytes[I];

  K := 0;

  for I := 0 to 7 do
  begin
    BufferToBinary(Arr1[I], Arr5);

    for J := 0 to 7 do
    begin
      Arr3[K] := Arr5[J];
      Inc(K);
    end;
  end;

  K := 0;

  for I := 0 to 7 do
  begin
    BufferToBinary(Arr2[I], Arr5);

    for J := 0 to 7 do
    begin
      Arr4[K] := Arr5[J];
      Inc(K);
    end;
  end;

  J := 0;

  for I := 0 to 63 do
  begin
    Arr6[J] := Arr3[I];
    Arr6[J + 1] := Arr4[I];
    Inc(J, 2);
  end;

  N := 0;

  for I := 1 to 25 do
  begin
    K := 0;
    L := 1;
    Inc(N, 5);
    M := N;

    for J := 1 to 5 do
    begin
      Dec(M);
      Inc(K, L * Arr6[M]);
      L := L * 2;
    end;

    Result := Result + Charset[K + 1];
  end;

  Insert('-', Result, 6);
  Insert('-', Result, 12);
  Insert('-', Result, 18);
  Insert('-', Result, 24);
end;

end.
