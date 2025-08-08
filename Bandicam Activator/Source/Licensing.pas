unit Licensing;

interface

function ActivateApp(const EMail: String): Boolean;

implementation

uses
  Windows,
  Blowfish,
  MD5,
  SysUtils;

//------------------------------------------------------------------------------

function PathAppend(pszPath, pMore: PAnsiChar): BOOL; stdcall; external 'shlwapi.dll' name 'PathAppendA';

function RtlComputeCrc32(dwInitial: DWORD; pData: Pointer;
  iLen: Integer): DWORD; stdcall; external 'ntdll.dll';

function SHGetValue(hkey: HKEY; pszSubKey, pszValue: PAnsiChar;
  var pdwType: DWORD; pvData: Pointer; var pcbData: DWORD): DWORD; stdcall; external 'shlwapi.dll' name 'SHGetValueA';

function SHSetValue(hkey: HKEY; pszSubKey: PAnsiChar; pszValue: PAnsiChar;
  dwType: DWORD; pvData: Pointer; cbData: DWORD): DWORD; stdcall; external 'shlwapi.dll' name 'SHSetValueA';

//------------------------------------------------------------------------------

function BinToHex(const Buffer; Size: Integer): String;
var
  I: Integer;
begin
  Result := '';
  for I := 0 to Size - 1 do
    Result := Result + LowerCase(IntToHex(Byte(PChar(@Buffer)[I]), 2));
end;

//------------------------------------------------------------------------------

function GetVolumeSerialNumber: DWORD;
var
  FileName: array[0..511] of Char;
  FileInfo: BY_HANDLE_FILE_INFORMATION;
  FileHandle: THandle;
  DataType, DataSize: DWORD;
begin
  Result := 0;
  ZeroMemory(@FileName, SizeOf(FileName));

  if GetWindowsDirectory(FileName, SizeOf(FileName)) <> 0 then
  begin
    PathAppend(FileName, 'notepad.exe');
    FileHandle := CreateFile(FileName, 0, FILE_SHARE_READ	or FILE_SHARE_WRITE,
                    nil, OPEN_EXISTING, 0, 0);

    if FileHandle <> INVALID_HANDLE_VALUE then
    begin
      GetFileInformationByHandle(FileHandle, FileInfo);
      CloseHandle(FileHandle);
      Result := FileInfo.dwVolumeSerialNumber;
      Exit;
    end;
  end;

  ZeroMemory(@FileName, SizeOf(FileName));
  DataType := REG_SZ;
  DataSize := SizeOf(FileName);

  if SHGetValue(HKEY_LOCAL_MACHINE, 'SOFTWARE\BANDISOFT\BANDICAM', 'ProgramPath',
      DataType, @FileName, DataSize) = 0 then
  begin
    FileHandle := CreateFile(FileName, 0, FILE_SHARE_READ	or FILE_SHARE_WRITE,
                    nil, OPEN_EXISTING, 0, 0);

    if FileHandle <> INVALID_HANDLE_VALUE then
    begin
      GetFileInformationByHandle(FileHandle, FileInfo);
      CloseHandle(FileHandle);
      Result := FileInfo.dwVolumeSerialNumber;
    end;
  end;
end;

//------------------------------------------------------------------------------

function ActivateApp(const EMail: String): Boolean;
var
  Buffer: array[0..127] of Byte;
  LocalTime: SYSTEMTIME;
  Digest: TMD5Digest;
  Key, Data, UserData, UserInfo: String;
  VolumeSerialNumber: DWORD;
  P1, P2: Pointer;
  I, Count, DataLen: Integer;
begin
  VolumeSerialNumber := GetVolumeSerialNumber;
  Key := MD5ToString(MD5FromBuffer(VolumeSerialNumber, SizeOf(VolumeSerialNumber)));
  Blowfish_Init(PChar(Key)^, Length(Key));

  // Calculate UserInfo value

  GetLocalTime(LocalTime);
  Data := Format('%s,%.4d%.2d%.2d-%.8X-%.8X-',
            [EMail, LocalTime.wYear, LocalTime.wMonth, LocalTime.wDay,
            RtlComputeCrc32(0, @EMail[1], Length(EMail)), VolumeSerialNumber]);

  Count := 0;
  for I := Length(EMail) + 2 to Length(Data) do
    Inc(Count, Byte(Data[I]));

  Data := Data + Format('%.4d', [Count]);

  // Padding for encryption
  Count := Length(Data) shr 3;

  if (Count * 8) <> Length(Data) then
    Inc(Count);

  DataLen := Count * 8;
  Data := Data + StringOfChar(#0, DataLen - Length(Data));
  FillChar(Buffer, DataLen, 0);

  P1 := @Data[1];
  P2 := @Buffer;

  for I := 1 to Count do
  begin
    Blowfish_Encrypt(P1^, P2^);
    P1 := Pointer(LongWord(P1) + 8);
    P2 := Pointer(LongWord(P2) + 8);
  end;

  UserInfo := BinToHex(Buffer, DataLen);

  // Calculate UserData value

  Key := Copy(Key, 1, 18);
  Digest := MD5FromString(Key);
  Data := Format('%.18s,%s', [Key,
          LowerCase(IntToHex(RtlComputeCrc32(0, @Digest, SizeOf(Digest)) xor $20080902, 0))]);

  // Padding for encryption
  Count := Length(Data) shr 3;

  if (Count * 8) <> Length(Data) then
    Inc(Count);

  DataLen := Count * 8;
  Data := Data + StringOfChar(#0, DataLen - Length(Data));
  FillChar(Buffer, DataLen, 0);

  P1 := @Data[1];
  P2 := @Buffer;

  for I := 1 to Count do
  begin
    Blowfish_Encrypt(P1^, P2^);
    P1 := Pointer(LongWord(P1) + 8);
    P2 := Pointer(LongWord(P2) + 8);
  end;

  UserData := BinToHex(Buffer, DataLen) + #0#0;

  // Write values to registry

  Result := (SHSetValue(HKEY_LOCAL_MACHINE, 'SOFTWARE\BANDISOFT\BANDICAM\OPTION',
            'sUserData', REG_MULTI_SZ, @UserData[1], Length(UserData)) = ERROR_SUCCESS) and
            (SHSetValue(HKEY_LOCAL_MACHINE, 'SOFTWARE\BANDISOFT\BANDICAM\OPTION',
            'sUserInfo', REG_MULTI_SZ, @UserInfo[1], Length(UserInfo)) = ERROR_SUCCESS);
end;

end.
 