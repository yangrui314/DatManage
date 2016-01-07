unit formSendEmail;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, formParentMenu, cxLookAndFeels, dxLayoutControl, cxControls,
  ExtCtrls, Menus, cxLookAndFeelPainters, cxGraphics, cxDropDownEdit,
  StdCtrls, cxButtons, cxContainer, cxEdit, cxTextEdit, cxMaskEdit,
  cxCalendar;

type
  TfmSendEmail = class(TfmParentMenu)
    pnlMain: TPanel;
    lcMain: TdxLayoutControl;
    edtBeginDate: TcxDateEdit;
    edtEndDate: TcxDateEdit;
    btnSaveLogAndSendEmail: TcxButton;
    dxLayoutGroup1: TdxLayoutGroup;
    dxLayoutGroup2: TdxLayoutGroup;
    lcMainItem3: TdxLayoutItem;
    lcMainItem2: TdxLayoutItem;
    lcMainItem6: TdxLayoutItem;
    lcMainItem1: TdxLayoutItem;
    edtPathName: TcxComboBox;
    procedure btnSaveLogAndSendEmailClick(Sender: TObject);
  private
    { Private declarations }
  public
    function CreateWorkLogFile : Boolean;
    procedure SendEmail;
  end;

var
  fmSendEmail: TfmSendEmail;

implementation

{$R *.dfm}

function TfmSendEmail.CreateWorkLogFile : Boolean;
begin
  Result := True;    
end;


procedure TfmSendEmail.SendEmail;
begin

end;

procedure TfmSendEmail.btnSaveLogAndSendEmailClick(Sender: TObject);
begin
  inherited;
  if  CreateWorkLogFile then
  begin
    SendEmail;
  end;
end;

end.
