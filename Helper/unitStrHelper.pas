unit unitStrHelper;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs,StdCtrls,unitParentHelper,StrUtils;

type
  TStrHelper = class(TParentHelper)
  private
  protected
  public
    constructor Create;
    function GetMidStr(aStr : String;aBeginStr : String; aEndStr : String = '') : String;
    function StringListToString(const aInput : TStringList) : String;    
  end;

var
  StrHelper: TStrHelper;

implementation


constructor TStrHelper.Create;
begin

end;

function TStrHelper.GetMidStr(aStr : String;aBeginStr : String; aEndStr : String) : String;
var
  aBeginNum,aEndStrNum: Integer;
  aNotLeft  : String;
begin
  Result := '';
  aBeginNum := Pos(aBeginStr,aStr);
  aNotLeft :=  Copy(aStr,aBeginNum + Length(aBeginStr) ,Length(aStr)-aBeginNum+1);

  if aEndStr = '' then
  begin
    Result := aNotLeft;
  end
  else
  begin
    aEndStrNum :=  Pos(aEndStr,WideString(aNotLeft));
    Result := LeftStr(aNotLeft,aEndStrNum-1);  
  end;

end;

function TStrHelper.StringListToString(const aInput : TStringList) : String;
var
  I : Integer;
  aStr : String;
begin
   for I:=0 to  aInput.Count - 1 do
  begin
    aStr := aInput[I];
    if Result = '' then
    begin
      Result := aStr ;      
    end
    else
    begin
      Result := Result +  #13#10 + aStr ;
    end;
  end;
end;



end.
