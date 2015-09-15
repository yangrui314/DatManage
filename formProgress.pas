unit formProgress;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls,frameProgressBar,formParent;

type
  TfmProgress = class(TParentForm)
    pnlProgress: TPanel;
    procedure FormCreate(Sender: TObject);
  private
  public
    FProgressBar: TfrmProgressBar;
  end;

var
  fmProgress: TfmProgress;

implementation

{$R *.dfm}

procedure TfmProgress.FormCreate(Sender: TObject);
begin
  inherited;
  FProgressBar := TfrmProgressBar.Create(pnlProgress,True,True);
  pnlProgress.Height := FProgressBar.Height;
  FProgressBar.Parent := pnlProgress;
  FProgressBar.Align := alClient;
end;

end.
