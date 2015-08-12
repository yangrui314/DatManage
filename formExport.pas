unit formExport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxPC, cxControls, cxGraphics, dxLayoutControl, cxContainer,
  cxEdit, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxImageComboBox, Menus,
  cxLookAndFeelPainters, StdCtrls, cxButtons, ExtCtrls,unitTable,frameTableProperty,frameShowResult,
  cxButtonEdit;

type
  TfmExport = class(TForm)
    PageExport: TcxPageControl;
    SheetWay: TcxTabSheet;
    SheetField: TcxTabSheet;
    lcMainGroup_Root: TdxLayoutGroup;
    lcMain: TdxLayoutControl;
    cmbExportType: TcxImageComboBox;
    lcMainItem2: TdxLayoutItem;
    pnlCommand: TPanel;
    dxLayoutControl1Group_Root: TdxLayoutGroup;
    dxLayoutControl1: TdxLayoutControl;
    dxLayoutControl1Item1: TdxLayoutItem;
    btnFinish: TcxButton;
    dxLayoutControl1Item2: TdxLayoutItem;
    btnNext: TcxButton;
    dxLayoutControl1Item3: TdxLayoutItem;
    btnPrevious: TcxButton;
    SheetPreview: TcxTabSheet;
    SheetFinish: TcxTabSheet;
    pnlField: TPanel;
    pnlPreview: TPanel;
    dlgSave: TSaveDialog;
    lcMainItem1: TdxLayoutItem;
    btnFilePath: TcxButtonEdit;
    procedure btnNextClick(Sender: TObject);
    procedure btnPreviousClick(Sender: TObject);
    procedure btnFinishClick(Sender: TObject);
    procedure btnFilePathPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure cmbExportTypePropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption;
      var Error: Boolean);
    procedure btnFilePathPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption;
      var Error: Boolean);
  private
    FField : TfrmTableProperty;
    FTable : TTable;
    FPreview : TShowResultFrame;
    FWay : Integer;
    FFilePath : String;    
    procedure NavigateChange(aPageIndex: Integer);
    function GetActivePage : Integer;
    procedure SetActivePage(const Value: Integer);
    procedure InitField;
    procedure LoadPreview;
    procedure InitPreview;
    procedure CheckWay;    
  public
    constructor Create(AOwner: TComponent;aTable: TTable);
    property ActivePage: Integer read GetActivePage write SetActivePage ;
  end;

var
  fmExport: TfmExport;

implementation

{$R *.dfm}


constructor TfmExport.Create(AOwner: TComponent;aTable: TTable);
begin
  inherited Create(AOwner);
  FTable := aTable;
  NavigateChange(0);
  InitField;
  InitPreview;
  FWay := 0;
end;

procedure TfmExport.InitField;
begin
  FField := TfrmTableProperty.Create(Self,FTable,True);
  FField.Parent := pnlField;
  FField.Align := alClient;
end;

procedure TfmExport.InitPreview;
begin
  FPreview := TShowResultFrame.Create(Self);
  FPreview.Parent := pnlPreview;
  FPreview.Align := alClient;  
end;

procedure TfmExport.LoadPreview;
begin
  FField.RefreshTableFieldVisible;
  FPreview.Update(FTable);
end;


function TfmExport.GetActivePage : Integer;
begin
  Result := PageExport.ActivePageIndex;
end;

procedure TfmExport.SetActivePage(const Value: Integer);
begin
  PageExport.ActivePageIndex := Value;
end;

procedure TfmExport.CheckWay;
begin

end;


procedure TfmExport.NavigateChange(aPageIndex: Integer);
begin
  { �����仯����:  0: ������ʽ��1�������ֶΣ�2��Ԥ����3�����}
    case aPageIndex of
      0:begin
          ActivePage := 0;
          btnPrevious.Visible := False;
          btnNext.Visible := True;
          btnFinish.Visible := False;
          Self.Caption := '��һ����������ʽ';
        end;
      1:begin
          ActivePage := 1;
          btnPrevious.Visible := True;
          btnNext.Visible := True;
          btnFinish.Visible := False;          
          Self.Caption := '�ڶ����������ֶ�ѡ��';          
        end;
      2:begin
          ActivePage := 2;
          btnPrevious.Visible := True;
          btnNext.Visible := True;
          btnFinish.Visible := False;
          Self.Caption := '��������Ԥ��';
          LoadPreview;
        end;
      3:begin
          ActivePage := 3;
          btnPrevious.Visible := True;
          btnNext.Visible := False;
          btnFinish.Visible := True;
          Self.Caption := '���Ĳ������';
        end;
    end;
end;


procedure TfmExport.btnNextClick(Sender: TObject);
var
  aActivePageIndex: Integer;
begin
  (* ��һ�� *)
  if FWay = 0 then
  begin
    ShowMessage('��ѡ�񵼳�����');
    Exit;
  end;

  if FFilePath = '' then
  begin
    ShowMessage('��ѡ���ļ�����·����');
    Exit;
  end;

  aActivePageIndex := ActivePage;
  try
    if aActivePageIndex <> PageExport.PageCount - 1 then
      NavigateChange(aActivePageIndex + 1);
  except on E: Exception do
    begin
      NavigateChange(aActivePageIndex);
      ShowMessage('����ʧ�ܡ�');
    end;
  end;
end;

procedure TfmExport.btnPreviousClick(Sender: TObject);
var
  aActivePageIndex: Integer;
begin
  (* ��һ�� *)
  aActivePageIndex := ActivePage;
  try
    if ActivePage <> 0 then
      NavigateChange(ActivePage - 1 );
  except on E: Exception do
    begin
      NavigateChange(aActivePageIndex);
      ShowMessage('����ʧ�ܡ�');
    end;
  end;
end;
procedure TfmExport.btnFinishClick(Sender: TObject);
begin
  if FWay = 0 then Exit;
  if FWay = 1 then
  begin
    FPreview.ExportExcel(FFilePath);
    ShowMessage('����excel�ɹ���');
  end
  else if FWay = 2 then
  begin
    FTable.SaveSQLFile(FFilePath);
    ShowMessage('����SQL�ű��ɹ���');  
  end;
end;

procedure TfmExport.btnFilePathPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
var
  I : Integer;
begin
  btnFilePath.Text := '';
  if dlgSave.Execute then
  begin
    for I := 0 to dlgSave.Files.Count-1 do
    begin
      btnFilePath.Text := dlgSave.Files.Strings[I];
      FFilePath := btnFilePath.Text;
    end;
  end;
end;

procedure TfmExport.cmbExportTypePropertiesValidate(Sender: TObject;
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
begin
  FWay := cmbExportType.ItemIndex + 1;
end;

procedure TfmExport.btnFilePathPropertiesValidate(Sender: TObject;
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
begin
  FFilePath := DisplayValue;
end;

end.
