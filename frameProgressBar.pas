unit frameProgressBar;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, Menus, cxLookAndFeelPainters, StdCtrls, cxButtons,
  cxProgressBar, dxLayoutControl, cxContainer, cxEdit, cxLabel, cxControls,
  ExtCtrls;

type
  TfrmProgressBar = class(TFrame)
    pnlProgressBar: TPanel;
    lcMainGroup_Root: TdxLayoutGroup;
    lcMain: TdxLayoutControl;
    lblProgressBarMessage: TcxLabel;
    lcMainItem1: TdxLayoutItem;
    PgB: TcxProgressBar;
    lcMainItem2: TdxLayoutItem;
    btnProgressBarCancel: TcxButton;
    lcMainItem3: TdxLayoutItem;
    procedure btnProgressBarCancelClick(Sender: TObject);
  private
    bCancel : Boolean;
  public
    constructor Create(AOwner: TComponent; AShowMessage : Boolean; ACancel : Boolean); reintroduce; virtual;
  public
    procedure SetMax(const Max: Double);
    procedure SetCaption(const Caption: String); overload;
    procedure SetCaption; overload;
    procedure UpdateProcess(const Increment: Integer); overload;
    procedure UpdateProcess; overload;
    procedure SetPosition(const Position: Double);
    function GetMax : Double;
    function GetPosition : Double;
    function GetCancel : Boolean;
    procedure SetCancel(const Cancel : Boolean);
  end;

implementation

{$R *.dfm}

constructor TfrmProgressBar.Create(AOwner: TComponent; AShowMessage : Boolean; ACancel : Boolean);
begin
  inherited Create(AOwner);
  lblProgressBarMessage.Visible := AShowMessage;
  btnProgressBarCancel.Visible  := ACancel;
end; 

procedure TfrmProgressBar.SetMax(const Max: Double);
begin
  Application.ProcessMessages; 
  PgB.Properties.Min:= 0;
  PgB.Properties.Max:= Max;
end;

procedure TfrmProgressBar.SetCaption(const Caption: String);
begin
  lblProgressBarMessage.Caption := Caption;
  Application.ProcessMessages;  
end;


procedure TfrmProgressBar.SetCaption;
begin
  SetCaption('正在导入数据，请稍等......');
end;


procedure TfrmProgressBar.UpdateProcess(const Increment: Integer); 
begin
  PgB.Position:=PgB.Position  + Increment;
  Application.ProcessMessages;    
end;

procedure TfrmProgressBar.UpdateProcess;
begin
  UpdateProcess(1);   
end;

procedure TfrmProgressBar.SetPosition(const Position: Double);
begin
  PgB.Position:=  Position;    
end;

function TfrmProgressBar.GetMax : Double;
begin
  Result := PgB.Properties.Max;
end;

function TfrmProgressBar.GetPosition : Double;
begin
  Result := PgB.Position;
end;


function TfrmProgressBar.GetCancel : Boolean;
begin
  Result := bCancel;
end;

procedure TfrmProgressBar.SetCancel(const Cancel : Boolean);
begin
  bCancel := Cancel;    
end;

procedure TfrmProgressBar.btnProgressBarCancelClick(Sender: TObject);
begin
  bCancel := True;
end;

end.
