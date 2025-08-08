unit FormMain;

interface

uses
  Windows, SysUtils, Classes, Graphics, Controls, Forms, StdCtrls, ComCtrls, ExtCtrls, jpeg;

type
  TMainForm = class(TForm)
    Bevel: TBevel;
    btnGenerate: TButton;
    dtpExpiration: TDateTimePicker;
    edtName: TEdit;
    imgBanner: TImage;
    lblCopyright: TLabel;
    lblExpiration: TLabel;
    lblName: TLabel;
    procedure btnGenerateClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
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
  case ActivateProduct(edtName.Text, dtpExpiration.Date) of
    arOk:
      Application.MessageBox('Product activated successfully.', PChar(Caption), MB_ICONINFORMATION or MB_OK);

    arNameTooShort:
      Application.MessageBox('Name must have at least 4 chars!', PChar(Caption), MB_ICONWARNING or MB_OK);

    arInvalidExpirationDate:
      Application.MessageBox('Invalid expiration date!', PChar(Caption), MB_ICONWARNING or MB_OK);

    arCannotGetLicenseFilePath:
      Application.MessageBox('Cannot get path to license file!', PChar(Caption), MB_ICONWARNING or MB_OK);

    arLicenseFileNotFound:
      Application.MessageBox('You must run the program at least once and close it before activate it!', PChar(Caption), MB_ICONWARNING or MB_OK);

    arCannotUpdateLicenseFile:
      Application.MessageBox('Cannot update license file!', PChar(Caption), MB_ICONWARNING or MB_OK);
  end;
end;

//--------------------------------------------------------------------------------------------------

procedure TMainForm.FormCreate(Sender: TObject);
begin
  Caption := Application.Title;
  edtName.Text := License.GetUserName;
  dtpExpiration.Date := EncodeDate(2050, 1, 1);
end;

//--------------------------------------------------------------------------------------------------

procedure TMainForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #27 then
    Close;
end;

end.
