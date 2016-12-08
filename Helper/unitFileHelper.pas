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
    //获取某种目录的某种后缀的文件名集合 yr 2016-12-08
    function GetFilesByPathAndExt(const aPath : String;const aExt : String;
      const aNameFilter : String = '') : TStringList;
  end;

var
  FileHelper: TFileHelper;

implementation


constructor TFileHelper.Create;
begin

end;

function TFileHelper.GetFilesByPathAndExt(const aPath : String;const aExt : String;const aNameFilter : String) : TStringList;
var
  SearchRec: TSearchRec;
  Found: Integer;
  TmpPath : string;
  TmpExt :String;
begin
  //aExt:后缀名称  aNameFilter 查找名称中是否含有某种字符 yr 2016-12-08
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


initialization
  FileHelper := TFileHelper.Create;

finalization
  FileHelper.Free;;

end.
