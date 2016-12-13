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
    dgPropertyIsIndex: TcxGridColumn;
    procedure dgPropertyCaptionPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption;
      var Error: Boolean);
  private
    FTable : TTable;
    FSelect : Boolean;
    FUpdateCaption : Boolean;
    procedure SetSelect;
    procedure LoadData;    
  public
    procedure RefreshTableFieldVisible;
    procedure RefreshTableFieldCaption;
    constructor Create(AOwner: TComponent;aTable : TTable;aSelect:Boolean);
    destructor Destroy; override;
  end;

implementation
  uses
    unitXmlWay,unitConfigHelper;

{$R *.dfm}

constructor TfrmTableProperty.Create(AOwner: TComponent;aTable : TTable;aSelect:Boolean);
begin
  inherited Create(AOwner);
  FUpdateCaption := False;
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
  if FUpdateCaption then RefreshTableFieldCaption;
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
  ConfigHelper.SaveTableEnvironment(FTable);
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
      else dgProperty.DataController.Values[ANewRecId,dgPropertySelected.Index] := False;



      dgProperty.DataController.Values[ANewRecId,dgPropertyID.Index] := ANewRecId + 1;
      dgProperty.DataController.Values[ANewRecId,dgPropertyName.Index] := FTable.TableFieldNameArray[I];
      //如果是隐藏的列，默认不导出
      if FTable.TableFieldNameArray[I] = 'RecordID_1' then
      begin
        dgProperty.DataController.Values[ANewRecId,dgPropertySelected.Index] := False;
      end;

      dgProperty.DataController.Values[ANewRecId,dgPropertyCaption.Index] := FTable.TableFieldCaptionArray[I];
      dgProperty.DataController.Values[ANewRecId,dgPropertyDataType.Index] := FTable.TableFieldSQLTypeArray[I];
      dgProperty.DataController.Values[ANewRecId,dgPropertySize.Index] := FTable.TableFieldSizeArray[I];
      dgProperty.DataController.Values[ANewRecId,dgPropertyIsNull.Index] := FTable.TableFieldIsNullArray[I];
      dgProperty.DataController.Values[ANewRecId,dgPropertyIsIndex.Index] := FTable.TableFieldMainArray[I];
      dgProperty.DataController.Post();
    finally
      dgProperty.EndUpdate;
    end;
  end;
end;

procedure TfrmTableProperty.dgPropertyCaptionPropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
begin
  FUpdateCaption := True;
end;





end.
