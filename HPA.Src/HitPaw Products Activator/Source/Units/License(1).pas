unit License;

interface

type
  TProductInfo = record
    Name: String;
    ProductID: Word;
    LicenseID: String;
    RegKey: String;
  end;

//--------------------------------------------------------------------------------------------------

const
  ProductCount = 7;
  ProductList: array[0..ProductCount - 1] of TProductInfo = (
    (
      Name: 'HitPaw Object Remover';
      ProductID: 5279;
      LicenseID: '5279L1PHitPawObjectRemover';
      RegKey: 'SOFTWARE\HitPaw Software\HitPaw Object Remover';
    ),
    (
      Name: 'HitPaw Photo Enhancer';
      ProductID: 3086;
      LicenseID: '3086L1PHitPawPhotoEnhancer';
      RegKey: 'SOFTWARE\HitPaw Software\HitPawPhotoEnhancer';
    ),
    (
      Name: 'HitPaw Screen Recorder';
      ProductID: 2934;
      LicenseID: '2934L1PHitPawScreenRecorder';
      RegKey: 'SOFTWARE\HitPaw Software\HitPaw Screen Recorder';
    ),
    (
      Name: 'HitPaw Video Converter';
      ProductID: 2705;
      LicenseID: '2705L1PHitPawVideoConverterWin';
      RegKey: 'SOFTWARE\HitPaw Software\HitPawVideoConverter';
    ),
    (
      Name: 'HitPaw Video Editor';
      ProductID: 3526;
      LicenseID: '3526L1PHitPawVideoEditor';
      RegKey: 'SOFTWARE\HitPaw Software\HitPaw Video Editor';
    ),
    (
      Name: 'HitPaw Video Enhancer';
      ProductID: 4781;
      LicenseID: '4781L1PHitPawVideoEnhancer';
      RegKey: 'SOFTWARE\HitPaw Software\HitPaw Video Enhancer';
    ),
    (
      Name: 'HitPaw Watermark Remover';
      ProductID: 2739;
      LicenseID: '2739L1PHitPawRemoveWatermark';
      RegKey: 'SOFTWARE\Tenorshare\RemoveWatermark';
    )
  );

function ActivateProduct(const ProductInfo: TProductInfo; const EMail, SerialNumber: String): Boolean;
function GetSerialNumber(const ProductInfo: TProductInfo; const EMail: String): String;

implementation

uses
  Windows,
  DCPbase64,
  DCPrijndael,
  DCPmd5,
  Registry,
  SysUtils;
  
const
  // AES string Encryption/decryption params.
  Key = '?!.,TENOR@#${[;@';
  IV  = '?!.,@#${TENOR[;@';
  // Local registration info cache format.
  RegInfoFormat = '{'#10+
                  '    "kRegLocalCache_Email": "%s",'#10+
                  '    "kRegLocalCache_ExpiredDate": "",'#10+
                  '    "kRegLocalCache_PID": "%u",'#10+
                  '    "kRegLocalCache_SN": "%s",'#10+
                  '    "kRegLocalCache_UsedPcCount": 1'#10+
                  '}'#10;

//==================================================================================================
// Private Functions
//==================================================================================================

function MD5FromStr(const S: String): String;
begin
  try
    SetLength(Result, 16);
    with TDCP_md5.Create(nil) do
    try
      Init;
      UpdateStr(S);
      Final(Result[1]);
    finally
      Free;
    end;
  except
    Result := '';
  end;
end;

//--------------------------------------------------------------------------------------------------

function MD5ToStr(const S: String): String;
var
  I: Integer;
begin
  Result := '';
  for I := 1 to Length(S) do
    Result := Result + IntToHex(Ord(S[I]), 2);
end;

//--------------------------------------------------------------------------------------------------

function DecryptString(const S, Key, IV: String): String;
var
  I: Integer;
begin
  try
    // Decode the input string from Base64.
    Result := Base64DecodeStr(S);

    // Decrypt the input string with AES.
    with TDCP_rijndael.Create(nil) do
    try
      Init(Key[1], 128, PChar(IV));
      DecryptCBC(Result[1], Result[1], Length(Result));
    finally
      Free;
    end;

    // Remove padding bytes from the result string.
    I := Ord(Result[Length(Result)]);
    Delete(Result, Length(Result) - I + 1, I);
  except
    Result := '';
  end;
end;

//--------------------------------------------------------------------------------------------------

function EncryptString(const S, Key, IV: String): String;
var
  I: Integer;
begin
  try
    // Align the size of input string and fill it with padding bytes.
    I := Length(S);

    if (I mod 16) = 0 then
      Inc(I);

    SetLength(Result, (I + (16 - 1)) and not (16 - 1));
    FillChar(Result[1], Length(Result), Length(Result) - Length(S));
    Move(S[1], Result[1], Length(S));

    // Encrypt the input string with AES.
    with TDCP_rijndael.Create(nil) do
    try
      Init(Key[1], 128, PChar(IV));
      EncryptCBC(Result[1], Result[1], Length(Result));
    finally
      Free;
    end;

    // Encode the result string to Base64.
    Result := Base64EncodeStr(Result);
  except
    Result := '';
  end;
end;

//--------------------------------------------------------------------------------------------------

function ReadRegInfo(const ProductInfo: TProductInfo): String;
begin
  try
    Result := '';

    if ProductInfo.RegKey <> '' then
    begin
      with TRegistry.Create do
      try
        RootKey := HKEY_CURRENT_USER;

        if OpenKey(ProductInfo.RegKey, True) then
        begin
          Result := Trim(ReadString('RegInfo'));

          if Result <> '' then
            Result := DecryptString(Result, Key, IV);

          CloseKey;
        end;
      finally
        Free;
      end;
    end;
  except
    Result := '';
  end;
end;

//--------------------------------------------------------------------------------------------------

function WriteRegInfo(const ProductInfo: TProductInfo; const RegInfo: String): Boolean;
begin
  try
    Result := False;

    if (ProductInfo.RegKey <> '') and (RegInfo <> '') then
    begin
      with TRegistry.Create do
      try
        RootKey := HKEY_CURRENT_USER;

        if OpenKey(ProductInfo.RegKey, True) then
        begin
          WriteString('RegInfo', EncryptString(RegInfo, Key, IV));
          CloseKey;
          Result := True;
        end;
      finally
        Free;
      end;
    end;
  except
    Result := False;
  end;
end;

//==================================================================================================
// Public Functions
//==================================================================================================

function ActivateProduct(const ProductInfo: TProductInfo; const EMail, SerialNumber: String): Boolean;
begin
  Result := WriteRegInfo(ProductInfo, Format(RegInfoFormat, [EMail, ProductInfo.ProductID, SerialNumber]));
end;

//--------------------------------------------------------------------------------------------------

function GetSerialNumber(const ProductInfo: TProductInfo; const EMail: String): String;
var
  Id: String;
  I: Integer;
begin
  // Define the product id string.
  Id := ProductInfo.LicenseID + '_abcdefghijklmn';
  // Get the MD5 hash of the email.
  Result := MD5FromStr(EMail);
  // Xor each byte of the email hash with the product id string.
  for I := 1 to Length(Result) do
    Result[I] := Chr(Ord(Result[I]) xor Ord(Id[I]));
  // Get an hex string from the resulting hash value. This string will be the s/n.
  Result := MD5ToStr(Result);
  // Format the s/n with dashes.
  Insert('-', Result, 7);
  Insert('-', Result, 14);
  Insert('-', Result, 21);
  Insert('-', Result, 28);
end;

end.
