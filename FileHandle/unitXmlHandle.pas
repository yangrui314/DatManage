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
  pNode,tNode,cNode: IXMLNode; {���������ڵ�: ���ڵ㡢�ӽڵ�}
  I : Integer;
begin
  XMLFile.XML.Clear;
  XMLFile.Active := True;                {�����ȼ���}
  XMLFile.Version := '1.0';              {���ð汾}
  XMLFile.Encoding := 'GB2312';          {��������}

  pNode := XMLFile.AddChild('TableConfig'); {��ӵĵ�һ���ڵ��Ǹ��ڵ�, ���ڵ� pNode �Ǹ��ڵ�}
  pNode.SetAttribute('TableName',FTable.TableName);         {Ϊ���ڵ���������}
  pNode.SetAttribute('TableFieldCount',FTable.TableFieldCount);         {Ϊ���ڵ���������}



  for I:=0 to FTable.TableFieldCount - 1 do
  begin
    tNode := pNode.AddChild(FTable.TableFieldNameArray[I]);            {Ϊ���ڵ�����ӽڵ�, ���ڵ� pNode �� "��Ա" �ڵ�}
//    tNode.SetAttribute('ְ��', '�Ƴ�');         {��������}

    cNode := tNode.AddChild('Caption');  {Ϊ pNode ����ӽڵ�, ����ֵ cNode ָ��������ӵĽڵ�}
    cNode.Text := FTable.TableFieldCaptionArray[I];

    cNode := tNode.AddChild('Size');  {Ϊ pNode ����ӽڵ�, ����ֵ cNode ָ��������ӵĽڵ�}
    cNode.Text := IntToStr(FTable.TableFieldSizeArray[I]);
  end;


//
//  cNode := pNode.AddChild('�Ա�');
//  cNode.Text := '��';
//
//  cNode := pNode.AddChild('����');
//  cNode.Text := '34';

//  {�鿴}
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


  {����}
  XMLFile.SaveToFile(FConfigFile);
  ShowMessage('����'+FConfigFile+ '�ɹ�');
end;


destructor TXmlHandle.Destroy;
begin
  inherited;
end;

end.
