unit formSVN;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, formParent, dxLayoutControl, cxControls, ExtCtrls, cxGraphics,
  Menus, cxLookAndFeelPainters, StdCtrls, cxButtons, cxContainer, cxEdit,
  cxTextEdit, cxMaskEdit, cxDropDownEdit, cxLookAndFeels,formParentMenu;

type
  TfmSVN = class(TfmParentMenu)
    pnlMain: TPanel;
    lcMainGroup_Root: TdxLayoutGroup;
    lcMain: TdxLayoutControl;
    edtSvnPath: TcxComboBox;
    lcMainItem1: TdxLayoutItem;
    btnSelectPath: TcxButton;
    lcMainItem2: TdxLayoutItem;
    dlgOpen: TOpenDialog;
    btnCommit: TcxButton;
    lcMainItem3: TdxLayoutItem;
    lcMainGroup1: TdxLayoutGroup;
    lcMainItem4: TdxLayoutItem;
    btnUpdate: TcxButton;
    lcMainGroup2: TdxLayoutGroup;
    lcMainItem5: TdxLayoutItem;
    btnLog: TcxButton;
    lcMainItem6: TdxLayoutItem;
    btnDiff: TcxButton;
    procedure btnSelectPathClick(Sender: TObject);
    procedure btnUpdateClick(Sender: TObject);
    procedure btnCommitClick(Sender: TObject);
    procedure btnLogClick(Sender: TObject);
    procedure btnDiffClick(Sender: TObject);
  private
    procedure CreateSVNBat(aSaveFilePath : string;aSvnPath : String ;aCmd : string = 'update');
    procedure Load(aCmd : String = 'update');
  public
    procedure WorkRun(aSvnPath : String;aCmd : String = 'update');
    function CheckSvnIsExist : Boolean;
    function CheckIsShow : Boolean; override;
  end;

var
  fmSVN: TfmSVN;

const
  SVN_EXE_PATH = 'C:/Program Files/TortoiseSVN/bin/TortoiseProc.exe';  

implementation

  uses
    unitStandardHandle;



{$R *.dfm}

procedure TfmSVN.btnSelectPathClick(Sender: TObject);
var
  I : Integer;
begin
  if dlgOpen.Execute then
  begin
    for I := 0 to dlgOpen.Files.Count-1 do
    begin
      edtSvnPath.Text := dlgOpen.Files.Strings[I];
    end;
  end;
end;

procedure TfmSVN.CreateSVNBat(aSaveFilePath : string;aSvnPath : String  ;aCmd : string = 'update');
var
  aBatText : string;
  aFile : TStandardHandle;  
begin
  aBatText := '@echo off' + #13#10 + ' "'+ SVN_EXE_PATH +'" '
    + '/command:' + aCmd + ' /path:' + '"' + aSvnPath + '"'
    +'/closeonend:0';
  aFile := TStandardHandle.Create;
  try
    aFile.SaveFile(aSaveFilePath,aBatText);
  finally
    aFile.Free;
  end;
end;

function TfmSVN.CheckIsShow : Boolean; 
begin
  Result := CheckSvnIsExist;
end;

function TfmSVN.CheckSvnIsExist : Boolean;
begin
  Result :=  FileExists(SVN_EXE_PATH);
end;

procedure TfmSVN.WorkRun(aSvnPath : String;aCmd : String = 'update');
var
  aFold : string;
  aFileName : string;
  aPath : string;
  aBatStr : string;  
begin
  inherited;
  if not CheckSvnIsExist then
  begin
    ShowMessage('未安装SVN,无法使用该功能。');
    Exit;
  end;

  aFold := ExtractFileDir(ParamStr(0)) + '\Config\';
  aFileName := aCmd + '.bat';
  aPath := aFold + aFileName;
  CreateSVNBat(aPath,aSvnPath,aCmd);
  winexec(pchar(aPath), SW_HIDE);
end;

procedure TfmSVN.Load(aCmd : String = 'update');
begin
  WorkRun(edtSvnPath.Text,aCmd)
end;

procedure TfmSVN.btnUpdateClick(Sender: TObject);
begin
  inherited;
  Load('update');
end;

procedure TfmSVN.btnCommitClick(Sender: TObject);
begin
  inherited;
  Load('commit');
end;

procedure TfmSVN.btnLogClick(Sender: TObject);
begin
  inherited;
  Load('log');
end;

procedure TfmSVN.btnDiffClick(Sender: TObject);
begin
  inherited;
  Load('diff');
end;

initialization
  RegisterClass(TfmSVN);

finalization
  UnregisterClass(TfmSVN);

end.
