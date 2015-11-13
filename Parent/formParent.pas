unit formParent;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,dxSkinsForm, cxLookAndFeels;

type
  TParentForm = class(TForm)
    lafMain: TcxLookAndFeelController;
  private
    { Private declarations }
  public
    function CheckIsShow : Boolean; virtual;
  end;

var
  ParentForm: TParentForm;

implementation

{$R *.dfm}

function TParentForm.CheckIsShow : Boolean; 
begin
  Result := True;    
end;


end.
