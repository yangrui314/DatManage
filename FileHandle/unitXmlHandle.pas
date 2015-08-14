unit unitXmlHandle;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs,StdCtrls,unitFileHandle,unitTable, xmldom, XMLIntf, msxmldom, XMLDoc;

type
  TXmlHandle = class(TFileHandle)
  private
    FTable : TTable;
    XMLDocument1: TXMLDocument;    
  protected
    procedure LoadFile; override;
  public
    destructor Destroy; override;
    constructor Create(aTable : TTable);
    procedure SaveFile;
  end;


implementation


constructor TXmlHandle.Create(aTable : TTable);
begin
  FTable := aTable;
  XMLDocument1 := TXMLDocument.Create(nil);   
  LoadFile;
end;



procedure TXmlHandle.LoadFile;
begin
  inherited;
end;


procedure TXmlHandle.SaveFile;
var
  pNode,cNode: IXMLNode; {���������ڵ�: ���ڵ㡢�ӽڵ�}
begin
  XMLDocument1.XML.Clear;
  XMLDocument1.Active := True;                {�����ȼ���}
  XMLDocument1.Version := '1.0';              {���ð汾}
  XMLDocument1.Encoding := 'GB2312';          {��������}

  pNode := XMLDocument1.AddChild('��������'); {��ӵĵ�һ���ڵ��Ǹ��ڵ�, ���ڵ� pNode �Ǹ��ڵ�}
  pNode.SetAttribute('��ע', '����');         {Ϊ���ڵ���������}

  pNode := pNode.AddChild('��Ա');            {Ϊ���ڵ�����ӽڵ�, ���ڵ� pNode �� "��Ա" �ڵ�}
  pNode.SetAttribute('ְ��', '�Ƴ�');         {��������}
  pNode.SetAttribute('��ע', '���ּ�');

//  cNode := pNode.AddChild('����');  {Ϊ pNode ����ӽڵ�, ����ֵ cNode ָ��������ӵĽڵ�}
//  cNode.Text := '����';
//
//  cNode := pNode.AddChild('�Ա�');
//  cNode.Text := '��';
//
//  cNode := pNode.AddChild('����');
//  cNode.Text := '34';

  {�鿴}
//  ShowMessage(XMLDocument1.XML.Text);

  {����}
  XMLDocument1.SaveToFile('E:\��ʱʹ��\2.xml');
end;


destructor TXmlHandle.Destroy;
begin
  inherited;
end;

end.
