unit unitFileHelper;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs,StdCtrls,unitParentHelper,StrUtils;

type
  TFileHelper = class(TParentHelper)
  private
  protected
  public
    constructor Create;
    //��ȡĳ��Ŀ¼��ĳ�ֺ�׺���ļ������� yr 2016-12-08
    function GetFilesByPathAndExt(const aPath : String;const aExt : String;
      const aNameFilter : String = '') : TStringList;
    //ɾ��ָ��Ŀ¼ָ����׺���ļ� yr 2016-12-12
    procedure DelFiles(const aFilePath : String;const aExt : String);
    //������־ yr 2016-12-13
    procedure SaveLog(const aIsSuccess : Boolean;const aSQL : String;const aMessage: String = '');
    //�����ļ�
    function SaveFile(aFilePath : String;aData : String) : Boolean;
    function ReadFileToStr(aFilePath : String) : String;
    function ReadFile(aFilePath : String) : TStringList;    
  end;

var
  FileHelper: TFileHelper;

implementation
  uses
    unitConfig,unitStrHelper;


constructor TFileHelper.Create;
begin

end;

procedure TFileHelper.DelFiles(const aFilePath : String;const aExt : String);
var
  TmpFiles :TStringList;
  TmpPath : String;
  TempExt : String;
  I : Integer;
begin
  TempExt := aExt;
  if LeftStr(TempExt,1) <> '.' then
    TempExt := '.' + TempExt;
    
  TmpFiles := GetFilesByPathAndExt(aFilePath,TempExt);
  for I := 0 to TmpFiles.Count - 1 do
  begin
    TmpPath := ExtractFileDir(ParamStr(0)) + '\' + TmpFiles[I] + TempExt;
    if FileExists(TmpPath) then
      DeleteFile(TmpPath);
  end;
end;


function TFileHelper.GetFilesByPathAndExt(const aPath : String;const aExt : String;const aNameFilter : String) : TStringList;
var
  SearchRec: TSearchRec;
  Found: Integer;
  TmpPath : string;
  TmpExt :String;
begin
  //aExt:��׺����  aNameFilter �����������Ƿ���ĳ���ַ� yr 2016-12-08
  Result := TStringList.Create;
  
  TmpPath := aPath;
  TmpExt := aExt;

  if RightStr(TmpPath, 1) <> '\' then
    TmpPath := TmpPath + '\';

  if LeftStr(TmpExt,1) <> '.' then
    TmpExt := '.' + TmpExt;
    
  Found := FindFirst(TmpPath + '*.*', faAnyFile, SearchRec);
  try
    while Found = 0 do
    begin
      if ((Pos(UpperCase(aNameFilter),UpperCase(SearchRec.Name)) <> 0) or (aNameFilter = '')) and
        (SearchRec.Name <> '.') and (SearchRec.Name <> '..') and (SearchRec.Attr <> faDirectory) and ((ExtractFileExt(SearchRec.Name) = TmpExt)) then
      begin
        Result.Add(ChangeFileExt(SearchRec.Name, ''));
      end;
      Found := FindNext(SearchRec);
    end;
  finally
    FindClose(SearchRec);  
  end;
end;


procedure TFileHelper.SaveLog(const aIsSuccess : Boolean;const aSQL : String;const aMessage: String = '');
var
  aLogStr : string;
  aNewLog : string;
  FLogPath : String;
  aDirPath : String;

 function GetNewLog : string;
 var
   aModeStr : string;
   aResultStr : string;
   aSQLStr : string;
   aMessageStr : string;
   aTimeStr : string;
 begin
  Result := '';
  Result := Config.SystemParameterCaption;

  if Config.ConnectWay = '1' then
  begin
    aModeStr := #13#10  + '���ݿ�:' + 'DBISAMģʽ';
  end
  else
  begin
    aModeStr := #13#10 + '���ݿ�:' + 'SQLģʽ';
  end;

  if aIsSuccess then
  begin
    aResultStr := #13#10 + 'ִ�гɹ���';
  end
  else
  begin
    aResultStr := #13#10 + 'ִ��ʧ��!';
  end;
  aSQLStr :=   #13#10 + 'ִ��SQL:' + aSQL;
  aMessageStr :=  #13#10 + '�����Ϣ:' + aMessage;
  aTimeStr  :=   #13#10 + '����ʱ��:' + FormatDatetime('YYYY/MM/DD HH:MM:SS',Now);
  Result := Result + aModeStr + aResultStr  + aSQLStr ;
  if aMessage <> '' then
  begin
    Result := Result  + aMessageStr ;
  end;
  Result := Result  + aTimeStr;
 end;

begin
  aDirPath := ExtractFilePath(ParamStr(0)) + 'log\';
  if not DirectoryExists(aDirPath) then
  begin
    CreateDir(aDirPath);
  end;
  FLogPath := aDirPath + FormatDateTime('yyyymmdd', Now) +  '.txt';

  aLogStr := ReadFileToStr(FLogPath);
  aNewLog := GetNewLog;
  if aLogStr <> '' then
    aLogStr := aLogStr + #13#10 +  #13#10  + aNewLog
  else
    aLogStr := aNewLog;
  SaveFile(FLogPath,aLogStr);
end;

function TFileHelper.SaveFile(aFilePath : String;aData : String) : Boolean;
var
  aFile: TextFile;
  aStr : String;
begin
  aStr := aData;
  AssignFile(aFile,aFilePath);
  Rewrite(aFile);
  Writeln(aFile, aStr);
  CloseFile(aFile);
  Result := True;
end;


function TFileHelper.ReadFileToStr(aFilePath : String) : String;
begin
  Result := StrHelper.StringListToString(ReadFile(aFilePath));
end;


function TFileHelper.ReadFile(aFilePath : String) : TStringList;
var
  aFile : Textfile;
  aStr : String;
begin
  Result := TStringList.Create;
  if not FileExists(aFilePath) then
  begin
    Exit;
  end;
  AssignFile(aFile, aFilePath);
  try
    Reset(aFile);
    while not Eof(aFile) do
    begin
      Readln(aFile, aStr);
      Result.Add(aStr) ;
    end;
  finally
    Closefile(aFile);
  end;
end;

end.
