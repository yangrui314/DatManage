unit formParentMenu;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, formParent, cxLookAndFeels;

type
  TfmParentMenu = class(TParentForm)
  private
  protected
    FParameter : String;
    FActivePageIndex : Integer;
    FTableName :String;
    function GetParameter : String;
    function GetActivePageIndex : Integer;
    function GetTableName : String;    
  public
    procedure MenuHandle ;virtual;
    function CheckIsShow : Boolean; virtual;
  end;

var
  fmParentMenu: TfmParentMenu;

implementation

uses
    unitConfig;

{$R *.dfm}

function TfmParentMenu.CheckIsShow : Boolean; 
begin
  Result := True;
end;

procedure TfmParentMenu.MenuHandle;
begin
  FParameter := GetParameter;
  FActivePageIndex := GetActivePageIndex;
  FTableName := GetTableName;
end;

function TfmParentMenu.GetParameter : String;
begin
  Result := Config.SystemParameter;
end;

function TfmParentMenu.GetActivePageIndex : Integer;
begin
  Result := Config.SystemActivePageIndex;
end;

function TfmParentMenu.GetTableName : String;
begin
  Result := Config.SystemTableName;    
end;


initialization
  RegisterClass(TfmParentMenu);

finalization
  UnregisterClass(TfmParentMenu);


end.
