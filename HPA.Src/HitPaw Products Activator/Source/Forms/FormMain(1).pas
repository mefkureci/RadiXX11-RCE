unit FormMain;

interface

uses
  Windows, SysUtils, Classes, Graphics, Controls, Forms, StdCtrls, ExtCtrls,
  jpeg;

type
  TMainForm = class(TForm)
    Bevel: TBevel;
    btnAbout: TButton;
    btnActivate: TButton;
    btnPatchHosts: TButton;
    cboProduct: TComboBox;
    edtEMail: TEdit;
    edtSN: TMemo;
    imgBanner: TImage;
    lblHomepage: TLabel;
    lblProduct: TLabel;
    lblEMail: TLabel;
    lblSN: TLabel;

    procedure btnAboutClick(Sender: TObject);
    procedure btnActivateClick(Sender: TObject);
    procedure btnPatchHostsClick(Sender: TObject);
    procedure cboProductChange(Sender: TObject);
    procedure cboProductDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure edtEMailChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure lblHomepageClick(Sender: TObject);
    procedure lblHomepageMouseEnter(Sender: TObject);
    procedure lblHomepageMouseLeave(Sender: TObject);

  private
    procedure PopulateProductList;
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

uses
  HostsFile,
  License,
  ShellAPI;

//--------------------------------------------------------------------------------------------------

procedure TMainForm.btnAboutClick(Sender: TObject);
begin
  Application.MessageBox(PChar(Format('%s'#13#10#13#10 +
    'Version 1.0'#13#10#13#10 +
    '© 2023, RadiXX11', [Caption])), 'About', MB_ICONINFORMATION or MB_OK);
end;

//--------------------------------------------------------------------------------------------------

procedure TMainForm.btnActivateClick(Sender: TObject);
begin
  if (cboProduct.ItemIndex >= 0) and (Trim(edtEMail.Text) <> '') and (edtSN.Text <> '') then
  begin
    if ActivateProduct(ProductList[cboProduct.ItemIndex], edtEMail.Text, edtSN.Text) then
      Application.MessageBox(PChar(Format('%s activated successfully.', [ProductList[cboProduct.ItemIndex].Name])), PChar(Caption), MB_ICONINFORMATION or MB_OK)
    else
      Application.MessageBox(PChar(Format('Could not activate %s!', [ProductList[cboProduct.ItemIndex].Name])), PChar(Caption), MB_ICONWARNING or MB_OK);
  end;
end;

//--------------------------------------------------------------------------------------------------

procedure TMainForm.btnPatchHostsClick(Sender: TObject);
const
  Host = 'check.mobie.app';
begin
  try
    if HostsEntryExists(Host) then
    begin
      Application.MessageBox('Hosts file already patched.', PChar(Caption), MB_ICONINFORMATION or MB_OK);
      Exit;
    end;

    AddHostsEntry('0.0.0.0', Host);

    Application.MessageBox('Hosts file patched sucessfully.', PChar(Caption), MB_ICONINFORMATION or MB_OK);

  except
    Application.MessageBox('Cannot open the hosts file!', PChar(Caption), MB_ICONWARNING or MB_OK);
  end;
end;

//--------------------------------------------------------------------------------------------------

procedure TMainForm.cboProductChange(Sender: TObject);
begin
  edtEMail.OnChange(nil);
end;

//--------------------------------------------------------------------------------------------------

procedure TMainForm.cboProductDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
var
  Text : String;
begin
  Text := cboProduct.Items[Index];

  if odSelected in State then
    cboProduct.Canvas.Brush.Color := clHighlight
  else
    cboProduct.Canvas.Brush.Color := clWindow;

  cboProduct.Canvas.FillRect(Rect);

  DrawText(cboProduct.Canvas.Handle, PChar(Text), Length(Text), Rect, DT_VCENTER + DT_SINGLELINE + DT_CENTER + DT_NOPREFIX);
end;

//--------------------------------------------------------------------------------------------------

procedure TMainForm.edtEMailChange(Sender: TObject);
begin
  if (cboProduct.ItemIndex >= 0) and (Trim(edtEMail.Text) <> '') then
  begin
    edtSN.Font.Color := clWindowText;
    edtSN.Text := GetSerialNumber(ProductList[cboProduct.ItemIndex], edtEMail.Text);
    btnActivate.Enabled := True;
  end
  else
  begin
    edtSN.Font.Color := clBtnShadow;
    edtSN.Text := 'Enter an email or name...';
    btnActivate.Enabled := False;
  end;
end;

//--------------------------------------------------------------------------------------------------

procedure TMainForm.FormCreate(Sender: TObject);
begin
  Screen.Cursors[crHandPoint] := LoadCursor(0, IDC_HAND);
  Caption := Application.Title;
  PopulateProductList;
  lblHomepage.OnMouseLeave(nil);
end;

//--------------------------------------------------------------------------------------------------

procedure TMainForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #27 then Close;
end;

//--------------------------------------------------------------------------------------------------

procedure TMainForm.FormShow(Sender: TObject);
begin
  edtEMail.OnChange(nil);
end;

//--------------------------------------------------------------------------------------------------

procedure TMainForm.lblHomepageClick(Sender: TObject);
begin
  try
    ShellExecute(Handle, 'open', 'https://www.hitpaw.com', nil, nil, SW_SHOWNORMAL);
  except
    Application.MessageBox('Cannot open default web browser!', PChar(Caption), MB_ICONWARNING or MB_OK);
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

procedure TMainForm.PopulateProductList;
var
  I: Integer;
begin
  cboProduct.Items.BeginUpdate;

  for I := Low(ProductList) to High(ProductList) do
    cboProduct.Items.Add(ProductList[I].Name);

  cboProduct.Items.EndUpdate;

  if cboProduct.Items.Count > 0 then
    cboProduct.ItemIndex := 0;
end;

end.
