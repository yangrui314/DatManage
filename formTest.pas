unit formTest;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, cxGridCustomTableView, cxGridTableView,
  cxControls, cxGridCustomView, cxClasses, cxGridLevel, cxGrid, cxTextEdit;

type
  TForm1 = class(TForm)
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    dg: TcxGridTableView;
    dgColumn1: TcxGridColumn;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormShow(Sender: TObject);
var
  ANewRecId : Integer;
  aTest : String;  
begin
  aTest := '≤‚ ‘ «∑Ò¬“¬Î';
  ANewRecId := dg.DataController.AppendRecord;
  dg.DataController.Values[0,0] := '≤‚ ‘ «∑Ò¬“¬Î';
  dg.DataController.Post();
  ANewRecId := dg.DataController.AppendRecord;
  dg.DataController.Values[1,0] := '≤‚ ‘ «∑Ò¬“¬Î';
  dg.DataController.Post();
//  dg.DataController.Edit;
//  dg.DataController.Values[0,0] := '≤‚ ‘';
//  dg.DataController.Post();
//
//  dg.DataController.AppendRecord;
//  dg.DataController.Values[2,0] := '≤‚ ‘';
//  dg.DataController.Post();
end;

end.
