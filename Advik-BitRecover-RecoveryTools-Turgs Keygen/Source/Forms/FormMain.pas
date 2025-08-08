unit FormMain;

interface

uses
  Windows, SysUtils, Classes, Graphics, Controls, Forms, StdCtrls, ExtCtrls,
  VistaAltFixUnit, jpeg;

type
  TMainForm = class(TForm)
    btnAbout: TButton;
    btnCopy: TButton;
    cboDeveloper: TComboBox;
    cboLicense: TComboBox;
    cboProduct: TComboBox;
    edtEMail: TEdit;
    edtLicenseKey: TEdit;
    imgBanner: TImage;
    lblDeveloper: TLabel;
    lblEMail: TLabel;
    lblHomepage: TLabel;
    lblLicense: TLabel;
    lblLicenseKey: TLabel;
    lblProduct: TLabel;
    VistaAltFix: TVistaAltFix;

    procedure btnAboutClick(Sender: TObject);
    procedure btnCopyClick(Sender: TObject);
    procedure cboDeveloperChange(Sender: TObject);
    procedure cboLicenseChange(Sender: TObject);
    procedure cboProductChange(Sender: TObject);
    procedure edtEMailChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure lblHomepageClick(Sender: TObject);
    procedure lblHomepageMouseEnter(Sender: TObject);
    procedure lblHomepageMouseLeave(Sender: TObject);

  private
    procedure InitializeControls;
    procedure LoadLicenseList; 
    procedure LoadProductList;
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
  edtLicenseKey.SelectAll;
  edtLicenseKey.CopyToClipboard;
  edtLicenseKey.SelLength := 0;
end;

//------------------------------------------------------------------------------

procedure TMainForm.cboDeveloperChange(Sender: TObject);
begin
  LoadProductList;
  LoadLicenseList;
  edtEMail.OnChange(nil);
  edtEMail.SetFocus;  
end;

//------------------------------------------------------------------------------

procedure TMainForm.cboLicenseChange(Sender: TObject);
begin
  edtEMail.OnChange(nil);
  edtEMail.SetFocus;
end;

//------------------------------------------------------------------------------

procedure TMainForm.cboProductChange(Sender: TObject);
begin
  LoadLicenseList;
  edtEMail.OnChange(nil);
  edtEMail.SetFocus;
end;

//------------------------------------------------------------------------------

procedure TMainForm.edtEMailChange(Sender: TObject);
var
  ProductIndex: Integer;
  LicenseType: TLicenseType;
begin
  if (cboProduct.ItemIndex >= 0) and (edtEMail.Text <> '') then
  begin
    ProductIndex := Integer(cboProduct.Items.Objects[cboProduct.ItemIndex]);

    if (cboLicense.ItemIndex >= 0) then
      LicenseType := TLicenseType(cboLicense.Items.Objects[cboLicense.ItemIndex])
    else
      LicenseType := Low(TLicenseType);

    edtLicenseKey.Text := GenerateLicenseKey(ProductList[ProductIndex],
                            LicenseType, edtEMail.Text);
    btnCopy.Enabled := True;
  end
  else
  begin
    edtLicenseKey.Text := 'Enter an email or anything you want...';
    btnCopy.Enabled := False;
  end;
end;

//------------------------------------------------------------------------------

procedure TMainForm.FormCreate(Sender: TObject);
begin
  InitializeControls;
end;

//------------------------------------------------------------------------------

procedure TMainForm.FormShow(Sender: TObject);
begin
  edtEMail.SetFocus;
end;

//------------------------------------------------------------------------------

procedure TMainForm.InitializeControls;
var
  Dev: TProductDeveloper;
begin
  Screen.Cursors[crHandPoint] := LoadCursor(0, IDC_HAND);
  Caption := Application.Title;

  cboDeveloper.Items.BeginUpdate;
  cboDeveloper.Items.Clear;

  for Dev := Low(TProductDeveloper) to High(TProductDeveloper) do
    cboDeveloper.Items.Add(DeveloperList[Dev].Name);

  cboDeveloper.Items.EndUpdate;

  if cboDeveloper.Items.Count > 0 then
    cboDeveloper.ItemIndex := 0;

  LoadProductList;
  LoadLicenseList;

  edtEMail.OnChange(nil);
  lblHomepage.OnMouseLeave(nil);
end;

//------------------------------------------------------------------------------

procedure TMainForm.lblHomepageClick(Sender: TObject);
begin
  if cboDeveloper.ItemIndex >= 0 then
    try
      ShellExecute(Handle, 'open',
        PChar(DeveloperList[TProductDeveloper(cboDeveloper.ItemIndex)].Homepage),
        nil, nil, SW_SHOWNORMAL);
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

procedure TMainForm.LoadLicenseList;
var
  Index: Integer;
  License: TLicenseType;
begin
  if cboProduct.ItemIndex >= 0 then
  begin
    Index := Integer(cboProduct.Items.Objects[cboProduct.ItemIndex]);

    if (Index >= Low(ProductList)) and (Index <= High(ProductList)) then
    begin
      if ProductList[Index].SupportedLicenses <> [] then
      begin
        cboLicense.Items.BeginUpdate;
        cboLicense.Items.Clear;

        for License := Low(TLicenseType) to High(TLicenseType) do
        begin
          if License in ProductList[Index].SupportedLicenses then
            cboLicense.Items.AddObject(LicenseList[License], TObject(License));
        end;

        cboLicense.Items.EndUpdate;

        if cboLicense.Items.Count > 0 then
          cboLicense.ItemIndex := 0;

        cboLicense.Enabled := True;
        lblLicense.Enabled := True;
      end
      else
      begin
        cboLicense.Clear;
        cboLicense.Enabled := False;
        lblLicense.Enabled := False;
      end;
    end;
  end;
end;

//------------------------------------------------------------------------------

procedure TMainForm.LoadProductList;
var
  I: Integer;
begin
  if cboDeveloper.ItemIndex >= 0 then
  begin
    cboProduct.Items.BeginUpdate;
    cboProduct.Items.Clear;

    for I := Low(ProductList) to High(ProductList) do
      if ProductList[I].Developer = TProductDeveloper(cboDeveloper.ItemIndex) then
        cboProduct.Items.AddObject(ProductList[I].Name, TObject(I));

    cboProduct.Items.EndUpdate;

    if cboProduct.Items.Count > 0 then
      cboProduct.ItemIndex := 0;
  end;
end;

end.
