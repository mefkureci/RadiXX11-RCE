unit FormMain;

interface

uses
  Windows, SysUtils, Classes, Graphics, Controls, Forms, StdCtrls, ExtCtrls,
  jpeg;

type
  TMainForm = class(TForm)
    btnAbout: TButton;
    btnCopy: TButton;
    lblLink: TLabel;
    lblRegKey: TLabel;
    lblRegName: TLabel;
    lblRegEMail: TLabel;
    edtRegEMail: TEdit;
    edtRegKey: TEdit;
    edtRegName: TEdit;
    imgLogo: TImage;
    procedure btnAboutClick(Sender: TObject);
    procedure btnCopyClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure lblLinkClick(Sender: TObject);
    procedure lblLinkMouseEnter(Sender: TObject);
    procedure lblLinkMouseLeave(Sender: TObject);
    procedure OnTextChange(Sender: TObject);
  private
    function GenerateRegKey(const RegName, RegEMail: String): String;
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

uses
  ShellAPI, VistaAltFixUnit;

{$R *.dfm}

//------------------------------------------------------------------------------

procedure TMainForm.btnAboutClick(Sender: TObject);
begin
  Application.MessageBox(PChar(Caption + #13#10#13#10'(c) 2017, RadiXX11'),
    'About', MB_ICONINFORMATION or MB_OK);
end;

//------------------------------------------------------------------------------

procedure TMainForm.btnCopyClick(Sender: TObject);
begin
  edtRegKey.SelectAll;
  edtRegKey.CopyToClipboard;
  edtRegKey.SelLength := 0;
end;

//------------------------------------------------------------------------------

procedure TMainForm.FormCreate(Sender: TObject);
begin
{$IF CompilerVersion < 20}
  // fix for ALT issue
  TVistaAltFix.Create(Self);
{$IFEND}

  // replace ugly Delphi handpoint cursor by system default one
  Screen.Cursors[crHandPoint] := LoadCursor(0, MakeIntResource(IDC_HAND));
end;

//------------------------------------------------------------------------------

procedure TMainForm.FormShow(Sender: TObject);
begin
  OnTextChange(nil);
end;

//------------------------------------------------------------------------------

function TMainForm.GenerateRegKey(const RegName, RegEMail: String): String;
const
  ProductName = 'ALLConverterPRO';
var
  S: String;
  I: Integer;
  Value1, Value2: LongWord;
begin
  Value1 := 1;
  Value2 := 1;

  S := UpperCase(ProductName + RegName);

  for I := 1 to Length(S) do
    Value1 := Value1 + (LongWord(Byte(S[I]) * Value1) div 10);

  S := UpperCase(ProductName + RegEMail);

  for I := 1 to Length(S) do
    Value2 := Value2 + (LongWord(Byte(S[I]) * Value2) div 10);

  Result := IntToStr(value1) + IntToStr(value2);
end;

//------------------------------------------------------------------------------

procedure TMainForm.lblLinkClick(Sender: TObject);
begin
  // try to open link to homepage in default browser
  try
    ShellExecute(Handle, 'open', 'http://www.allconverter.com', nil, nil,
      SW_SHOWNORMAL);
  except
    Application.MessageBox('Unable to open link in default web browser.', nil,
      MB_ICONWARNING or MB_OK);
  end;
end;

//------------------------------------------------------------------------------

procedure TMainForm.lblLinkMouseEnter(Sender: TObject);
begin
  lblLink.Font.Color := clHotLight;
  lblLink.Font.Style := [fsUnderline];
end;

//------------------------------------------------------------------------------

procedure TMainForm.lblLinkMouseLeave(Sender: TObject);
begin
  lblLink.Font.Color := clGrayText;
  lblLink.Font.Style := [];
end;

//------------------------------------------------------------------------------

procedure TMainForm.OnTextChange(Sender: TObject);
begin
  if (edtRegName.Text <> '') and (edtRegEMail.Text <> '') then
  begin
    edtRegKey.Font.Color := clWindowText;
    edtRegKey.Text := GenerateRegKey(edtRegName.Text, edtRegEMail.Text);
    btnCopy.Enabled := True;
  end
  else
  begin
    edtRegKey.Font.Color := clGrayText;
    edtRegKey.Text := 'Enter any name/email you want';
    btnCopy.Enabled := False;
  end;
end;

end.
