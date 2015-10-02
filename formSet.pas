unit formSet;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, dxLayoutControl, cxContainer, cxEdit, cxImage, cxControls,
  ExtCtrls, Menus, cxLookAndFeelPainters, StdCtrls, cxButtons, cxLabel,
  RzStatus,formParent, cxCheckBox;

type
  TfmSet = class(TParentForm)
    pnlSet: TPanel;
    lcMainGroup_Root: TdxLayoutGroup;
    lcMain: TdxLayoutControl;
    lcMainItem3: TdxLayoutItem;
    btnOK: TcxButton;
    cbShowName: TcxCheckBox;
    lcMainItem1: TdxLayoutItem;
    lcMainItem2: TdxLayoutItem;
    cbShowPath: TcxCheckBox;
    lcMainGroup1: TdxLayoutGroup;
    procedure btnOKClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cbShowPathClick(Sender: TObject);
    procedure cbShowNameClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmSet: TfmSet;

implementation

  uses
    unitConfig;

{$R *.dfm}

procedure TfmSet.btnOKClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfmSet.FormShow(Sender: TObject);
begin
  inherited;
  cbShowPath.Checked := Config.ShowPath;
  cbShowName.Checked := Config.ShowName
end;

procedure TfmSet.cbShowPathClick(Sender: TObject);
begin
  inherited;
  Config.ShowPath := cbShowPath.Checked;
end;

procedure TfmSet.cbShowNameClick(Sender: TObject);
begin
  inherited;
  Config.ShowName := cbShowName.Checked;
end;

end.
