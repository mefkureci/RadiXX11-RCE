//==============================================================================
// License codes generator
//------------------------------------------------------------------------------
// Bigasoft Products Keygen
// © 2016, RadiXX11
//------------------------------------------------------------------------------
// DISCLAIMER
//
// This program is provided "AS IS" without any warranty, either expressed or
// implied, including, but not limited to, the implied warranties of
// merchantability and fitness for a particular purpose.
//
// This program and its source code are distributed for educational and
// practical purposes ONLY.
//
// You are not allowed to get a monetary profit of any kind through its use.
//
// The author will not take any responsibility for the consequences due to the
// improper use of this program and/or its source code.
//==============================================================================

unit ProductLicense;

interface

type
  // Information needed about each product; note that the Id string may
  // change between major versions of each product and need to be updated
  // accordingly, otherwise the generated codes will not work.
  TProductInfo = record
    Name: String;         // <--- name of the product
    Id: String;           // <--- unique id string for the product (generated
                          //      codes depend on this string)
  end;

const
  // List of all supported products from Bigasoft
  ProductCount = 46;
  ProductList: array[0..ProductCount - 1] of TProductInfo = (
    (
      Name: 'Bigasoft 3GP Converter 3.x';
      Id:   'Bigasoft3GP Converter 3';
    ),
    (
      Name: 'Bigasoft ASF Converter 3.x';
      Id:   'BigasoftASF Converter 3';
    ),
    (
      Name: 'Bigasoft Audio Converter 5.x';
      Id:   'BigasoftAudio Converter 4';
    ),
    (
      Name: 'Bigasoft AVCHD Converter 4.x';
      Id:   'BigasoftAVCHD Converter 4';
    ),
    (
      Name: 'Bigasoft AVI Converter 3.x';
      Id:   'BigasoftAVI Converter 3';
    ),
    (
      Name: 'Bigasoft BlackBerry Ringtone Maker 1.x';
      Id:   'BigasoftBlackBerry Ringtone Maker';
    ),
    (
      Name: 'Bigasoft BlackBerry Video Converter 3.x';
      Id:   'BigasoftBlackBerry Video Converter 3';
    ),
    (
      Name: 'Bigasoft DVD to BlackBerry Converter 1.x';
      Id:   'BigasoftDVD to BlackBerry Converter';
    ),
    (
      Name: 'Bigasoft DVD to iPhone Converter 1.x';
      Id:   'BigasoftDVD to iPhone Converter';
    ),
    (
      Name: 'Bigasoft DVD to iPod Converter 1.x';
      Id:   'BigasoftDVD to iPod Converter';
    ),
    (
      Name: 'Bigasoft Facebook Downloader 3.x';
      Id:   'BigasoftFacebook Downloader 3';
    ),
    (
      Name: 'Bigasoft FLV Converter 3.x';
      Id:   'BigasoftFLV Converter 3';
    ),
    (
      Name: 'Bigasoft iPad Video Converter 3.x';
      Id:   'BigasoftiPad Video Converter 3';
    ),
    (
      Name: 'Bigasoft iPhone Ringtone Maker 1.x';
      Id:   'BigasoftiPhone Ringtone Maker';
    ),
    (
      Name: 'Bigasoft iPhone Video Converter 3.x';
      Id:   'BigasoftiPhone Video Converter 3';
    ),
    (
      Name: 'Bigasoft iPod Transfer 1.x';
      Id:   'BigasoftiPod Transfer';
    ),
    (
      Name: 'Bigasoft iPod Video Converter 3.x';
      Id:   'BigasoftiPod Video Converter 3';
    ),
    (
      Name: 'Bigasoft iTunes Video Converter 4.x';
      Id:   'BigasoftiTunes Video Converter 4';
    ),
    (
      Name: 'Bigasoft M4A Converter 4.x';
      Id:   'BigasoftM4A Converter 4';
    ),
    (
      Name: 'Bigasoft MKV Converter 3.x';
      Id:   'BigasoftMKV Converter 3';
    ),
    (
      Name: 'Bigasoft MOV Converter 3.x';
      Id:   'BigasoftMOV Converter 3';
    ),
    (
      Name: 'Bigasoft MP4 Converter 4.x';
      Id:   'BigasoftMP4 Converter 4';
    ),
    (
      Name: 'Bigasoft MPC Converter 3.x';
      Id:   'BigasoftMPC Converter 3';
    ),
    (
      Name: 'Bigasoft ProRes Converter 4.x';
      Id:   'BigasoftProRes Converter 4';
    ),
    (
      Name: 'Bigasoft PSP Video Converter 3.x';
      Id:   'BigasoftPSP Video Converter 3';
    ),
    (
      Name: 'Bigasoft QuickTime Converter 3.x';
      Id:   'BigasoftQuickTime Converter 3';
    ),
    (
      Name: 'Bigasoft RealPlayer Converter 3.x';
      Id:   'BigasoftRealPlayer Converter 3';
    ),
    (
      Name: 'Bigasoft Total Video Converter 5.x';
      Id:   'BigasoftTotal Video Converter 4';
    ),
    (
      Name: 'Bigasoft Video Downloader 3.x';
      Id:   'BigasoftVideo Downloader 3';
    ),
    (
      Name: 'Bigasoft Video Downloader Pro 3.x';
      Id:   'BigasoftVideo Downloader Pro 3';
    ),
    (
      Name: 'Bigasoft VOB Converter 3.x';
      Id:   'BigasoftVOB Converter 3';
    ),
    (
      Name: 'Bigasoft VOB to 3GP Converter 3.x';
      Id:   'BigasoftVOB to 3GP Converter 3';
    ),
    (
      Name: 'Bigasoft VOB to AVI Converter 3.x';
      Id:   'BigasoftVOB to AVI Converter 3';
    ),
    (
      Name: 'Bigasoft VOB to BlackBerry Converter 3.x';
      Id:   'BigasoftVOB to BlackBerry Converter 3';
    ),
    (
      Name: 'Bigasoft VOB to iPad Converter 3.x';
      Id:   'BigasoftVOB to iPad Converter 3';
    ),
    (
      Name: 'Bigasoft VOB to iPhone Converter 3.x';
      Id:   'BigasoftVOB to iPhone Converter 3';
    ),
    (
      Name: 'Bigasoft VOB to iPod Converter 3.x';
      Id:   'BigasoftVOB to iPod Converter 3';
    ),
    (
      Name: 'Bigasoft VOB to MP4 Converter 3.x';
      Id:   'BigasoftVOB to MP4 Converter 3';
    ),
    (
      Name: 'Bigasoft VOB to PSP Converter 3.x';
      Id:   'BigasoftVOB to PSP Converter 3';
    ),
    (
      Name: 'Bigasoft VOB to WebM Converter 3.x';
      Id:   'BigasoftVOB to WebM Converter 3';
    ),
    (
      Name: 'Bigasoft VOB to WMV Converter 3.x';
      Id:   'BigasoftVOB to WMV Converter 3';
    ),
    (
      Name: 'Bigasoft VOB to Zune Converter 3.x';
      Id:   'BigasoftVOB to Zune Converter 3';
    ),
    (
      Name: 'Bigasoft WebM Converter 3.x';
      Id:   'BigasoftWebM Converter 3';
    ),
    (
      Name: 'Bigasoft WMV Converter 3.x';
      Id:   'BigasoftWMV Converter 3';
    ),
    (
      Name: 'Bigasoft WTV Converter 5.x';
      Id:   'BigasoftWTV Converter 4';
    ),
    (
      Name: 'Bigasoft Zune Video Converter 3.x';
      Id:   'BigasoftZune Video Converter 3';
    )
  );

  
// function for license codes generation
function GenerateLicenseCode(const ProductId: String): String;

implementation

uses
  MD5,
  SysUtils;

//------------------------------------------------------------------------------

const
  HexCharset = '0123456789ABCDEF';

function GenerateLicenseCode(const ProductId: String): String;
var
  MD5String, S: String;
  Buffer: PChar;
  I, Index, BufferSize: Integer;
begin
  Result := '';

  if ProductId = '' then Exit;

  for I := 1 to 10 do
  begin
    if (I mod 5) <> 0 then
      Result := Result + HexCharset[Random(Length(HexCharset)) + 1]
    else
      Result := Result + '-';
  end;

  BufferSize := (Length(ProductId) * 3) + 13;

  GetMem(Buffer, BufferSize);

  Buffer[0] := '1';

  Index := 1;

  for I := 1 to Length(ProductId) do
  begin
    if (I and 1) <> 0 then
    begin
      Buffer[Index] := ProductId[I];
      Buffer[Index + 1] := Char(I);

      Inc(Index, 2);
    end;
  end;

  for I := 1 to Length(ProductId) do
  begin
    if (I and 1) = 0 then
    begin
      Buffer[Index] := ProductId[I];
      Buffer[Index + 1] := Char(I);

      Inc(Index, 2);
    end;
  end;

  Buffer[Index] := '0';
  Buffer[Index + 1] := '0';

  Inc(Index, 2);

  for I := 1 to 10 do
  begin
    Buffer[Index] := Result[I];

    Inc(Index);
  end;

  for I := 1 to Length(ProductId) do
  begin
    Buffer[Index] := ProductId[I];

    Inc(Index);
  end;

  MD5String := MD5ToString(MD5FromData(Buffer, BufferSize));

  FreeMem(Buffer);

  Index := 0;

  S := '';

  for I := 1 to Length(MD5String) do
  begin
    if (I and 1) <> 0 then
    begin
      S := S + MD5String[I];

      Inc(Index);

      if Index = 4 then
      begin
        S := S + '-';
        Index := 0;
      end;
    end;
  end;

  Result := Result + UpperCase(Copy(S, 1, Length(S) - 1)) + '-';

  Index := ((Byte(Result[1]) + Byte(Result[2]) + Byte(Result[3]) + Byte(Result[4]) +
            Byte(Result[6]) + Byte(Result[7]) + Byte(Result[8]) + Byte(Result[9]) + 19) mod Length(HexCharset)) + 1;

  Result := Result + HexCharset[Index];

  for I := 2 to 9 do
  begin
    if (I mod 5) <> 0 then
      Result := Result + HexCharset[Random(Length(HexCharset)) + 1]
    else
      Result := Result + '-';
  end;
end;

end.
