unit formUpgradeProgress;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, formProgress, ExtCtrls, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdHTTP, AbBase, AbBrowse, AbZBrows,
  AbUnzper;

type
  TfmUpgradeProgress = class(TfmProgress)
    IdHTTP: TIdHTTP;
    Timer: TTimer;
    unzip: TAbUnZipper;
    procedure FormCreate(Sender: TObject);
    procedure IdHTTPWorkBegin(Sender: TObject; AWorkMode: TWorkMode;
      const AWorkCountMax: Integer);
    procedure IdHTTPWork(Sender: TObject; AWorkMode: TWorkMode;
      const AWorkCount: Integer);
    procedure TimerTimer(Sender: TObject);
  private
    FDownLoadURL : string;
    FDownLoadPath: string;
    FFileName : String;
    function BytesToStr(iBytes: Integer): String;
  public
    constructor Create(AOwner: TComponent;aUrl : String;aFilePath : String);
    procedure LoadData;
    function  UnZipfile(filename:String;Director:string;APassword: string = ''):boolean ;
  end;

var
  fmUpgradeProgress: TfmUpgradeProgress;

implementation

  uses
    AbArcTyp,AbUtils;

{$R *.dfm}

constructor TfmUpgradeProgress.Create(AOwner: TComponent;aUrl : String;aFilePath : String);
begin
  inherited Create(AOwner);
  FDownLoadURL := aUrl;
  FDownLoadPath := aFilePath;
  FFileName := ExtractFileName(aFilePath);
end;

procedure TfmUpgradeProgress.FormCreate(Sender: TObject);
begin
  inherited;
  FProgressBar.SetCaption('׼������...');
end;

procedure TfmUpgradeProgress.LoadData;
var
  tStream: TMemoryStream;
begin
  tStream := TMemoryStream.Create;
  try
    try
      IdHTTP.Get(FDownLoadURL, tStream); //���浽�ڴ���
      tStream.SaveToFile(FDownLoadPath); //����Ϊ�ļ�
      FProgressBar.SetCaption('���سɹ�...');
      if ExtractFileExt(FFileName) = '.zip' then
      begin
        FProgressBar.SetCaption('��ѹ��...');
        UnZipfile(FDownLoadPath,ExtractFilePath(FDownLoadPath));
      end;
      FProgressBar.SetCaption('������ɣ�');
    except
      ShowMessage('����ʧ�ܣ�');
    end;
  finally
    tStream.Free;
    Close;  
  end;
end;


function TfmUpgradeProgress.BytesToStr(iBytes: Integer): String;
var
  iKb: Integer;
begin
  iKb := Round(iBytes / 1024);
  if iKb > 1000 then
    Result := Format('%.2f MB', [iKb / 1024])
  else
    Result := Format('%d KB', [iKb]);
end;


procedure TfmUpgradeProgress.IdHTTPWorkBegin(Sender: TObject;
  AWorkMode: TWorkMode; const AWorkCountMax: Integer);
begin
  inherited;
  FProgressBar.SetMax(aWorkCountMax);
  FProgressBar.Update;
end;

procedure TfmUpgradeProgress.IdHTTPWork(Sender: TObject;
  AWorkMode: TWorkMode; const AWorkCount: Integer);
var
  aMessage : string;
begin
  inherited;
  if FProgressBar.GetCancel then
  begin
    IdHTTP.Disconnect;
  end;
  aMessage := '��������'+ FFileName +',�Ѿ�����'+BytesToStr(aWorkCount) +'...';
  FProgressBar.SetCaption(aMessage);
  FProgressBar.SetPosition(aWorkCount);
  FProgressBar.Update;
end;

procedure TfmUpgradeProgress.TimerTimer(Sender: TObject);
begin
  inherited;
  Timer.Enabled := False;
  LoadData;
end;

function  TfmUpgradeProgress.UnZipfile(filename:String;Director:string;APassword: string = ''):boolean ;
begin
  unzip.ExtractOptions := [eoCreateDirs];
  unzip.BaseDirectory := Director;
  unzip.ArchiveType:=atzip;
  unzip.FileName := filename;
  if APassword <> '' then
  unzip.Password := APassword;
  unzip.ExtractFiles('*.*');
  unzip.CloseArchive;
  result:=true;
end;

end.
