unit License;

interface

type
  TProductInfo = record
    Name: String;
    EXEName: String;
    Id: String[2];
  end;

const
  ProductCount = 7;
  ProductList: array[0..ProductCount - 1] of TProductInfo = (
    (
      Name: 'Brickaizer 7.x';
      EXEName: 'Brickaizer.exe';
      Id: 'B5';
    ),
    (
      Name: 'Collaizer 2.x';
      EXEName: 'Collaizer.exe';
      Id: 'C8';
    ),
    (
      Name: 'Interactive LiveMosaics! 3.x';
      EXEName: 'ILM.exe';
      Id: 'L4';
    ),
    (
      Name: 'Mosaizer XV 15.x';
      EXEName: 'MosaizerXV.exe';
      Id: 'M1';
    ),
    (
      Name: 'Pattaizer 3.x';
      EXEName: 'Pattaizer.exe';
      Id: 'P6';
    ),
    (
      Name: 'Textaizer Pro 5.x';
      EXEName: 'TextaizerPro.exe';
      Id: 'T2';
    ),
    (
      Name: 'Wordaizer 5.x';
      EXEName: 'Wordaizer.exe';
      Id: 'W3';
    )
  );

function CreateLicenseFile(const ProductInfo: TProductInfo;
  const Path, UserName: String; Lifetime: Boolean): Boolean;
function IsInstallationDir(const ProductInfo: TProductInfo;
  const Path: String): Boolean;
  
implementation

uses
  Classes,
  DCPrc6,
  DCPsha512,
  DCPripemd160,
  DCPblowfish,
  DCPmd5,
  DCPrijndael,
  DCPtiger,
  SysUtils;

//------------------------------------------------------------------------------

function DateToRFC1123(Date: TDateTime): String;
const
  MonthStr = 'JanFebMarAprMayJunJulAugSepOctNovDec';
var
  Y, M, D: Word;
begin
  DecodeDate(Date, Y, M, D);
  Result := Format('%2.2d %s %4.4d', [D, Copy(MonthStr, 1 + 3 * (M - 1), 3), Y]);
end;

//------------------------------------------------------------------------------

function EncryptStr(const S: String): String;
var
  Digest: array[0..19] of Byte;
  I: Integer;
begin
  Result := '';

  with TDCP_ripemd160.Create(nil) do
  try
    Init;
    UpdateStr(S);
    Final(Digest);
  finally
    Free;
  end;

  for I := 0 to 19 do
    Result := Result + IntToHex(Digest[I], 2);
end;

//------------------------------------------------------------------------------

function CreateLicenseFile(const ProductInfo: TProductInfo;
  const Path, UserName: String; Lifetime: Boolean): Boolean;
var
  FileName, Key, Name, S1, S2: String;
begin
  try
    Name := ProductInfo.Id[1] + '_' + StringReplace(Trim(UserName), ' ', '_', [rfReplaceAll]);
    FileName := Name + '.lic';
    Key := EncryptStr(FileName);
    S1 := StringOfChar('_', 22) + Format('%.2d%s', [Length(Name), Name]);
    S2 := '1' + DateToRFC1123(Now) + IntToStr(Integer(LifeTime)) + ProductInfo.Id[2];
    S2 := S2 + StringOfChar('_', Length(S1) - Length(S2));

    with TStringList.Create do
    try

      with TDCP_rc6.Create(nil) do
      try
        InitStr('APP2012', TDCP_sha512);
        Add(EncryptString(S1));
        InitStr(Key, TDCP_sha512);
        Add(EncryptString(S2));
        Burn;

      finally
        Free;
      end;

      with TDCP_blowfish.Create(nil) do
      try
        InitStr(Key, TDCP_md5);
        Add(EncryptString(S2));
        Burn;

      finally
        Free;
      end;

      with TDCP_rijndael.Create(nil) do
      try
        InitStr(Key, TDCP_tiger);
        Add(EncryptString(S2));
        Burn;

      finally
        Free;
      end;

      SaveToFile(IncludeTrailingPathDelimiter(Path) + FileName);
      
      Result := True;

    finally
      Free;
    end;

  except
    Result := False;
  end;
end;

//------------------------------------------------------------------------------

function IsInstallationDir(const ProductInfo: TProductInfo;
  const Path: String): Boolean;
begin
  Result := FileExists(IncludeTrailingPathDelimiter(Path) + ProductInfo.EXEName);
end;

end.
