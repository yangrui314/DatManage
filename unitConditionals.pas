unit unitConditionals;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs,StdCtrls,StrUtils,unitConfig;

type
  TConditionals = class
  private
    FParameter : String;
    function GetOutputDirAndConditionalsAndPathName(aFilePath : String;
        aOutputDirKeyStr : String; aConditionalsKeyStr : String;
        var aOutputDir : string; var aConditionals : String;var aPathName : String;aSelectStr : String = '') : Boolean;    
    function GetPathName(aOutputDir : String) : String;
    procedure FileReplace(FileName  : String;SrcWord : String; ModifyWord : String;CaseFlag : Boolean);   

  protected
  public
    procedure View(aParameter : String);
    procedure Update(aParameter : String);
    function GetStrNum(const aFilePath : String;const aSelectStr : String) : Integer;
    function GetFileMidStr(aFilePath : String;aBeginStr : String; aEndStr : String = '') : String;
    function AnalysisStr(const aStr : String;var aName : String; var aOutputDir : String; var aConditionals : String) : Boolean;
    function ConvertToPath(const aBasePath : String ;const aOutputDir : String) : String;
  end;

implementation

  uses
    unitStrHelper;

procedure TConditionals.View(aParameter : String);
var
  aSoftwareScrPath : string;
  aOutputDir : String;
  aConditionals : string;
  aPathName : string;
begin
  inherited;
  FParameter := aParameter;
  aSoftwareScrPath :=LeftStr(FParameter,Pos('deploy',FParameter)-1) + 'src\delphi\';

  if GetOutputDirAndConditionalsAndPathName(aSoftwareScrPath + 'Omni.dof','OutputDir=',
                                'Conditionals=',aOutputDir,aConditionals,aPathName) then
  begin
    ShowMessage('��ǰ·������:'  + aPathName + #13
    + '��ǰ���·��:' + #13 + aOutputDir + #13
    + '��ǰ�������ָ�' + #13 + aConditionals);      
  end
  else
  begin
    ShowMessage('�鿴ʧ�ܡ�');
  end;
end;


procedure TConditionals.Update(aParameter : String);
var
  aSelectStr : String;
  aSoftwareScrPath : String;
  aAlterOutputDir,aAlterConditionals,aAlterPathName: String;
  aOutputDir,aConditionals,aPathName: String;
  aIsGetAlter,aIsGetScr : Boolean;
begin
  inherited;
  FParameter := aParameter;
  aSelectStr := '�������Ŀ¼��..\..\deploy\client' + StrHelper.GetMidStr(FParameter,'client','data');
  aSoftwareScrPath :=LeftStr(FParameter,Pos('deploy',FParameter)-1) + 'src\delphi\';
  aIsGetAlter := GetOutputDirAndConditionalsAndPathName(aSoftwareScrPath + 'Readme.txt' ,'�������Ŀ¼��',
                                '����ָ�',aAlterOutputDir,aAlterConditionals,aAlterPathName,aSelectStr);
  aIsGetScr := GetOutputDirAndConditionalsAndPathName(aSoftwareScrPath + 'Omni.dof','OutputDir=',
                              'Conditionals=',aOutputDir,aConditionals,aPathName);
  if aAlterPathName = aPathName then
  begin
    ShowMessage('�޸ĵ�Ŀ¼�͵�ǰĿ¼��ͬ��' + aPathName + ',�޷��޸ġ�');
    Exit;
  end;
                              
  if aIsGetAlter and aIsGetScr  then
  begin
    //�޸����·��
    FileReplace(aSoftwareScrPath + 'Omni.dof',aOutputDir,aAlterOutputDir,False);
    //�޸ı���ָ��
    FileReplace(aSoftwareScrPath + 'Omni.dof',aConditionals,aAlterConditionals,False);
    ShowMessage('�޸ı���ָ��ɹ���'+ #13 + aPathName + '�޸�Ϊ' +aAlterPathName);
  end
  else
  begin
    ShowMessage('�޸ı���ָ��ɹ���');
  end;  
end;

function TConditionals.GetStrNum(const aFilePath : String;const aSelectStr : String) : Integer;
var
  aFile : TStringList;
  aStr : String;
  aNum : Integer;
  aTempStr,aNotLeft : String;
begin
  Result := 0;
  aFile := TStringList.Create();
  try
    if not FileExists(aFilePath) then
    begin
      Exit;
    end;
    aFile.LoadFromFile(aFilePath);
    aStr := aFile.Text;
    aTempStr := aStr;
    aNum := 0;
    while (Pos(aSelectStr,aTempStr) <> 0)  do
    begin
      aNotLeft := StrHelper.GetMidStr(aTempStr,aSelectStr);
      aTempStr := aNotLeft;
      Inc(aNum);
    end;
    Result := aNum;
  finally
    aFile.Free;
  end;
end;

function TConditionals.GetFileMidStr(aFilePath : String;aBeginStr : String; aEndStr : String) : String;
var
  aFile : TStringList;
  aStr : String;
  aNum : Integer;
begin
  Result := '';
  aFile := TStringList.Create();
  try
    if not FileExists(aFilePath) then
    begin
      Exit;
    end;
    aFile.LoadFromFile(aFilePath);
    aStr := aFile.Text;
    Result := StrHelper.GetMidStr(aStr,aBeginStr,aEndStr);
  finally
    aFile.Free;
  end;
end;


function TConditionals.AnalysisStr(const aStr : String;var aName : String; var aOutputDir : String; var aConditionals : String) : Boolean;
var
  aNameEndNum : Integer;
begin
  Result := False;
  aNameEndNum :=  Pos(#13,WideString(aStr));
  aName := LeftStr(aStr,aNameEndNum-1);
  aOutputDir := StrHelper.GetMidStr(aStr,'�������Ŀ¼��',#13);
  if (Pos('��',aOutputDir) <> 0) then
  begin
    aOutputDir := StrHelper.GetMidStr(aOutputDir,'��');
  end;
  aConditionals := StrHelper.GetMidStr(aStr,'����ָ�',#13);
  Result := True;
end;


function TConditionals.ConvertToPath(const aBasePath : String ;const aOutputDir : String) : String;
begin
  // aOutputDir ..\..\deploy\client\dg-n-tax\bin
  // aBasePath D:\Project\new_omni\
  Result := '';
  Result := aBasePath + 'trunk\engineering\' + StrHelper.GetMidStr(aOutputDir,'..\..\','bin') +'data';
end;

function TConditionals.GetOutputDirAndConditionalsAndPathName(aFilePath : String;
aOutputDirKeyStr : String; aConditionalsKeyStr : String;
var aOutputDir : string; var aConditionals : String;var aPathName : String;aSelectStr : String = '') : Boolean;
var
  aFile : TStringList;
  aStr : String;
  aSelectNum : Integer;
begin
  Result := False;
  aFile := TStringList.Create();
  try
    if not FileExists(aFilePath) then
    begin
      Exit;
    end;
    aFile.LoadFromFile(aFilePath);
    aStr := aFile.Text;
    if aSelectStr <> '' then
    begin
      aSelectNum := Pos(aSelectStr,aStr);
      aStr := Copy(aStr,aSelectNum ,Length(aStr)-aSelectNum+1);
    end;
    aOutputDir := StrHelper.GetMidStr(aStr,aOutputDirKeyStr,#13);
    aConditionals :=  StrHelper.GetMidStr(aStr,aConditionalsKeyStr,#13);
    aPathName :=  GetPathName(aOutputDir);
    Result := True;

  finally
    aFile.Free;
  end;
end;




function TConditionals.GetPathName(aOutputDir : String) : String;
var
  aSelectStr : string;
begin
  Result := '';
  aSelectStr := StrHelper.GetMidStr(aOutputDir,'client','bin');
  Result := Config.GetHistoryName(aSelectStr,True);
end;

procedure TConditionals.FileReplace(FileName  : String;SrcWord : String; ModifyWord : String;CaseFlag : Boolean);
var
  List : TStringList;
begin
  List := TStringList.Create();
  try
    List.LoadFromFile(FileName);
    if CaseFlag
    then List.Text := StringReplace(List.Text,SrcWord,ModifyWord,[rfReplaceAll])
    else List.Text := StringReplace(List.Text,SrcWord,ModifyWord,[rfReplaceAll, rfIgnoreCase]);
    List.SaveToFile(FileName);
  finally
    List.Free;
  end;
end;

end.
