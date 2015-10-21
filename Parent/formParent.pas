unit formParent;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,dxSkinsForm;

type
  TParentForm = class(TForm)
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    dxSkinController1: TdxSkinController;
  end;

var
  ParentForm: TParentForm;

implementation

{$R *.dfm}

procedure TParentForm.FormShow(Sender: TObject);
begin
  inherited;
  dxSkinController1.UseSkins := False;
  dxSkinController1.SkinName := 'Office2007Blue';
  dxSkinController1.NativeStyle := false;
  dxSkinController1.UseSkins := True;
end;

procedure TParentForm.FormCreate(Sender: TObject);
begin
  inherited;
  dxSkinController1 := TdxSkinController.Create(Self);  
end;

end.
