unit FormMain;

interface

uses
  Windows, SysUtils, Classes, Graphics, Controls, Forms, StdCtrls, ComCtrls, ExtCtrls, jpeg;

type
  TMainForm = class(TForm)
    Bevel: TBevel;
    btnGenerate: TButton;
    cbEdition: TComboBox;
    dtpExpiration: TDateTimePicker;
    edtCode: TEdit;
    edtName: TEdit;
    edtVerification: TEdit;
    imgBanner: TImage;
    lblCode: TLabel;
    lblCopyright: TLabel;
    lblEdition: TLabel;
    lblExpiration: TLabel;
    lblName: TLabel;
    lblVerification: TLabel;
    procedure btnGenerateClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure UpdateLicense(Sender: TObject);
  private
    procedure PopulateLicenseEdition;
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

uses
  License;

//--------------------------------------------------------------------------------------------------

procedure TMainForm.btnGenerateClick(Sender: TObject);
begin
  UpdateLicense(nil);
end;

//--------------------------------------------------------------------------------------------------

procedure TMainForm.FormCreate(Sender: TObject);
begin
  Caption := Application.Title;
  edtName.Text := License.GetUserName;
  PopulateLicenseEdition;
  dtpExpiration.Date := EncodeDate(2050, 1, 1);
  UpdateLicense(nil);
end;

//--------------------------------------------------------------------------------------------------

procedure TMainForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #27 then
    Close;
end;

//--------------------------------------------------------------------------------------------------

procedure TMainForm.PopulateLicenseEdition;
var
  Edition: TLicenseEdition;
begin
  cbEdition.Items.BeginUpdate;
  try
    cbEdition.Items.Clear;

    for Edition := Low(Edition) to High(Edition) do
      cbEdition.Items.Add(LicenseEditionStr[Edition]);
  finally
    cbEdition.Items.EndUpdate;

    if cbEdition.Items.Count > 0 then
      cbEdition.ItemIndex := 0;
  end;
end;

//--------------------------------------------------------------------------------------------------

procedure TMainForm.UpdateLicense(Sender: TObject);
var
  Code, Verification: String;
begin
  if (Trim(edtName.Text) <> '') then
  begin
    case GenerateLicense(edtName.Text, TLicenseEdition(cbEdition.ItemIndex), dtpExpiration.Date, Code, Verification) of
      1:
        begin
          edtVerification.Text := '';
          edtCode.Text := 'Name must have at least 4 chars!';
          edtCode.Font.Color := clGrayText;
          Exit;
        end;
      2:
        begin
          edtVerification.Text := '';
          edtCode.Text := 'Name is banned!';
          edtCode.Font.Color := clGrayText;
          Exit;
        end;
      3:
        begin
          edtVerification.Text := '';
          edtCode.Text := 'Invalid expiration date!';
          edtCode.Font.Color := clGrayText;
          Exit;
        end;
    end;

    edtVerification.Text := Verification;
    edtCode.Text := Code;
    edtCode.Font.Color := clWindowText;
  end
  else
  begin
    edtVerification.Text := '';
    edtCode.Text := 'Enter a name...';
    edtCode.Font.Color := clGrayText;
  end;
end;

end.
