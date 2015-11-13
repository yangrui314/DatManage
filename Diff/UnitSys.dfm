object dmSys: TdmSys
  OldCreateOrder = False
  Left = 456
  Top = 224
  Height = 264
  Width = 379
  object dbA: TDBISAMDatabase
    EngineVersion = '4.24 Build 1'
    DatabaseName = 'dbA'
    Directory = 'D:\SVN\test_src\DBContrastTooler\data1'
    KeepTablesOpen = False
    SessionName = 'Default'
    Left = 24
    Top = 8
  end
  object tbA: TDBISAMTable
    AutoDisplayLabels = False
    CopyOnAppend = False
    DatabaseName = 'dbA'
    EngineVersion = '4.24 Build 1'
    Left = 88
    Top = 8
  end
  object dbB: TDBISAMDatabase
    EngineVersion = '4.24 Build 1'
    DatabaseName = 'dbB'
    Directory = 'D:\SVN\test_src\DBContrastTooler\data1'
    KeepTablesOpen = False
    SessionName = 'Default'
    Left = 24
    Top = 88
  end
  object qryA: TDBISAMQuery
    AutoDisplayLabels = False
    CopyOnAppend = False
    DatabaseName = 'dbA'
    EngineVersion = '4.24 Build 1'
    MaxRowCount = -1
    Params = <>
    Left = 152
    Top = 16
  end
end
