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
    ShowMessage('当前路径名称:'  + aPathName + #13
    + '当前输出路径:' + #13 + aOutputDir + #13
    + '当前输出编译指令：' + #13 + aConditionals);      
  end
  else
  begin
    ShowMessage('查看失败。');
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
  aSelectStr := '编译输出目录：..\..\deploy\client' +GetMidStr(FParameter,'client','data');
  aSoftwareScrPath :=LeftStr(FParameter,Pos('deploy',FParameter)-1) + 'src\delphi\';
  aIsGetAlter := GetOutputDirAndConditionalsAndPathName(aSoftwareScrPath + 'Readme.txt' ,'编译输出目录：',
                                '编译指令：',aAlterOutputDir,aAlterConditionals,aAlterPathName,aSelectStr);
  aIsGetScr := GetOutputDirAndConditionalsAndPathName(aSoftwareScrPath + 'Omni.dof','OutputDir=',
                              'Conditionals=',aOutputDir,aConditionals,aPathName);
  if aAlterPathName = aPathName then
  begin
    ShowMessage('修改的目录和当前目录相同，' + aPathName + ',无法修改。');
    Exit;
  end;
                              
  if aIsGetAlter and aIsGetScr  then
  begin
    //修改输出路径
    FileReplace(aSoftwareScrPath + 'Omni.dof',aOutputDir,aAlterOutputDir,False);
    //修改编译指令
    FileReplace(aSoftwareScrPath + 'Omni.dof',aConditionals,aAlterConditionals,False);
    ShowMessage('修改编译指令成功。'+ #13 + aPathName + '修改为' +aAlterPathName);
  end
  else
  begin
    ShowMessage('修改编译指令成功。');
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
