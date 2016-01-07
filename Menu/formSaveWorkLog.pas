unit formSaveWorkLog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, formParentMenu, cxLookAndFeels, dxLayoutControl, cxControls,
  ExtCtrls, cxGraphics, cxSpinEdit, cxDropDownEdit, cxCalendar,
  cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxMemo, Menus,
  cxLookAndFeelPainters, StdCtrls, cxButtons;

type
  TfmSaveWorkLog = class(TfmParentMenu)
    pnlMain: TPanel;
    lcMain: TdxLayoutControl;
    dxLayoutGroup1: TdxLayoutGroup;
    lcMainItem1: TdxLayoutItem;
    edtPathName: TcxComboBox;
    edtBeginDate: TcxDateEdit;
    edtEndDate: TcxDateEdit;
    lcMainItem2: TdxLayoutItem;
    lcMainItem3: TdxLayoutItem;
    edtExpectDay: TcxSpinEdit;
    lcMainItem4: TdxLayoutItem;
    edtWorkLog: TcxMemo;
    lcMainItem5: TdxLayoutItem;
    lcMainGroup1: TdxLayoutGroup;
    btnSaveLog: TcxButton;
    lcMainItem6: TdxLayoutItem;
    procedure btnSaveLogClick(Sender: TObject);
  private
    function CheckParameter : Boolean;
  public
    procedure SaveLog;
  end;

var
  fmSaveWorkLog: TfmSaveWorkLog;

implementation
  uses
    unitWorkLog;

{$R *.dfm}

procedure TfmSaveWorkLog.btnSaveLogClick(Sender: TObject);
begin
  inherited;
  SaveLog;
end;

function TfmSaveWorkLog.CheckParameter : Boolean;
begin
  Result := False;
end;


procedure TfmSaveWorkLog.SaveLog;
var
  WorkLog : TWorkLog;
begin
  WorkLog := TWorkLog.Create;
  try
    WorkLog.EnvironmentName := edtPathName.Text;
    WorkLog.BeginDate := edtBeginDate.EditValue;
    WorkLog.EndDate := edtEndDate.EditValue;
    WorkLog.WorkDay := edtExpectDay.EditValue;
    WorkLog.WorkLog := edtWorkLog.Text;
  finally
    WorkLog.Free;
  end;
end;

initialization
  RegisterClass(TfmSaveWorkLog);

finalization
  UnregisterClass(TfmSaveWorkLog);

end.
