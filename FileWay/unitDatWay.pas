unit unitDatWay;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs,StdCtrls,unitFileWay, DB, dbisamtb,unitHistory,unitTable,unitMenu,
  unitConfig;


type
  TDatWay = class(TFileWay)
  private
  protected
    FSystemConfig : TDBISAMTable;
    FHistory: TDBISAMTable;
    FMenu : TDBISAMTable;
    FPassword : TDBISAMTable;

    procedure CreateSystemConfig;override;
    procedure CreateHistory; override;
    procedure CreateMenu; override;
    procedure CreatePassword; override;
    procedure InitData; override;
  public
    constructor Create; override;
    destructor Destroy; override;
    function GetSystemConfig(aName : String) : String; override;
    procedure SaveSystemConfig(aName : String;aValue : String); override;
    function LoadHistorys : TList;override;
    procedure SaveHistory(const aHistory : THistory);override;
    function SaveFile(aFilePath : String;var aTable : TTable) : Boolean;override;
    function ReadFile(aFilePath : String;var aTable : TTable) : Boolean;override;
    procedure LoadMenu; override;
    procedure SaveMenu; override;
    procedure ClearHistorys;override;
    function LoadPasswords : TStringList;override;
    //删除保存的配置 yr 2016-12-12
    procedure DelHistory(const aHistory : THistory);override;
  end;


  //本软件需要加密的配置的密码 2016-01-14
const
  SELF_CONFIG_PASSWORD = 'YouAreNotPreparedForIT';

implementation


constructor TDatWay.Create;
begin
  FSystemConfig := TDBISAMTable.Create(nil);
  FHistory := TDBISAMTable.Create(nil);
  FMenu  := TDBISAMTable.Create(nil);
  FPassword := TDBISAMTable.Create(nil);
  inherited;
end;

destructor TDatWay.Destroy;
begin
  inherited;
  FHistory.Free;
  FMenu.Free;
  FSystemConfig.Free;
  FPassword.Free;      
end;

procedure TDatWay.CreateSystemConfig;
begin
  with FSystemConfig do
  begin
    DatabaseName:= FConfigPath;
    TableName:= FSystemConfigName;
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


procedure TDatWay.CreateHistory;
begin
  with FHistory do
  begin
    DatabaseName:= FConfigPath;
    TableName:= FHistoryName;
    with FieldDefs do
    begin 
      Clear; 
      Add('ID',ftAutoInc,0,False);
      Add('ConnectWay',ftString,255,False);      
      Add('Name',ftString,255,False);
      Add('Path',ftString,255,False);
      Add('FullName',ftString,255,False);      
      Add('OutputDir',ftString,255,False);
      Add('Conditionals',ftString,500,False);      
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

procedure TDatWay.CreateMenu;
begin
  with FMenu do
  begin
    DatabaseName:= FConfigPath;
    TableName:= FMenuName;
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
      CreateTable(0,1,0,True,SELF_CONFIG_PASSWORD);
  end;
end;




procedure TDatWay.CreatePassword;
begin
  with FPassword do
  begin
    DatabaseName:= FConfigPath;
    TableName:= FPasswordName;
    with FieldDefs do
    begin 
      Clear; 
      Add('ID',ftAutoInc,0,False);
      Add('Password',ftString,255,False);
    end;
    with IndexDefs do
    begin
      Clear;
      Add('','ID',[ixPrimary]);
    end;
    if not Exists then
      CreateTable(0,1,0,True,SELF_CONFIG_PASSWORD);
  end;
end;


procedure TDatWay.InitData;
begin
  FExt := '.dat';
  inherited;
end;

function TDatWay.GetSystemConfig(aName : String) : String;
var
  FSystemConfig : TDBISAMTable;
begin
  inherited;
  Result := '';
  FSystemConfig := TDBISAMTable.Create(nil);
  try
    with FSystemConfig do
    begin
      DatabaseName:= FConfigPath;
      TableName:= FSystemConfigName;

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
  finally
    FSystemConfig.Free;
  end;
end;
    
procedure TDatWay.SaveSystemConfig(aName : String;aValue : String);
var
  FSystemConfig : TDBISAMTable;
begin
  inherited;
  FSystemConfig := TDBISAMTable.Create(nil);
  try
    with FSystemConfig do
    begin
      DatabaseName:= FConfigPath;
      TableName:= FSystemConfigName;

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
  finally
    FSystemConfig.Free;
  end;

end;

function TDatWay.LoadHistorys : TList;
var
  aHistory : THistory;
  FHistory : TDBISAMTable;
begin
  inherited;
  Result := TList.Create;
  if not FileExists(FHistoryFilePath) then Exit;
  FHistory := TDBISAMTable.Create(nil);
  try
    with FHistory do
    begin
      DatabaseName:= FConfigPath;
      TableName:= FHistoryName;


      if Active then Close;
      Open;

      First;
      while not Eof do
      begin
        aHistory := THistory.Create(FieldByName('ConnectWay').AsString,FieldByName('Name').AsString,FieldByName('Path').AsString);
        aHistory.FullName  := FieldByName('FullName').AsString;
        aHistory.OutputDir := FieldByName('OutputDir').AsString;
        aHistory.Conditionals := FieldByName('Conditionals').AsString;
        Result.Add(aHistory);
        Next;
      end;

      Close;
    end;   
  finally
    FHistory.Free;
  end;
end;


function TDatWay.LoadPasswords : TStringList;
begin
  inherited;
  Result := TStringList.Create;
  if not FileExists(FPasswordFilePath) then Exit;
  with FPassword do
  begin
    DatabaseName:= FConfigPath;
    TableName:= FPasswordName;
    DBSession.AddPassword(SELF_CONFIG_PASSWORD);

    if Active then Close;
    Open;

    First;
    while not Eof do
    begin
      Result.Add(FieldByName('Password').AsString);
      Next;
    end;
    Close;
  end;
end;

procedure TDatWay.ClearHistorys;
var
  FHistory : TDBISAMTable;
begin
  inherited;
  if not FileExists(FHistoryFilePath) then Exit;
  FHistory := TDBISAMTable.Create(nil);
  try
    with FHistory do
    begin
      DatabaseName:= FConfigPath;
      TableName:= FHistoryName;
      EmptyTable;
    end;
  finally
    FHistory.Free;
  end;
end;


procedure TDatWay.SaveHistory(const aHistory : THistory);
var
  FHistory : TDBISAMTable;
begin
  inherited;
  FHistory := TDBISAMTable.Create(nil);
  try
    with FHistory do
    begin
      DatabaseName:= FConfigPath;
      TableName:= FHistoryName;

      if Active then Close;
      Open;
    
      if Locate('Name',aHistory.Name,[]) then
      begin
        ShowMessage('该名称历史记录已经存在，无法保存。');
        Exit;
      end;

      if Locate('Path',aHistory.Path,[]) then
      begin
        ShowMessage('该路径历史记录已经存在，无法保存。');
        Exit;
      end;

      First;
      Append;
      FieldByName('ConnectWay').AsString := aHistory.ConnectWay;
      FieldByName('Name').AsString := aHistory.Name;
      FieldByName('Path').AsString := aHistory.Path;
      FieldByName('FullName').AsString := aHistory.FullName;
      FieldByName('OutputDir').AsString := aHistory.OutputDir;
      FieldByName('Conditionals').AsString := aHistory.Conditionals;
      Post;

      Close;
    end; 
  finally
    FHistory.Free;
  end;

end;

procedure TDatWay.DelHistory(const aHistory : THistory);
var
  FHistory : TDBISAMTable;
begin
  inherited;
  FHistory := TDBISAMTable.Create(nil);
  try
    with FHistory do
    begin
      DatabaseName:= FConfigPath;
      TableName:= FHistoryName;

      if Active then Close;
      Open;
    
      if not Locate('Name',aHistory.Name,[]) then
      begin
        Exit;
      end;
      Edit;
      Locate('Name',aHistory.Name,[]);
      Delete;
      Append;
      Close;
    end;
  finally
    FHistory.Free;
  end;

end;




function TDatWay.SaveFile(aFilePath : String;var aTable : TTable) : Boolean;
var
  I : Integer;
  FSystemConfig : TDBISAMTable;
begin
  inherited;
  FSystemConfig := TDBISAMTable.Create(nil);
  try
    with FSystemConfig do
    begin
      DatabaseName:= FConfigPath;
      TableName:= FSystemConfigName;

      if Active then Close;
      Open;
      try
        First;
        I := 0;
        while not Eof do
        begin
          if  aTable.TableFieldNameArray[I] = FieldByName('Name').AsString then
          begin
            Edit;
          end
          else
          begin
            Append;          
          end;
          FieldByName('Name').AsString := aTable.TableFieldNameArray[I];
          FieldByName('Caption').AsString := aTable.TableFieldCaptionArray[I];
          FieldByName('Size').AsInteger := aTable.TableFieldSizeArray[I];
          Post;
          Inc(I);
          Next;
        end;
        Result := True;
      finally
        Close;
      end;
    end;
  finally
    FSystemConfig.Free;
  end;

end;

function TDatWay.ReadFile(aFilePath : String;var aTable : TTable) : Boolean;
var
  FSystemConfig : TDBISAMTable;
  I : Integer;
begin
  FSystemConfig := TDBISAMTable.Create(nil);
  try
    with FSystemConfig do
    begin
      DatabaseName:= ExtractFilePath(aFilePath);
      TableName:= ExtractFileName(aFilePath);

      if Active then Close;
      Open;
      try
        First;
        I := 0;
        while not Eof do
        begin
          aTable.TableFieldNameArray[I] := FieldByName('Name').AsString;
          aTable.TableFieldCaptionArray[I] := FieldByName('Caption').AsString;
          aTable.TableFieldSizeArray[I] :=  FieldByName('Size').AsInteger;
          Next;
        end;
      finally
        Close;
      end;
    end;  
  finally
    FSystemConfig.Free;
  end;
  Result := True;
end;


procedure TDatWay.LoadMenu;
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
      DatabaseName:= FMenuName;
      TableName:= FMenuFilePath;
      DBSession.AddPassword(SELF_CONFIG_PASSWORD);

      if Active then Close;
      Open;

      SetLength(Config.FMenuList,FMenu.RecordCount);

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
        aMenu.MenuClassType := FieldByName('ClassType').AsString;
        aMenu.MenuClassName := FieldByName('ClassName').AsString;
        aMenu.NotShowFormHint := FieldByName('NotShowFormHint').AsString;
        aMenu.ParentName := FieldByName('ParentName').AsString;
        Config.FMenuList[N] := (aMenu);
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


procedure TDatWay.SaveMenu;
var
  aMenu : TMenu;
  I : Integer;
begin
    with FMenu do
    begin
      DatabaseName:= FMenuName;
      TableName:= FMenuFilePath;
      DBSession.AddPassword(SELF_CONFIG_PASSWORD);

      if Active then Close;
      Open;

      for I := 0 to High(Config.FMenuList) - Low(Config.FMenuList) -1 do
      begin
        aMenu := Config.FMenuList[I];
        if FMenu.Locate('Name',aMenu.Name,[]) then
          Edit
        else Append;
        FieldByName('Name').AsString := aMenu.Name;
        FieldByName('Caption').AsString := aMenu.Caption;
        FieldByName('OrderID').AsInteger := aMenu.OrderID;
        FieldByName('Visible').AsBoolean := aMenu.Visible ;
        FieldByName('ClassType').AsString := aMenu.MenuClassType ;
        FieldByName('ClassName').AsString := aMenu.MenuClassName ;
        FieldByName('NotShowFormHint').AsString := aMenu.NotShowFormHint;
        FieldByName('ParentName').AsString := aMenu.ParentName;
        Post;
      end;
      Close;
    end;
end;




end.
