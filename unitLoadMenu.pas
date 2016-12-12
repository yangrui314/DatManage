unit unitLoadMenu;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs,StdCtrls,StrUtils,unitConfigHelper,unitConfig,Menus,formParentMenu;

type
  TLoadMenu = class
  private
    MainMenu : TMainMenu;
    procedure MenuClick(Sender: TObject);
  protected
    procedure LoadMenu(aMenuName : String;aHint : String = '';aShow : Boolean = True);
    procedure InitMenu;  
  public
    procedure Load(var aMainMenu : TMainMenu);
  end;

implementation

procedure TLoadMenu.Load(var aMainMenu : TMainMenu);
begin
  MainMenu := aMainMenu;
  InitMenu;
  aMainMenu := MainMenu;
end;

procedure TLoadMenu.LoadMenu(aMenuName : String;aHint : String = '';aShow : Boolean = True);
var
  aMenu : TfmParentMenu;
begin
  ConfigHelper.CreateInstance(aMenu,aMenuName);
  aMenu.Caption := ConfigHelper.GetMenuCaption(aMenuName);
  try
    if not aMenu.CheckIsShow then
    begin
      if aHint <> '' then
      begin
        ShowMessage(aHint);
      end
      else
      begin
        ShowMessage('无法使用该功能。');
      end;
      Exit;
    end;
    if aShow then
    begin
      aMenu.ShowModal;    
    end
    else
    begin
      aMenu.MenuHandle;
    end;
  finally
    aMenu.Free;
  end;
end;

procedure TLoadMenu.InitMenu;
var
  MenuItem,MenuSubItem:TMenuItem;
  I ,J: Integer;
  MenuNum : Integer;  
begin
  MenuNum := 0;
  for I := 0 to Length(Config.FMenuList) - 1 do
  begin
    if Config.FMenuList[I].ParentName <> '' then
      Continue;
      
    MenuItem:=TMenuItem.Create(MainMenu);
    if Config.FMenuList[I].ClassName = '' then
    begin
      MenuItem.Name := 'Unit' + IntToStr(Random(100));
    end
    else
    begin
      if Config.FMenuList[I].ClassType = 'Class' then
      begin
        MenuItem.Name := 'Unit' + Config.FMenuList[I].ClassName;
      end
      else
      begin
        MenuItem.Name := 'Form' + Config.FMenuList[I].ClassName;
      end;    
    end;
    MenuItem.Caption:= Config.FMenuList[I].Caption;
    MenuItem.Hint := Config.FMenuList[I].NotShowFormHint;
    MenuItem.Visible := Config.FMenuList[I].Visible;
    if Config.FMenuList[I].ClassName <> '' then
      MenuItem.OnClick := MenuClick;
    MainMenu.Items.Add(MenuItem);
    for J := 0 to Length(Config.FMenuList) - 1 do
    begin
      if (Config.FMenuList[I].Name = Config.FMenuList[J].ParentName)   then
      begin
        MenuSubItem:=TMenuItem.Create(MainMenu);
        if Config.FMenuList[J].ClassName = '' then
        begin
          MenuSubItem.Name := 'Unit' + IntToStr(Random(100));
        end
        else
        begin
          if Config.FMenuList[J].ClassType = 'Class' then
          begin
            MenuSubItem.Name := 'Unit' + Config.FMenuList[J].ClassName;
          end
          else
          begin
            MenuSubItem.Name := 'Form' + Config.FMenuList[J].ClassName;
          end;
        end;
        MenuSubItem.Caption:= Config.FMenuList[J].Caption;
        MenuSubItem.Hint := Config.FMenuList[J].NotShowFormHint;
        MenuSubItem.Visible := Config.FMenuList[J].Visible;
        if Config.FMenuList[J].ClassName <> '' then
          MenuSubItem.OnClick := MenuClick;

        MainMenu.Items[MenuNum].Add(MenuSubItem);
      end;
    end;    
    Inc(MenuNum);
  end;
end;

procedure TLoadMenu.MenuClick(Sender: TObject);
var
  aClassName : string;
  aMenuName : string;
  aNotShowFormHint : string;
  aShow : Boolean;
begin
//  Config.SystemParameter := FParameter;
  aMenuName := (Sender as TMenuItem).Name;
  aNotShowFormHint := (Sender as TMenuItem).Hint;
  aClassName := Copy(aMenuName,5,Length(aMenuName)-4);
  aShow := (LeftStr(aMenuName,4)  <> 'Unit');
  LoadMenu(aClassName,aNotShowFormHint,aShow);
end;

end.
