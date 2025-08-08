unit FormMain;

interface

uses
  Windows, SysUtils, Classes, Graphics, Controls, Forms, StdCtrls, ExtCtrls,
  jpeg, VistaAltFixUnit;

type
  TMainForm = class(TForm)
    Bevel: TBevel;
    btnAbout: TButton;
    btnGenerate: TButton;
    cboProduct: TComboBox;
    edtUserName: TEdit;
    imgBanner: TImage;
    lblHomepage: TLabel;
    lblUserName: TLabel;
    lblProduct: TLabel;
    VistaAltFix: TVistaAltFix;

    procedure btnAboutClick(Sender: TObject);
    procedure btnGenerateClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure lblHomepageClick(Sender: TObject);
    procedure lblHomepageMouseEnter(Sender: TObject);
    procedure lblHomepageMouseLeave(Sender: TObject);
    procedure edtUserNameChange(Sender: TObject);
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}
{$WARN UNIT_PLATFORM OFF}

uses
  FileCtrl,
  License,
  Utils;

//------------------------------------------------------------------------------

procedure TMainForm.btnAboutClick(Sender: TObject);
begin
  Application.MessageBox(PChar(Format('%s'#13#10#13#10 +
    'Version 1.0'#13#10#13#10 +
    '© 2019, RadiXX11 [RdX11]', [Caption])), 'About', MB_ICONINFORMATION or MB_OK);
end;

//------------------------------------------------------------------------------

procedure TMainForm.btnGenerateClick(Sender: TObject);
var
  Path: String;
  Valid: Boolean;
begin
  if cboProduct.ItemIndex >= 0 then
  begin
    Path := GetCurrentDir;

    if not IsInstallationDir(ProductList[cboProduct.ItemIndex], Path) then
    begin
      repeat
        if not SelectDirectory('Select installation folder:', '', Path) then
          Exit;

        Valid := IsInstallationDir(ProductList[cboProduct.ItemIndex], Path);

        if not Valid then
          Application.MessageBox(PChar(Format('%s not found in %s',
            [ProductList[cboProduct.ItemIndex].Name, Path])),
            PChar(Caption), MB_ICONWARNING or MB_OK);

      until Valid;
    end;

    if CreateLicenseFile(ProductList[cboProduct.ItemIndex], Path, edtUserName.Text, True) then
      Application.MessageBox(PChar(Format('License file sucessfully created in %s',
        [Path])), PChar(Caption), MB_ICONINFORMATION or MB_OK)
    else
      Application.MessageBox(PChar(Format('Cannot create license file in %s',
        [Path])), PChar(Caption), MB_ICONWARNING or MB_OK);
  end;
end;

//------------------------------------------------------------------------------

procedure TMainForm.edtUserNameChange(Sender: TObject);
begin
  btnGenerate.Enabled := Trim(edtUserName.Text) <> '';
end;

//------------------------------------------------------------------------------

procedure TMainForm.FormCreate(Sender: TObject);
var
  I: Integer;
begin
  Screen.Cursors[crHandPoint] := LoadCursor(0, IDC_HAND);
  Caption := Application.Title;

  cboProduct.Items.BeginUpdate;

  for I := Low(ProductList) to High(ProductList) do
    cboProduct.Items.Add(ProductList[I].Name);

  cboProduct.Items.EndUpdate;

  if cboProduct.Items.Count > 0 then
    cboProduct.ItemIndex := 0;

  edtUserName.Text := Utils.GetUserName;

  edtUserName.OnChange(nil);
  lblHomepage.OnMouseLeave(nil);
end;

//------------------------------------------------------------------------------

procedure TMainForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #27 then Close;
end;

//------------------------------------------------------------------------------

procedure TMainForm.FormShow(Sender: TObject);
begin
  edtUserName.SetFocus;
end;

//------------------------------------------------------------------------------

procedure TMainForm.lblHomepageClick(Sender: TObject);
begin
  if not OpenURL('https://www.apphelmond.com') then
    Application.MessageBox('Cannot open default web browser!', 'Error',
      MB_ICONWARNING or MB_OK);
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

end.
