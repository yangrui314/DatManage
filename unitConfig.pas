unit unitConfig;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,unitHistory,unitMenu,
  Dialogs,formParentMenu,Forms;

type
  TConfig = class
  private
    FInitFolderPath : String;
    FLastFolderPath : String;
    FHistorys: TList;
    FShowName : Boolean;
    FShowPath : Boolean;
    FSelectShowWay : String;
    FConnectWay : String;
    FFileWay : string;
    FSystemParameterCaption : String;
    FSystemParameter : String;
    FSystemActivePageIndex : Integer;
    FSystemTableName :String;

    constructor Create;
    procedure InitData;
    procedure SetHistorys(aHistorys : TList);
    procedure FreeHistorys;
    procedure FreeMenuList;
    destructor Destroy;
  protected
  public
    FMenuList :  array of TMenu;
    property InitFolderPath: string read FInitFolderPath;
    property LastFolderPath: string read FLastFolderPath write FLastFolderPath;
    property ShowName: Boolean read FShowName write FShowName;
    property ShowPath: Boolean read FShowPath write FShowPath;
    property SelectShowWay: string read FSelectShowWay write FSelectShowWay;
    property ConnectWay : string read  FConnectWay write  FConnectWay;
    property FileWay : string read  FFileWay write  FFileWay;


    //�����ĸ�����
    property SystemParameterCaption : string read  FSystemParameterCaption write  FSystemParameterCaption;
    property SystemParameter : string read  FSystemParameter write  FSystemParameter;
    property SystemActivePageIndex : Integer read  FSystemActivePageIndex write  FSystemActivePageIndex;
    property SystemTableName : string read  FSystemTableName write  FSystemTableName;    



    property Historys : TList read FHistorys write FHistorys;
    function GetHistoryName(aPath : String ; aInclude : Boolean = False) : String;
    function GetHistoryPath(aName : String ; aInclude : Boolean = False ) : String;

    class function CreateInstance(var AForm: TfmParentMenu; AFormClassName: String = ''): TfmParentMenu;overload;
  end;

var
  Config: TConfig;

implementation


constructor TConfig.Create;
begin
  InitData;
end;


class function TConfig.CreateInstance(var AForm: TfmParentMenu; AFormClassName: String = ''): TfmParentMenu;
var
  FormClassName: String;
  FormClass: TPersistentClass;
begin
  FormClass := nil;

  if Trim(AFormClassName) <> '' then
    FormClass := GetClass(AFormClassName);

  if (FormClass = nil) and (FormClassName <> ClassName) then
    FormClass := FindClass(ClassName);

  if FormClass = nil then
    FormClass := TfmParentMenu;

  if FormClass <> nil then begin
    Application.CreateForm(TComponentClass(FormClass), AForm);
    Result := TfmParentMenu(AForm);
  end else
    Result := nil;
end;

procedure TConfig.InitData;
begin
  FHistorys := TList.Create;
  FInitFolderPath :='D:\Project\new_omni\trunk\engineering\deploy\client\'
        +'gd-n-tax(GuiZhou)\deploy(WS)\data\';

  //�����ʼ�������ο���ʵ����û�����á�ʵ���ϻ��ѯ���ݿ⣬����һ�ε�ʱ���������ݣ����صĶ���''���ж�ֵ��
  FShowName := True;
  FShowPath := True;
  //��ѯʱ��1�����ѯ�ֶΣ�2�����ѯ��������Ĭ����ֱ�Ӳ�ѯ�ֶΡ�
  FSelectShowWay := '1';
  //���ӷ�ʽ,1����DBISAM,2����SQL
  FConnectWay := '1';
  //�ļ�����ʽ,Ĭ��dat
  FFileWay := 'dat';
end;

procedure TConfig.FreeHistorys;
var
  I: Integer;
  aHistory: THistory;
begin
  for I := 0 to FHistorys.Count - 1 do
  begin
    aHistory := THistory(FHistorys.Items[I]);
    FreeAndNil(aHistory);
  end;
  FHistorys.Clear;
end;

procedure TConfig.FreeMenuList;
var
  I: Integer;
  aMenu: TMenu;
begin
  for I := 0 to Length(FMenuList) - 1 do
  begin
    aMenu := FMenuList[I];
    FreeAndNil(aMenu);
  end;
end;

procedure TConfig.SetHistorys(aHistorys : TList);
var
  I: Integer;
begin
  FreeHistorys;
  for I := 0 to aHistorys.Count - 1 do
  begin
    FHistorys.Add(THistory(aHistorys.Items[I]));
  end;
end;


function TConfig.GetHistoryName(aPath : String; aInclude : Boolean = False) : String;
var
  I: Integer;
begin
  Result := '';
//  if aPath = FLastFolderPath then
//  begin
//    Result := '���һ����¼';
//    Exit;
//  end;
  for I := 0 to FHistorys.Count - 1 do
  begin
    if aInclude then
    begin
      if Pos(aPath,THistory(FHistorys.Items[I]).Path) <> 0 then
      begin
        Result :=  THistory(FHistorys.Items[I]).Name;
        Exit;
      end    
    end
    else
    begin
      if THistory(FHistorys.Items[I]).Path = aPath then
      begin
        Result :=  THistory(FHistorys.Items[I]).Name;
        Exit;
      end    
    end;
  end;
end;

function TConfig.GetHistoryPath(aName : String; aInclude : Boolean = False) : String;
var
  I: Integer;
begin
  Result := '';
//  if aName = '���һ����¼' then
//  begin
//    Result := FLastFolderPath;
//    Exit;
//  end;
  for I := 0 to FHistorys.Count - 1 do
  begin
    if aInclude then
    begin
      if Pos(aName,THistory(FHistorys.Items[I]).Name) <> 0  then
      begin
        Result :=  THistory(FHistorys.Items[I]).Path;
        Exit;
      end    
    end
    else
    begin
      if THistory(FHistorys.Items[I]).Name = aName then
      begin
        Result :=  THistory(FHistorys.Items[I]).Path;
        Exit;
      end    
    end;

  end;
end;




destructor TConfig.Destroy;
begin
  FreeHistorys;
  FreeAndNil(FHistorys);
  FreeMenuList;
  SetLength(FMenuList,0);  
end;


initialization
  Config := TConfig.Create;

finalization
  Config.Destroy;

end.
