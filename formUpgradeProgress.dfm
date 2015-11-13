inherited fmUpgradeProgress: TfmUpgradeProgress
  Caption = 'fmUpgradeProgress'
  PixelsPerInch = 96
  TextHeight = 13
  object IdHTTP: TIdHTTP
    MaxLineAction = maException
    OnWork = IdHTTPWork
    OnWorkBegin = IdHTTPWorkBegin
    AllowCookies = True
    ProxyParams.BasicAuthentication = False
    ProxyParams.ProxyPort = 0
    Request.ContentLength = -1
    Request.ContentRangeEnd = 0
    Request.ContentRangeStart = 0
    Request.Accept = 'text/html, */*'
    Request.BasicAuthentication = False
    Request.UserAgent = 'Mozilla/3.0 (compatible; Indy Library)'
    HTTPOptions = [hoForceEncodeParams]
    Left = 104
    Top = 16
  end
  object Timer: TTimer
    OnTimer = TimerTimer
    Left = 152
    Top = 16
  end
  object unzip: TAbUnZipper
    Left = 312
    Top = 24
  end
end
