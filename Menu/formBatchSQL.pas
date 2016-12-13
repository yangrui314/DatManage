unit formBatchSQL;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, formParentMenu, cxLookAndFeels, dxLayoutControl, cxControls,
  ExtCtrls, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, cxCheckBox, cxSpinEdit, cxTextEdit, cxGridLevel,
  cxGridCustomTableView, cxGridTableView, cxClasses, cxGridCustomView,
  cxGrid, Menus, cxLookAndFeelPainters, StdCtrls, cxButtons, cxContainer,
  cxMemo;

type
  TfmBatchSQL = class(TfmParentMenu)
    pnlBatchSQL: TPanel;
    lcMain: TdxLayoutControl;
    dxLayoutGroup1: TdxLayoutGroup;
    lcMainItem1: TdxLayoutItem;
    gridParameter: TcxGrid;
    dgParameter: TcxGridTableView;
    dgParameterSelected: TcxGridColumn;
    dgParameterID: TcxGridColumn;
    dgParameterPath: TcxGridColumn;
    dgParameterName: TcxGridColumn;
    levelParameter: TcxGridLevel;
    edtSQL: TcxMemo;
    lcMainItem2: TdxLayoutItem;
    cbOK: TcxButton;
    lcMainItem3: TdxLayoutItem;
    procedure FormShow(Sender: TObject);
    procedure cbOKClick(Sender: TObject);
  private
    procedure LoadData;
    procedure LoadSQL(const aSQL : string);
  public
    { Public declarations }
  end;

var
  fmBatchSQL: TfmBatchSQL;

implementation
  uses
    unitConfig,unitHistory,unitTable,unitEnvironment,unitDbisamEnvironment,unitSQLEnvironment;

{$R *.dfm}

procedure TfmBatchSQL.FormShow(Sender: TObject);
begin
  inherited;
  LoadData;
end;


procedure TfmBatchSQL.LoadData;
var
  I : Integer;
  ANewRecId : Integer;
begin
  for I:=0  to Config.Historys.Count - 1 do
  begin
    if  THistory(Config.Historys[I]).ConnectWay <> Config.ConnectWay then
      Continue;

    dgParameter.BeginUpdate;
    try
      ANewRecId := dgParameter.DataController.AppendRecord;
      dgParameter.DataController.Values[ANewRecId,dgParameterSelected.Index] := False;
      dgParameter.DataController.Values[ANewRecId,dgParameterID.Index] := ANewRecId + 1;
      dgParameter.DataController.Values[ANewRecId,dgParameterName.Index] := THistory(Config.Historys[I]).Name;
      dgParameter.DataController.Values[ANewRecId,dgParameterPath.Index] := THistory(Config.Historys[I]).Path;
      dgParameter.DataController.Post();
    finally
      dgParameter.EndUpdate;
    end;
  end;
end;

procedure TfmBatchSQL.cbOKClick(Sender: TObject);
var
  I : Integer;
  TotalCount : Integer;
  aSQL : string;
  aInitSystemParameter,aInitSystemParameterCaption : string;
  aLoadParameters : string;
begin
  inherited;
  TotalCount := dgParameter.DataController.RowCount;
  aSQL := edtSQL.Text;
  if  TotalCount = 0 then Exit;
  if aSQL = '' then
  begin
    ShowMessage('SQL不能为空。请输入SQL.');
  end;

  aInitSystemParameterCaption := Config.SystemParameterCaption;
  aInitSystemParameter := Config.SystemParameter;
  aLoadParameters := '';
  dgParameter.BeginUpdate;
  try
    for i:= 0  to  TotalCount - 1 do
    begin
      if dgParameter.DataController.Values[i,dgParameterSelected.Index] then
      begin
        if aLoadParameters = '' then
        begin
          aLoadParameters := dgParameter.DataController.Values[i,dgParameterName.Index];
        end
        else
        begin
          aLoadParameters := aLoadParameters +','+ dgParameter.DataController.Values[i,dgParameterName.Index];
        end;
        Config.SystemParameterCaption := dgParameter.DataController.Values[i,dgParameterName.Index];
        Config.SystemParameter := dgParameter.DataController.Values[i,dgParameterPath.Index];
        LoadSQL(aSQL);
      end;
    end;
  finally
    dgParameter.EndUpdate;
  end;
  Config.SystemParameterCaption := aInitSystemParameterCaption;
  Config.SystemParameter := aInitSystemParameter;
  ShowMessage(aLoadParameters +'处理成功。');
end;

procedure TfmBatchSQL.LoadSQL(const aSQL : string);
var
  aEnvironment : TEnvironment;
  aTable : TTable;
begin
  if Config.ConnectWay = '1' then
  begin
    aEnvironment := TDbisamEnvironment.Create(Self, Config.SystemParameter);
  end
  else
  begin
    aEnvironment := TSQLEnvironment.Create(Self, Config.SystemParameter);
  end;
  aTable := TTable.Create(aEnvironment, '', '');
  try
    aTable.Environment.SetSQL(aSQL);
  finally
    aTable.Free;
    aEnvironment.Free;
  end;
end;

initialization
  RegisterClass(TfmBatchSQL);

finalization
  UnregisterClass(TfmBatchSQL);

end.
