unit unitXmlHandle;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs,StdCtrls,unitFileHandle,unitTable, xmldom, XMLIntf, msxmldom, XMLDoc;

type
  TXmlHandle = class(TFileHandle)
  private
    FTable : TTable;
    XMLFile: TXMLDocument;
    XMLRead : TXMLDocument;
    FAppPath : String;
    FSavePath : String;
    FConfigFile : String;
    procedure SetPath;
  protected
    procedure LoadFile; override;
  public
    destructor Destroy; override;
    constructor Create(aTable : TTable);
    procedure SaveFile;
    procedure ReadFile;
  end;


implementation


constructor TXmlHandle.Create(aTable : TTable);
begin
  FTable := aTable;
  XMLFile := TXMLDocument.Create(nil);
  SetPath;
  LoadFile;
end;

procedure TXmlHandle.SetPath;
begin
  FAppPath := ExtractFileDir(ParamStr(0));
  FSavePath := FAppPath + '\Template';
  FConfigFile := FSavePath + '\'+ FTable.TableName + '.xml';
end;


procedure TXmlHandle.LoadFile;
begin
  inherited;
end;

procedure TXmlHandle.ReadFile;
var
  nodeList: IXMLNodeList;
  node: IXMLNode;
  num,i: Integer;
  comp : TComponent;
begin
  if not FileExists(FConfigFile) then
  begin
    Exit;
  end;
  comp :=TComponent.create(nil);
  XMLRead := TXMLDocument.Create(comp);
  XMLRead.LoadFromFile(FConfigFile);
  
  for I:=0 to FTable.TableFieldCount - 1 do
  begin
     FTable.TableFieldCaptionArray[I] :=  XMLRead.DocumentElement.ChildNodes[I].ChildNodes['Caption'].Text;
     FTable.TableFieldSizeArray[I] :=  StrToInt(XMLRead.DocumentElement.ChildNodes[I].ChildNodes['Size'].Text);
  end;
end;


procedure TXmlHandle.SaveFile;
var
  pNode,tNode,cNode: IXMLNode; {定义两个节点: 父节点、子节点}
  I : Integer;
begin
  XMLFile.XML.Clear;
  XMLFile.Active := True;                {必须先激活}
  XMLFile.Version := '1.0';              {设置版本}
  XMLFile.Encoding := 'GB2312';          {设置语言}

  pNode := XMLFile.AddChild('TableConfig'); {添加的第一个节点是根节点, 现在的 pNode 是根节点}
  pNode.SetAttribute('TableName',FTable.TableName);         {为根节点设置属性}
  pNode.SetAttribute('TableFieldCount',FTable.TableFieldCount);         {为根节点设置属性}



  for I:=0 to FTable.TableFieldCount - 1 do
  begin
    tNode := pNode.AddChild(FTable.TableFieldNameArray[I]);            {为根节点添加子节点, 现在的 pNode 是 "人员" 节点}
//    tNode.SetAttribute('职务', '科长');         {设置属性}

    cNode := tNode.AddChild('Caption');  {为 pNode 添加子节点, 返回值 cNode 指向了新添加的节点}
    cNode.Text := FTable.TableFieldCaptionArray[I];

    cNode := tNode.AddChild('Size');  {为 pNode 添加子节点, 返回值 cNode 指向了新添加的节点}
    cNode.Text := IntToStr(FTable.TableFieldSizeArray[I]);
  end;


//
//  cNode := pNode.AddChild('性别');
//  cNode.Text := '男';
//
//  cNode := pNode.AddChild('年龄');
//  cNode.Text := '34';

//  {查看}
//  ShowMessage(XMLFile.XML.Text);

  if not DirectoryExists(FSavePath) then
  try
    begin
      CreateDir(FSavePath);
//      ForceDirectories(Edit1.Text);
    end;
  finally
    raise Exception.Create('Cannot Create '+FSavePath);
  end;


  {保存}
  XMLFile.SaveToFile(FConfigFile);
  ShowMessage('生成'+FConfigFile+ '成功');
end;


destructor TXmlHandle.Destroy;
begin
  inherited;
end;

end.
