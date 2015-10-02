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
    procedure InitTable;
    procedure InitSystemConfig;
    procedure InitHistory;
  protected
    procedure InitData; override;
    function LoadLastFolderPath : String; override;
    procedure SaveLastFolderPath(aPath : String); override;

    function LoadShowName : Boolean; override;
    procedure SaveShowName(aValue : Boolean); override;
    function LoadShowPath : Boolean; override;
    procedure SaveShowPath(aValue : Boolean); override;

    function LoadHistorys : TList; override;
  public
    constructor Create; override;
    procedure SaveHistory(aName : String;aPath : String);override;    
    destructor Destroy; override;
  end;

const
  LAST_FOLDER_PATH_NAME = 'SystemConfig';
  HISTORY_NAME = 'History';

implementation

  uses
    unitHistory;

constructor TConfigDat.Create;
begin
  FSystemConfig := TDBISAMTable.Create(nil);;
  FHistory := TDBISAMTable.Create(nil);
  inherited;
end;

procedure TConfigDat.InitTable;
begin
  InitSystemConfig;
  InitHistory;
end;


procedure TConfigDat.InitSystemConfig;
begin
  with FSystemConfig do
  begin
    DatabaseName:= FConfigPath;
    TableName:= LAST_FOLDER_PATH_NAME;
    with FieldDefs do
    begin
      Clear;
      Add('ID',ftAutoInc,0,False);
      Add('LastFolderPath',ftString,255,False);
      Add('ShowName',ftBoolean,0,False);
      Add('ShowPath',ftBoolean,0,False);
    end;
    with IndexDefs do
    begin
      Clear;
      Add('','ID',[ixPrimary]);
      Add('ByLastFolderPath','LastFolderPath',[ixUnique]);
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

procedure TConfigDat.InitData;
begin
  inherited;
  InitTable;
end;



function TConfigDat.LoadLastFolderPath : String;
begin
  inherited;
  Result := '';
  with FSystemConfig do
  begin
    DatabaseName:= FConfigPath;
    TableName:= LAST_FOLDER_PATH_NAME;
    
    if Active then Close;
    Open;

    First;
    while not Eof do
    begin
      Result :=  FieldByName('LastFolderPath').AsString;
      Next;
    end;

    Close;
  end;    
end;

procedure TConfigDat.SaveLastFolderPath(aPath : String);
begin
  inherited;
  with FSystemConfig do
  begin
    DatabaseName:= FConfigPath;
    TableName:= LAST_FOLDER_PATH_NAME;
    
    if Active then Close;
    Open;

    First;
    Edit;
    FieldByName('LastFolderPath').AsString := aPath;
    Post;

    Close;
  end;  
end;


function TConfigDat.LoadShowName : Boolean;
begin
  inherited;
  Result := True;
  with FSystemConfig do
  begin
    DatabaseName:= FConfigPath;
    TableName:= LAST_FOLDER_PATH_NAME;
    
    if Active then Close;
    Open;

    First;
    while not Eof do
    begin
      Result :=  FieldByName('ShowName').AsBoolean;
      Next;
    end;

    Close;
  end;  
end;

procedure TConfigDat.SaveShowName(aValue : Boolean);
begin
  inherited;
  with FSystemConfig do
  begin
    DatabaseName:= FConfigPath;
    TableName:= LAST_FOLDER_PATH_NAME;
    
    if Active then Close;
    Open;

    First;
    Edit;
    FieldByName('ShowName').AsBoolean := aValue;
    Post;

    Close;
  end;  
end;

function TConfigDat.LoadShowPath : Boolean;
begin
  inherited;
  Result := True;
  with FSystemConfig do
  begin
    DatabaseName:= FConfigPath;
    TableName:= LAST_FOLDER_PATH_NAME;
    
    if Active then Close;
    Open;

    First;
    while not Eof do
    begin
      Result :=  FieldByName('ShowPath').AsBoolean;
      Next;
    end;

    Close;
  end;  
end;

procedure TConfigDat.SaveShowPath(aValue : Boolean);
begin
  inherited;
  with FSystemConfig do
  begin
    DatabaseName:= FConfigPath;
    TableName:= LAST_FOLDER_PATH_NAME;
    
    if Active then Close;
    Open;

    First;
    Edit;
    FieldByName('ShowPath').AsBoolean := aValue;
    Post;

    Close;
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
        aHistory := THistory.Create(FieldByName('Name').AsString,FieldByName('Path').AsString);
        Result.Add(aHistory);
        Next;
      end;

      Close;
    end;   
  finally
//    aHistory.Free;
  end;
end;
    
procedure TConfigDat.SaveHistory(aName : String;aPath : String);
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
  FSystemConfig.Free;      
end;

end.
