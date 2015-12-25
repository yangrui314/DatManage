unit formSet;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, dxLayoutControl, cxContainer, cxEdit, cxImage, cxControls,
  ExtCtrls, Menus, cxLookAndFeelPainters, StdCtrls, cxButtons, cxLabel,
  RzStatus,formParent, cxCheckBox, cxRadioGroup, cxPC,formParentMenu;

type
  TfmSet = class(TfmParentMenu)
    pnlSet: TPanel;
    Page: TcxPageControl;
    SheetShow: TcxTabSheet;
    SheetSelect: TcxTabSheet;
    lcMain: TdxLayoutControl;
    cbShowName: TcxCheckBox;
    cbShowPath: TcxCheckBox;
    dxLayoutGroup1: TdxLayoutGroup;
    dxLayoutItem1: TdxLayoutItem;
    lcMainItem2: TdxLayoutItem;
    lcSelect: TdxLayoutControl;
    dxLayoutGroup3: TdxLayoutGroup;
    rbSelectCaption: TcxRadioButton;
    lcSelectItem1: TdxLayoutItem;
    lcSelectItem2: TdxLayoutItem;
    rbSelectField: TcxRadioButton;
    pnlOK: TPanel;
    lcOK: TdxLayoutControl;
    cxButton2: TcxButton;
    dxLayoutGroup4: TdxLayoutGroup;
    dxLayoutItem5: TdxLayoutItem;
    lcSelectGroup1: TdxLayoutGroup;
    lcMainGroup1: TdxLayoutGroup;
    SheetConnect: TcxTabSheet;
    lcConnect: TdxLayoutControl;
    rbDBISAM: TcxRadioButton;
    rbSQLSERVER: TcxRadioButton;
    dxLayoutGroup2: TdxLayoutGroup;
    dxLayoutItem2: TdxLayoutItem;
    dxLayoutItem3: TdxLayoutItem;
    SheetFileWay: TcxTabSheet;
    lcFileWay: TdxLayoutControl;
    rbDAT: TcxRadioButton;
    rbXML: TcxRadioButton;
    dxLayoutGroup5: TdxLayoutGroup;
    dxLayoutItem4: TdxLayoutItem;
    dxLayoutItem6: TdxLayoutItem;
    procedure btnOKClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cbShowPathClick(Sender: TObject);
    procedure cbShowNameClick(Sender: TObject);
    procedure rbSelectFieldClick(Sender: TObject);
    procedure rbSelectCaptionClick(Sender: TObject);
    procedure rbDBISAMClick(Sender: TObject);
    procedure rbSQLSERVERClick(Sender: TObject);
    procedure rbDATClick(Sender: TObject);
    procedure rbXMLClick(Sender: TObject);
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
  cbShowName.Checked := Config.ShowName;
  if Config.SelectShowWay = '1' then
  begin
    rbSelectField.Checked := True;
    rbSelectCaption.Checked := False;  
  end
  else
  begin
    rbSelectField.Checked := False;
    rbSelectCaption.Checked := True;    
  end;
  if Config.ConnectWay = '1' then
  begin
    rbDBISAM.Checked := True;
    rbSQLSERVER.Checked := False;
  end
  else
  begin
    rbDBISAM.Checked := False;
    rbSQLSERVER.Checked := True;    
  end;

  if Config.FileWay ='dat' then
  begin
    rbDAT.Checked := True;
    rbXML.Checked := False;
  end
  else
  begin
    rbDAT.Checked := False;
    rbXML.Checked := True;
  end;

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

procedure TfmSet.rbSelectFieldClick(Sender: TObject);
begin
  inherited;
  Config.SelectShowWay := '1';
end;

procedure TfmSet.rbSelectCaptionClick(Sender: TObject);
begin
  inherited;
  Config.SelectShowWay := '2';
end;

procedure TfmSet.rbDBISAMClick(Sender: TObject);
begin
  inherited;
  Config.ConnectWay := '1';
end;

procedure TfmSet.rbSQLSERVERClick(Sender: TObject);
begin
  inherited;
  Config.ConnectWay := '2';
end;

procedure TfmSet.rbDATClick(Sender: TObject);
begin
  inherited;
  Config.FileWay :='dat';
end;

procedure TfmSet.rbXMLClick(Sender: TObject);
begin
  inherited;
  Config.FileWay :='xml';
end;

initialization
  RegisterClass(TfmSet);

finalization
  UnregisterClass(TfmSet);

end.
