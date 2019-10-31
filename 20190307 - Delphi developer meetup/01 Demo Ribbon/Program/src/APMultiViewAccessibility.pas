unit APMultiViewAccessibility;
// Date             : 13-09-2016
// Developer        : J.P. Bone (Albumprinter)
// Release          : 1.00
// History          : 1.0 - Initial version 13-09-2016
//
// Unit description : Implementation of an IAccessible interface to the
//                    TAPMultiView and TAPPhotoBrowser control to make it's methods,
//                    properties and children accessible for automation testing
// -----------------------------------------------------------------------------

{$I APDefines.inc}

interface

uses
  System.Classes,
  System.Types,
  System.Variants,
  System.SysUtils,
  System.Generics.Collections,
  Vcl.Controls,
  Vcl.StdCtrls,
  Winapi.Windows,
  Winapi.Messages,
  Winapi.ActiveX,
  Winapi.oleacc,
  APBaseAccessibility,
  APMultiView,
  APPhotoBrowser,
  APLog.Log;

type
  TAPMultiViewAccessibility = class(TAPBaseWinControlAccessibility, IAccessible, IAPBaseAccessibility)
  protected
    FChildObjects: TList<IAPBaseAccessibility>; // TODO move to baseclass
    function GetMultiView: TAPMultiView;
    function CreateChild(const aLinkObject: TObject): IAPBaseAccessibility; override;
    function GetChild(const aIndex: Integer): IAPBaseAccessibility; override;
    function GetChildCount: Integer; override;
    function GetChildIndex(const aChild: TAPBaseAccessibility): Integer; override;
    function GetAccessibleName: string; override;
    function GetAccessibleRoleID: Integer; override;
    function GetHitTest(const aScreenX, aScreenY: Integer; out aChildIndex: Integer): THitTest; override;
    procedure LoadChilds; override;

//    // Simple element
//    function IsSimpleElement: Boolean; override;
//    function GetChildAccessibleName(const aIndex: Integer): string; override;
//    function GetChildAccessibleRoleID(const aIndex: Integer): integer; override;
//    function GetChildScreenRectangle(const aIndex: Integer): TRect; override;
//    function DoChildDefaultAction(const aIndex: Integer): Boolean; override;
//    function GetChildVisible(const aIndex: Integer): Boolean; override;
//    function GetChildSelected(const aIndex: Integer): Boolean; override;

  public
    destructor Destroy; override;
    property MultiView: TAPMultiView read GetMultiView;
  end;

  TAPPhotoBrowserAccessibility = class(TAPMultiViewAccessibility, IAccessible, IAPBaseAccessibility)
  protected
    function GetPhotoBrowser: TAPPhotoBrowser;
    function CreateChild(const aLinkObject: TObject): IAPBaseAccessibility; override;
//    function GetChildAccessibleValue(const aIndex: Integer): string; override;
  public
    property PhotoBrowser: TAPPhotoBrowser read GetPhotoBrowser;
  end;

implementation

uses
  APMultiViewItemsAccessibility,
  APMultiViewButtonsAccessibility,
  APMultiViewButtons;


{ TAPMultiViewAccessibility }


destructor TAPMultiViewAccessibility.Destroy;
begin
  FreeAndNil(FChildObjects);
  inherited Destroy;
end;

function TAPMultiViewAccessibility.GetAccessibleRoleID: Integer;
begin
  Result := ROLE_SYSTEM_PANE;
end;

function TAPMultiViewAccessibility.GetMultiView: TAPMultiView;
begin
  Result := TAPMultiView(FLinkObject);
end;

function TAPMultiViewAccessibility.CreateChild(const aLinkObject: TObject): IAPBaseAccessibility;
begin
  if aLinkObject is TAPMultiView then
    Result := TAPMultiViewItemsAccessibility.Create(Self, aLinkObject)

  else if aLinkObject is TAPMultiViewBaseButton then
    Result := TAPMultiViewButtonsAccessibility.Create(Self, aLinkObject)

  else
    Result := nil;

end;

function TAPMultiViewAccessibility.GetChild(const aIndex: Integer): IAPBaseAccessibility;
begin
  Result := FChildObjects[aIndex];
end;

function TAPMultiViewAccessibility.GetChildCount: Integer;
begin
  if HasLinkObject then
//    Result := MultiView.ImageCount
    Result := FChildObjects.Count
  else
    Result := 0;

end;

function TAPMultiViewAccessibility.GetChildIndex(const aChild: TAPBaseAccessibility): Integer;
begin
  for Result := 0 to GetChildCount - 1 do
  begin
    if (Pointer(GetChild(Result)) = Pointer(aChild)) then
      Exit;

  end;
  Result := -1;
end;


function TAPMultiViewAccessibility.GetAccessibleName: string;
begin
  Result := '';
  if HasLinkObject then
  begin
    Result := MultiView.Name;
    if Result.IsEmpty then
      Result := FLinkObject.ClassName;

  end;
end;

function TAPMultiViewAccessibility.GetHitTest(const aScreenX, aScreenY: Integer; out aChildIndex: Integer): THitTest;
begin
  Result := htChild;
  aChildIndex := 0;
end;

procedure TAPMultiViewAccessibility.LoadChilds;
begin
  inherited;
  if not Assigned(FChildObjects) then
    FChildObjects := TList<IAPBaseAccessibility>.Create;

  FChildObjects.Clear;
  FChildObjects.Add(CreateChild(MultiView));

  if Assigned(MultiView.DeleteButton) then
    FChildObjects.Add(CreateChild(MultiView.DeleteButton));

  if Assigned(MultiView.InsertButton) then
    FChildObjects.Add(CreateChild(MultiView.InsertButton));

  if Assigned(MultiView.MenuButton) then
    FChildObjects.Add(CreateChild(MultiView.MenuButton));

  if Assigned(MultiView.ViewButton) then
    FChildObjects.Add(CreateChild(MultiView.ViewButton));

end;

//function TAPMultiViewAccessibility.IsSimpleElement: Boolean;
//begin
//  Result := True;
//end;
//
//function TAPMultiViewAccessibility.GetChildAccessibleName(const aIndex: Integer): string;
//begin
//  Result := Format('Item_%d', [aIndex]);
//
//end;
//
//function TAPMultiViewAccessibility.GetChildAccessibleRoleID(const aIndex: Integer): integer;
//begin
//  Result := ROLE_SYSTEM_GRAPHIC;
//end;
//
//function TAPMultiViewAccessibility.GetChildScreenRectangle(const aIndex: Integer): TRect;
//begin
//  if HasLinkObject then
//  begin
//    Result := MultiView.ImageRect[aIndex];
//    Result.TopLeft := MultiView.ClientToScreen(Result.TopLeft);
//    Result.BottomRight := MultiView.ClientToScreen(Result.BottomRight);
//  end else
//    Result := TRect.Empty;
//
//end;
//
//function TAPMultiViewAccessibility.DoChildDefaultAction(const aIndex: Integer): Boolean;
//begin
//  Result := False;
//end;
//
//function TAPMultiViewAccessibility.GetChildVisible(const aIndex: Integer): Boolean;
//begin
//  if HasLinkObject then
//    Result := MultiView.IsVisible(aIndex)
//  else
//    Result := False;
//
//end;
//
//function TAPMultiViewAccessibility.GetChildSelected(const aIndex: Integer): Boolean;
//begin
//  if HasLinkObject then
//    Result := MultiView.IsSelected(aIndex)
//  else
//    Result := False;
//
//end;
//
//{ TAPPhotoBrowserAccessibility }
//
//function TAPPhotoBrowserAccessibility.GetChildAccessibleValue(const aIndex: Integer): string;
//var
//  pageNr: Integer;
//begin
//  pageNr := PhotoBrowser.UsedOnPage[aIndex];
//  if pageNr<>0 then
//    Result := Format('OnPage %d', [pageNr])
//  else
//    Result := 'NotOnPage';
//end;

function TAPPhotoBrowserAccessibility.GetPhotoBrowser: TAPPhotoBrowser;
begin
  Result := TAPPhotoBrowser(FLinkObject);
end;

function TAPPhotoBrowserAccessibility.CreateChild(const aLinkObject: TObject): IAPBaseAccessibility;
begin
  if aLinkObject is TAPPhotoBrowser then
    Result := TAPPhotoBrowserItemsAccessibility.Create(Self, aLinkObject)

  else
    Result := inherited CreateChild(aLinkObject);

end;


end.


