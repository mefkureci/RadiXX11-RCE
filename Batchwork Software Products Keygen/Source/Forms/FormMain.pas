unit FormMain;

interface

uses
  Windows, SysUtils, Classes, Graphics, Controls, Forms, StdCtrls, ExtCtrls,
  VistaAltFixUnit, jpeg;

type
  TMainForm = class(TForm)
    Bevel: TBevel;
    btnAbout: TButton;
    btnCopy: TButton;
    cboProduct: TComboBox;
    edtMail: TEdit;
    edtName: TEdit;
    imgBanner: TImage;
    lblHomepage: TLabel;
    lblLicenseCode: TLabel;
    lblMail: TLabel;
    lblName: TLabel;
    lblProduct: TLabel;
    mLicenseCode: TMemo;
    VistaAltFix: TVistaAltFix;

    procedure btnAboutClick(Sender: TObject);
    procedure btnCopyClick(Sender: TObject);
    procedure cboProductChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure lblHomepageClick(Sender: TObject);
    procedure lblHomepageMouseEnter(Sender: TObject);
    procedure lblHomepageMouseLeave(Sender: TObject);
    procedure OnChange(Sender: TObject);

  private
    procedure InitializeControls;
    procedure UpdateLicenseCode;
  end;

var
  MainForm: TMainForm;

implementation

uses
  Licensing,
  ShellAPI;

{$R *.dfm}

//------------------------------------------------------------------------------

procedure TMainForm.btnAboutClick(Sender: TObject);
begin
  Application.MessageBox(PChar(Format('%s'#13#10#13#10 +
    'Version 1.0'#13#10#13#10 +
    '© 2018, RadiXX11', [Caption])), 'About', MB_ICONINFORMATION or MB_OK);
end;

//------------------------------------------------------------------------------

procedure TMainForm.btnCopyClick(Sender: TObject);
begin
  mLicenseCode.SelectAll;
  mLicenseCode.CopyToClipboard;
  mLicenseCode.SelLength := 0;
  mLicenseCode.SetFocus;
end;

//------------------------------------------------------------------------------

procedure TMainForm.cboProductChange(Sender: TObject);
begin
  UpdateLicenseCode;

  if edtName.Text = '' then
    edtName.SetFocus
  else if edtMail.Text = '' then
    edtMail.SetFocus
  else
    mLicenseCode.SetFocus;
end;

//------------------------------------------------------------------------------

procedure TMainForm.FormCreate(Sender: TObject);
begin
  InitializeControls;
end;

//------------------------------------------------------------------------------

procedure TMainForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #27 then Close;
end;

//------------------------------------------------------------------------------

procedure TMainForm.FormShow(Sender: TObject);
begin
  UpdateLicenseCode;
  edtName.SetFocus;
end;

//------------------------------------------------------------------------------

procedure TMainForm.InitializeControls;
var
  I: Integer;
begin
  Screen.Cursors[crHandPoint] := LoadCursor(0, IDC_HAND);
  Caption := Application.Title;

  cboProduct.Items.BeginUpdate;
  cboProduct.Items.Clear;

  for I := Low(ProductList) to High(ProductList) do
    cboProduct.Items.Add(ProductList[I].Name);

  cboProduct.Items.EndUpdate;

  if cboProduct.Items.Count > 0 then
    cboProduct.ItemIndex := 0;

  lblHomepage.OnMouseLeave(nil);
end;

//------------------------------------------------------------------------------

procedure TMainForm.lblHomepageClick(Sender: TObject);
begin
  try
    ShellExecute(Handle, 'open', 'http://www.batchwork.com', nil, nil, SW_SHOWNORMAL);
  except
    Application.MessageBox('Cannot open default web browser!', 'Error',
      MB_ICONWARNING or MB_OK);
  end;
end;

//------------------------------------------------------------------------------

procedure TMainForm.lblHomepageMouseEnter(Sender: TObject);
begin
  lblHomepage.Font.Color := clHighlight;
end;

//------------------------------------------------------------------------------

procedure TMainForm.lblHomepageMouseLeave(Sender: TObject);
begin
  lblHomepage.Font.Color := clHotlight;
end;

//------------------------------------------------------------------------------

procedure TMainForm.OnChange(Sender: TObject);
begin
  UpdateLicenseCode;
end;

//------------------------------------------------------------------------------

procedure TMainForm.UpdateLicenseCode;
begin
  if (cboProduct.ItemIndex >= 0) and
    (edtName.Text <> '') and
    (edtMail.Text <> '') then
  begin
    mLicenseCode.Text := GenerateLicenseCode(ProductList[cboProduct.ItemIndex].AppId,
                          edtName.Text, edtMail.Text);
    btnCopy.Enabled := True;
  end
  else
  begin
    mLicenseCode.Clear;
    btnCopy.Enabled := False;
  end;
end;

end.
