unit formSet;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, dxLayoutControl, cxContainer, cxEdit, cxImage, cxControls,
  ExtCtrls, Menus, cxLookAndFeelPainters, StdCtrls, cxButtons, cxLabel,
  RzStatus,formParent;

type
  TfmSet = class(TParentForm)
    pnlAbout: TPanel;
    lcMainGroup_Root: TdxLayoutGroup;
    lcMain: TdxLayoutControl;
    ImgIcon: TcxImage;
    lcMainItem1: TdxLayoutItem;
    lblCaption: TcxLabel;
    lcMainItem2: TdxLayoutItem;
    btnOK: TcxButton;
    lcMainItem3: TdxLayoutItem;
    lblVersion: TcxLabel;
    lcMainItem4: TdxLayoutItem;
    lcMainGroup3: TdxLayoutGroup;
    RzVersionInfo: TRzVersionInfo;
    procedure btnOKClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmSet: TfmSet;

implementation

{$R *.dfm}

procedure TfmSet.btnOKClick(Sender: TObject);
begin
  Close;
end;

procedure TfmAbout.FormShow(Sender: TObject);
begin
  RzVersionInfo.FilePath := Application.Exename;
  lblVersion.EditValue := RzVersionInfo.FileVersion;
end;

end.
