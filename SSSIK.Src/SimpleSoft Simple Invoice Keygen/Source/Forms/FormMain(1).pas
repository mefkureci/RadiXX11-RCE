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
    edtActivationCode: TEdit;
    edtEMail: TEdit;
    imgBanner: TImage;
    lblHomepage: TLabel;
    lblActivationCode: TLabel;
    lblEMail: TLabel;

    procedure btnAboutClick(Sender: TObject);
    procedure btnCopyClick(Sender: TObject);
    procedure edtEMailChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure lblHomepageClick(Sender: TObject);
    procedure lblHomepageMouseEnter(Sender: TObject);
    procedure lblHomepageMouseLeave(Sender: TObject);
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
  edtActivationCode.SelectAll;
  edtActivationCode.CopyToClipboard;
  edtActivationCode.SelLength := 0;
end;

//--------------------------------------------------------------------------------------------------

procedure TMainForm.edtEMailChange(Sender: TObject);
begin
  btnCopy.Enabled := False;

  if Trim(edtEMail.Text) <> '' then
  begin
    edtActivationCode.Font.Color := clWindowText;
    edtActivationCode.Text := GetActivationCode(edtEMail.Text);
    btnCopy.Enabled := True;
  end
  else
  begin
    edtActivationCode.Font.Color := clGrayText;
    edtActivationCode.Text := 'Enter any email...';
  end;
end;

//--------------------------------------------------------------------------------------------------

procedure TMainForm.FormCreate(Sender: TObject);
begin
  Screen.Cursors[crHandPoint] := LoadCursor(0, IDC_HAND);
  Caption := Application.Title;
  lblHomepage.OnMouseLeave(nil);
  edtEMail.OnChange(nil);
end;

//--------------------------------------------------------------------------------------------------

procedure TMainForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #27 then Close;
end;

//--------------------------------------------------------------------------------------------------

procedure TMainForm.FormShow(Sender: TObject);
begin
  edtEMail.SetFocus;
end;

//--------------------------------------------------------------------------------------------------

procedure TMainForm.lblHomepageClick(Sender: TObject);
begin
  try
    ShellExecute(Handle, 'open', 'http://www.simple-invoice.co.uk', nil, nil, SW_SHOWNORMAL);
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

end.
