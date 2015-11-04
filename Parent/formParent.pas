unit formParent;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxLookAndFeels;

type
  TParentForm = class(TForm)
    lafMain: TcxLookAndFeelController;
  private
    { Private declarations }
  public

  end;

var
  ParentForm: TParentForm;

implementation

{$R *.dfm}

end.
