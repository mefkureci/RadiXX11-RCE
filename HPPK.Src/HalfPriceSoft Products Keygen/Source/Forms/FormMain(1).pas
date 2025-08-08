unit FormMain;

interface

uses
  Windows, SysUtils, Classes, Graphics, Controls, Forms, StdCtrls, ExtCtrls,
  jpeg;

type
  TMainForm = class(TForm)
    Bevel: TBevel;
    btnAbout: TButton;
    btnCopy: TButton;
    btnGenerate: TButton;
    cbProduct: TComboBox;
    edtLicenseKey: TEdit;
    edtRefno: TEdit;
    imgBanner: TImage;
    lblHomepage: TLabel;
    lblLicenseKey: TLabel;
    lblProduct: TLabel;
    lblRefNo: TLabel;

    procedure btnAboutClick(Sender: TObject);
    procedure btnCopyClick(Sender: TObject);
    procedure btnGenerateClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure lblHomepageClick(Sender: TObject);
    procedure lblHomepageMouseEnter(Sender: TObject);
    procedure lblHomepageMouseLeave(Sender: TObject);
    procedure OnChange(Sender: TObject);
    procedure PopulateProductList;
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

uses
  Licensing,
  ShellAPI;

//--------------------------------------------------------------------------------------------------

procedure TMainForm.btnAboutClick(Sender: TObject);
begin
  Application.MessageBox(PChar(Format('%s'#13#10#13#10'Version 1.0'#13#10#13#10'© 2023, RadiXX11', [Caption])), 'About', MB_ICONINFORMATION or MB_OK);
end;

//--------------------------------------------------------------------------------------------------

procedure TMainForm.btnCopyClick(Sender: TObject);
begin
  edtLicenseKey.SelectAll;
  edtLicenseKey.CopyToClipboard;
  edtLicenseKey.SelLength := 0;
end;

//--------------------------------------------------------------------------------------------------

procedure TMainForm.btnGenerateClick(Sender: TObject);
var
  LicenseKey: String;
begin
  btnCopy.Enabled := False;

  if Trim(edtRefNo.Text) <> '' then
  begin
    LicenseKey := GenerateLicenseKey(ProductList[cbProduct.ItemIndex], edtRefNo.Text);

    if LicenseKey <> '' then
    begin
      edtLicenseKey.Font.Color := clWindowText;
      edtLicenseKey.Text := LicenseKey;
      btnCopy.Enabled := True;
    end
    else
    begin
      edtLicenseKey.Font.Color := clGrayText;
      edtLicenseKey.Text := 'Invalid reference number!';

      if Visible then
        edtRefNo.SetFocus;
    end;
  end
  else
  begin
    edtLicenseKey.Font.Color := clGrayText;
    edtLicenseKey.Text := 'Enter reference number...';

    if Visible then
      edtRefNo.SetFocus;
  end;
end;

//--------------------------------------------------------------------------------------------------

procedure TMainForm.FormCreate(Sender: TObject);
begin
  Screen.Cursors[crHandPoint] := LoadCursor(0, IDC_HAND);
  Caption := Application.Title;
  PopulateProductList;
  lblHomepage.OnMouseLeave(nil);
  btnGenerate.OnClick(nil);
end;

//--------------------------------------------------------------------------------------------------

procedure TMainForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #27 then Close;
end;

//--------------------------------------------------------------------------------------------------

procedure TMainForm.FormShow(Sender: TObject);
begin
  edtRefNo.SetFocus;
end;

//--------------------------------------------------------------------------------------------------

procedure TMainForm.lblHomepageClick(Sender: TObject);
begin
  try
    ShellExecute(Handle, 'open', 'https://www.halfpricesoft.com', nil, nil, SW_SHOWNORMAL);
  except
    Application.MessageBox('Cannot open default web browser!', 'Error', MB_ICONWARNING or MB_OK);
  end;
end;

//--------------------------------------------------------------------------------------------------

procedure TMainForm.lblHomepageMouseEnter(Sender: TObject);
begin
  lblHomepage.Font.Color := clHighlight;
end;

//--------------------------------------------------------------------------------------------------

procedure TMainForm.lblHomepageMouseLeave(Sender: TObject);
begin
  lblHomepage.Font.Color := clHotlight;
end;

//--------------------------------------------------------------------------------------------------

procedure TMainForm.OnChange(Sender: TObject);
begin
  btnGenerate.OnClick(nil);
end;

//--------------------------------------------------------------------------------------------------

procedure TMainForm.PopulateProductList;
var
  I: Integer;
begin
  cbProduct.Items.BeginUpdate;
  try
    cbProduct.Items.Clear;

    for I := Low(ProductList) to High(ProductList) do
      cbProduct.Items.Add(Format('%s (%u)', [ProductList[I].Name, ProductList[I].Year]));

    if cbProduct.Items.Count > 0 then
      cbProduct.ItemIndex := 0;
  finally
    cbProduct.Items.EndUpdate;
  end;
end;

end.
