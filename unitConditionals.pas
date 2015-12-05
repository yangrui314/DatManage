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
    function GetMidStr(aStr : String;aBeginStr : String; aEndStr : String) : String;
    function GetPathName(aOutputDir : String) : String;
    procedure FileReplace(FileName  : String;SrcWord : String; ModifyWord : String;CaseFlag : Boolean);    
  protected
  public
    procedure View(aParameter : String);
    procedure Update(aParameter : String);
  end;

implementation

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
  aSelectStr := '�������Ŀ¼��..\..\deploy\client' +GetMidStr(FParameter,'client','data');
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
    aOutputDir := GetMidStr(aStr,aOutputDirKeyStr,#13);
    aConditionals :=  GetMidStr(aStr,aConditionalsKeyStr,#13);
    aPathName :=  GetPathName(aOutputDir);
    Result := True;

  finally
    aFile.Free;
  end;
end;


function TConditionals.GetMidStr(aStr : String;aBeginStr : String; aEndStr : String) : String;
var
  aBeginNum,aEndStrNum: Integer;
  aNotLeft  : String;
begin
  Result := '';
  aBeginNum := Pos(aBeginStr,aStr);
  aNotLeft :=  Copy(aStr,aBeginNum + Length(aBeginStr) ,Length(aStr)-aBeginNum+1);

  aEndStrNum :=  Pos(aEndStr,aNotLeft);
  Result := LeftStr(aNotLeft,aEndStrNum-1);
end;

function TConditionals.GetPathName(aOutputDir : String) : String;
var
  aSelectStr : string;
begin
  Result := '';
  aSelectStr := GetMidStr(aOutputDir,'client','bin');
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
