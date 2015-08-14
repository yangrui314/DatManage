unit frameTableProperty;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, cxSpinEdit, cxTextEdit, cxCheckBox, cxGridLevel,
  cxGridCustomTableView, cxGridTableView, cxClasses, cxControls,
  cxGridCustomView, cxGrid,unitTable;

type
  TfrmTableProperty = class(TFrame)
    gridProperty: TcxGrid;
    dgProperty: TcxGridTableView;
    dgPropertyID: TcxGridColumn;
    dgPropertyName: TcxGridColumn;
    dgPropertyDataType: TcxGridColumn;
    dgPropertySize: TcxGridColumn;
    dgPropertyIsNull: TcxGridColumn;
    levelProperty: TcxGridLevel;
    dgPropertySelected: TcxGridColumn;
    dgPropertyCaption: TcxGridColumn;
  private
    FTable : TTable;
    FSelect : Boolean;
    procedure SetSelect;
    procedure LoadData;    
  public
    procedure RefreshTableFieldVisible;
    procedure RefreshTableFieldCaption;
    constructor Create(AOwner: TComponent;aTable : TTable;aSelect:Boolean);
    destructor Destroy; override;
  end;

implementation

{$R *.dfm}

constructor TfrmTableProperty.Create(AOwner: TComponent;aTable : TTable;aSelect:Boolean);
begin
  inherited Create(AOwner);
  FTable := aTable;
  FSelect := aSelect;
  SetSelect;
  LoadData;
end;

procedure TfrmTableProperty.SetSelect;
begin
  dgPropertySelected.Visible := FSelect;
end;


destructor TfrmTableProperty.Destroy;
begin
  RefreshTableFieldCaption;
  inherited;
end;

procedure TfrmTableProperty.RefreshTableFieldVisible;
var
  I : Integer;
begin
  for I:=0  to FTable.TableFieldCount - 1 do
  begin
    dgProperty.BeginUpdate;
    try
      FTable.TableFieldVisibleArray[I] := dgProperty.DataController.Values[I,dgPropertySelected.Index];
    finally
      dgProperty.EndUpdate;
    end;
  end;
end;

procedure TfrmTableProperty.RefreshTableFieldCaption;
var
  I : Integer;
begin
  for I:=0  to FTable.TableFieldCount - 1 do
  begin
    dgProperty.BeginUpdate;
    try
      if dgProperty.DataController.Values[I,dgPropertyCaption.Index] = null then Continue;
      FTable.TableFieldCaptionArray[I] := dgProperty.DataController.Values[I,dgPropertyCaption.Index];
    finally
      dgProperty.EndUpdate;
    end;
  end;
end;



procedure TfrmTableProperty.LoadData;
var
  I : Integer;
  ANewRecId : Integer;
begin
  for I:=0  to FTable.TableFieldCount - 1 do
  begin
    dgProperty.BeginUpdate;
    try
      ANewRecId := dgProperty.DataController.AppendRecord;
      if FSelect
      then dgProperty.DataController.Values[ANewRecId,dgPropertySelected.Index] := True
      else dgProperty.DataController.Values[ANewRecId,dgPropertySelected.Index] := True;

      dgProperty.DataController.Values[ANewRecId,dgPropertyID.Index] := ANewRecId + 1;
      dgProperty.DataController.Values[ANewRecId,dgPropertyName.Index] := FTable.TableFieldNameArray[I];
      dgProperty.DataController.Values[ANewRecId,dgPropertyCaption.Index] := FTable.TableFieldCaptionArray[I];
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
