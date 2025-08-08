unit License;

interface

type
  TProductInfo = record
    Name: String;
    Id: String;
    NeedsFormat: Boolean;
  end;

const
  ProductCount = 7;
  ProductList: array[0..ProductCount - 1] of TProductInfo = (
    (
      Name: 'Animation Maker';
      Id: 'AS32 TRE5 HGYJ GF65 TR99 0SDG 0SA3 1543 6OSD ASAW ASAW AA96 43DD SW90 ASAW AA87';
      NeedsFormat: False;
    ),
    (
      Name: 'Barcode Generator';
      Id: 'H3DT 54DL PS3G JKOP SD0I LPO9 ASD3 1WEF LP01 SDCI ASP7 MMK1 54YT CV54 SW5D A3RY';
      NeedsFormat: True;
    ),
    (
      Name: 'DesignBox';
      Id: 'JKIA MLAI QSOP 12XU PO8H A09D 1D9H 4DFP PL09 HDMI YES0 NND1 PPTA CCTV KO07 SXFG';
      NeedsFormat: True;
    ),
    (
      Name: 'ImageConverterPro';
      Id: 'HABE LOSU 81DF 56XU PO09 AS56 12DF 4DFP PL09 HDMI YES0 NND1 KK9D CF3F OP01 DFG4';
      NeedsFormat: True;
    ),
    (
      Name: 'Presentation 2012';
      Id: 'QWER FDS5 TRER 0960 DI99 09FG 0933 1JUT 6OIR PORT DKGO EU96 OIRT DF90 SDFG KI87';
      NeedsFormat: False;
    ),
    (
      Name: 'SVG Viewer & Converter';
      Id: 'SDE4 SD3S DDE3 SD32 SD43 DF54 SD45 1D45 6OWE SEWS ASE3 AWE2 ASAQ AWW2 SSA2 AS33';
      NeedsFormat: False;
    ),
    (
      Name: 'Text & Logo Maker';
      Id: 'ASDR FDS5 34FD 0960 SS99 09FG 0933 1JUT 6OIR PORT DKGO FD45 OIWS DF90 SDFG KI34';
      NeedsFormat: False;
    )
  );

function GenerateSN(const ProductInfo: TProductInfo; const RegInfo: String): String;

implementation

uses
  MD5,
  SysUtils;

function GenerateSN(const ProductInfo: TProductInfo; const RegInfo: String): String;
var
  S: String;
begin
  if ProductInfo.NeedsFormat then
    S := StringReplace(UpperCase(Trim(RegInfo)), '-', '', [rfReplaceAll])
  else
    S := RegInfo;

  Result := Copy(MD5ToString(MD5FromString(S + ProductInfo.Id), True), 4, 20);

  Insert('-', Result, 5);
  Insert('-', Result, 10);
  Insert('-', Result, 15);
  Insert('-', Result, 20);
end;

end.
