unit APRibbonAccessibility;
// Date             : 14-08-2016
// Developer        : J.P. Bone (Albumprinter)
// Release          : 1.00
// History          : 1.0 - Initial version 02-09-2016
//
// Unit description : Implementation of an IAccessible interface to the DevExpress
//                    Ribbon to make it's methods, properties and children
//                    accessible for automation testing
// -----------------------------------------------------------------------------



interface

uses
  System.Classes,
  System.Types,
  System.Variants,
  System.SysUtils,
  Vcl.StdCtrls,
  Winapi.Windows,
  Winapi.Messages,
  Winapi.ActiveX,
  Winapi.oleacc,
  dxRibbon,
  cxControls,
  APBaseAccessibility;

type
  TAPRibbonTabAccessibility = class;
  TAPRibbon = class(TdxRibbon);
  TAPRibbonTab = class(TdxRibbonTab);
  TAPApplicationButton = class(TdxRibbonApplicationButton);

  TAPRibbonAccessibility = class(TAPBaseWinControlExAccessibility, IAccessible, IAPBaseAccessibility)
  protected
    function GetRibbon: TAPRibbon;
    function CreateChild(const aLinkObject: TObject): IAPBaseAccessibility; override;
    function GetChildLinkObject(const aIndex: Integer): TObject; override;
    function GetChildCount: Integer; override;
    function GetAccessibleName: string; override;
    function GetAccessibleRoleID: Integer; override;
    procedure LoadChilds; override;
  public
    property Ribbon: TAPRibbon read GetRibbon;
  end;

  TAPRibbonTabAccessibility = class(TAPBaseAccessibility, IAccessible, IAPBaseAccessibility)
  protected
    function GetRibbonTab: TAPRibbonTab;
    function CreateChild(const aLinkObject: TObject): IAPBaseAccessibility; override;
    function GetChildLinkObject(const aIndex: Integer): TObject; override;
    function GetChildCount: Integer; override;
    function GetAccessibleName: string; override;
    function GetAccessibleDescription: string; override;
    function GetScreenRectangle: TRect; override;
    function GetAccessibleRoleID: Integer; override;
    function DoDefaultAction: Boolean; override;
    function GetVisible: Boolean; override;
    function GetSelected: Boolean; override;
  public
    property RibbonTab: TAPRibbonTab read GetRibbonTab;
  end;

  TAPRibbonApplicationButtonAccessibility = class(TAPBaseAccessibility, IAccessible, IAPBaseAccessibility)
  protected
    function GetApplicationButton: TAPApplicationButton;
    function GetAccessibleName: string; override;
    function GetAccessibleDescription: string; override;
    function GetScreenRectangle: TRect; override;
    function GetAccessibleRoleID: Integer; override;
    function GetVisible: Boolean; override;
    function GetSelected: Boolean; override;
  public
    property ApplicationButton: TAPApplicationButton read GetApplicationButton;
  end;

implementation

uses
  Vcl.Forms,
  APRibbonBarAccessibility;

{ TAPRibbonAccessibility }

function TAPRibbonAccessibility.GetAccessibleRoleID: Integer;
begin
  Result := ROLE_SYSTEM_PAGETABLIST;
end;

function TAPRibbonAccessibility.GetRibbon: TAPRibbon;
begin
  Result := TAPRibbon(FLinkObject);
end;

procedure TAPRibbonAccessibility.LoadChilds;
begin
//  TAPBarControlAccessibility.Create(nil, Ribbon.QuickAccessToolbar.Toolbar.Control);
//  TAPBarControlAccessibility.Create(nil, Ribbon.TabAreaToolbar.Toolbar.Control);
  // tabs are loaded on demand under the Ribbon
end;

function TAPRibbonAccessibility.CreateChild(const aLinkObject: TObject): IAPBaseAccessibility;
begin
  if aLinkObject is TdxRibbonTab then
    Result := TAPRibbonTabAccessibility.Create(Self, aLinkObject)
  else if aLinkObject is TdxRibbonApplicationButton then
    Result := TAPRibbonApplicationButtonAccessibility.Create(Self, aLinkObject);
end;

function TAPRibbonAccessibility.GetChildLinkObject(const aIndex: Integer): TObject;
begin
  if AIndex <= (Ribbon.Tabs.Count-1) then
    Result := Ribbon.Tabs.Items[aIndex]
  else
    Result := Ribbon.ApplicationButton;
end;

function TAPRibbonAccessibility.GetChildCount: Integer;
begin
  Result := Ribbon.Tabs.Count + 1; //1st item after tabs is application button
end;

function TAPRibbonAccessibility.GetAccessibleName: string;
begin
  Result := '';
  if HasLinkObject then
  begin
    Result := Ribbon.Name;

    if Result.IsEmpty then
      Result := Ribbon.ClassName;

  end;
end;


{ TAPRibbonTabAccessibility }

function TAPRibbonTabAccessibility.CreateChild(const aLinkObject: TObject): IAPBaseAccessibility;
begin
  Result := TAPBarControlAccessibility.Create(Self, aLinkObject);
end;

function TAPRibbonTabAccessibility.DoDefaultAction: Boolean;
begin
  if GetVisible then
    RibbonTab.Ribbon.ActiveTab := RibbonTab;

//  DoMouseClickAction;  //TODO defer mouse click action
  Result := True;
end;

function TAPRibbonTabAccessibility.GetAccessibleDescription: string;
begin
  Result := RibbonTab.Caption;
end;

function TAPRibbonTabAccessibility.GetAccessibleName: string;
begin
  Result := RibbonTab.Name;
end;

function TAPRibbonTabAccessibility.GetAccessibleRoleID: Integer;
begin
  Result := ROLE_SYSTEM_PAGETAB;
end;

function TAPRibbonTabAccessibility.GetChildCount: Integer;
begin
  if Assigned(RibbonTab.Groups) then
    Result := RibbonTab.Groups.Count
  else
    Result := 0;

end;

function TAPRibbonTabAccessibility.GetChildLinkObject(const aIndex: Integer): TObject;
var
  group: TdxRibbonTabGroup;
begin
  Result := nil;
  if ((aIndex >= 0) and (aIndex < GetChildCount)) then
  begin
    group := RibbonTab.Groups[aIndex];
    if Assigned(group) and Assigned(group.ToolBar) then
      Result := group.ToolBar.Control

  end;
end;

function TAPRibbonTabAccessibility.GetRibbonTab: TAPRibbonTab;
begin
  Result := TAPRibbonTab(FLinkObject);
end;

function TAPRibbonTabAccessibility.GetScreenRectangle: TRect;
begin
  if Assigned(RibbonTab.ViewInfo) then
  begin
    Result := RibbonTab.ViewInfo.Bounds;
    Result.TopLeft := RibbonTab.Ribbon.ClientToScreen(Result.TopLeft);
    Result.BottomRight := RibbonTab.Ribbon.ClientToScreen(Result.BottomRight);
  end else
    Result := TRect.Empty;

end;

function TAPRibbonTabAccessibility.GetVisible: Boolean;
begin
  Result := RibbonTab.Visible;
end;

function TAPRibbonTabAccessibility.GetSelected: Boolean;
begin
  Result := (RibbonTab.Ribbon.ActiveTab = RibbonTab);
end;


{ TAPRibbonApplicationButtonAccessibility }

function TAPRibbonApplicationButtonAccessibility.GetAccessibleDescription: string;
begin
  Result := 'ApplicationButton';
end;

function TAPRibbonApplicationButtonAccessibility.GetAccessibleName: string;
begin
  Result := 'ApplicationButton';
end;

function TAPRibbonApplicationButtonAccessibility.GetAccessibleRoleID: Integer;
begin
  Result := ROLE_SYSTEM_BUTTONMENU;
end;

function TAPRibbonApplicationButtonAccessibility.GetApplicationButton: TAPApplicationButton;
begin
  Result := TAPApplicationButton(FLinkObject);
end;

function TAPRibbonApplicationButtonAccessibility.GetScreenRectangle: TRect;
var
  vi: TdxRibbonApplicationButtonViewInfo;
begin
  if Assigned(TAPRibbon(ApplicationButton.Ribbon).ApplicationButtonViewInfo) then
  begin
    vi := TAPRibbon(ApplicationButton.Ribbon).ApplicationButtonViewInfo;
    Result := vi.Bounds;
    Result.TopLeft := ApplicationButton.Ribbon.ClientToScreen(Result.TopLeft);
    Result.BottomRight := ApplicationButton.Ribbon.ClientToScreen(Result.BottomRight);
  end else
    Result := TRect.Empty;
end;

function TAPRibbonApplicationButtonAccessibility.GetSelected: Boolean;
begin
  Result := False;
end;

function TAPRibbonApplicationButtonAccessibility.GetVisible: Boolean;
begin
  Result := ApplicationButton.Ribbon.Visible and
            ApplicationButton.Visible;
end;

end.
