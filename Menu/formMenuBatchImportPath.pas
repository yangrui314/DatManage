unit formMenuBatchImportPath;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, formParentMenu, cxLookAndFeels, cxStyles, cxCustomData,
  cxGraphics, cxFilter, cxData, cxDataStorage, cxEdit, cxCheckBox,
  cxSpinEdit, cxTextEdit, Menus, cxLookAndFeelPainters, dxLayoutControl,
  StdCtrls, cxButtons, cxContainer, cxMemo, cxGridLevel,
  cxGridCustomTableView, cxGridTableView, cxClasses, cxControls,
  cxGridCustomView, cxGrid, ExtCtrls, cxButtonEdit, cxMaskEdit,
  cxDropDownEdit, cxImageComboBox, cxPC, cxLabel;

type
  TfmMenuBatchImportPath = class(TfmParentMenu)
    pnlMain: TPanel;
    PageExport: TcxPageControl;
    SheetConfig: TcxTabSheet;
    dxLayoutControl1: TdxLayoutControl;
    edtFilePath: TcxButtonEdit;
    cbClearOld: TcxCheckBox;
    lcMainGroup_Root: TdxLayoutGroup;
    lcMainItem1: TdxLayoutItem;
    lcMainItem3: TdxLayoutItem;
    SheetPreview: TcxTabSheet;
    pnlPreview: TPanel;
    gridParameter: TcxGrid;
    dgParameter: TcxGridTableView;
    dgParameterSelected: TcxGridColumn;
    dgParameterID: TcxGridColumn;
    dgParameterFullName: TcxGridColumn;
    dgParameterOutputDir: TcxGridColumn;
    levelParameter: TcxGridLevel;
    pnlCommand: TPanel;
    dxLayoutControl2: TdxLayoutControl;
    btnFinish: TcxButton;
    btnNext: TcxButton;
    btnPrevious: TcxButton;
    dxLayoutControl1Group_Root: TdxLayoutGroup;
    dxLayoutControl1Item3: TdxLayoutItem;
    dxLayoutControl1Item2: TdxLayoutItem;
    dxLayoutControl1Item1: TdxLayoutItem;
    dgParameterPath: TcxGridColumn;
    dgParameterConditionals: TcxGridColumn;
    dgParameterName: TcxGridColumn;
    procedure btnFilePathPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure btnFilePathPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption;
      var Error: Boolean);
    procedure btnNextClick(Sender: TObject);
    procedure btnPreviousClick(Sender: TObject);
    procedure btnFinishClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FFilePath : String;
    FIsClearOld : Boolean;
    procedure NavigateChange(aPageIndex: Integer);
    function GetActivePage : Integer;
    procedure SetActivePage(const Value: Integer);
    procedure LoadPreview;
    procedure SaveData;
  public
    property ActivePage: Integer read GetActivePage write SetActivePage ;
  end;

var
  fmMenuBatchImportPath: TfmMenuBatchImportPath;

implementation

  uses
    FileCtrl,StrUtils,unitConditionals,unitConfigHelper,unitHistory,unitConfig;

{$R *.dfm}


procedure TfmMenuBatchImportPath.btnFilePathPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
var
  DirectoryPath : String;
begin
  if SelectDirectory('请指定文件夹', '', DirectoryPath) then
  begin
    if RightStr(DirectoryPath, 1) = '\' then
      edtFilePath.Text := DirectoryPath
    else
      edtFilePath.Text := DirectoryPath + '\';
  end;
  FFilePath := edtFilePath.Text;
end;

procedure TfmMenuBatchImportPath.btnFilePathPropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
begin
  inherited;
  FFilePath := DisplayValue;
end;

procedure TfmMenuBatchImportPath.btnNextClick(Sender: TObject);
var
  aActivePageIndex: Integer;
begin
  (* 下一步 *)
  FFilePath := edtFilePath.Text;
  if FFilePath = '' then
  begin
    ShowMessage('请设置路径。');
    Exit;
  end;

  aActivePageIndex := ActivePage;
  try
    if aActivePageIndex <> PageExport.PageCount - 1 then
      NavigateChange(aActivePageIndex + 1);
  except on E: Exception do
    begin
      NavigateChange(aActivePageIndex);
      ShowMessage('导出失败。');
    end;
  end;
end;

procedure TfmMenuBatchImportPath.btnPreviousClick(Sender: TObject);
var
  aActivePageIndex: Integer;
begin
  (* 上一步 *)
  aActivePageIndex := ActivePage;
  try
    if ActivePage <> 0 then
      NavigateChange(ActivePage - 1 );
  except on E: Exception do
    begin
      NavigateChange(aActivePageIndex);
      ShowMessage('导出失败。');
    end;
  end;
end;

procedure TfmMenuBatchImportPath.btnFinishClick(Sender: TObject);
begin
  SaveData;
  Close;
end;

procedure TfmMenuBatchImportPath.NavigateChange(aPageIndex: Integer);
begin
  { 导航变化处理:  0: 设置参数；1：预览}
    case aPageIndex of
      0:begin
          ActivePage := 0;
          FIsClearOld := cbClearOld.Checked; 
          btnPrevious.Visible := False;
          btnNext.Visible := True;
          btnFinish.Visible := False;
          Self.Caption := '第一步：设置参数';
        end;
      1:begin
          ActivePage := 1;
          FIsClearOld := cbClearOld.Checked;           
          btnPrevious.Visible := True;
          btnNext.Visible := False;
          btnFinish.Visible := True;
          Self.Caption := '第二步：预览';
          LoadPreview;
        end;
    end;
end;


procedure TfmMenuBatchImportPath.LoadPreview;
var
  I,J: Integer;
  aSelectStr : String;
  aAllStr,aHandleStr , aRemainStr : String;
  aName,aOutputDir,aConditionals : String;
  aCdn : TConditionals;
  aReadMeFilePath : String;
  ANewRecId : Integer;
  TotalCount : Integer;
  aNum : Integer;
  aIsLoad : Boolean; 
begin
  TotalCount := dgParameter.DataController.RowCount;
  if TotalCount <> 0 then
  begin
    dgParameter.BeginUpdate;
    try
      for J:= 0  to  TotalCount - 1 do
      begin
        dgParameter.DataController.DeleteRecord(TotalCount - 1  - J);
      end;
    finally
      dgParameter.EndUpdate;
    end;      
  end;

  aCdn := TConditionals.Create;
  I := 1;
  aReadMeFilePath := FFilePath + 'trunk\engineering\src\delphi\'+'Readme.txt';
  try
    aSelectStr := IntToStr(I) + '、';
    aNum := aCdn.GetStrNum(aReadMeFilePath,aSelectStr);
    aIsLoad := False;
    while aNum <> 0  do
    begin
//      if (aNum <> 1) and (not aIsLoad) then
//      begin
//        aIsLoad := True;
//        aHandleStr := aCdn.GetFileMidStr(aReadMeFilePath,aSelectStr,aSelectStr);
//      end
//      else
//      begin
        if (aCdn.GetStrNum(aReadMeFilePath,IntToStr(I+1) +'、') <> 0) then
        begin
          aHandleStr := aCdn.GetFileMidStr(aReadMeFilePath,aSelectStr,IntToStr(I+1) +'、');
        end
        else
        begin
          aHandleStr := aCdn.GetFileMidStr(aReadMeFilePath,aSelectStr);
        end;      
//      end;

      aCdn.AnalysisStr(aHandleStr,aName,aOutputDir,aConditionals);
      //ShowMessage(aName + ',' + aOutputDir + ','+ aConditionals);

      dgParameter.BeginUpdate;
      try
        ANewRecId := dgParameter.DataController.AppendRecord;
        dgParameter.DataController.Values[ANewRecId,dgParameterSelected.Index] := False;
        dgParameter.DataController.Values[ANewRecId,dgParameterID.Index] := ANewRecId + 1;
        dgParameter.DataController.Values[ANewRecId,dgParameterFullName.Index] := aName;
        dgParameter.DataController.Values[ANewRecId,dgParameterOutputDir.Index] := aOutputDir;
        dgParameter.DataController.Values[ANewRecId,dgParameterPath.Index] := aCdn.ConvertToPath(FFilePath,aOutputDir);
        dgParameter.DataController.Values[ANewRecId,dgParameterConditionals.Index] := aConditionals;
        dgParameter.DataController.Post();
      finally
        dgParameter.EndUpdate;
      end;
//      if (aNum = 1) or aIsLoad then
//      begin
        Inc(I);
//      end;

      aSelectStr := IntToStr(I) + '、';
      aNum := aCdn.GetStrNum(aReadMeFilePath,aSelectStr);      
    end;
  finally
    aCdn.Free;
  end;
end;


procedure TfmMenuBatchImportPath.SaveData;
var
  I,J: Integer;
  TotalCount : Integer;
  aConfigHelper : TConfigHelper;
  aHistory : THistory;
  aTotalCount : Integer;
begin
  inherited;
//  Config.Historys.Clear;
  aTotalCount := Config.Historys.Count;
  if FIsClearOld then
  begin
    for J:= 0  to  aTotalCount - 1 do
    begin
      Config.Historys.Delete(aTotalCount - 1  - J);
    end;  
  end;


  TotalCount := dgParameter.DataController.RowCount;
  if  TotalCount = 0 then Exit;
  dgParameter.BeginUpdate;
  try
//    if FIsClearOld then
//    begin
//      aConfigFile.ClearHistorys;
//    end;
    for i:= 0  to  TotalCount - 1 do
    begin
      if dgParameter.DataController.Values[i,dgParameterSelected.Index] then
      begin
        aHistory := THistory.Create;
        aHistory.ConnectWay := '1';
        aHistory.Name :=  dgParameter.DataController.Values[i,dgParameterName.Index];
        aHistory.Path :=  dgParameter.DataController.Values[i,dgParameterPath.Index];
        aHistory.FullName :=  dgParameter.DataController.Values[i,dgParameterFullName.Index];
        aHistory.OutputDir :=  dgParameter.DataController.Values[i,dgParameterOutputDir.Index];
        aHistory.Conditionals :=  dgParameter.DataController.Values[i,dgParameterConditionals.Index];
//        aConfigFile.SaveHistory(aHistory);
        Config.Historys.Add(aHistory);
       end;
    end;
  finally
    dgParameter.EndUpdate;
  end;
  ShowMessage('导入数据成功。');
end;

function TfmMenuBatchImportPath.GetActivePage : Integer;
begin
  Result := PageExport.ActivePageIndex;
end;

procedure TfmMenuBatchImportPath.SetActivePage(const Value: Integer);
begin
  PageExport.ActivePageIndex := Value;
end;

procedure TfmMenuBatchImportPath.FormShow(Sender: TObject);
begin
  inherited;
  NavigateChange(0);
  FIsClearOld := False;
end;

initialization
  RegisterClass(TfmMenuBatchImportPath);

finalization
  UnregisterClass(TfmMenuBatchImportPath);

end.
