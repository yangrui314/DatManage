unit unitDownLoadFile;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs,StdCtrls, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdHTTP;

type
  TDownLoadFile = class
  private
    FIdHTTP: TIdHTTP;
    FDownLoadURL : string;
    FDownLoadPath: string;
    FFileName : String;    
  protected
  public
    constructor Create(AOwner: TComponent;aUrl : String;aFilePath : String);
    destructor Destroy;
    procedure LoadData;    
  end;

implementation

constructor TDownLoadFile.Create(AOwner: TComponent;aUrl : String;aFilePath : String);
begin
  FIdHTTP := TIdHTTP.Create(AOwner);
  FDownLoadURL := aUrl;
  FDownLoadPath := aFilePath;
  FFileName := ExtractFileName(aFilePath);  
  LoadData;
end;


procedure TDownLoadFile.LoadData;
var
  tStream: TMemoryStream;
begin
  tStream := TMemoryStream.Create;
  try
    try
      FIdHTTP.Get(FDownLoadURL, tStream); //保存到内存流
      tStream.SaveToFile(FDownLoadPath); //保存为文件
    except
      //ShowMessage('下载失败！');
    end;
  finally
    tStream.Free;
  end;
end;

destructor TDownLoadFile.Destroy;
begin
  FIdHTTP.Free;    
end;

end.
 