unit formTableProperty;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, cxGridLevel, cxClasses, cxControls,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, cxCheckBox,unitTable, cxSpinEdit, cxTextEdit;

type
  TfmTableProperty = class(TForm)
    levelProperty: TcxGridLevel;
    gridProperty: TcxGrid;
    dgProperty: TcxGridTableView;
    dgPropertyID: TcxGridColumn;
    dgPropertyName: TcxGridColumn;
    dgPropertyDataType: TcxGridColumn;
    dgPropertySize: TcxGridColumn;
    dgPropertyIsNull: TcxGridColumn;
  private
    FTable : TTable;
    procedure LoadData;
  public
    procedure InitData(aTable : TTable);
  end;

var
  fmTableProperty: TfmTableProperty;

implementation

{$R *.dfm}

procedure TfmTableProperty.InitData(aTable : TTable);
begin
  FTable := aTable;
  LoadData;
end;

procedure TfmTableProperty.LoadData;
var
  I : Integer;
  ANewRecId : Integer;
begin
  for I:=0  to FTable.TableFieldCount - 1 do
  begin
    dgProperty.BeginUpdate;
    try
      ANewRecId := dgProperty.DataController.AppendRecord;
      dgProperty.DataController.Values[ANewRecId,dgPropertyID.Index] := ANewRecId + 1;
      dgProperty.DataController.Values[ANewRecId,dgPropertyName.Index] := FTable.TableFieldNameArray[I];
      dgProperty.DataController.Values[ANewRecId,dgPropertyDataType.Index] := FTable.TableFieldSQLTypeArray[I];
      dgProperty.DataController.Values[ANewRecId,dgPropertySize.Index] := FTable.TableFieldSizeArray[I];
      dgProperty.DataController.Values[ANewRecId,dgPropertyIsNull.Index] := FTable.TableFieldIsNullArray[I];
      dgProperty.DataController.Post();
    finally
      dgProperty.EndUpdate;
    end;
  end;
end;


end.
