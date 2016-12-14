unit formExport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxPC, cxControls, cxGraphics, dxLayoutControl, cxContainer,
  cxEdit, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxImageComboBox, Menus,
  cxLookAndFeelPainters, StdCtrls, cxButtons, ExtCtrls,unitTable,frameTableProperty,frameShowResult,
  cxButtonEdit,formParent, cxCheckBox;

type
  TfmExport = class(TParentForm)
    PageExport: TcxPageControl;
    SheetWay: TcxTabSheet;
    SheetField: TcxTabSheet;
    lcMainGroup_Root: TdxLayoutGroup;
    lcMain: TdxLayoutControl;
    cmbExportType: TcxImageComboBox;
    lcMainItem2: TdxLayoutItem;
    pnlCommand: TPanel;
    dxLayoutControl1Group_Root: TdxLayoutGroup;
    dxLayoutControl1: TdxLayoutControl;
    dxLayoutControl1Item1: TdxLayoutItem;
    btnFinish: TcxButton;
    dxLayoutControl1Item2: TdxLayoutItem;
    btnNext: TcxButton;
    dxLayoutControl1Item3: TdxLayoutItem;
    btnPrevious: TcxButton;
    SheetPreview: TcxTabSheet;
    SheetFinish: TcxTabSheet;
    pnlField: TPanel;
    pnlPreview: TPanel;
    dlgSave: TSaveDialog;
    lcMainItem1: TdxLayoutItem;
    btnFilePath: TcxButtonEdit;
    cbSelectField: TcxCheckBox;
    lcMainItem3: TdxLayoutItem;
    edtExportTableName: TcxTextEdit;
    lcMainItem4: TdxLayoutItem;
    lcMainItem5: TdxLayoutItem;
    edtDelKeyField: TcxComboBox;
    lcMainItem6: TdxLayoutItem;
    cbContainDelSQL: TcxCheckBox;
    procedure btnNextClick(Sender: TObject);
    procedure btnPreviousClick(Sender: TObject);
    procedure btnFinishClick(Sender: TObject);
    procedure btnFilePathPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure cmbExportTypePropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption;
      var Error: Boolean);
    procedure btnFilePathPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption;
      var Error: Boolean);
    procedure cbContainDelSQLPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption;
      var Error: Boolean);
  private
    FField : TfrmTableProperty;
    FTable : TTable;
    FPreview : TShowResultFrame;
    FWay : Integer;
    FFilePath : String;
    FNotTableName : Boolean;    
    procedure NavigateChange(aPageIndex: Integer);
    function GetActivePage : Integer;
    procedure SetActivePage(const Value: Integer);
    procedure InitField;
    procedure LoadPreview;
    procedure InitPreview;
    procedure SetState;
  public
    constructor Create(AOwner: TComponent;aTable: TTable);Reintroduce;overload;
    property ActivePage: Integer read GetActivePage write SetActivePage ;
  end;

var
  fmExport: TfmExport;

implementation
  uses
    unitConfigHelper;

{$R *.dfm}


constructor TfmExport.Create(AOwner: TComponent;aTable: TTable);
begin
  inherited Create(AOwner);
  FTable := aTable;
  FNotTableName :=  (FTable.TableName = '');
  FWay := 2;
  NavigateChange(0);
  InitField;
  InitPreview;
  lcMainItem4.Visible := FNotTableName and (FWay = 2);
  cbContainDelSQL.Checked := True;
  SetState;  
end;

procedure TfmExport.InitField;
var
  I : Integer;
begin
  FField := TfrmTableProperty.Create(Self,FTable,True);
  FField.Parent := pnlField;
  FField.Align := alClient;

  edtDelKeyField.Properties.Items.Clear;
  for I:=0  to FTable.TableFieldCount - 1 do
  begin
    edtDelKeyField.Properties.Items.Add(FTable.TableFieldNameArray[I]);
  end;
end;

procedure TfmExport.InitPreview;
begin
  FPreview := TShowResultFrame.Create(Self);
  FPreview.Parent := pnlPreview;
  FPreview.Align := alClient;  
end;

procedure TfmExport.LoadPreview;
begin
  FField.RefreshTableFieldVisible;
  FPreview.UpdateResult(FTable);
end;


function TfmExport.GetActivePage : Integer;
begin
  Result := PageExport.ActivePageIndex;
end;

procedure TfmExport.SetActivePage(const Value: Integer);
begin
  PageExport.ActivePageIndex := Value;
end;




procedure TfmExport.NavigateChange(aPageIndex: Integer);
begin
  { 导航变化处理:  0: 导出方式；1：导出字段；2：预览；3：完成}
    case aPageIndex of
      0:begin
          ActivePage := 0;
          btnPrevious.Visible := False;
          btnNext.Visible := True;
          btnFinish.Visible := False;
          Self.Caption := '第一步：导出方式';
          cmbExportType.ItemIndex := FWay -1 ;
        end;
      1:begin
          ActivePage := 1;
          btnPrevious.Visible := True;
          btnNext.Visible := True;
          btnFinish.Visible := False;          
          Self.Caption := '第二步：导出字段选择';          
        end;
      2:begin
          ActivePage := 2;
          btnPrevious.Visible := True;
          btnNext.Visible := False;
          btnFinish.Visible := True;
          Self.Caption := '第三步：预览';
          LoadPreview;
        end;
      3:begin
          ActivePage := 3;
          btnPrevious.Visible := True;
          btnNext.Visible := False;
          btnFinish.Visible := True;
          Self.Caption := '第四步：完成';
        end;
    end;
end;


procedure TfmExport.btnNextClick(Sender: TObject);
var
  aActivePageIndex: Integer;
begin
  (* 下一步 *)
  if FWay = 0 then
  begin
    ShowMessage('请选择导出类型');
    Exit;
  end;

  if FFilePath = '' then
  begin
    ShowMessage('请选择文件保存路径。');
    Exit;
  end;

  if cbContainDelSQL.Checked and (edtDelKeyField.EditText = '') then
  begin
    ShowMessage('请输入关键字段');
    Exit;
  end;




  aActivePageIndex := ActivePage;
  try
    if (not cbSelectField.Checked) and (aActivePageIndex = 0) then
    begin
      if aActivePageIndex <= PageExport.PageCount - 2 then
        NavigateChange(aActivePageIndex + 2);
    end
    else
    begin
      if aActivePageIndex <> PageExport.PageCount - 1 then
        NavigateChange(aActivePageIndex + 1);  
    end;
  except on E: Exception do
    begin
      NavigateChange(aActivePageIndex);
      ShowMessage('导出失败。');
    end;
  end;
end;

procedure TfmExport.btnPreviousClick(Sender: TObject);
var
  aActivePageIndex: Integer;
begin
  (* 上一步 *)
  aActivePageIndex := ActivePage;
  try
    if (not cbSelectField.Checked) and (aActivePageIndex = 2) then
    begin
      if ActivePage >= 2 then
        NavigateChange(ActivePage - 2);
    end
    else
    begin
      if ActivePage <> 0 then
        NavigateChange(ActivePage - 1 );
    end;


  except on E: Exception do
    begin
      NavigateChange(aActivePageIndex);
      ShowMessage('导出失败。');
    end;
  end;
end;
procedure TfmExport.btnFinishClick(Sender: TObject);
begin
  if FWay = 0 then Exit;
  if FWay = 1 then
  begin
    FPreview.ExportExcel(FFilePath);
    ShowMessage('导出excel成功！');
    Close;
  end
  else if FWay = 2 then
  begin
    if FNotTableName
    then FTable.TableName := edtExportTableName.EditValue;

    ConfigHelper.SaveSQLFile(FFilePath,cbContainDelSQL.Checked,edtDelKeyField.EditText,FTable);

    if FNotTableName
    then FTable.TableName := '';

    ShowMessage('导出SQL脚本成功！');
    Close;  
  end;
end;

procedure TfmExport.btnFilePathPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
var
  I : Integer;
  aExt : String;  
begin
  btnFilePath.Text := '';
  aExt := cmbExportType.EditText;
  if aExt = '' then
  begin
    ShowMessage('请选择对应的导出类型。');
    Exit;
  end;
  dlgSave.Filter := '相关文档('+aExt +')|'+'*' + aExt;  
  if dlgSave.Execute then
  begin
    for I := 0 to dlgSave.Files.Count-1 do
    begin
      if ExtractFileExt(dlgSave.Files.Strings[I]) <> ''
      then  btnFilePath.Text := dlgSave.Files.Strings[I]
      else  btnFilePath.Text := dlgSave.Files.Strings[I] + ExtractFileExt(aExt);
      FFilePath := btnFilePath.Text;
    end;
  end;
end;

procedure TfmExport.cmbExportTypePropertiesValidate(Sender: TObject;
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
begin
  FWay := cmbExportType.ItemIndex + 1;
  lcMainItem4.Visible := FNotTableName and (FWay = 2);
end;

procedure TfmExport.btnFilePathPropertiesValidate(Sender: TObject;
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
begin
  FFilePath := DisplayValue;
end;

procedure TfmExport.cbContainDelSQLPropertiesValidate(Sender: TObject;
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
begin
  inherited;
  SetState;
end;

procedure TfmExport.SetState;
begin
  if cbContainDelSQL.Checked then
  begin
    edtDelKeyField.Enabled := True;
  end
  else
  begin
    edtDelKeyField.Enabled := False;  
  end;
end;


end.
