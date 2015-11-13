unit frmMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxControls, cxContainer, cxEdit, cxTextEdit, StdCtrls, ExtCtrls,
  Menus, cxLookAndFeelPainters, cxButtons, cxStyles, cxCustomData,
  cxGraphics, cxFilter, cxData, cxDataStorage, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridBandedTableView, cxClasses,
  cxGridLevel, cxGrid, cxProgressBar, cxButtonEdit,formParent;

type
  TMainForm = class(TParentForm)
    pnlDIC: TPanel;
    lblDataA: TLabel;
    lblDataB: TLabel;
    edtDataA: TcxTextEdit;
    edtDataB: TcxTextEdit;
    btn1: TcxButton;
    btn2: TcxButton;
    btnStart: TcxButton;
    gdl1: TcxGridLevel;
    gd1: TcxGrid;
    gdvResult: TcxGridBandedTableView;
    colATable: TcxGridBandedColumn;
    colBTable: TcxGridBandedColumn;
    colType: TcxGridBandedColumn;
    colOp: TcxGridBandedColumn;
    pbDetail: TcxProgressBar;
    pbMain: TcxProgressBar;
    procedure btn1Click(Sender: TObject);
    procedure btn2Click(Sender: TObject);
    procedure btnStartClick(Sender: TObject);
    procedure gdvResultCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure colOpPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
  private
    { Private declarations }
  public
    { Public declarations }

    FFileDataA, FFileDataB: string;
    procedure ContrastDB;
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

uses
  FileCtrl, UnitSys, UnitContrast, UnitShowDiff;

procedure TMainForm.btn1Click(Sender: TObject);
var
  DirectoryPath: string;
begin
  if SelectDirectory('请选择DataA路径', '', DirectoryPath) then
    edtDataA.Text := DirectoryPath;
end;

procedure TMainForm.btn2Click(Sender: TObject);
var
  DirectoryPath: string;
begin
  if SelectDirectory('请选择DataB路径', '', DirectoryPath) then
    edtDataB.Text := DirectoryPath;
end;

procedure TMainForm.btnStartClick(Sender: TObject);
begin
  FFileDataA := Trim(edtDataA.Text);
  FFileDataB := Trim(edtDataB.Text);
  if (FFileDataA='') or (FFileDataB='') then
  begin
    ShowMessage('请选择或输入数据库路径！');
    exit;
  end;
  if not DirectoryExists(FFileDataA) then
  begin
    ShowMessage('DataA数据库路径有误 ！');
    exit;
  end;
  if not DirectoryExists(FFileDataB) then
  begin
    ShowMessage('DataB数据库路径有误 ！');
    exit;
  end;
  if not dmSys.OpenDataA(FFileDataA) then
    exit;
  if not dmSys.OpenDataB(FFileDataB) then
    exit;

  ContrastDB;
  ShowMessage('对比完成！');
end;

procedure TMainForm.ContrastDB;

  procedure AddDataA;
  var
    SearchRec: TSearchRec;
    found: integer;
    procedure DoAddDataA(TableNM: string);
    var
      iRecord: integer;
    begin
      with gdvResult do
      begin
        iRecord := DataController.RecordCount;
        DataController.AppendRecord;
        DataController.Values[iRecord, colATable.Index] := TableNM;
        DataController.Values[iRecord, colType.Index] := 'miss';
        DataController.Values[iRecord, colOp.Index] := 'show data';
      end;
    end;
  begin   
    found := FindFirst(FFileDataA + '\' + '*.dat', faAnyFile, SearchRec);
    while found = 0 do
    begin
      if (SearchRec.Name <> '.') and (SearchRec.Name <> '..') and
        (SearchRec.Attr <> faDirectory) then
        DoAddDataA(Copy(SearchRec.Name, 1, Length(SearchRec.Name)-4));  
      found := FindNext(SearchRec);
    end;
    FindClose(SearchRec);
  end;
  procedure AddDataB;
  var
    SearchRec: TSearchRec;
    found: integer;
    procedure DoAddDataB(TableNM: string);
    var
      i: integer;
      bFind: Boolean;
    begin
      bFind := False;
      with gdvResult.DataController do
      begin
        for i:=0 to RecordCount-1 do
        begin
          if Values[i, colATable.Index] = TableNM then
          begin
            Values[i, colType.Index] := '';
            Values[i, colBTable.Index] := TableNM;
            bFind := true;
            Break;
          end;
        end;
        if not bFind then
        begin
          AppendRecord;
          Values[RecordCount-1, colType.Index] := 'add';
          Values[RecordCount-1, colBTable.Index] := TableNM;
          Values[RecordCount-1, colOp.Index] := 'show data';
        end;
      end;
    end;
  begin   
    found := FindFirst(FFileDataB + '\' + '*.dat', faAnyFile, SearchRec);
    while found = 0 do
    begin
      if (SearchRec.Name <> '.') and (SearchRec.Name <> '..') and
        (SearchRec.Attr <> faDirectory) then
        DoAddDataB(Copy(SearchRec.Name, 1, Length(SearchRec.Name)-4));  
      found := FindNext(SearchRec);
    end;
    FindClose(SearchRec);
  end;
  procedure DoContrastDB;
  var
    i: integer;
    ATableA, ATableB: string;
  begin
    pbDetail.Properties.Max := gdvResult.DataController.RecordCount;
    with gdvResult.DataController do
    begin
      for i:=0 to RecordCount-1 do
      begin
        if Values[i, colType.Index] = '' then
        begin
          ATableA := FFileDataA + '\' + Values[i, colATable.Index] +'.dat';
          ATableB := FFileDataB + '\' + Values[i, colBTable.Index] +'.dat';
          if CompareFile(ATableA, ATableB) then
            Values[i, colType.Index] := 'no diff'
          else
          begin
            Values[i, colType.Index] := 'diff';
            Values[i, colOp.Index] := 'show diff';
          end;
          pbDetail.Position := pbMain.Position + 1;
          pbDetail.Update;
        end;
      end;
    end;
    pbDetail.Position := pbDetail.Properties.Max;
  end;

begin
  pbDetail.Position := 0;
  pbMain.Properties.Max := 4;
  pbMain.Position := 0;
  pbMain.Update;
  pbDetail.Update;
  with gdvResult do
  begin
    BeginUpdate;
    while DataController.RecordCount > 0 do
      DataController.DeleteRecord(0);
    EndUpdate;
  end;
  pbMain.Position := pbMain.Position + 1;
  pbMain.Update;
  AddDataA;
  pbMain.Position := pbMain.Position + 1;
  pbMain.Update;
  AddDataB;
  pbMain.Position := pbMain.Position + 1;
  pbMain.Update;
  DoContrastDB;
  pbMain.Position := pbMain.Position + 1;
  pbMain.Update;
end;

procedure TMainForm.gdvResultCustomDrawCell(Sender: TcxCustomGridTableView;
  ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
  var ADone: Boolean);
begin
  if AViewInfo.GridRecord.DisplayTexts[colType.Index] <> 'no diff' then
    ACanvas.Font.Color := clRed;
end;

procedure TMainForm.colOpPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
var
  ATableNM, ADBName: string;
  ADiffInfo: TDiffInfo;
  ADataInfo: TDataInfo;
begin
  if gdvResult.DataController.Values[gdvResult.DataController.FocusedRecordIndex, colType.Index] = 'diff' then
  begin
    pbMain.Properties.Max := 2;
    pbMain.Position := 0;
    pbMain.Update;
    ATableNM := gdvResult.DataController.Values[gdvResult.DataController.FocusedRecordIndex, colATable.Index];
    ADiffInfo := CompareTable(ATableNM);
    pbMain.Position := pbMain.Position + 1;
    pbMain.Update;    
    Application.CreateForm(TfrmShowDiff, frmShowDiff);
    frmShowDiff.FDiffInfo := ADiffInfo;
    frmShowDiff.ShowDiff;
    frmShowDiff.Show;
    pbMain.Position := pbMain.Position + 1;
    pbMain.Update;
  end
  else
  begin
    ADBName := 'dbA';
    if gdvResult.DataController.Values[gdvResult.DataController.FocusedRecordIndex, colATable.Index] <> null then
      ATableNM := gdvResult.DataController.Values[gdvResult.DataController.FocusedRecordIndex, colATable.Index]
    else
      ATableNM := '';
    if ATableNM = '' then
    begin
      ATableNM := gdvResult.DataController.Values[gdvResult.DataController.FocusedRecordIndex, colBTable.Index];
      ADBName := 'dbB';
    end;
    ADataInfo := GetData(ADBName, ATableNM);
    Application.CreateForm(TfrmShowDiff, frmShowDiff);
    frmShowDiff.ShowData(ADataInfo);
    frmShowDiff.Show;
  end;
end;

initialization
  RegisterClass(TMainForm);

finalization
  UnregisterClass(TMainForm);

end.
