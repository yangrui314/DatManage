unit formTableProperty;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, cxGridLevel, cxClasses, cxControls,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, cxCheckBox,unitTable, cxSpinEdit, cxTextEdit,frameTableProperty,formParent;

type
  TfmTableProperty = class(TParentForm)
    pnlProperty: TPanel;
  private
    FTable : TTable;
    FShowProperty: TfrmTableProperty;
  public
    constructor Create(AOwner: TComponent;aTable : TTable);Reintroduce;overload;
  end;

var
  fmTableProperty: TfmTableProperty;

implementation

{$R *.dfm}

constructor TfmTableProperty.Create(AOwner: TComponent;aTable : TTable);
begin
  inherited Create(AOwner);
  FTable := aTable;
  FShowProperty := TfrmTableProperty.Create(Self,FTable,False);
  FShowProperty.Parent := pnlProperty;
  FShowProperty.Align := alClient;    
end;


end.
