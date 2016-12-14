{***************************************************
����ģ��:���ݴ洢��,���������ݵĲ���.
������Ա��yr
�������ڣ�2016-12-12 ����һ
�޸����ڣ�2016-12-12 ����һ
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
    //frameShowResult��ǰ��λ������ Ĭ��Ϊ0 yr 2016-12-11
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

    //�����ĸ�����
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

  //�����ʼ�������ο���ʵ����û�����á�ʵ���ϻ��ѯ���ݿ⣬����һ�ε�ʱ���������ݣ����صĶ���''���ж�ֵ��
  FShowName := True;
  FShowPath := True;
  //��ѯʱ��1�����ѯ�ֶΣ�2�����ѯ��������Ĭ����ֱ�Ӳ�ѯ�ֶΡ�
  FSelectShowWay := '1';
  //���ӷ�ʽ,1����DBISAM,2����SQL
  FConnectWay := '1';
  //�ļ�����ʽ,Ĭ��dat
  FFileWay := 'dat';
  //frameShowResult��ǰ��λ������ Ĭ��Ϊ0 yr 2016-12-11
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


