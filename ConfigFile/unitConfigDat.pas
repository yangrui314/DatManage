unit unitConfigDat;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, dbisamtb,StdCtrls,unitConfigFile;


type
  TConfigDat = class(TConfigFile)
  private
    FSystemConfig : TDBISAMTable;
    FHistory: TDBISAMTable;
    FMenu : TDBISAMTable;
    procedure InitTable;
    procedure InitSystemConfig;
    procedure InitHistory;
    procedure InitMenu;
  protected
    procedure LoadMenu;
    procedure InitData; override;
    function GetSystemConfigValue(aName : String) : String; override;
    procedure SaveSystemConfig(aName : String;aValue : String); override;
    function LoadHistorys : TList; override;
  public
    constructor Create; override;
    procedure SaveHistory(aConnectWay : string;aName : String;aPath : String);override;    
    destructor Destroy; override;
  end;

const
  SYSTEMCONFIG_NAME = 'SystemConfig';
  HISTORY_NAME = 'History';
  MENU_NAME = 'Menu';
  

implementation

  uses
    unitHistory,unitMenu;

constructor TConfigDat.Create;
begin
  FSystemConfig := TDBISAMTable.Create(nil);
  FHistory := TDBISAMTable.Create(nil);
  FMenu  := TDBISAMTable.Create(nil);
  inherited;
end;

procedure TConfigDat.InitTable;
begin
  InitSystemConfig;
  InitHistory;
  InitMenu;
end;


procedure TConfigDat.InitSystemConfig;
begin
  with FSystemConfig do
  begin
    DatabaseName:= FConfigPath;
    TableName:= SYSTEMCONFIG_NAME;
    with FieldDefs do
    begin
      Clear;
      Add('ID',ftAutoInc,0,False);
      Add('Name',ftString,255,False);
      Add('Value',ftString,255,False);
    end;
    with IndexDefs do
    begin
      Clear;
      Add('','ID',[ixPrimary]);
      Add('ByName','Name',[ixUnique]);
    end;
    if not Exists then
      CreateTable;
  end;      
end;


procedure TConfigDat.InitHistory;
begin
  with FHistory do
  begin
    DatabaseName:= FConfigPath;
    TableName:= HISTORY_NAME;
    with FieldDefs do
    begin 
      Clear; 
      Add('ID',ftAutoInc,0,False);
      Add('ConnectWay',ftString,255,False);      
      Add('Name',ftString,255,False);
      Add('Path',ftString,255,False);
    end;
    with IndexDefs do
    begin
      Clear;
      Add('','ID',[ixPrimary]);
      Add('ByLastFolderPath','Path',[ixUnique]);
    end;
    if not Exists then
      CreateTable;
  end;      
end;

procedure TConfigDat.InitMenu;
begin
  with FMenu do
  begin
    DatabaseName:= FConfigPath;
    TableName:= MENU_NAME;
    with FieldDefs do
    begin 
      Clear; 
      Add('ID',ftAutoInc,0,False);
      Add('Name',ftString,255,False);
      Add('Caption',ftString,255,False);
      Add('OrderID',ftInteger,0,False);
      Add('Visible',ftBoolean,0,False);
      Add('ClassType',ftString,60,False);
      Add('ClassName',ftString,255,False);
      Add('NotShowFormHint',ftString,255,False);
      Add('ParentName',ftString,255,False);
    end;
    with IndexDefs do
    begin
      Clear;
      Add('','ID',[ixPrimary]);
      Add('ByName','Name',[ixUnique]);
    end;
    if not Exists then
      CreateTable(0,1,0,True,'YouAreNotPreparedForIT')
  end;
end;

procedure TConfigDat.InitData;
begin
  inherited;
  InitTable;
  LoadMenu;
end;

procedure TConfigDat.LoadMenu;
var
  aMenu : TMenu;
  I,J,K,N : Integer;
  aMenuNames : array of String;
  aMenuOrderIDs : array of Integer;
  aTemp : Integer;
  aTempStr : string;
begin
  try
    with FMenu do
    begin
      DatabaseName:= FConfigPath;
      TableName:= MENU_NAME;
      DBSession.AddPassword('YouAreNotPreparedForIT');

      if Active then Close;
      Open;

      SetLength(FConfig.FMenuList,FMenu.RecordCount);

      I := 0;
      SetLength(aMenuNames,FMenu.RecordCount);
      SetLength(aMenuOrderIDs,FMenu.RecordCount);
      First;
      while not Eof do
      begin
        aMenuNames[I] := FieldByName('Name').AsString;
        aMenuOrderIDs[I] := FieldByName('OrderID').AsInteger;
        Inc(I);
        Next;
      end;

      for J:=0 to FMenu.RecordCount - 1 do
      begin
        for K:=0 to (FMenu.RecordCount - 1) - J -1 do
        begin
          if aMenuOrderIDs[K]>aMenuOrderIDs[K+1] then
          begin
            aTemp:= aMenuOrderIDs[K];
            aTempStr :=  aMenuNames[K];
            aMenuOrderIDs[K]:=aMenuOrderIDs[K+1];
            aMenuNames[K] := aMenuNames[K+1];
            aMenuOrderIDs[K+1]:=aTemp;
            aMenuNames[K+1] := aTempStr;
          end;
        end;
      end;

      for N:=0 to FMenu.RecordCount - 1 do
      begin
        FMenu.Locate('Name',aMenuNames[N],[]);
        aMenu := TMenu.Create;
        aMenu.Name := FieldByName('Name').AsString;
        aMenu.Caption := FieldByName('Caption').AsString;
        aMenu.OrderID := FieldByName('OrderID').AsInteger;
        aMenu.Visible := FieldByName('Visible').AsBoolean;
        aMenu.ClassType := FieldByName('ClassType').AsString;
        aMenu.ClassName := FieldByName('ClassName').AsString;
        aMenu.NotShowFormHint := FieldByName('NotShowFormHint').AsString;
        aMenu.ParentName := FieldByName('ParentName').AsString;
        FConfig.FMenuList[N] := (aMenu);
      end;

//      First;
//      while not Eof do
//      begin
//        aMenu := TMenu.Create;
//        aMenu.Name := FieldByName('Name').AsString;
//        aMenu.Caption := FieldByName('Caption').AsString;
//        aMenu.OrderID := FieldByName('OrderID').AsInteger;
//        aMenu.Visible := FieldByName('Visible').AsBoolean;
//        aMenu.ClassType := FieldByName('ClassType').AsString;
//        aMenu.ClassName := FieldByName('ClassName').AsString;
//        aMenu.NotShowFormHint := FieldByName('NotShowFormHint').AsString;
//        aMenu.ParentName := FieldByName('ParentName').AsString;
//        FConfig.FMenuList[I] := (aMenu);
//        Inc(I);
//        Next;
//      end;
      Close;
    end;
  finally
    SetLength(aMenuNames,0);
    SetLength(aMenuOrderIDs,0);  
  end;
end;


function TConfigDat.GetSystemConfigValue(aName : String) : String;
begin
  inherited;
  Result := '';
  with FSystemConfig do
  begin
    DatabaseName:= FConfigPath;
    TableName:= SYSTEMCONFIG_NAME;

    if Active then Close;
    Open;
    try
      First;
      while not Eof do
      begin
        if aName = FieldByName('Name').AsString then
        begin
          Result :=  FieldByName('Value').AsString;
          Exit;      
        end;
        Next;
      end;
    finally
      Close;
    end;
  end;
end;

procedure TConfigDat.SaveSystemConfig(aName : String;aValue : String); 
begin
  inherited;
  with FSystemConfig do
  begin
    DatabaseName:= FConfigPath;
    TableName:= SYSTEMCONFIG_NAME;

    if Active then Close;
    Open;
    try
      First;
      while not Eof do
      begin
        if aName = FieldByName('Name').AsString then
        begin
          Edit;
          FieldByName('Value').AsString := aValue;
          Post;
          Exit;      
        end;
        Next;
      end;
      Append;
      FieldByName('Name').AsString := aName;
      FieldByName('Value').AsString := aValue;
      Post;
    finally
      Close;
    end;
  end;
end;



function TConfigDat.LoadHistorys : TList;
var
  aHistory : THistory;
begin
  inherited;
  Result := TList.Create;
//  aHistory := THistory.Create('','');
  try
    with FHistory do
    begin
      DatabaseName:= FConfigPath;
      TableName:= HISTORY_NAME;


      if Active then Close;
      Open;

      First;
      while not Eof do
      begin
        aHistory := THistory.Create(FieldByName('ConnectWay').AsString,FieldByName('Name').AsString,FieldByName('Path').AsString);
        Result.Add(aHistory);
        Next;
      end;

      Close;
    end;   
  finally
//    aHistory.Free;
  end;
end;
    
procedure TConfigDat.SaveHistory(aConnectWay : string;aName : String;aPath : String);
begin
  inherited;
  with FSystemConfig do
  begin
    DatabaseName:= FConfigPath;
    TableName:= HISTORY_NAME;

    if Active then Close;
    Open;
    
    if Locate('Name',aName,[]) then
    begin
      ShowMessage('该名称历史记录已经存在，无法保存。');
      Exit;
    end;

    if Locate('Path',aPath,[]) then
    begin
      ShowMessage('该路径历史记录已经存在，无法保存。');
      Exit;
    end;



    First;
    Append;
    FieldByName('ConnectWay').AsString := aConnectWay;
    FieldByName('Name').AsString := aName;
    FieldByName('Path').AsString := aPath;
    Post;

    Close;
  end;      
end;




destructor TConfigDat.Destroy;
begin
  inherited;
  FHistory.Free;
  FMenu.Free;
  FSystemConfig.Free;      
end;

end.
