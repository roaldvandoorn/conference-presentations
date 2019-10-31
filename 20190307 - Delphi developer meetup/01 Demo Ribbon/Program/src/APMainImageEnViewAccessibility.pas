unit APMainImageEnViewAccessibility;
// Date             : 2-12-2016
// Developer        : J.P. Bone (Albumprinter)
// Release          : 1.00
// History          : 1.0 - Initial version 2-12-2016
//
// Unit description : Implementation of an IAccessible interface to the
//                    TAPMainImageEnView control to make it's methods,
//                    properties and children accessible for automation testing
// -----------------------------------------------------------------------------

{$I APDefines.inc}

interface

uses
  System.Classes,
  System.Types,
  System.Variants,
  System.SysUtils,
  Vcl.Controls,
  Vcl.StdCtrls,
  Winapi.Windows,
  Winapi.Messages,
  Winapi.ActiveX,
  Winapi.oleacc,
  APObjects,
  APBaseAccessibility,
  imageenview,
  APImageEnView,
  APLog.Log;

type

  TAPMainImageEnViewAccessibility = class(TAPBaseWinControlAccessibility, IAccessible, IAPBaseAccessibility)
  protected
    FMainViewSpread: TObject{TAPMainViewSpread};
    function GetMainView: TAPMainImageEnView;
    function CreateChild(const aLinkObject: TObject): IAPBaseAccessibility; override;
    function GetChildLinkObject(const aIndex: Integer): TObject; override;
    function GetChildCount: Integer; override;
    function GetAccessibleName: string; override;
    function GetAccessibleRoleID: Integer; override;
    function GetHitTest(const aScreenX, aScreenY: Integer; out aChildIndex: Integer): THitTest; override;
  public
    constructor Create(const aParent: TAPBaseAccessibility; const aLinkObject: TObject); override;
    destructor Destroy; override;
    procedure RefreshData; override;
    property MainView: TAPMainImageEnView read GetMainView;
  end;


implementation

uses
  APMainImageEnViewAccessibilityData,
  APMainViewPageItemsAccessibility;

type
  TAPMainViewPageAccessibility = class(TAPBaseAccessibility, IAccessible, IAPBaseAccessibility)
  protected
    function GetMainViewPage: TAPMainViewPage;
    function CreateChild(const aLinkObject: TObject): IAPBaseAccessibility; override;
    function GetChildLinkObject(const aIndex: Integer): TObject; override;
    function GetChildCount: Integer; override;
    function GetAccessibleName: string; override;
    function GetAccessibleDescription: string; override;
    function GetAccessibleValue: string; override;
    function GetScreenRectangle: TRect; override;
    function GetAccessibleRoleID: Integer; override;
    function GetEnabled: Boolean; override;
  public
    property MainViewPage: TAPMainViewPage read GetMainViewPage;
  end;

{ TAPMainViewPageAccessibility }

function TAPMainViewPageAccessibility.GetMainViewPage: TAPMainViewPage;
begin
  Result :=  TAPMainViewPage(FLinkObject);
end;

function TAPMainViewPageAccessibility.CreateChild(const aLinkObject: TObject): IAPBaseAccessibility;
begin
  if aLinkObject = MainViewPage.TextItems then
    Result := TAPMainViewPageTextItemsAccessibility.Create(Self, aLinkObject)
  else
    Result := TAPMainViewPageItemsAccessibility.Create(Self, aLinkObject);

end;

function TAPMainViewPageAccessibility.GetChildLinkObject(const aIndex: Integer): TObject;
begin
  Result := nil;
  if HasLinkObject then
  begin
    case aIndex of
      0: Result := MainViewPage.ImageItems;
      1: Result := MainViewPage.TextItems;
      2: Result := MainViewPage.BorderItems;
    end;
  end;
end;

function TAPMainViewPageAccessibility.GetChildCount: Integer;
begin
  if HasLinkObject then
    Result := 3
  else
    Result := 0;

end;

function TAPMainViewPageAccessibility.GetAccessibleName: string;
begin
  if HasLinkObject then
    Result := MainViewPage.Name
  else
    Result := '';

end;

function TAPMainViewPageAccessibility.GetAccessibleRoleID: Integer;
begin
  Result := ROLE_SYSTEM_PANE;
end;

function TAPMainViewPageAccessibility.GetEnabled: Boolean;
begin
  if HasLinkObject and Assigned(MainViewPage.AlbumPage) then
    Result := not MainViewPage.AlbumPage.Protectd
  else
    Result := False;

end;

function TAPMainViewPageAccessibility.GetAccessibleDescription: string;
begin
  if HasLinkObject and Assigned(MainViewPage.AlbumPage) then
    Result := Format('Page %d',[MainViewPage.AlbumPage.PageNumber])
  else
    Result := '';

end;

function TAPMainViewPageAccessibility.GetAccessibleValue: string;
begin
  if HasLinkObject and Assigned(MainViewPage.AlbumPage) and Assigned(MainViewPage.Background) then
  begin
    Result := MainViewPage.AlbumPage.ID
  end else
    Result := 'Empty';

end;

function TAPMainViewPageAccessibility.GetScreenRectangle: TRect;
var
  parent: TControl;
begin
  if HasLinkObject then
  begin
    Result := MainViewPage.PageRect;
    parent := MainViewPage.MainView;
    if Assigned(parent) then
    begin
      Result.TopLeft := parent.ClientToScreen(Result.TopLeft);
      Result.BottomRight := parent.ClientToScreen(Result.BottomRight);
    end else
      Result := TRect.Empty;

  end else
    Result := TRect.Empty;

end;

{ TAPMainImageEnViewAccessibility }

constructor TAPMainImageEnViewAccessibility.Create(const aParent: TAPBaseAccessibility; const aLinkObject: TObject);
begin
  inherited;
  FMainViewSpread := TAPMainViewSpread.Create(MainView);
end;

destructor TAPMainImageEnViewAccessibility.Destroy;
begin
  FreeAndNil(FMainViewSpread);
  inherited;
end;

procedure TAPMainImageEnViewAccessibility.RefreshData;
begin
  inherited;
  TAPMainViewSpread(FMainViewSpread).RefreshData;
end;

function TAPMainImageEnViewAccessibility.GetAccessibleRoleID: Integer;
begin
  Result := ROLE_SYSTEM_PANE;
end;

function TAPMainImageEnViewAccessibility.GetMainView: TAPMainImageEnView;
begin
  Result := TAPMainImageEnView(FLinkObject);
end;

function TAPMainImageEnViewAccessibility.CreateChild(const aLinkObject: TObject): IAPBaseAccessibility;
begin
  Result := TAPMainViewPageAccessibility.Create(Self, aLinkObject);
end;

function TAPMainImageEnViewAccessibility.GetChildLinkObject(const aIndex: Integer): TObject;
begin
  Result := nil;
  if HasLinkObject then
  begin
    case aIndex of
      0: Result := TAPMainViewSpread(FMainViewSpread).LeftPage;
      1: Result := TAPMainViewSpread(FMainViewSpread).RightPage;
    end;
  end;
end;

function TAPMainImageEnViewAccessibility.GetChildCount: Integer;
begin
  if HasLinkObject then
    Result := 2
  else
    Result := 0;

end;

function TAPMainImageEnViewAccessibility.GetAccessibleName: string;
begin
  Result := 'Spread';
//  if HasLinkObject then
//  begin
//    Result := MainView.Name;
//    if Result.IsEmpty then
//      Result := FLinkObject.ClassName;
//
//  end;
end;

function TAPMainImageEnViewAccessibility.GetHitTest(const aScreenX, aScreenY: Integer; out aChildIndex: Integer): THitTest;
begin
  Result := htChild;  // TODO
  aChildIndex := 0;
end;


end.

