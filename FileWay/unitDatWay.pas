unit unitDatWay;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs,StdCtrls,unitFileWay, DB, dbisamtb,unitHistory,unitTable;


type
  TDatWay = class(TFileWay)
  private
  protected
    FSystemConfig : TDBISAMTable;
    FHistory: TDBISAMTable;
    FMenu : TDBISAMTable;
    procedure CreateSystemConfig;override;
    procedure CreateHistory; override;
    procedure CreateMenu; override;
  public
    constructor Create; override;
    destructor Destroy; override;    
    function GetSystemConfig(aName : String) : String; override;
    procedure SaveSystemConfig(aName : String;aValue : String); override;
    function LoadHistorys : TList; 
    procedure SaveHistory(aConnectWay : string;aName : String;aPath : String);
    function SaveFile(aFilePath : String;var aTable : TTable) : Boolean;
    function ReadFile(aFilePath : String;var aTable : TTable) : Boolean;               
  end;


implementation


constructor TDatWay.Create;
begin
  FSystemConfig := TDBISAMTable.Create(nil);
  FHistory := TDBISAMTable.Create(nil);
  FMenu  := TDBISAMTable.Create(nil);
  inherited;
end;

destructor TDatWay.Destroy;
begin
  inherited;
  FHistory.Free;
  FMenu.Free;
  FSystemConfig.Free;      
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
      CreateTable(0,1,0,True,'YouAreNotPreparedForIT')
  end;
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
//  aHistory := THistory.Create('','');
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
        Result.Add(aHistory);
        Next;
      end;

      Close;
    end;   
  finally
//    aHistory.Free;
    FHistory.Free;
  end;
end;

procedure TDatWay.SaveHistory(aConnectWay : string;aName : String;aPath : String);
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
    
      if Locate('Name',aName,[]) then
      begin
        ShowMessage('��������ʷ��¼�Ѿ����ڣ��޷����档');
        Exit;
      end;

      if Locate('Path',aPath,[]) then
      begin
        ShowMessage('��·����ʷ��¼�Ѿ����ڣ��޷����档');
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
  finally
    FHistory.Free;
  end;

end;

function TDatWay.ReadFile(aFilePath : String;var aTable : TTable) : Boolean;
var
  FSystemConfig : TDBISAMTable;
  I : Integer;
begin
  Result := False;
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

      finally
        Close;
      end;
    end;
  finally
    FSystemConfig.Free;
  end;

end;

end.