unit APBackstageViewAccessibility;

interface

uses
  APBaseAccessibility, Winapi.oleacc, dxRibbonBackstageView, System.Types, dxBar;


type
  TAPBackstageView = class(TdxRibbonBackstageView);
  TAPBackStageViewButton = TdxBarItemLink;

  TAPBackstageViewAccessibility = class(TAPBaseWinControlExAccessibility, IAccessible, IAPBaseAccessibility)
  protected
    function GetBackStageView: TAPBackstageView;
    function CreateChild(const aLinkObject: TObject): IAPBaseAccessibility; override;
    function GetChildLinkObject(const aIndex: Integer): TObject; override;
    function GetChildCount: Integer; override;
    function GetAccessibleName: string; override;
    function GetAccessibleRoleID: Integer; override;
    function GetVisible: Boolean; override;
    procedure LoadChilds; override;
  public
    property BackStageView: TAPBackstageView read GetBackStageView;
  end;

  TAPBackStageViewButtonAccessibility = class(TAPBaseAccessibility, IAccessible, IAPBaseAccessibility)
  protected
    function GetBackStageviewButton: TAPBackStageViewButton;
    function GetAccessibleName: string; override;
    function GetAccessibleDescription: string; override;
    function GetScreenRectangle: TRect; override;
    function GetAccessibleRoleID: Integer; override;
    function GetVisible: Boolean; override;
    function GetSelected: Boolean; override;
  public
    property BackStageViewButton: TAPBackStageViewButton read GetBackStageviewButton;
  end;

implementation

uses
  System.Classes;

{ TAPBackstageViewAccessibility }

function TAPBackstageViewAccessibility.CreateChild(
  const aLinkObject: TObject): IAPBaseAccessibility;
begin
  Result := TAPBackStageViewButtonAccessibility.Create(Self, ALinkObject);
end;

function TAPBackstageViewAccessibility.GetAccessibleName: string;
begin
  Result := 'ApplicationMenu';
end;

function TAPBackstageViewAccessibility.GetAccessibleRoleID: Integer;
begin
  Result := ROLE_SYSTEM_PAGETAB;
end;

function TAPBackstageViewAccessibility.GetChildCount: Integer;
begin
  Result := BackStageView.MenuViewInfo.ItemLinks.Count;
end;

function TAPBackstageViewAccessibility.GetChildLinkObject(
  const aIndex: Integer): TObject;
begin
  Result := nil;
  if ((aIndex >= 0) and (aIndex < GetChildCount)) then
  begin
    result := BackStageView.MenuViewInfo.ItemLinks[aIndex];
  end;
end;

procedure TAPBackstageViewAccessibility.LoadChilds;
begin
  inherited;
  //
end;


function TAPBackstageViewAccessibility.GetBackStageView: TAPBackstageView;
begin
  Result := TAPBackstageView(FLinkObject);
end;

function TAPBackstageViewAccessibility.GetVisible: Boolean;
begin
  Result := BackStageView.Visible;
end;

{ TAPBackStageViewButtonAccessibility }

function TAPBackStageViewButtonAccessibility.GetAccessibleDescription: string;
begin
  BackStageViewButton.Item.Caption;
end;

function TAPBackStageViewButtonAccessibility.GetAccessibleName: string;
begin
  Result := BackStageViewButton.Item.Caption;
end;

function TAPBackStageViewButtonAccessibility.GetAccessibleRoleID: Integer;
begin
  Result := ROLE_SYSTEM_MENUITEM;
end;

function TAPBackStageViewButtonAccessibility.GetBackStageviewButton: TAPBackStageViewButton;
begin
  Result := TAPBackStageViewButton(FLinkObject);
end;

function TAPBackStageViewButtonAccessibility.GetScreenRectangle: TRect;
var
  bsv: TAPBackstageView;
begin

  if FParent.LinkObject is TdxRibbonBackstageView then
  begin
    bsv := TAPBackstageView(FParent.LinkObject);
    Result.TopLeft := bsv.ClientToScreen(BackStageViewButton.ItemRect.TopLeft);
    Result.BottomRight := bsv.ClientToScreen(BackStageViewButton.ItemRect.BottomRight);
  end else
    Result := TRect.Empty;
end;

function TAPBackStageViewButtonAccessibility.GetSelected: Boolean;
begin
  Result := False;
end;

function TAPBackStageViewButtonAccessibility.GetVisible: Boolean;
begin
  Result := BackStageViewButton.Item.VisibleForUser;
end;

end.
