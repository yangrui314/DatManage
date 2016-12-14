{***************************************************
功能模块:数据存储类,不进行数据的操作.
开发人员：yr
开发日期：2016-12-12 星期一
修改日期：2016-12-12 星期一
***************************************************}
unit unitConfig;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, unitHistory, unitMenu,
  Dialogs, unitEnvironment, unitTable;

type
  TConfig = class(TObject)
  private
    FInitFolderPath: string;
    FLastFolderPath: string;
    FHistorys: TList;
    FShowName: Boolean;
    FShowPath: Boolean;
    FSelectShowWay: string;
    FInitConnectWay : String;
    FConnectWay: string;
    FFileWay: string;
    FSystemParameterCaption: string;
    FSystemParameter: string;
    FSystemActivePageIndex: Integer;
    FSystemTableName: string;
    FPassword: TStringList;

    //Main
    FGetTable: Boolean;
    //FConfigFile: TConfigFile;
    //frameShowResult当前定位的行数 默认为0 yr 2016-12-11
    FNowRow: Integer;

    procedure InitData;
    procedure FreeHistorys;
    procedure FreeMenuList;
  protected
  public
    FMenuList: array of TMenu;
    //Main
    SystemEnvironment: TEnvironment;
    SystemTable: TTable;

    property InitFolderPath: string read FInitFolderPath;
    property LastFolderPath: string read FLastFolderPath write FLastFolderPath;
    property ShowName: Boolean read FShowName write FShowName;
    property ShowPath: Boolean read FShowPath write FShowPath;
    property SelectShowWay: string read FSelectShowWay write FSelectShowWay;
    property InitConnectWay: string read FInitConnectWay write FInitConnectWay;
    property ConnectWay: string read FConnectWay write FConnectWay;
    property FileWay: string read FFileWay write FFileWay;
    property Password: TStringList read FPassword write FPassword;

    //主表四个参数
    property SystemParameterCaption: string read FSystemParameterCaption write FSystemParameterCaption;
    property SystemParameter: string read FSystemParameter write FSystemParameter;
    property SystemActivePageIndex: Integer read FSystemActivePageIndex write FSystemActivePageIndex;
    property SystemTableName: string read FSystemTableName write FSystemTableName;
    property NowRow: Integer read FNowRow write FNowRow;
    property GetTable: Boolean read FGetTable write FGetTable;
    property Historys: TList read FHistorys write FHistorys;

    constructor Create;
    destructor Destroy;override;    
  end;

var
  Config: TConfig;

implementation

constructor TConfig.Create;
begin
  inherited;
  InitData;
end;


procedure TConfig.InitData;
begin
  FHistorys := TList.Create;
  FInitFolderPath := 'D:\Project\new_omni\trunk\engineering\deploy\client\' + 'gd-n-tax(GuiZhou)\deploy(WS)\data\';

  //这里初始化仅供参考。实际上没起作用。实际上会查询数据库，即第一次的时由于无数据，返回的都是''来判断值。
  FShowName := True;
  FShowPath := True;
  //查询时，1代表查询字段，2代表查询中文名。默认是直接查询字段。
  FSelectShowWay := '1';
  //连接方式,1代表DBISAM,2代表SQL
  FConnectWay := '1';
  //文件处理方式,默认dat
  FFileWay := 'dat';
  //frameShowResult当前定位的行数 默认为0 yr 2016-12-11
  FNowRow := 0;
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



destructor TConfig.Destroy;
begin
  FreeHistorys;
  FreeAndNil(FHistorys);
  FreeMenuList;
  SetLength(FMenuList, 0);
  inherited;  
end;


end.


