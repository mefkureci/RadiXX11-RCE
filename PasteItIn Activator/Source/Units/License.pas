unit License;

interface

type
  TActivationResult = (
    arOk,
    arNameTooShort,
    arInvalidExpirationDate,
    arCannotGetLicenseFilePath,
    arLicenseFileNotFound,
    arCannotUpdateLicenseFile
  );

function ActivateProduct(const Name: String; const Expiration: TDateTime): TActivationResult;
function GetUserName: String;

implementation

uses
  Windows,
  Classes,
  DateUtils,
  DCPrijndael,
  SysUtils;

//--------------------------------------------------------------------------------------------------

const
  IV: array[0..15] of Byte = ($49, $6E, $69, $74, $20, $56, $65, $63, $74, $6F, $72, $00, $00, $00, $00, $00);

const
  Base64Charset = '+-0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz';

const
  SHGFP_TYPE_CURRENT  = 0;
  CSIDL_LOCAL_APPDATA = $001C;

function SHGetFolderPath(hwnd: HWND; csidl: Integer; hToken: THandle; dwFlags: DWORD; pszPath: LPSTR): HResult; stdcall; external 'shell32.dll' name 'SHGetFolderPathA';

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

function ActivateProduct(const Name: String; const Expiration: TDateTime): TActivationResult;
var
  Path: array[0..MAX_PATH] of Char;
  Dir, FileName: String;
  I: Integer;
  Y, M, D: Word;
begin
  if Length(Name) < 4 then
  begin
    Result := arNameTooShort;
    Exit;
  end;

  if CompareDate(Expiration, Now) <= 0 then
  begin
    Result := arInvalidExpirationDate;
    Exit;
  end;

  if not SHGetFolderPath(0, CSIDL_LOCAL_APPDATA, 0, SHGFP_TYPE_CURRENT, Path) = S_OK then
  begin
    Result := arCannotGetLicenseFilePath;
    Exit;
  end;

  Dir := IncludeTrailingPathDelimiter(Path) + 'PasteItIn';

  if not ForceDirectories(Dir) then
  begin
    Result := arCannotGetLicenseFilePath;
    Exit;
  end;

  FileName := Dir + '\PasteItIn.dat';

  if not FileExists(FileName) then
  begin
    Result := arLicenseFileNotFound;
    Exit;
  end;

  try
    with TStringList.Create do
    try
      LoadFromFile(FileName);

      if Count < 65 then
      begin
        for I := 1 to 65 - Count do
          Add('');
      end;

      DecodeDate(Expiration, Y, M, D);

      Strings[62] := EncryptStr(Name, 'PasteItIn');
      Strings[63] := EncryptStr(Format('%s%.2u%.2u', [Copy(IntToStr(Y), 3, 2), M, D]), 'PasteItIn');

      SaveToFile(FileName);

      Result := arOk;
    finally
      Free;
    end;
  except
    Result := arCannotUpdateLicenseFile;
  end;
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
