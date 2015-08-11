unit formExport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxPC, cxControls, cxGraphics, dxLayoutControl, cxContainer,
  cxEdit, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxImageComboBox;

type
  TfmExport = class(TForm)
    PageExport: TcxPageControl;
    SheetWay: TcxTabSheet;
    SheetField: TcxTabSheet;
    lcMainGroup_Root: TdxLayoutGroup;
    lcMain: TdxLayoutControl;
    cmbExportType: TcxImageComboBox;
    lcMainItem2: TdxLayoutItem;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmExport: TfmExport;

implementation

{$R *.dfm}

end.
