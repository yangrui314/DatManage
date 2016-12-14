unit formSavePath;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, formParent, dxLayoutControl, cxControls, cxContainer, cxEdit,
  cxTextEdit, Menus, cxLookAndFeelPainters, StdCtrls, cxButtons,
  cxLookAndFeels;

type
  TfmSavePath = class(TParentForm)
    dxLayoutControl1Group_Root: TdxLayoutGroup;
    dxLayoutControl1: TdxLayoutControl;
    edtPath: TcxTextEdit;
    dxLayoutControl1Item1: TdxLayoutItem;
    dxLayoutControl1Item2: TdxLayoutItem;
    edtName: TcxTextEdit;
    btnCancel: TcxButton;
    dxLayoutControl1Item3: TdxLayoutItem;
    dxLayoutControl1Item4: TdxLayoutItem;
    btnOK: TcxButton;
    dxLayoutControl1Group1: TdxLayoutGroup;
    procedure btnCancelClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
  private
    FName : String;
    FPath : String;
  public
    constructor Create(AOwner: TComponent;aName: String;aPath: String );Reintroduce;overload;
    property PathName: String read FName write FName;
    property Path: String read FPath write FPath;
  end;

var
  fmSavePath: TfmSavePath;

implementation

  uses
    unitConfig;


{$R *.dfm}


constructor TfmSavePath.Create(AOwner: TComponent; aName: String ; aPath: String );
begin
  inherited Create(AOwner);
  FName := aName;
  FPath := aPath;
  edtName.EditValue := FName;
  edtPath.EditValue := FPath;
end;

procedure TfmSavePath.btnCancelClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfmSavePath.btnOKClick(Sender: TObject);
begin
  inherited;
  FName := edtName.EditValue;
  FPath := edtPath.EditValue;
end;

end.
