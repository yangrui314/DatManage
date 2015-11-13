unit UnitShowDiff;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, cxButtonEdit, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridBandedTableView, cxClasses, cxControls,
  cxGridCustomView, cxGrid, UnitContrast, ExtCtrls, cxLookAndFeelPainters,
  StdCtrls, cxRadioGroup, cxContainer, cxGroupBox, cxCheckGroup, Menus,
  cxButtons;

type
  TfrmShowDiff = class(TForm)
    gd1: TcxGrid;
    gdvDiff: TcxGridBandedTableView;
    gdl1: TcxGridLevel;
    colData: TcxGridBandedColumn;
    pnlTop: TPanel;
    cxchckgrp1: TcxCheckGroup;
    rbhx: TcxRadioButton;
    rbzx: TcxRadioButton;
    colModifyType: TcxGridBandedColumn;
    cxstylrpstry1: TcxStyleRepository;
    cxstyl1: TcxStyle;
    cxstyl2: TcxStyle;
    procedure gdvDiffCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure rbhxClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    FDiffInfo: TDiffInfo;
    procedure ShowDiff;
    procedure ShowData(ADataInfo: TDataInfo);     
  end;

var
  frmShowDiff: TfrmShowDiff;

implementation



{$R *.dfm}

{ TfrmShowDiff }

procedure TfrmShowDiff.ShowDiff;
var
  i,j: integer;
  ARowDiffInfo: TRowDiffInfo;
begin
  if FDiffInfo = nil then
    Exit;
  if FDiffInfo.FieldList = nil then
    Exit;
  Self.Caption := Self.Caption + '-' + FDiffInfo.TableNM;
  try
    gdvDiff.BeginUpdate;
    gdvDiff.ClearItems;
    while gdvDiff.DataController.RecordCount > 0 do
      gdvDiff.DataController.DeleteRecord(0);
    with gdvDiff.CreateColumn do
    begin
      Name := 'colData';
      Caption := 'Data';
      Width := 60;
      Position.BandIndex := 1;
      Visible := false;
    end;
    with gdvDiff.CreateColumn do
    begin
      Name := 'colModifyType';
      Caption := 'MType';
      Width := 80;
      Position.BandIndex := 1;
      Visible := True;
    end;
    if rbzx.Checked then
    begin
      gdvDiff.Bands[0].Caption := FDiffInfo.TableNM;
      gdvDiff.Bands[0].Width :=  FDiffInfo.FieldList.Count * 80;
      gdvDiff.Bands[1].Width :=  FDiffInfo.KeyList.Count * 80 + 60;
      gdvDiff.Bands[2].Visible := false;
      colData.Visible := True;
      for i:=0 to FDiffInfo.KeyList.Count-1 do
      begin
        with gdvDiff.CreateColumn do
        begin
          Name := FDiffInfo.KeyList.Strings[i];
          Caption := Name;
          Width := 80;
          Position.BandIndex := 1;
        end;
      end;
      for i:=0 to FDiffInfo.FieldList.Count-1 do
      begin
        with gdvDiff.CreateColumn do
        begin
          Name := FDiffInfo.FieldList.Strings[i];
          Caption := Name;
          Width := 80;
          Position.BandIndex := 0;
        end;
      end;
      for i:=0 to FDiffInfo.DiffList.Count-1 do
      begin
        ARowDiffInfo := TRowDiffInfo(FDiffInfo.DiffList.Items[i]);
        with gdvDiff.DataController do
        begin
          AppendRecord;
          Values[RecordCount-1, colData.Index] := 'DataA';
          for j:=0 to FDiffInfo.KeyList.Count-1 do
          begin
            if ARowDiffInfo.KeyValueA.Strings[0] <> '无此行' then
              Values[RecordCount-1, j+2] := ARowDiffInfo.KeyValueA.Strings[j]
            else
               Values[RecordCount-1, j+2] := ARowDiffInfo.KeyValueB.Strings[j];
          end;
          for j:=0 to FDiffInfo.FieldList.Count-1 do
          begin
            if ARowDiffInfo.KeyValueA.Strings[0] <> '无此行' then
            begin
              if ARowDiffInfo.AValue.Count > j then
                Values[RecordCount-1, j+FDiffInfo.KeyList.Count+2] := ARowDiffInfo.AValue.Strings[j];
            end
            else
               Values[RecordCount-1, j+FDiffInfo.KeyList.Count+2] := '----';
          end;
          if ARowDiffInfo.KeyValueA.Strings[0] = '无此行' then
            Values[RecordCount-1, colModifyType.Index] := 'added'
          else if ARowDiffInfo.KeyValueB.Strings[0] = '无此行' then
            Values[RecordCount-1, colModifyType.Index] := 'deleted'
          else
            Values[RecordCount-1, colModifyType.Index] := 'modified';
          AppendRecord;
          Values[RecordCount-1, colData.Index] := 'DataB';
          for j:=0 to FDiffInfo.KeyList.Count-1 do
          begin
            if ARowDiffInfo.KeyValueB.Strings[0] <> '无此行' then
              Values[RecordCount-1, j+2] := ARowDiffInfo.KeyValueB.Strings[j]
            else
               Values[RecordCount-1, j+2] := ARowDiffInfo.KeyValueA.Strings[j];
          end;
          for j:=0 to FDiffInfo.FieldList.Count-1 do
          begin
            if ARowDiffInfo.KeyValueB.Strings[0] <> '无此行' then
            begin
              if ARowDiffInfo.BValue.Count > j then
                Values[RecordCount-1, j+FDiffInfo.KeyList.Count+2] := ARowDiffInfo.BValue.Strings[j];
            end
            else
               Values[RecordCount-1, j+FDiffInfo.KeyList.Count+2] := '----';
          end;
          if ARowDiffInfo.KeyValueA.Strings[0] = '无此行' then
            Values[RecordCount-1, colModifyType.Index] := 'added'
          else if ARowDiffInfo.KeyValueB.Strings[0] = '无此行' then
            Values[RecordCount-1, colModifyType.Index] := 'deleted'
          else
            Values[RecordCount-1, colModifyType.Index] := 'modified';
        end;
      end;
    end
    else
    begin
      gdvDiff.Bands[0].Caption := 'DataA';
      gdvDiff.Bands[0].Width :=  FDiffInfo.FieldList.Count * 80;
      gdvDiff.Bands[1].Width :=  FDiffInfo.KeyList.Count * 80 + 60;
      gdvDiff.Bands[2].Width :=  FDiffInfo.FieldList.Count * 80;
      gdvDiff.Bands[2].Visible := True;   
      for i:=0 to FDiffInfo.KeyList.Count-1 do
      begin
        with gdvDiff.CreateColumn do
        begin
          Name := FDiffInfo.KeyList.Strings[i];
          Caption := Name;
          Width := 80;
          Position.BandIndex := 1;
        end;
      end;
      for i:=0 to FDiffInfo.FieldList.Count-1 do
      begin
        with gdvDiff.CreateColumn do
        begin
          Name := 'ColA' + FDiffInfo.FieldList.Strings[i];
          Caption := FDiffInfo.FieldList.Strings[i];
          Width := 80;
          Position.BandIndex := 0;
        end;
      end;
      for i:=0 to FDiffInfo.FieldList.Count-1 do
      begin
        with gdvDiff.CreateColumn do
        begin
          Name := 'ColB' + FDiffInfo.FieldList.Strings[i];
          Caption := FDiffInfo.FieldList.Strings[i];
          Width := 80;
          Position.BandIndex := 2;
        end;
      end;
      for i:=0 to FDiffInfo.DiffList.Count-1 do
      begin
        ARowDiffInfo := TRowDiffInfo(FDiffInfo.DiffList.Items[i]);
        with gdvDiff.DataController do
        begin
          AppendRecord;  
          for j:=0 to FDiffInfo.KeyList.Count-1 do
          begin
            if ARowDiffInfo.KeyValueA.Strings[0] <> '无此行' then
              Values[RecordCount-1, j+2] := ARowDiffInfo.KeyValueA.Strings[j]
            else
               Values[RecordCount-1, j+2] := ARowDiffInfo.KeyValueB.Strings[j];
          end;
          //DataA
          for j:=0 to FDiffInfo.FieldList.Count-1 do
          begin
            if ARowDiffInfo.KeyValueA.Strings[0] <> '无此行' then
            begin
              if ARowDiffInfo.AValue.Count > j then
                Values[RecordCount-1, j+FDiffInfo.KeyList.Count+2] := ARowDiffInfo.AValue.Strings[j];
            end
            else
               Values[RecordCount-1, j+FDiffInfo.KeyList.Count+2] := '----';
          end;
          //DataB 
          for j:=0 to FDiffInfo.FieldList.Count-1 do
          begin
            if ARowDiffInfo.KeyValueB.Strings[0] <> '无此行' then
            begin
              if ARowDiffInfo.BValue.Count > j then
                Values[RecordCount-1, j+FDiffInfo.KeyList.Count+FDiffInfo.FieldList.Count+2] := ARowDiffInfo.BValue.Strings[j];
            end
            else
              Values[RecordCount-1, j+FDiffInfo.KeyList.Count+FDiffInfo.FieldList.Count+2] := '----';
          end;
          if ARowDiffInfo.KeyValueA.Strings[0] = '无此行' then
            Values[RecordCount-1, colModifyType.Index] := 'added'
          else if ARowDiffInfo.KeyValueB.Strings[0] = '无此行' then
            Values[RecordCount-1, colModifyType.Index] := 'deleted'
          else
            Values[RecordCount-1, colModifyType.Index] := 'modified';
        end;
      end;
    end;
  finally
    gdvDiff.EndUpdate;
    gdvDiff.ApplyBestFit;
  end;
end;

procedure TfrmShowDiff.gdvDiffCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  if AViewInfo.GridRecord.DisplayTexts[colData.Index] = 'DataA' then
   // ACanvas.Brush.Color := clInactiveBorder
  else if AViewInfo.GridRecord.DisplayTexts[colData.Index] = 'DataB' then
    ACanvas.Brush.Color := clGradientInactiveCaption;
  if Copy(AViewInfo.Text,1,3) = 'A>>' then
    ACanvas.Font.Color := clBlue
  else if Copy(AViewInfo.Text,1,3) = 'B>>' then
    ACanvas.Font.Color := clRed
  else
    ACanvas.Font.Color := clDefault;
  if AViewInfo.GridRecord.DisplayTexts[colModifyType.Index] = 'added' then
    ACanvas.Font.Color := clRed
  else if AViewInfo.GridRecord.DisplayTexts[colModifyType.Index] = 'deleted' then
    ACanvas.Font.Color := clBlue;       
end;

procedure TfrmShowDiff.ShowData(ADataInfo: TDataInfo);
var
  i,j: integer;
  ARowDataInfo: TRowDataInfo;
begin
  pnlTop.Visible := False;
  if ADataInfo = nil then
    Exit;
  if ADataInfo.FieldList = nil then
    Exit;
  Self.Caption := Self.Caption + '-' + ADataInfo.TableNM;
  try
    gdvDiff.BeginUpdate;
    gdvDiff.Bands[0].Caption := ADataInfo.TableNM;
    gdvDiff.Bands[0].Width :=  ADataInfo.FieldList.Count * 80;
    gdvDiff.Bands[1].Visible := false;
    gdvDiff.Bands[2].Visible := false;
    for i:=0 to ADataInfo.FieldList.Count-1 do
    begin
      with gdvDiff.CreateColumn do
      begin
        Name := ADataInfo.FieldList.Strings[i];
        Caption := Name;
        Width := 80;
        Position.BandIndex := 0;
      end;
    end;
    for i:=0 to ADataInfo.DataList.Count-1 do
    begin
      ARowDataInfo := TRowDataInfo(ADataInfo.DataList.Items[i]);
      with gdvDiff.DataController do
      begin
        AppendRecord;
        for j:=0 to ADataInfo.FieldList.Count-1 do
        begin
          if ARowDataInfo.FieldValues <> nil then
            if ARowDataInfo.FieldValues.Count > j then
              Values[RecordCount-1, j+1] := ARowDataInfo.FieldValues.Strings[j];
        end;   
      end;
    end;
  finally
    gdvDiff.EndUpdate;
    gdvDiff.ApplyBestFit;
  end;
end;

procedure TfrmShowDiff.rbhxClick(Sender: TObject);
begin
  ShowDiff;
end;

end.
