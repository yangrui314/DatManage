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
  pNode,cNode: IXMLNode; {定义两个节点: 父节点、子节点}
begin
  XMLDocument1.XML.Clear;
  XMLDocument1.Active := True;                {必须先激活}
  XMLDocument1.Version := '1.0';              {设置版本}
  XMLDocument1.Encoding := 'GB2312';          {设置语言}

  pNode := XMLDocument1.AddChild('科室名单'); {添加的第一个节点是根节点, 现在的 pNode 是根节点}
  pNode.SetAttribute('备注', '测试');         {为根节点设置属性}

  pNode := pNode.AddChild('人员');            {为根节点添加子节点, 现在的 pNode 是 "人员" 节点}
  pNode.SetAttribute('职务', '科长');         {设置属性}
  pNode.SetAttribute('备注', '正局级');

//  cNode := pNode.AddChild('姓名');  {为 pNode 添加子节点, 返回值 cNode 指向了新添加的节点}
//  cNode.Text := '张三';
//
//  cNode := pNode.AddChild('性别');
//  cNode.Text := '男';
//
//  cNode := pNode.AddChild('年龄');
//  cNode.Text := '34';

  {查看}
//  ShowMessage(XMLDocument1.XML.Text);

  {保存}
  XMLDocument1.SaveToFile('E:\临时使用\2.xml');
end;


destructor TXmlHandle.Destroy;
begin
  inherited;
end;

end.
