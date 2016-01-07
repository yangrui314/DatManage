unit unitWorkLog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs,StdCtrls;

type
  TWorkLog = class
  private
    FVaild : Boolean;
    FEnvironmentName : String;
    FBeginDate : TDateTime;
    FEndDate : TDateTime;
    FWorkDay : Integer;
    FWorkLog : String;
  protected
  public
    constructor Create;
    property Vaild : Boolean read  FVaild write FVaild;
    property EnvironmentName : String read  FEnvironmentName write FEnvironmentName;
    property BeginDate : TDateTime read  FBeginDate write FBeginDate;
    property EndDate : TDateTime read  FEndDate write FEndDate;
    property WorkDay : Integer read  FWorkDay write FWorkDay;
    property WorkLog : String read  FWorkLog write FWorkLog;
  end;


implementation


constructor TWorkLog.Create;
begin
  FVaild := True;
end;


end.

