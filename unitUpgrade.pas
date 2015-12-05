unit unitUpgrade;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs,StdCtrls,StrUtils,Forms,RzStatus,unitStandardHandle,formUpgradeProgress,
  unitDownLoadFile;

type
  TUpgrade = class
  private
    FPatchVersion : String;
    FNowVersion : string;
    RzVersionInfo: TRzVersionInfo;
    FOwner : TComponent;
    procedure StartUpgrade;
    function NeedUpdate : Boolean;
    function ReadNowVersion : String;
    function ReadWebVersion: String;
    procedure DownloadFile(aURL : string;aFileName : String;aShowProgress : Boolean = True);
    function GetNeedUpdateToVersion(aNowVersion : string;aWebVersion : string):Boolean;
    procedure CreateNew;
    procedure MergeNew;
    procedure CreateBat;
  protected
  public
    procedure UpdateSelf(AOwner : TComponent);
  end;

implementation


const
  VERSION_URL = 'http://sz-btfs.yun.ftn.qq.com/ftn_handler/2b9f99e1565690cd424cf4a2cc2ff3ad4da93155f7ea9365baf46d09c876a3d1/?fname=Version.ini&from=30111&version=2.0.0.2&uin=190200649';
  UPGRADE_URL = 'http://sz-btfs.yun.ftn.qq.com/ftn_handler/3b301df756b88a0b720798d077c605b69eeda0113c9dc0cc8624625e70dd80d2/?fname=Upgrade.zip&from=30111&version=2.0.0.2&uin=190200649';


procedure TUpgrade.StartUpgrade;
var
  aExec : string;
begin
  aExec := ExtractFilePath(ParamStr(0)) + 'Upgrade.exe';
  WinExec(PChar(aExec), SW_SHOWNORMAL);
  Application.Terminate;
end;  

function TUpgrade.NeedUpdate : Boolean;
var
  aNowVersion : string;
  aWebVersion : string;
begin
  Result := False;
  aNowVersion := ReadNowVersion;
  DownloadFile(VERSION_URL,'Version.ini',False);
  aWebVersion :=  ReadWebVersion;
  Result :=  GetNeedUpdateToVersion(aNowVersion,aWebVersion);
end;

function TUpgrade.ReadNowVersion : String;
begin
  Result := '';
  FNowVersion := '';
  RzVersionInfo.FilePath := Application.ExeName;
  FNowVersion := RzVersionInfo.FileVersion;
  Result := RzVersionInfo.FileVersion;
end;

function TUpgrade.ReadWebVersion : String;
var
  aConfigPath : string;
  I : Integer;
  aReadConfig : TStandardHandle;
  aStr : string;
  aNum : Integer;
begin
  Result := '';
  FPatchVersion := '';
  aConfigPath := ExtractFilePath(ParamStr(0)) + 'Upgrade\' + 'Version.ini';
  if not FileExists(aConfigPath) then
  begin
    Exit;
  end;
  aReadConfig := TStandardHandle.Create;
  try
    aReadConfig.ReadFile(aConfigPath);
    for I := 0 to aReadConfig.FileData.Count - 1 do
    begin
      aStr := aReadConfig.FileData[I];
      if Pos('Patch',aStr) <> 0 then
      begin
        aNum := Pos('=',aStr);
        aStr := Copy(aStr,aNum + 1,Length(aStr)-aNum);
        FPatchVersion := aStr;
      end;

      if Pos('Version',aStr) <> 0 then
      begin
        aNum := Pos('=',aStr);
        aStr := Copy(aStr,aNum + 1,Length(aStr)-aNum);
        Result := aStr;
        Exit;
      end;
    end;
  finally
    aReadConfig.Free;
  end;
end;

procedure TUpgrade.DownloadFile(aURL : string;aFileName : String;aShowProgress : Boolean = True);
var
  aSrcFilePath : string;
  aCreateFilePath : string;
  aProgress :  TfmUpgradeProgress;
  aSavePath : string;
  aDownLoad : TDownLoadFile;
begin
//  lblState.Caption := '下载数据...';
  aSavePath := ExtractFilePath(ParamStr(0)) + 'Upgrade\';

  if aShowProgress then
  begin
    aProgress := TfmUpgradeProgress.Create(FOwner,aURL,aSavePath + aFileName);
    try
    aProgress.ShowModal;
    finally
      aProgress.Free;
    end;  
  end
  else
  begin
    aDownLoad := TDownLoadFile.Create(FOwner,aURL,aSavePath + aFileName);
    try
    finally
      aDownLoad.Free;
    end;
  end;
//  lblState.Caption := '状态...';
end;

function TUpgrade.GetNeedUpdateToVersion(aNowVersion : string;aWebVersion : string):Boolean;
var
  aNow : Integer;
  aWeb : Integer;
  aNowRemain,aWebRemain : string;
  aNowNumStr,aWebNumStr : String;
  aNowPostNum,aWebPostNum : Integer;
  aNowNum,aWebNum : Integer;
begin
  Result := False;
  aNowRemain := aNowVersion;
  aWebRemain := aWebVersion;
  while (aNowRemain <> '') or (aWebRemain <> '')  do
  begin
    if aNowRemain = '' then
    begin
      aNowNum := -1;
    end
    else if Pos('.',aNowRemain) = 0  then
    begin
      aNowNum := StrToInt(aNowRemain);
      aNowRemain := '';
    end
    else
    begin
      aNowPostNum := Pos('.',aNowRemain);
      aNowNumStr := Copy(aNowRemain,0,aNowPostNum-1);
      aNowRemain := Copy(aNowRemain,aNowPostNum + 1,Length(aNowRemain)-aNowPostNum);
      aNowNum :=  StrToInt(aNowNumStr);
    end;

    if aWebRemain ='' then
    begin
      aWebNum := -1;
    end
    else if Pos('.',aWebRemain) = 0  then
    begin
      aWebNum := StrToInt(aWebRemain);
      aWebRemain := '';
    end    
    else
    begin
      aWebPostNum := Pos('.',aWebRemain);
      aWebNumStr := Copy(aWebRemain,0,aWebPostNum-1);
      aWebRemain := Copy(aWebRemain,aWebPostNum + 1,Length(aWebRemain)-aWebPostNum);
      aWebNum :=  StrToInt(aWebNumStr);    
    end;


    if aNowNum < aWebNum then
    begin
      Result := True;
      Exit;
    end
    else if aNowNum > aWebNum then
    begin
      Result := False;
      Exit;    
    end;
  end;
end;

procedure TUpgrade.CreateNew;
var
  aPatchPath : string;
  aUpgradePath : string;
  aName : string;
begin
  aPatchPath := ExtractFilePath(ParamStr(0))  + 'Patch\';
  aUpgradePath := ExtractFilePath(ParamStr(0)) + 'Upgrade\';
  CopyFile((PChar(aUpgradePath + 'Patch.xdt')),(PChar(aPatchPath + 'Patch.xdt')),False);
  aName := ExtractFileName(ParamStr(0));
  CopyFile((PChar(ParamStr(0))),(PChar(aPatchPath + 'Old.exe')),False);
  MergeNew;
  CopyFile((PChar(aPatchPath + 'New.exe')),(PChar(aUpgradePath + aName )),False);
end;

procedure TUpgrade.MergeNew;
var
  aBat : String;
begin
  CreateBat;
  aBat := ExtractFilePath(ParamStr(0))  + 'Patch\' + 'Patch.bat';
  winexec(pchar(aBat), SW_HIDE);
end;


procedure TUpgrade.CreateBat;
var
  aBatText : string;
  aFile : TStandardHandle;
  aPath : String;  
begin
  aPath := ExtractFilePath(ParamStr(0))  + 'Patch\';
  aBatText := aPath + 'xdelta.exe' + ' patch ' +  aPath+'Patch.xdt '+ aPath + 'Old.exe '+ aPath +'New.exe';
  aFile := TStandardHandle.Create;
  try
    aFile.SaveFile(ExtractFilePath(ParamStr(0))  + 'Patch\' + 'Patch.bat',aBatText);
  finally
    aFile.Free;
  end;
end;

procedure TUpgrade.UpdateSelf(AOwner : TComponent);
var
  Version : string;
  aNum : Integer;
  aRemainVersion : string;
  aNumStr : string;
  i,j,k,l : Integer;
  aPath : string;
  FUsePatch : Boolean;
begin
  FOwner := AOwner;
  RzVersionInfo := TRzVersionInfo.Create(FOwner);
  try
    FUsePatch := False;
    if not NeedUpdate then
    begin
      ShowMessage('已是最新版本,不需要下载。');
      Exit;
    end;
    aPath := ExtractFilePath(ParamStr(0))  + 'Patch\';
    if (FPatchVersion = FNowVersion) and FileExists(aPath + 'xdelta.exe') and FUsePatch then
    begin
      DownloadFile('','Patch.xdt');
      CreateNew;
    end
    else
    begin
      DownloadFile(UPGRADE_URL,'Upgrade.zip');
    end;
    StartUpgrade;
  finally
    RzVersionInfo.Free;
  end;
end;

end.
