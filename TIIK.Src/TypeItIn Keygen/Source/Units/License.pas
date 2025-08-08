unit License;

interface

type
  TLicenseEdition = (
    leEnterprise,
    leNetwork,
    leProfessional
  );

const
  LicenseEditionStr: array[TLicenseEdition] of String = (
    'Enterprise',
    'Network',
    'Professional'
  );

function GenerateLicense(const Name: String; Edition: TLicenseEdition; Expiration: TDateTime; var Code, Verification: String): Integer;
function GetUserName: String;

implementation

uses
  Windows,
  DateUtils,
  DCPrijndael,
  SysUtils;

//--------------------------------------------------------------------------------------------------

const
  IV: array[0..15] of Byte = ($49, $6E, $69, $74, $20, $56, $65, $63, $74, $6F, $72, $00, $00, $00, $00, $00);

const
  Base64Charset = '+-0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz';

//--------------------------------------------------------------------------------------------------

function Base64DecodeByte(Value: Byte): Byte;
begin
  if (Value >= $30) and (Value <= $39) then
    Result := Value - 48 + 2
  else if (Value >= $41) and (Value <= $5A) then
    Result := Value - 65 + 12
  else if (Value >= $61) and (Value <= $7A) then
    Result := Value - 97 + 38
  else if Value = $2B then
    Result := 0
  else
    Result := Byte(Value = $2D);
end;

//--------------------------------------------------------------------------------------------------

function Base64DecodeStr(const S: String): String;
var
  Values: array[0..4] of Byte;
  I, J: Integer;
begin
  Result := '';
  J := 0;
  FillChar(Values, SizeOf(Values), 0);

  for I := 1 to Length(S) do
  begin
    Values[3] := Ord(S[I]);

    if J <> 0 then
    begin
      case J of
        1:
          begin
            Values[4] := Values[3];
            Values[1] := Base64DecodeByte(Values[4]);
            Result := Result + Chr((Values[1] shr 4) or Values[2]);
            Values[2] := 16 * Values[1];
          end;
        2:
          begin
            Values[1] := Base64DecodeByte(Values[3]);
            Result := Result + Chr((Values[1] shr 2) or Values[2]);
            Values[2] := Values[1] shl 6;
          end;
        3:
          begin
            Values[1] := Base64DecodeByte(Values[3]);
            Result := Result + Chr(Values[1] or Values[2]);
            Values[2] := 0;
          end;
      end;
    end
    else
    begin
      Values[4] := Values[3];
      Values[2] := 4 * Base64DecodeByte(Values[4]);
    end;

    Inc(J);

    if J = 4 then
      J := 0;
  end;
end;

//--------------------------------------------------------------------------------------------------

function Base64EncodeStr(const S: String): String;
var
  Values: array[0..4] of Byte;
  Data: String;
  I, J, Len: Integer;
begin
  Result := '';

  FillChar(Values, SizeOf(Values), 0);

  Data := S;

  if (Length(Data) mod 3) <> 0 then
  begin
    Data := Data + #0;
    Values[1] := 1;
  end;

  J := 0;
  Len := Length(Data);

  for I := 1 to Len do
  begin
    if Len < I then
      Values[3] := 0
    else
      Values[3] := Ord(Data[I]);

    if J <> 0 then
    begin
      if J = 1 then
      begin
        Result := Result + Base64Charset[(((Values[3] and $F0) shr 4) or (16 * (Values[2] and 3))) + 1];
        Values[2] := Values[3];
      end
      else if J = 2 then
      begin
        Result := Result + Base64Charset[(((Values[3] and $C0) shr 6) or (4 * (Values[2] and $0F))) + 1];

        if (Values[1] = 0) or (Len <> I) then
          Result := Result + Base64Charset[(Values[3] and $3F) + 1];

        Values[2] := 0;
      end;
    end
    else
    begin
      Result := Result + Base64Charset[(Values[3] shr 2) + 1];
      Values[2] := Values[3];
    end;

    Inc(J);

    if J = 3 then
      J := 0;
  end;
end;

//--------------------------------------------------------------------------------------------------

function DecryptStr(const S, Key: String): String;
var
  Data: String;
  I: Integer;
begin
  Data := Base64DecodeStr(S);

  SetLength(Result, Length(Data));

  with TDCP_rijndael.Create(nil) do
  try
    Init(PChar(Key)^, Length(Key) * 8, nil);
    SetIV(IV);
    DecryptCBC(PChar(Data)^, PChar(Result)^, Length(Data));
  finally
    Free;
  end;

  I := Ord(Result[Length(Result)]);

  if (I = 0) or (I > 16) then
    Result := Copy(Result, 1, Length(Result) - 1)
  else
    Result := Copy(Result, 1, Length(Result) - I);
end;

//--------------------------------------------------------------------------------------------------

function EncryptStr(const S, Key: String): String;
var
  Data: String;
  I, J: Integer;
begin
  Data := S;
  I := Length(Data) + 1;
  J := 16 - Length(Data) mod 16;
  SetLength(Data, Length(Data) + J);

  while I <= Length(Data) do
  begin
    Data[I] := Chr(J);
    Inc(I);
  end;

  SetLength(Result, Length(Data));

  with TDCP_rijndael.Create(nil) do
  try
    Init(PChar(Key)^, Length(Key) * 8, nil);
    SetIV(IV);
    EncryptCBC(PChar(Data)^, PChar(Result)^, Length(Data));
  finally
    Free;
  end;

  Result := Base64EncodeStr(Result);
end;

//--------------------------------------------------------------------------------------------------

function RandomString(const Charset: String; Len: Integer): String;
var
  I: Integer;
begin
  SetLength(Result, Len);
  for I := 1 to Len do
    Result[I] := Charset[Random(Length(Charset)) + 1];
end;

//--------------------------------------------------------------------------------------------------

function GenerateLicense(const Name: String; Edition: TLicenseEdition; Expiration: TDateTime; var Code, Verification: String): Integer;
const
  Charset = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  EditionId: array[TLicenseEdition] of String = ('E', 'N', 'P');
var
  Data: String;
  Y, M, D: Word;
begin
  Code := '';
  Verification := '';

  if Length(Name) < 4 then
  begin
    Result := 1;
    Exit;
  end;

  if SameText(Name, 'Scully') then
  begin
    Result := 2;
    Exit;
  end;

  if CompareDate(Expiration, Now) <= 0 then
  begin
    Result := 3;
    Exit;
  end;

  DecodeDate(Expiration, Y, M, D);

  Data := EditionId[Edition] + Format('%.3d', [Random(1000)]) + RandomString(Charset, 11);
  Code := EncryptStr(Data, Copy(Name + 'jftwqltpcbstelhydstdt', 1, 14));
  Data := RandomString(Charset, 3) + Format('%s%.2u%.2u', [Copy(IntToStr(Y), 3, 2), M, D]) + RandomString(Charset, 6);
  Verification := EncryptStr(Data, Name);
  Result := 0;
end;

//--------------------------------------------------------------------------------------------------

function GetUserName: String;
var
  Buffer: array[0..255] of Char;
  Size: LongWord;
begin
  Size := 255;
  
  if Windows.GetUserName(Buffer, Size) then
    Result := Buffer
  else
    Result := '';
end;

end.
