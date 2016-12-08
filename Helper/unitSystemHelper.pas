unit unitSystemHelper;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs,StdCtrls,unitParentHelper,StrUtils;

type
  TSystemHelper = class(TParentHelper)
  private
  protected
  public
    constructor Create;
    procedure WorkRun(const aPageIndex : Integer);
    function GetSQL(const aPageIndex : Integer): string;
    procedure LoadField(aSQL: string);
    procedure ShowResult(bShow: Boolean); overload;
    procedure ShowResult; overload;
  end;

var
  SystemHelper: TSystemHelper;

implementation


constructor TSystemHelper.Create;
begin

end;

procedure TSystemHelper.WorkRun(const aPageIndex : Integer);
var
  aSQL: string;
begin
  try
    aSQL := GetSQL(aPageIndex);
    if aSQL = '' then
      Exit;
    LoadField(aSQL);
    ShowResult;
  except
    on E: Exception do
      showmessage('异常类名称:' + E.ClassName + #13#10 + '异常信息:' + E.Message);
  end;
end;

function TSystemHelper.GetSQL(const aPageIndex : Integer): string;
var
  aFieldType : string;
begin
//  if aPageIndex = 0 then
//  begin
//    if FTableName = '' then FTableName := edtTable.EditText;
//    if FTableName = '' then
//    begin
//      Result := '';
//      ShowMessage('请输入表格名称');
//      Exit;
//    end
//    else
//    begin
//      Result := FEnvironment.GetBaseTableSQL(FTableName);
//      aFieldType := GetFieldType;
//      if  (edtFieldName.Text <> '') and  (edtKeyword.Text <> '') and (edtCondition.Text <> '') then
//      begin
//        if edtKeyword.Text = '包含' then
//        begin
//          if IsQuotation(aFieldType)   then
//          begin
//            ShowMessage('该字段不能使用''包含''查询。');
//            Result := '';
//          end
//          else
//          begin
//            Result := Result + ' where ' + FTable.HandleSpecialStr(edtFieldName.Text) + ' like ' + '''%'+  edtCondition.Text + '%''';
//          end;
//        end
//        else if edtKeyword.Text = '等于' then
//        begin
//          if IsQuotation(aFieldType)   then
//          begin
//            Result := Result + ' where ' + FTable.HandleSpecialStr(edtFieldName.Text)  + ' = ' +  edtCondition.Text ;
//          end
//          else
//          begin
//            Result := Result + ' where ' + FTable.HandleSpecialStr(edtFieldName.Text)  + ' = ' + ''''+  edtCondition.Text + '''';
//          end;
//        end
//        else if edtKeyword.Text = '不等于' then
//        begin
//          if IsQuotation(aFieldType) then
//          begin
//            Result := Result + ' where ' + FTable.HandleSpecialStr(edtFieldName.Text)  + ' <> ' +  edtCondition.Text ;
//          end
//          else
//          begin
//            Result := Result + ' where ' + FTable.HandleSpecialStr(edtFieldName.Text)  + ' <> ' + ''''+  edtCondition.Text + '''';          
//          end;
//        end;
//      end;
//      if  (edtFieldName.Text = '') and  (edtKeyword.Text = '') and (edtCondition.Text <> '') then
//      begin
//        Result := Result + ' where ' + edtCondition.Text ;     
//      end;
//    end;
//  end
//  else
//  begin
//    FTableName := '';
//    if edtSQL.SelText = '' then
//      Result := edtSQL.Text
//    else
//      Result := edtSQL.SelText;
//  end;
end;

procedure TSystemHelper.LoadField(aSQL: string);
var
  I : Integer;
  aHint : String;
begin
//  FTable := TTable.Create(FEnvironment, aSQL, FTableName);
//  if  PageSelect.ActivePageIndex = 0  then
//  begin
//    aHint := '打开'+ FTableName;
//  end
//  else
//  begin
//    if (Pos('update',aSQL) <> 0 ) then
//    begin
//      aHint := '更新';
//      aHint := aHint + Trim(StrHelper.GetMidStr(aSQL,'update','set'))
//    end
//    else if (Pos('delete',aSQL) <> 0) then
//    begin
//      aHint := '删除';
//      if (Pos('where',aSQL) <> 0) then
//      begin
//        aHint := aHint + Trim(StrHelper.GetMidStr(aSQL,'from','where'))
//      end
//      else
//      begin
//        aHint := aHint + Trim(StrHelper.GetMidStr(aSQL,'from'))
//      end;      
//    end
//    else if (Pos('insert',aSQL) <> 0) then
//    begin
//      aHint := '插入';
//      aHint := aHint + Trim(StrHelper.GetMidStr(aSQL,'into','('));
//    end
//    else
//    begin
//      aHint := '查询';
//      if (Pos('where',aSQL) <> 0) then
//      begin
//        aHint := aHint + Trim(StrHelper.GetMidStr(aSQL,'from','where'))
//      end
//      else
//      begin
//        aHint := aHint + Trim(StrHelper.GetMidStr(aSQL,'from'))
//      end;       
//    end;
//  end;
//
//  if FEnvironment.SQLSuccess then
//  begin
//    lblResult.Caption := aHint +#13#10 +  '执行成功' +#13#10 + '标识号:' + IntToStr(Random(100))  ;
//    lblResult.Style.TextColor := clBlue;
//  end
//  else
//  begin
//    lblResult.Caption :=  aHint + #13#10 + '失败' + #13#10 + '标识号:' + IntToStr(Random(100)) ;
//    lblResult.Style.TextColor := clRed;
//  end;
//
//
//  edtFieldName.Properties.Items.Clear;
//  for I := 0 to   FTable.TableFieldCount - 1 do
//  begin
//    edtFieldName.Properties.Items.Add(FTable.TableFieldNameArray[I]);
//  end;
//
//  FGetTable := True;
//  FResult.Update(FTable, Config.SelectShowWay);
end;


procedure TSystemHelper.ShowResult;
begin
//  ShowResult(FGetTable);
end;

procedure TSystemHelper.ShowResult(bShow: Boolean);
var
  aScrHeight: Integer;
  aResultHeight: Integer;
  aDefaultHeight: Integer;
begin
//  if pnlResult.Visible = bShow then
//    Exit;
//  pnlResult.Visible := bShow;
//  aDefaultHeight := 236;
//  if bShow then
//  begin
//    fmMain.Height := fmMain.Height + aDefaultHeight;
//  end
//  else
//  begin
//    fmMain.Height := fmMain.Height - aDefaultHeight;
//  end;
//  pnlResult.Height := aDefaultHeight;
end;





initialization
  SystemHelper := TSystemHelper.Create;

finalization
  SystemHelper.Free;;

end.
