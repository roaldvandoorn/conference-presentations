unit APRibbonBarAccessibility;
// Date             : 14-08-2016
// Developer        : J.P. Bone (Albumprinter)
// Release          : 1.00
// History          : 1.0 - Initial version 14-08-2016
//
// Unit description : Implementation of an IAccessible interface to the DevExpress
//                    Ribbon Bar to make it's methods, properties and children
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
  dxBar,
  cxControls,
  cxCheckBox,
  cxBarEditItem,
  APBaseAccessibility;

type
  TAPBarItemAccessibility = class;
  TAPBarItemControl = class(TdxBarItemControl);
  TAPBarControl = class(TdxBarControl);
  TAPBarItem = class(TdxBarItem);

  TAPBarControlAccessibility = class(TAPBaseWinControlExAccessibility, IAccessible, IAPBaseAccessibility)
  protected
    function GetBarControl: TAPBarControl;
    function CreateChild(const aLinkObject: TObject): IAPBaseAccessibility; override;
    function GetChildLinkObject(const aIndex: Integer): TObject; override;
    function GetChildCount: Integer; override;
    function GetAccessibleName: string; override;
    function GetAccessibleRoleID: Integer; override;
    function GetHitTest(const aScreenX, aScreenY: Integer; out aChildIndex: Integer): THitTest; override;
  public
    property BarControl: TAPBarControl read GetBarControl;
  end;

  TAPBarItemAccessibility = class(TAPBaseAccessibility, IAccessible, IAPBaseAccessibility)
  private

  protected
    function GetBarItemControl: TAPBarItemControl;
    function GetAccessibleName: string; override;
    function GetAccessibleDescription: string; override;
    function GetAccessibleValue: string; override;
    function GetScreenRectangle: TRect; override;
    function GetAccessibleRoleID: Integer; override;
    function DoDefaultAction: Boolean; override;
    function GetChecked: Boolean; override;
    function GetEnabled: Boolean; override;
  public
    property BarItemControl: TAPBarItemControl read GetBarItemControl;
  end;

  TAPAllBarControlsAccessibility = class(TAPBaseAccessibility, IAccessible, IAPBaseAccessibility)
  private
    procedure ReadChildComponents(const aComponent: TComponent);
  protected
    procedure LoadChilds; override;
  end;

implementation

uses
  Vcl.Forms,
  Vcl.ActnList;

{ TAPBarControlAccessibility }

function TAPBarControlAccessibility.GetAccessibleRoleID: Integer;
begin
  Result := ROLE_SYSTEM_TOOLBAR;
end;

function TAPBarControlAccessibility.GetBarControl: TAPBarControl;
begin
  Result := TAPBarControl(FLinkObject);
end;

function TAPBarControlAccessibility.CreateChild(const aLinkObject: TObject): IAPBaseAccessibility;
begin
  Result := TAPBarItemAccessibility.Create(Self, aLinkObject);
end;

function TAPBarControlAccessibility.GetChildLinkObject(const aIndex: Integer): TObject;
begin
  if HasLinkObject then
    Result := BarControl.ViewInfo.ItemControlViewInfos[aIndex].Control
  else
    Result := nil;
end;

function TAPBarControlAccessibility.GetChildCount: Integer;
begin
  if HasLinkObject then
    Result := BarControl.ViewInfo.ItemControlCount
  else
    Result := 0;

end;

function TAPBarControlAccessibility.GetAccessibleName: string;
begin
  Result := '';
  if HasLinkObject then
  begin
    if Assigned(BarControl.Bar) then
      Result := BarControl.Bar.Name;

    if Result.IsEmpty then
      Result := FLinkObject.ClassName;

  end;
end;

function TAPBarControlAccessibility.GetHitTest(const aScreenX, aScreenY: Integer; out aChildIndex: Integer): THitTest;
begin
  Result := htChild;
  aChildIndex := 0;
end;

{ TAPBarItemAccessibility }

function TAPBarItemAccessibility.GetBarItemControl: TAPBarItemControl;
begin
  Result :=  TAPBarItemControl(FLinkObject);;
end;

function TAPBarItemAccessibility.GetAccessibleName: string;
begin
  if HasLinkObject and Assigned(BarItemControl.ItemLink)
                   and Assigned(BarItemControl.ItemLink.Item) then
  begin
    Result := BarItemControl.ItemLink.Item.Name;

    if Result.IsEmpty then
      Result := BarItemControl.ItemLink.Item.ClassName;

  end else
    Result := '';

end;

function TAPBarItemAccessibility.GetAccessibleRoleID: Integer;
begin
  if HasLinkObject
  and Assigned(BarItemControl.ItemLink)
  and Assigned(BarItemControl.ItemLink.Item)
  and (BarItemControl.ItemLink.Item is TcxCustomBarEditItem)
  and (TcxCustomBarEditItem(BarItemControl.ItemLink.Item).Properties is TcxCustomCheckBoxProperties) then

    Result := ROLE_SYSTEM_CHECKBUTTON
  else
    Result := ROLE_SYSTEM_PUSHBUTTON;

end;

function TAPBarItemAccessibility.DoDefaultAction: Boolean;
var
  item: TdxBarItem;
begin
  if HasLinkObject then
  begin
    item := BarItemControl.Item;
    if Assigned(item) then
    begin
      if item is TcxCustomBarEditItem
      and (TcxCustomBarEditItem(item).Properties is TcxCustomCheckBoxProperties) then
        TcxCustomBarEditItem(item).EditValue :=  not TcxCustomBarEditItem(item).EditValue

      else
        item.Click;

    end;
  end;

//  DoMouseClickAction;  //TODO defer mouse click action
  Result := True;
end;

function TAPBarItemAccessibility.GetChecked: Boolean;
var
  item: TdxBarItem;
begin
  Result := False;
  if HasLinkObject then
  begin
    item := BarItemControl.Item;
    if Assigned(item) then
    begin
      if item is TcxCustomBarEditItem
      and (TcxCustomBarEditItem(item).Properties is TcxCustomCheckBoxProperties) then
        Result := TcxCustomBarEditItem(item).EditValue

      else
        if Assigned(item.Action) and (item.Action is TCustomAction) then
          Result := TCustomAction(item.Action).Checked;

    end;
  end;
end;

function TAPBarItemAccessibility.GetEnabled: Boolean;
var
  action: TCustomAction;
begin
  if HasLinkObject then
  begin
    action := BarItemControl.GetAction as TCustomAction;
    Result := Assigned(action) and action.Enabled;
  end else
    Result := False;

end;

function TAPBarItemAccessibility.GetAccessibleDescription: string;
begin
  if HasLinkObject and Assigned(BarItemControl.ItemLink)
                   and Assigned(BarItemControl.ItemLink.Item) then
  begin
    Result := BarItemControl.ItemLink.Item.Hint;

    if Result.IsEmpty then
      Result := BarItemControl.ItemLink.Item.Caption;

  end
  else
    Result := '';

end;

function TAPBarItemAccessibility.GetAccessibleValue: string;
begin
  if HasLinkObject and Assigned(BarItemControl.ItemLink)
                   and Assigned(BarItemControl.ItemLink.Item) then
    Result := BarItemControl.ItemLink.Item.Caption
  else
    Result := '';

end;


function TAPBarItemAccessibility.GetScreenRectangle: TRect;
var
  parent: TCustomdxBarControl;
begin
  if HasLinkObject and GetVisible then
  begin
    Result := BarItemControl.ViewInfo.Bounds;
    parent := BarItemControl.Parent;
    if Assigned(parent) then
    begin
      Result.TopLeft := parent.ClientToScreen(Result.TopLeft);
      Result.BottomRight := parent.ClientToScreen(Result.BottomRight);
    end;
  end
  else
    Result := TRect.Empty;

end;

{ TAPAllBarControlsAccessibility }

procedure TAPAllBarControlsAccessibility.ReadChildComponents(const aComponent: TComponent);
var
  comp: TComponent;
  enum: TComponentEnumerator;

begin
  enum := aComponent.GetEnumerator;
  try
    while enum.MoveNext do
    begin
      comp := enum.GetCurrent;
      if comp.InheritsFrom(TdxBarControl) then
      begin
        TAPBarControlAccessibility.Create(nil, comp);
      end else
      if comp.ComponentCount > 0 then
        ReadChildComponents(comp);

    end;
  finally
    enum.Free;
  end;
end;

procedure TAPAllBarControlsAccessibility.LoadChilds;
begin
  if FLinkObject is TComponent then
    ReadChildComponents(TComponent(FLinkObject));

end;



end.
