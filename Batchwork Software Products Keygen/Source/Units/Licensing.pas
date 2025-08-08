unit Licensing;

interface

// Info about each product

type
  TProductInfo = record
    Name: String;
    AppId: String;
  end;

// List of supported products. TIP: locate the word ".batch-" in the executable
// and above it will appear the secret word (AppId).

const
  ProductCount = 31;
  ProductList: array[0..ProductCount - 1] of TProductInfo = (
    (
      Name: 'Batch Access DB Compactor';
      AppId: 'axeszip'
    ),
    (
      Name: 'Batch CHM to PDF Converter';
      AppId: 'chm2pdf'
    ),
    (
      Name: 'Batch CHM to Word Converter';
      AppId: 'chm2doc'
    ),
    (
      Name: 'Batch DOC and DOCX Converter';
      AppId: 'doc2doc'
    ),
    (
      Name: 'Batch DOC to Help Generator';
      AppId: 'doc2chm'
    ),
    (
      Name: 'Batch DOCX to HTML Converter';
      AppId: 'dox2htm'
    ),
    (
      Name: 'Batch Excel to CSV Converter';
      AppId: 'xls2csv'
    ),
    (
      Name: 'Batch Excel to HTML Converter';
      AppId: 'xls2htm'
    ),
    (
      Name: 'Batch Excel to PDF Converter';
      AppId: 'xls2pdf'
    ),
    (
      Name: 'Batch Excel to Text Converter';
      AppId: 'xls2txt'
    ),
    (
      Name: 'Batch File FTP Sync Uploader';
      AppId: 'ftpsync'
    ),
    (
      Name: 'Batch HTML to MHT Converter';
      AppId: 'htm2mht'
    ),
    (
      Name: 'Batch HXS to Word Converter';
      AppId: 'hxs2doc'
    ),
    (
      Name: 'Batch PPT to EMF Converter';
      AppId: 'ppt2emf'
    ),
    (
      Name: 'Batch PPT to HTML Converter';
      AppId: 'ppt2htm'
    ),
    (
      Name: 'Batch PPT to PDF Converter';
      AppId: 'ppt2pdf'
    ),
    (
      Name: 'Batch PPT to RTF Converter';
      AppId: 'ppt2rtf'
    ),
    (
      Name: 'Batch PPT to TXT Converter';
      AppId: 'ppt2txt'
    ),
    (
      Name: 'Batch PPTX and PPSX Converter';
      AppId: 'ppt2pps'
    ),
    (
      Name: 'Batch PPT and PPTX Converter';
      AppId: 'ppt2ppt'
    ),
    (
      Name: 'Batch RTF to TXT Converter';
      AppId: 'rtf2txt'
    ),
    (
      Name: 'Batch Word Shrink Compactor';
      AppId: 'wordzip'
    ),
    (
      Name: 'Batch Word to EMF Converter';
      AppId: 'doc2emf'
    ),
    (
      Name: 'Batch Word to Excel Converter';
      AppId: 'doc2xls'
    ),
    (
      Name: 'Batch Word to HTML Converter';
      AppId: 'doc2htm'
    ),
    (
      Name: 'Batch Word to PDF Converter';
      AppId: 'doc2pdf'
    ),
    (
      Name: 'Batch Word to PNG Converter';
      AppId: 'doc2png'
    ),
    (
      Name: 'Batch Word to RTF Converter';
      AppId: 'doc2rtf'
    ),
    (
      Name: 'Batch Word to Text Converter';
      AppId: 'doc2txt'
    ),
    (
      Name: 'Batch XLS and XLSX Converter';
      AppId: 'xls2xls'
    ),
    (
      Name: 'Windows Snapshot Grabber';
      AppId: 'wingrab'
    )
  );

function GenerateLicenseCode(const AppId, Name, Mail: String): String;
{$IFDEF DEBUG}
function ValidateLicenseCode(const AppId, LicenseCode: String): Boolean;
{$ENDIF}

implementation

uses
{$IFDEF DEBUG}
  Classes,
{$ENDIF}
  SysUtils;

//------------------------------------------------------------------------------

const
  Data: array[0..63] of Byte = (
    $04, $02, $10, $07, $01, $0C, $00, $1C, $1A, $05, $14, $06, $11, $13, $12,
    $1D, $1F, $1E, $19, $0F, $0D, $16, $03, $17, $1B, $18, $24, $22, $30, $27,
    $21, $2C, $20, $3C, $3A, $25, $34, $26, $31, $33, $32, $3D, $3F, $3E, $39,
    $2F, $2D, $36, $23, $37, $3B, $38, $64, $67, $66, $61, $60, $63, $62, $6D,
    $6C, $65, $74, $15
  );

//------------------------------------------------------------------------------

function Transform1(var a1: Integer; a2: Integer): Integer;
var
  v4: Integer;
begin
  v4 := Round((a1 + 1) * 8.5397342222439876587) mod $10000;
  a1 := v4;
  Result := v4 mod a2;
end;

//------------------------------------------------------------------------------

procedure Transform2(a1: Integer; var a2: array of Byte; a3: Integer);
begin
  a2[a1] := a2[a3] xor a2[a1];
  a2[a3] := a2[a3] xor a2[a1];
  a2[a1] := a2[a3] xor a2[a1];
end;

//------------------------------------------------------------------------------

procedure Transform3(a1: Integer; var a2: array of Byte; a3: Integer;
  var a4: Integer);
var
  I, J: Integer;
begin
  for I := 1 to a3 do
  begin
    for J := a1 - 1 downto 1 do
      Transform2(J, a2, Transform1(a4, J));
  end;
end;

//------------------------------------------------------------------------------

function GenerateLicenseCode(const AppId, Name, Mail: String): String;
var
  Value1, Value2, Value3: array of Byte;
  Code, Mail2: String;
  I, J, R1, R2: Integer;
begin
  Mail2 := Trim(LowerCase(Mail));

  if (AppId = '') or (Trim(Name) = '') or (Mail2 = '') then
  begin
    Result := '';
    Exit;
  end;

  SetLength(Value1, Length(Data));

  for I := 0 to Length(Value1) - 1 do
    Value1[I] := Data[I];

  SetLength(Value2, 16);

  for I := 0 to Length(Value2) - 1 do
    Value2[I] := I + 1;

  SetLength(Value3, 16);

  R1 := 0;

  for I := 1 to Length(Mail2) do
    Inc(R1, Byte(Mail2[I]));

  R2 := 1;

  for I := 1 to Length(AppId) do
    Inc(R2, Byte(AppId[I]));

  for I := 1 to 16 do
  begin
    Transform3(Length(Value1), Value1, Byte(Mail2[(I mod Length(Mail2)) + 1]) xor $7F, R1);
    Transform3(Length(Value2), Value2, Byte(AppId[(I mod Length(AppId)) + 1]) xor $80, R2);

    J := Value2[Transform1(R2, Length(Value2))];

    Value3[I - 1] := Value1[J - 1] xor $FF;

    Transform3(Length(Value1), Value1, Value3[I - 1] xor $55, R1);
  end;

  Code := '';

  for I := 0 to Length(Value3) - 1 do
    Code := Code + Char(Value3[I] xor $AA);

  if Pos('-', Code) = 0 then
    Result := Format('Name=%s'#13#10'Mail=%s'#13#10'Code=%s'#13#10'Quie=1',
              [Trim(Name), Mail2, Code])
  else
    Result := 'Please, try with other Name/Mail...';
end;

//------------------------------------------------------------------------------

{$IFDEF DEBUG}
function ValidateLicenseCode(const AppId, LicenseCode: String): Boolean;
var
  Value1, Value2, Value3: array of Byte;
  Code, Mail: String;
  I, J, Count, R1, R2: Integer;
begin
  Result := False;

  if (AppId = '') or (LicenseCode = '') then Exit;

  with TStringList.Create do
  try
    Text := LicenseCode;
    Mail := Trim(LowerCase(Values['Mail']));
    Code := StringReplace(Trim(Values['Code']), '-', '', [rfReplaceAll]);
  finally
    Free;
  end;

  if (Mail = '') or (Length(Code) <> 16) then Exit;

  SetLength(Value1, Length(Data));

  for I := 0 to Length(Value1) - 1 do
    Value1[I] := Data[I];

  SetLength(Value2, 16);

  for I := 0 to Length(Value2) - 1 do
    Value2[I] := I + 1;

  SetLength(Value3, 16);

  for I := 0 to Length(Value3) - 1 do
    Value3[I] := Byte(Code[I + 1]) xor $AA;

  R1 := 0;

  for I := 1 to Length(Mail) do
    Inc(R1, Byte(Mail[I]));

  R2 := 1;

  for I := 1 to Length(AppId) do
    Inc(R2, Byte(AppId[I]));

  Count := 0;

  for I := 1 to 16 do
  begin
    Transform3(Length(Value1), Value1, Byte(Mail[(I mod Length(Mail)) + 1]) xor $7F, R1);
    Transform3(Length(Value2), Value2, Byte(AppId[(I mod Length(AppId)) + 1]) xor $80, R2);

    J := Value2[Transform1(R2, Length(Value2))];
    J := Value1[J - 1] xor (Value3[I - 1] xor $FF);

    if J <> 0 then
    begin
      Transform1(R1, Length(Value2));
      Transform1(R2, Length(Value2));
      Transform1(R1, Length(Value2));
    end
    else
    begin
      Transform3(Length(Value1), Value1, Value3[I - 1] xor $55, R1);
      Inc(Count);
    end;
  end;

  Result := Count = 16;
end;
{$ENDIF}

end.
