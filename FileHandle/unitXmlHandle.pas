unit unitXmlHandle;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs,StdCtrls,unitTableHandle,unitTable, xmldom, XMLIntf, msxmldom, XMLDoc;

type
  TXmlHandle = class(TTableHandle)
  private
    XMLFile: TXMLDocument;
    XMLRead : TXMLDocument;
  protected
  public
    destructor Destroy; override;
    constructor Create(aTable : TTable);override;
    function SaveFile(aFilePath : String) : Boolean; override;
    function ReadFile(aFilePath : String) : Boolean; override;
  end;


implementation


constructor TXmlHandle.Create(aTable : TTable);
begin
  inherited;
  XMLFile := TXMLDocument.Create(nil);
end;

//procedure TXmlHandle.SetPath;
//begin
//  FAppPath := ExtractFileDir(ParamStr(0));
//  FSavePath := FAppPath + '\Template';
//  FConfigFile := FSavePath + '\'+ FTable.TableName + '.xml';
//end;



function TXmlHandle.ReadFile(aFilePath : String) : Boolean;
var
  nodeList: IXMLNodeList;
  node: IXMLNode;
  num,i: Integer;
  comp : TComponent;
begin
  Result := False;
  if not FileExists(aFilePath) then
  begin
    Exit;
  end;
  comp :=TComponent.create(nil);
  XMLRead := TXMLDocument.Create(comp);
  XMLRead.LoadFromFile(aFilePath);
  
  for I:=0 to FTable.TableFieldCount - 1 do
  begin
     FTable.TableFieldCaptionArray[I] :=  XMLRead.DocumentElement.ChildNodes[I].ChildNodes['Caption'].Text;
     FTable.TableFieldSizeArray[I] :=  StrToInt(XMLRead.DocumentElement.ChildNodes[I].ChildNodes['Size'].Text);
  end;
  Result := True;
end;


function TXmlHandle.SaveFile(aFilePath : String) : Boolean;
var
  pNode,tNode,cNode: IXMLNode; {���������ڵ�: ���ڵ㡢�ӽڵ�}
  I : Integer;
  aSavePath : String;
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


  {����}
  XMLFile.SaveToFile(aFilePath);
//  ShowMessage('����'+aFilePath+ '�ɹ�');
end;


destructor TXmlHandle.Destroy;
begin
  XMLFile.Free;
  inherited;
end;

end.
