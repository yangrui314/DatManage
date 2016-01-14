unit formMenuTurn;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, formParentMenu, cxLookAndFeels, Menus, cxLookAndFeelPainters,
  dxLayoutControl, StdCtrls, cxButtons, cxControls, ExtCtrls, cxContainer,
  cxEdit, cxTextEdit, cxMemo;

type
  TfmMenuTurn = class(TfmParentMenu)
    pnlMain: TPanel;
    lcMain: TdxLayoutControl;
    btnOK: TcxButton;
    dxLayoutGroup1: TdxLayoutGroup;
    lcMainItem3: TdxLayoutItem;
    MSrc: TcxMemo;
    lcMainItem1: TdxLayoutItem;
    lcMainItem2: TdxLayoutItem;
    MText: TcxMemo;
    procedure btnOKClick(Sender: TObject);
  private
    function TurnText(const Str : String; const MidStr : String ;const EndStr : String) : String;
    function TurnOneStr(const Str : String; const MidStr : String ;const EndStr : String) : String;

    function GetHeadStr(const Str : String; const PartStr : String ) : String;
    function GetFootStr(const Str : String; const PartStr : String ) : String;

    function GetHeadStrAll(const Str : String; const PartStr : String ) : String;
    function GetFootStrAll(const Str : String; const PartStr : String ) : String;
  public
    { Public declarations }
  end;

var
  fmMenuTurn: TfmMenuTurn;

implementation

{$R *.dfm}

function  TfmMenuTurn.TurnText(const Str : String; const MidStr : String ;const EndStr : String):String;
var
  TempStr : String;
begin
 {将字符串以：=为中间点，；为终点。将其翻转过来。}
 TempStr := Str;
 while Pos(EndStr,TempStr) <> 0 do
 begin
   Result := Result +  TurnOneStr(GetHeadStrAll(TempStr,EndStr),MidStr,EndStr);
   TempStr := GetFootStr(TempStr,EndStr);
 end;

end;



 function  TfmMenuTurn.TurnOneStr(const Str : String; const MidStr : String ;const EndStr : String):String;
 begin
    {单列转换}
    if Pos(MidStr,Str) = 0
    then  Result := Str
    else  Result := GetFootStr(GetHeadStr(Str,EndStr),MidStr) + MidStr + GetHeadStr(GetHeadStr(Str,EndStr),MidStr) + EndStr ;

 end;


 function  TfmMenuTurn.GetHeadStr(const Str : String; const PartStr : String):String;
 begin
    {获取前端字符串，不含分割的字符串}
    Result := Copy(Str,1,Pos(PartStr,Str)-1);
 end;



 function  TfmMenuTurn.GetFootStr(const Str : String; const PartStr : String ):String;
 begin
    {获取后端字符串，不含分割的字符串}
   Result :=  Copy(Str,Pos(PartStr,Str) +Length(PartStr) ,Length(Str));
 end;


 function  TfmMenuTurn.GetHeadStrAll(const Str : String; const PartStr : String):String;
 begin
    {获取前端字符串，含分割的字符串}
    Result := GetHeadStr(Str,PartStr) +PartStr;
 end;

 function  TfmMenuTurn.GetFootStrAll(const Str : String; const PartStr : String ):String;
 begin
    {获取后端字符串，含分割的字符串}
    Result := PartStr + GetFootStr(Str,PartStr);
 end;


procedure TfmMenuTurn.btnOKClick(Sender: TObject);
var
  Scr : String;
  Res : String;
begin
  Scr := MSrc.Text;
  Res := TurnText(Scr,':=',';');
  MText.Text := Res;
end;

initialization
  RegisterClass(TfmMenuTurn);

finalization
  UnregisterClass(TfmMenuTurn);


end.
