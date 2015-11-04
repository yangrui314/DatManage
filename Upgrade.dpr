program Upgrade;

{$APPTYPE CONSOLE}

uses
  SysUtils,Windows;

var
  aFileName : string;
  aSrcFilePath : string;
  aCreateFilePath : string;
begin
  aFileName :=  'DatManageMain.exe';
  aSrcFilePath :=  ExtractFilePath(ParamStr(0)) + aFileName;
  aCreateFilePath := ExtractFilePath(ParamStr(0)) + 'Upgrade\' + aFileName;

  if FileExists(aCreateFilePath) then
  begin
    CopyFile((PChar(aCreateFilePath)),(PChar(aSrcFilePath)),False);
  end;
  WinExec(PChar(aSrcFilePath), SW_SHOWNORMAL);  
end.
