unit unitXmlWay;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs,StdCtrls,unitFileWay, xmldom, XMLIntf, msxmldom, XMLDoc,unitHistory,unitTable;


type
  TXmlWay = class(TFileWay)
  private
  protected
    FComp : TComponent;
    FSystemConfigXML : TXMLDocument;
    FHistoryXML : TXMLDocument;
    FMenuXML : TXMLDocument;    
    procedure CreateSystemConfig;override;
    procedure CreateHistory; override;
    procedure CreateMenu; override;
    procedure InitData; override;
    procedure CreateXMLFile(aFileName : string; aFilePath : string; aFieldCount : String);
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


constructor TXmlWay.Create;
begin
  FComp :=TComponent.create(nil);
  FSystemConfigXML := TXMLDocument.Create(FComp);
  FHistoryXML := TXMLDocument.Create(FComp);
  FMenuXML := TXMLDocument.Create(FComp);
  inherited;
end;


destructor TXmlWay.Destroy;
begin
  inherited;
  FSystemConfigXML.Free;
  FHistoryXML.Free;
  FMenuXML.Free;
  FComp.Free;
end;

procedure TXmlWay.InitData;
begin
  FExt := '.xml';
  inherited;
  FSystemConfigXML.LoadFromFile(FSystemConfigFilePath);
  FHistoryXML.LoadFromFile(FHistoryFilePath);
  FMenuXML.LoadFromFile(FMenuFilePath);  
end;


procedure TXmlWay.CreateSystemConfig;
begin
  CreateXMLFile(FSystemConfigName,FSystemConfigFilePath,'3')
end;

procedure TXmlWay.CreateHistory;
begin
  CreateXMLFile(FHistoryName,FHistoryFilePath,'4')
end;

procedure TXmlWay.CreateMenu;
begin
  CreateXMLFile(FMenuName,FMenuFilePath,'9')
end;


procedure TXmlWay.CreateXMLFile(aFileName : string; aFilePath : string; aFieldCount : String);
var
  XMLFile: TXMLDocument;
  pNode: IXMLNode;
  I : Integer;
begin
  XMLFile := TXMLDocument.Create(FComp);
  try
  XMLFile.XML.Clear;
  XMLFile.Active := True;                {必须先激活}
  XMLFile.Version := '1.0';              {设置版本}
  XMLFile.Encoding := 'GB2312';          {设置语言}
  pNode := XMLFile.AddChild('Config');  {添加的第一个节点是根节点, 现在的 pNode 是根节点}
  pNode.SetAttribute('ConfigName',aFileName);         {为根节点设置属性}
  pNode.SetAttribute('ConfigFieldCount',aFieldCount);         {为根节点设置属性}
  XMLFile.SaveToFile(aFilePath);
  finally
    XMLFile.Free;
  end;
end;

function TXmlWay.GetSystemConfig(aName : String) : String;
var
  I : Integer;
begin
  Result := '';
  FSystemConfigXML.Active := True;
  for I:=0 to FSystemConfigXML.DocumentElement.ChildNodes.Count- 1 do
  begin
    if aName = FSystemConfigXML.DocumentElement.ChildNodes[I].ChildNodes['Name'].Text then
    begin
      Result :=  FSystemConfigXML.DocumentElement.ChildNodes[I].ChildNodes['Value'].Text;
      Exit;
    end;
  end;
end;

procedure TXmlWay.SaveSystemConfig(aName : String;aValue : String);
var
  XMLFile: TXMLDocument;
  Comp : TComponent;
  pNode,tNode,cNode: IXMLNode;
  I : Integer;
  aNum : Integer;
begin
  try
    FSystemConfigXML.Active := True;
    for I:=0 to FSystemConfigXML.DocumentElement.ChildNodes.Count- 1 do
    begin
      if aName = FSystemConfigXML.DocumentElement.ChildNodes[I].ChildNodes['Name'].Text then
      begin
        FSystemConfigXML.DocumentElement.ChildNodes[I].ChildNodes['Value'].Text := aValue;
        Exit;
      end;
    end;
    aNum := FSystemConfigXML.DocumentElement.ChildNodes.Count;
    pNode := FSystemConfigXML.ChildNodes.FindNode('Config');


    tNode := pNode.AddChild('Message');

    if tNode = nil then
    begin
      ShowMessage('未找到');
    end;

    cNode := tNode.AddChild('ID');
    cNode.Text := IntToStr(aNum  + 1);

    cNode := tNode.AddChild('Name');
    cNode.Text := aName;

    cNode := tNode.AddChild('Value');
    cNode.Text := aValue;
  finally
    FSystemConfigXML.SaveToFile(FSystemConfigFilePath);
  end;
end;

function TXmlWay.LoadHistorys : TList;
var
  aHistory : THistory;
  I : Integer;  
begin
  inherited;
  Result := TList.Create;
  FHistoryXML.Active := True;
  for I:=0 to FHistoryXML.DocumentElement.ChildNodes.Count- 1 do
  begin
    aHistory := THistory.Create(FHistoryXML.DocumentElement.ChildNodes[I].ChildNodes['ConnectWay'].Text,
    FHistoryXML.DocumentElement.ChildNodes[I].ChildNodes['Name'].Text,FHistoryXML.DocumentElement.ChildNodes[I].ChildNodes['Path'].Text);
    Result.Add(aHistory);
  end;
end;

procedure TXmlWay.SaveHistory(aConnectWay : string;aName : String;aPath : String);
var
  XMLFile: TXMLDocument;
  Comp : TComponent;
  pNode,tNode,cNode: IXMLNode;
  I : Integer;
  aNum : Integer;  
begin
  inherited;
  try
    FHistoryXML.Active := True;
    for I:=0 to FHistoryXML.DocumentElement.ChildNodes.Count- 1 do
    begin
      if aName = FHistoryXML.DocumentElement.ChildNodes[I].ChildNodes['Name'].Text then
      begin
        ShowMessage('该名称历史记录已经存在，无法保存。');
        Exit;
      end;

      if aPath = FHistoryXML.DocumentElement.ChildNodes[I].ChildNodes['Path'].Text then
      begin
        ShowMessage('该路径历史记录已经存在，无法保存。');
        Exit;
      end;
    end;
    aNum := FHistoryXML.DocumentElement.ChildNodes.Count;
    pNode := FHistoryXML.ChildNodes.FindNode('Config');


    tNode := pNode.AddChild('Message');

    cNode := tNode.AddChild('ID');
    cNode.Text := IntToStr(aNum  + 1);

    cNode := tNode.AddChild('ConnectWay');
    cNode.Text := aConnectWay;

    cNode := tNode.AddChild('Name');
    cNode.Text := aName;

    cNode := tNode.AddChild('Path');
    cNode.Text := aPath;
  finally
    FHistoryXML.SaveToFile(FHistoryFilePath);
  end;
end;

function TXmlWay.ReadFile(aFilePath : String;var aTable : TTable) : Boolean;
var
  nodeList: IXMLNodeList;
  node: IXMLNode;
  num,i: Integer;
  comp : TComponent;
  XMLRead : TXMLDocument;  
begin
  Result := False;
  if not FileExists(aFilePath) then
  begin
    Exit;
  end;
  comp :=TComponent.create(nil);
  XMLRead := TXMLDocument.Create(comp);
  XMLRead.LoadFromFile(aFilePath);
  
  for I:=0 to aTable.TableFieldCount - 1 do
  begin
     aTable.TableFieldCaptionArray[I] :=  XMLRead.DocumentElement.ChildNodes[I].ChildNodes['Caption'].Text;
     aTable.TableFieldSizeArray[I] :=  StrToInt(XMLRead.DocumentElement.ChildNodes[I].ChildNodes['Size'].Text);
  end;
  Result := True;
end;


function TXmlWay.SaveFile(aFilePath : String;var aTable : TTable) : Boolean;
var
  pNode,tNode,cNode: IXMLNode; {定义两个节点: 父节点、子节点}
  I : Integer;
  aSavePath : String;
  XMLFile: TXMLDocument;  
begin
  XMLFile := TXMLDocument.Create(nil);
  try
    XMLFile.XML.Clear;
    XMLFile.Active := True;                {必须先激活}
    XMLFile.Version := '1.0';              {设置版本}
    XMLFile.Encoding := 'GB2312';          {设置语言}

    pNode := XMLFile.AddChild('TableConfig'); {添加的第一个节点是根节点, 现在的 pNode 是根节点}
    pNode.SetAttribute('TableName',aTable.TableName);         {为根节点设置属性}
    pNode.SetAttribute('TableFieldCount',aTable.TableFieldCount);         {为根节点设置属性}



    for I:=0 to aTable.TableFieldCount - 1 do
    begin
      tNode := pNode.AddChild(aTable.TableFieldNameArray[I]);            {为根节点添加子节点, 现在的 pNode 是 "人员" 节点}
  //    tNode.SetAttribute('职务', '科长');         {设置属性}

      cNode := tNode.AddChild('Caption');  {为 pNode 添加子节点, 返回值 cNode 指向了新添加的节点}
      cNode.Text := aTable.TableFieldCaptionArray[I];

      cNode := tNode.AddChild('Size');  {为 pNode 添加子节点, 返回值 cNode 指向了新添加的节点}
      cNode.Text := IntToStr(aTable.TableFieldSizeArray[I]);
    end;

    aSavePath := ExtractFilePath(aFilePath);

    if not DirectoryExists(aSavePath) then
    try
      begin
        CreateDir(aSavePath);
  //      ForceDirectories(Edit1.Text);
      end;
    finally
      raise Exception.Create('Cannot Create '+aSavePath);
    end;


    {保存}
    XMLFile.SaveToFile(aFilePath);
  //  ShowMessage('生成'+aFilePath+ '成功');
  finally
    XMLFile.Free;
  end;
end;


end.
