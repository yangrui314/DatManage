unit UnitContrast;

interface

uses
  Classes, SysUtils, Windows, dbisamtb, DB, Dialogs;

type
  TRowDiffInfo = class
    KeyValueA: TStringList;
    KeyValueB: TStringList;
    AValue: TStringList;
    BValue: TStringList;
    destructor Destroy; override;
    constructor Create;
  end;
  TDiffInfo = class
    TableNM: string;
    KeyList: TStringList;
    FieldList: TStringList;
    DiffList: TList;
    destructor Destroy; override;
    constructor Create;
  end;

  TRowDataInfo = class
    FieldValues: TStringList;
    destructor Destroy; override;
    constructor Create;
  end;
  TDataInfo = class
    TableNM: string;
    FieldList: TStringList;
    DataList: TList;
    destructor Destroy; override;
    constructor Create;
  end;

// 比较两个流是否相等
function CompareStream(mStream1, mStream2: TStream): Boolean;
// 比较两个文件是否相等
function CompareFile(mFileName1, mFileName2: string): Boolean;
// 比较两个数据表
function CompareTable(TableNM: string): TDiffInfo;
//获取数据表数据
function GetData(DBName, TableNM: string): TDataInfo;

implementation

uses
  UnitSys;

function CompareStream(mStream1, mStream2: TStream): Boolean;
var
  vBuffer1, vBuffer2: array[0..$1000-1] of Char;
   vLength1, vLength2: Integer; 
begin   
  Result := mStream1 = mStream2;
  if Result then Exit;
  if not Assigned(mStream1) or not Assigned(mStream2) then Exit;// 其中一个为空
  while True do
  begin
    vLength1 := mStream1.Read(vBuffer1, SizeOf(vBuffer1));
    vLength2 := mStream2.Read(vBuffer2, SizeOf(vBuffer2));
    if vLength1 <> vLength2 then Exit;
    if vLength1 =0 then Break;
    if not CompareMem(@vBuffer1[0],@vBuffer2[0], vLength1) then Exit;
  end;
  Result := True;
end;

function CompareFile(mFileName1, mFileName2: string): Boolean;
var
   vFileHandle1, vFileHandle2: THandle;
   vFileStream1, vFileStream2: TFileStream;
     vShortPath1, vShortPath2: array[0..MAX_PATH] of Char;
begin   
  Result := False;
  if not FileExists(mFileName1) or not FileExists(mFileName2) then Exit;// 其中一个文件不存在
  GetShortPathName(PChar(mFileName1), vShortPath1, SizeOf(vShortPath1));
  GetShortPathName(PChar(mFileName2), vShortPath2, SizeOf(vShortPath2));
  Result := SameText(vShortPath1, vShortPath2);// 两个文件名是否相同
  if Result then Exit;
  vFileHandle1 := _lopen(PChar(mFileName1), OF_READ or OF_SHARE_DENY_NONE);
  vFileHandle2 := _lopen(PChar(mFileName2), OF_READ or OF_SHARE_DENY_NONE);
  Result :=(Integer(vFileHandle1)>0) and (Integer(vFileHandle2)>0);// 文件是否可以访问
  if not Result then   begin
    _lclose(vFileHandle1);
    _lclose(vFileHandle2);
    Exit;
  end;
  Result := GetFileSize(vFileHandle1, nil)= GetFileSize(vFileHandle2, nil);// 文件大小是否一致
  if not Result then
  begin
    _lclose(vFileHandle1);
    _lclose(vFileHandle2);
    Exit;
  end;
  vFileStream1 := TFileStream.Create(vFileHandle1);
  vFileStream2 := TFileStream.Create(vFileHandle2);
  try
    Result := CompareStream(vFileStream1, vFileStream2);// 比较两个文件内容是否相同
  finally
    vFileStream1.Free;
    vFileStream2.Free;
  end;
end;

function CompareTable(TableNM: string): TDiffInfo;
var
  qryA, qryB: TDBISAMQuery;
  ASql, AComKey, AKeyFields, AFieldNM: string;
  AKeyValueA, AKeyValueB: TStringList;
  AList, BList: TStringList;
  ARowDiffInfo: TRowDiffInfo;
  i: integer;
  bIsDiff, bIsLocate: Boolean;
  FieldA, FieldB: TField;
  AKeyValues, AKeyValuesTemp: array of string;

  procedure GetComFields;
  var
    AFieldNM: string;
    i: integer;
  begin
    Result.KeyList.Clear;
    Result.FieldList.Clear;
    if UpperCase(Result.TableNM) = 'ACCOUNT' then
      Result.KeyList.Add('DJXH')
    else if UpperCase(Result.TableNM) = 'ACCOUNTPROP' then
    begin
      Result.KeyList.Add('AccountID');
      Result.KeyList.Add('Category');
      Result.KeyList.Add('SubCategory');
      Result.KeyList.Add('Name');
    end
    else if UpperCase(Result.TableNM) = 'ACCOUNTPROPDEF' then
    begin
      Result.KeyList.Add('Category');
      Result.KeyList.Add('SubCategory');
      Result.KeyList.Add('Name');
    end
    else if UpperCase(Result.TableNM) = 'ACCOUNTPROP_NSRZGXX' then
    begin
      Result.KeyList.Add('DJXH');
      Result.KeyList.Add('YXQQ');
      Result.KeyList.Add('YXQZ');        
    end
    else if UpperCase(Result.TableNM) = 'BASE_COUNTRY' then
      Result.KeyList.Add('Code')
    else if UpperCase(Result.TableNM) = 'CATEGORY' then
      Result.KeyList.Add('Category')  
    else if UpperCase(Result.TableNM) = 'CODETABLE' then
    begin
      Result.KeyList.Add('Name');
      Result.KeyList.Add('Code');
    end 
    else if UpperCase(Result.TableNM) = 'CODETABLEXML' then
      Result.KeyList.Add('Name')
    else if UpperCase(Result.TableNM) = 'DM_NF_SSSL_YJ_JM' then
      Result.KeyList.Add('CLFS_DM')
    else if UpperCase(Result.TableNM) = 'FORM' then         
    begin
      Result.KeyList.Add('DJXH');
      Result.KeyList.Add('FormType');
      Result.KeyList.Add('NSQXDM');
      Result.KeyList.Add('SSSQ');
    end
    else if UpperCase(Result.TableNM) = 'FORMFORJK' then         
    begin
      Result.KeyList.Add('DJXH');
      Result.KeyList.Add('FormType');
      Result.KeyList.Add('NSQXDM');
      Result.KeyList.Add('SSSQ');
    end
    else if UpperCase(Result.TableNM) = 'FORMRESULT' then
      Result.KeyList.Add('FormID')
    else if UpperCase(Result.TableNM) = 'FORMSUBMITTASK' then
      Result.KeyList.Add('TaskID')
    else if UpperCase(Result.TableNM) = 'FORMTASKLISTSQ' then
      Result.KeyList.Add('REQUEST_ID')
    else if UpperCase(Result.TableNM) = 'FORMTYPE' then
    begin
      Result.KeyList.Add('Category');
      Result.KeyList.Add('SubCategory');
      Result.KeyList.Add('Name');
    end
    else if UpperCase(Result.TableNM) = 'FORMTYPECATE' then
      Result.KeyList.Add('Categoryid')
    else if UpperCase(Result.TableNM) = 'FP_ZL_HY_MB_GL' then
    begin
      Result.KeyList.Add('FP_ZL_DM');
      Result.KeyList.Add('FP_HY_DM');
    end
    else if UpperCase(Result.TableNM) = 'FPLGSQ' then
      Result.KeyList.Add('XH')
    else if UpperCase(Result.TableNM) = 'FPLGSQMX' then
      Result.KeyList.Add('XH')
    else if UpperCase(Result.TableNM) = 'FPYJXX' then
      Result.KeyList.Add('XH')
    else if UpperCase(Result.TableNM) = 'IMMSGLIST' then
      Result.KeyList.Add('JID')
    else if UpperCase(Result.TableNM) = 'IMMSGLISTFIRST' then
      Result.KeyList.Add('JID')
    else if UpperCase(Result.TableNM) = 'IMMSGLISTUSER' then
      Result.KeyList.Add('JID')
    else if UpperCase(Result.TableNM) = 'MODULE' then
    begin
      Result.KeyList.Add('Category');
      Result.KeyList.Add('ModuleName');
    end
    else if UpperCase(Result.TableNM) = 'MODULEACCOUNT' then
    begin
      Result.KeyList.Add('ModuleName');
      Result.KeyList.Add('LinkUser');
    end
    else if UpperCase(Result.TableNM) = 'MODULEPROPS' then
    begin
      Result.KeyList.Add('ModuleName');
      Result.KeyList.Add('Name');
    end
    else if UpperCase(Result.TableNM) = 'NF_SSSL_YJ_JM_XX' then
    begin
      Result.KeyList.Add('GN_DM');
      Result.KeyList.Add('YZPZZLDM');
    end
    else if UpperCase(Result.TableNM) = 'NF_XTGL_BDMBDY' then
      Result.KeyList.Add('BD_ID')
    else if UpperCase(Result.TableNM) = 'NSRSFYZ' then
      Result.KeyList.Add('ACCOUNTID')
    else if UpperCase(Result.TableNM) = 'NT_CLASS' then
    begin
      Result.KeyList.Add('TypeName');
      Result.KeyList.Add('ClassName');
    end
    else if UpperCase(Result.TableNM) = 'NT_CWPROPS' then
      Result.KeyList.Add('YZPZZLDM')
    else if UpperCase(Result.TableNM) = 'NT_FLZLMX' then
    begin
      Result.KeyList.Add('FLZLID');
      Result.KeyList.Add('FileName');
    end
    else if UpperCase(Result.TableNM) = 'NT_FLZLSBB' then
    begin
      Result.KeyList.Add('FormID');
      Result.KeyList.Add('FLZLCode');
    end
    else if UpperCase(Result.TableNM) = 'NT_FORMFLZL' then
    begin
      Result.KeyList.Add('FormName');
      Result.KeyList.Add('Code');
    end
    else if UpperCase(Result.TableNM) = 'NT_FZJGXX' then
      Result.KeyList.Add('FZJGID')
    else if UpperCase(Result.TableNM) = 'NT_HDXX' then
    begin
      Result.KeyList.Add('NSRSBH');
      Result.KeyList.Add('SSSQ');
    end
    else if UpperCase(Result.TableNM) = 'NT_JYLB_CONTRAST' then
      Result.KeyList.Add('jylb_dm')
    else if UpperCase(Result.TableNM) = 'NT_JYLX_CONTRAST' then
      Result.KeyList.Add('jylx_dm')
    else if UpperCase(Result.TableNM) = 'NT_MESSAGEBOXINFO' then
      Result.KeyList.Add('ThreadName')
    else if UpperCase(Result.TableNM) = 'NT_MODULEFORMTYPE' then
    begin
      Result.KeyList.Add('FormTypeID');
      Result.KeyList.Add('ModuleName');
    end
    else if UpperCase(Result.TableNM) = 'NT_OMNIOPERATIONMENU' then
    begin
      Result.KeyList.Add('ModuleName');
      Result.KeyList.Add('Name');
    end
    else if UpperCase(Result.TableNM) = 'NT_PDF_MODULE_FORMTYPE' then
    begin
      Result.KeyList.Add('Name');
      Result.KeyList.Add('PDFModuleID');
    end
    else if UpperCase(Result.TableNM) = 'NT_SBFLZLLIST' then
    begin
      Result.KeyList.Add('FormID');
      Result.KeyList.Add('FLZLCode');
    end
    else if UpperCase(Result.TableNM) = 'NT_SBXX' then
      Result.KeyList.Add('SBZLID')
    else if UpperCase(Result.TableNM) = 'NT_SBZLXX' then
    begin
      Result.KeyList.Add('HDXXID');
      Result.KeyList.Add('SBZLCode');
    end
    else if UpperCase(Result.TableNM) = 'NT_SBZSXX' then
      Result.KeyList.Add('SBUUID')
    else if UpperCase(Result.TableNM) = 'NT_SDXMZSPMDMB' then
      Result.KeyList.Add('SDXMDM')
    else if UpperCase(Result.TableNM) = 'NT_SKBGB' then
      Result.KeyList.Add('XH')
    else if UpperCase(Result.TableNM) = 'NT_SLB' then
      Result.KeyList.Add('SDXMDM')
    else if UpperCase(Result.TableNM) = 'NT_SLB_DIY' then
      Result.KeyList.Add('SDXMDM')
    else if UpperCase(Result.TableNM) = 'NT_SSJKS' then
      Result.KeyList.Add('XH')
    else if UpperCase(Result.TableNM) = 'NT_SSJKSYHJS' then
      Result.KeyList.Add('XH')
    else if UpperCase(Result.TableNM) = 'NT_SXDZB' then
    begin
      Result.KeyList.Add('Category');
      Result.KeyList.Add('SubCategory');
      Result.KeyList.Add('PropName');
    end
    else if UpperCase(Result.TableNM) = 'NT_TABLEREF' then
      Result.KeyList.Add('CodeName')
    else if UpperCase(Result.TableNM) = 'NT_ZJGXX' then
      Result.KeyList.Add('ZJGID')
    else if UpperCase(Result.TableNM) = 'NT_ZSPM_CONTRAST' then
      Result.KeyList.Add('ZSPM_DM')
    else if UpperCase(Result.TableNM) = 'PACKAGVERSION' then
      Result.KeyList.Add('Version_ID')
    else if UpperCase(Result.TableNM) = 'SYSTEMCONFIG' then
    begin
      Result.KeyList.Add('UserID');
      Result.KeyList.Add('Category');
      Result.KeyList.Add('Name');
    end
    else if UpperCase(Result.TableNM) = 'UserAccount' then
      Result.KeyList.Add('UserID')
    else if UpperCase(Result.TableNM) = 'WEBUSERINFO' then
      Result.KeyList.Add('NSRSBH');

    with qryA do              
    begin
      Close;
      SQL.Text := 'select * from ' +TableNM+ ' where 1=2';
      Open;
      for i:=0 to FieldCount-1 do
      begin
        AFieldNM := Fields[i].FieldName;
        if UpperCase(AFieldNM) = 'ID' then
        begin
          if Result.KeyList.Count = 0 then
            Result.KeyList.Add('ID')
        end
        else
        begin
          if Result.KeyList.IndexOf(AFieldNM) < 0 then
            Result.FieldList.Add(AFieldNM);
        end;
      end;
    end;
    with qryB do
    begin
      Close;
      SQL.Text := 'select * from ' +TableNM+ ' where 1=2';
      Open;
      for i:=0 to FieldCount-1 do
      begin
        AFieldNM := Fields[i].FieldName;
        if UpperCase(AFieldNM) <> 'ID' then
        begin
          if (Result.KeyList.IndexOf(AFieldNM) < 0) and (Result.FieldList.IndexOf(AFieldNM) < 0) then
            Result.FieldList.Add(AFieldNM);
        end;
      end;
    end;

    if Result.KeyList.Count = 0 then
    begin
      ShowMessage('此表主键未明确！');
      Abort;
    end;
  end;
begin
  try
    Result := TDiffInfo.Create;
    Result.TableNM := TableNM;
    qryA := nil;
    qryB := nil;

    qryA := TDBISAMQuery.Create(nil);
    qryA.DatabaseName := 'dbA';
    qryB := TDBISAMQuery.Create(nil);
    qryB.DatabaseName := 'dbB';

    //获取字段列表
    GetComFields;
    AComKey := '';
    AKeyFields := '';
    SetLength(AKeyValues, Result.KeyList.Count);
    for i:=0 to Result.KeyList.Count-1 do
    begin
      AComKey := AComKey + Result.KeyList.Strings[i] + ',';
      AKeyFields := AKeyFields + Result.KeyList.Strings[i] + ';';
    end;
    AComKey := Copy(AComKey, 1, Length(AComKey)-1);
    AKeyFields := Copy(AKeyFields, 1, Length(AKeyFields)-1);
    ASql := 'select * from ' +TableNM+ ' order by ' + AComKey;
    if UpperCase(Result.TableNM) = 'CODETABLE' then
      ASql := ASql + ',Description';

    with qryA do
    begin
      Close;
      SQL.Text := ASql;
      Open;
      qryB.Close;
      qryB.SQL.Text := ASql;
      qryB.Open;

      First;
      Result.DiffList.Clear;
      while not Eof do
      begin
        AList := TStringList.Create;
        BList := TStringList.Create;
        AKeyValueA := TStringList.Create;
        AKeyValueB := TStringList.Create;
        AList.Clear;
        BList.Clear;
        AKeyValueA.Clear;
        AKeyValueB.Clear;
        for i:=0 to Result.KeyList.Count-1 do
        begin
          AKeyValueA.Add(FieldByName(Result.KeyList.Strings[i]).AsString);
          AKeyValues[i] := FieldByName(Result.KeyList.Strings[i]).AsString;
        end;
        //定位行
        //CODETABLE存储很多键值相同的行，做以下特殊处理
        if UpperCase(Result.TableNM) = 'CODETABLE' then
        begin
          SetLength(AKeyValuesTemp, 3);
          AKeyValuesTemp[0] := AKeyValues[0];
          AKeyValuesTemp[1] := AKeyValues[1];
          AKeyValuesTemp[2] := FieldByName('Description').AsString;
          bIsLocate := qryB.Locate(AKeyFields+';Description', AKeyValuesTemp, []);
          if not bIsLocate then
            bIsLocate := qryB.Locate(AKeyFields, AKeyValues, []);
        end
        else
          bIsLocate := qryB.Locate(AKeyFields, AKeyValues, []);
        if not bIsLocate then
          AKeyValueB.Add('无此行')
        else
        begin
          for i:= 0 to AKeyValueA.Count-1 do
            AKeyValueB.Add(AKeyValueA.Strings[i]);
        end;
        bIsDiff := not bIsLocate;
        for i:=0 to Result.FieldList.Count-1 do
        begin
          AFieldNM := Result.FieldList.Strings[i];
          FieldA := qryA.FindField(AFieldNM);
          FieldB := qryB.FindField(AFieldNM);
          if not bIsLocate then
          begin
            if FieldA <> nil then
              AList.Add(FieldA.AsString)
            else
              AList.Add('');
            BList.Add('');
          end
          else
          begin
            if (FieldA <> nil) and (FieldB <> nil) then
            begin
              if FieldA.AsString <> FieldB.AsString then
              begin
                bIsDiff := True;
                AList.Add('A>>' + FieldA.AsString);
                BList.Add('B>>' + FieldB.AsString);
              end
              else
              begin
                AList.Add(FieldA.AsString);
                BList.Add(FieldB.AsString);
              end;
            end
            else if (FieldA <> nil) and (FieldB = nil) then
            begin
              bIsDiff := True;
              AList.Add('A>>' + FieldA.AsString);
              BList.Add('B>>无此字段');
            end
            else
            begin
              bIsDiff := True;
              AList.Add('A>>无此字段');
              BList.Add('B>>' + FieldB.AsString);
            end;
          end;
        end;

        if bIsDiff then
        begin
          ARowDiffInfo := TRowDiffInfo.Create;
          ARowDiffInfo.KeyValueA := AKeyValueA;
          ARowDiffInfo.KeyValueB := AKeyValueB;
          ARowDiffInfo.AValue := AList;
          ARowDiffInfo.BValue := BList;
          Result.DiffList.Add(ARowDiffInfo);
        end
        else
        begin
          if Assigned(AList) then
            FreeAndNil(AList);
          if Assigned(BList) then
            FreeAndNil(BList);
        end;

        Next;
      end;

      qryB.First;
      while not qryB.Eof do
      begin
        AList := TStringList.Create;
        BList := TStringList.Create;
        AKeyValueA := TStringList.Create;
        AKeyValueB := TStringList.Create;
        AList.Clear;
        BList.Clear;
        AKeyValueA.Clear;
        AKeyValueB.Clear;
        for i:=0 to Result.KeyList.Count-1 do
        begin
          AKeyValueB.Add(qryB.FieldByName(Result.KeyList.Strings[i]).AsString);
          AKeyValues[i] := qryB.FieldByName(Result.KeyList.Strings[i]).AsString;
        end;
       
        if not Locate(AKeyFields, AKeyValues, []) then
        begin
          for i:=0 to Result.FieldList.Count-1 do
          begin
            AFieldNM := Result.FieldList.Strings[i];
            FieldB := qryB.FindField(AFieldNM);
            if FieldB <> nil then
              BList.Add(FieldB.AsString)
            else
              BList.Add('');
            AList.Add('');
          end;
          AKeyValueA.Add('无此行');
          bIsDiff := true;
        end
        else
          bIsDiff := false;

        if bIsDiff then
        begin
          ARowDiffInfo := TRowDiffInfo.Create;
          ARowDiffInfo.KeyValueA := AKeyValueA;
          ARowDiffInfo.KeyValueB := AKeyValueB;
          ARowDiffInfo.AValue := AList;
          ARowDiffInfo.BValue := BList;
          Result.DiffList.Add(ARowDiffInfo);
        end
        else
        begin
          if Assigned(AList) then
            FreeAndNil(AList);
          if Assigned(BList) then
            FreeAndNil(BList);
        end;

        qryB.Next;
      end;
    end;

  finally
    if Assigned(qryA) then
      FreeAndNil(qryA);
    if Assigned(qryB) then
      FreeAndNil(qryB);
  end;
end;

function GetData(DBName, TableNM: string): TDataInfo;
var
  qry: TDBISAMQuery;
  ARowDataInfo: TRowDataInfo;
  i: integer;
begin
  try
    qry := nil;
    Result := TDataInfo.Create;
    Result.TableNM := TableNM;
    qry := TDBISAMQuery.Create(nil);
    with qry do
    begin
      DatabaseName := DBName;
      Close;
      SQL.Text := 'select * from ' + TableNM;
      Open;
      first;
      for i:= 0 to Fields.Count-1 do
        Result.FieldList.Add(Fields[i].FieldName);
      while not eof do
      begin
        ARowDataInfo := TRowDataInfo.Create;
        for i:= 0 to Fields.Count-1 do
          ARowDataInfo.FieldValues.Add(Fields[i].AsString);
        Result.DataList.Add(ARowDataInfo);
        next;
      end;
    end;
  finally
    if Assigned(qry) then
      FreeAndNil(qry);
  end;
end;

{ TDiffInfo }

constructor TDiffInfo.Create;
begin
  DiffList := TList.Create;
  FieldList := TStringList.Create;
  KeyList := TStringList.Create;
  DiffList.Clear;
  FieldList.Clear;
  KeyList.Clear;
end;

destructor TDiffInfo.Destroy;
begin
  if Assigned(DiffList) then
    FreeAndNil(DiffList);
  if Assigned(FieldList) then
    FreeAndNil(FieldList);
  if Assigned(KeyList) then
    FreeAndNil(KeyList);
  inherited;
end;

{ TRowDiffInfo }

constructor TRowDiffInfo.Create;
begin
  AValue := TStringList.Create;
  BValue := TStringList.Create;
  KeyValueA := TStringList.Create;
  KeyValueB := TStringList.Create;
  AValue.clear;
  BValue.Clear;
  KeyValueA.Clear;
  KeyValueB.Clear;
end;

destructor TRowDiffInfo.Destroy;
begin
  if Assigned(AValue) then
    FreeAndNil(AValue);
  if Assigned(BValue) then
    FreeAndNil(BValue);
  if Assigned(KeyValueA) then
    FreeAndNil(KeyValueA);
  if Assigned(KeyValueB) then
    FreeAndNil(KeyValueB);
  inherited;
end;

{ TDataInfo }

constructor TDataInfo.Create;
begin
  DataList := TList.Create;
  DataList.Clear;
  FieldList := TStringList.Create;
  FieldList.Clear;
end;

destructor TDataInfo.Destroy;
begin
  if Assigned(DataList) then
    FreeAndNil(DataList);
  if Assigned(FieldList) then
    FreeAndNil(FieldList);
  inherited;
end;

{ TRowDataInfo }

constructor TRowDataInfo.Create;
begin
  FieldValues := TStringList.Create;
  FieldValues.Clear;
end;

destructor TRowDataInfo.Destroy;
begin
  if Assigned(FieldValues) then
    FreeAndNil(FieldValues);
  inherited;
end;

end.

