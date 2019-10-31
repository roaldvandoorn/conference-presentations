unit APMultiViewItemsAccessibility;
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
  TAPMultiViewItemsAccessibility = class(TAPBaseAccessibility, IAccessible, IAPBaseAccessibility)
  protected
    function GetMultiView: TAPMultiView;
//    function GetChildLinkObject(const aIndex: Integer): TObject; override;
    function GetChildCount: Integer; override;
    function GetAccessibleName: string; override;
    function GetAccessibleRoleID: Integer; override;
    function GetHitTest(const aScreenX, aScreenY: Integer; out aChildIndex: Integer): THitTest; override;

    // Simple element
    function IsSimpleElement: Boolean; override;
    function GetChildAccessibleName(const aIndex: Integer): string; override;
    function GetChildAccessibleRoleID(const aIndex: Integer): integer; override;
    function GetChildScreenRectangle(const aIndex: Integer): TRect; override;
    function DoChildDefaultAction(const aIndex: Integer): Boolean; override;
    function GetChildVisible(const aIndex: Integer): Boolean; override;
    function GetChildSelected(const aIndex: Integer): Boolean; override;

  public
    property MultiView: TAPMultiView read GetMultiView;
  end;

  TAPPhotoBrowserItemsAccessibility = class(TAPMultiViewItemsAccessibility, IAccessible, IAPBaseAccessibility)
  protected
    function GetPhotoBrowser: TAPPhotoBrowser;
    function GetChildAccessibleValue(const aIndex: Integer): string; override;
  public
    property PhotoBrowser: TAPPhotoBrowser read GetPhotoBrowser;
  end;

implementation

{ TAPMultiViewItemsAccessibility }

function TAPMultiViewItemsAccessibility.GetAccessibleRoleID: Integer;
begin
  Result := ROLE_SYSTEM_LIST;
end;

function TAPMultiViewItemsAccessibility.GetMultiView: TAPMultiView;
begin
  Result := TAPMultiView(FLinkObject);
end;

//function TAPMultiViewItemsAccessibility.GetChildLinkObject(const aIndex: Integer): TObject;
//begin
//  Result := nil;
//end;

function TAPMultiViewItemsAccessibility.GetChildCount: Integer;
begin
  if HasLinkObject then
    Result := MultiView.ImageCount
  else
    Result := 0;

end;

function TAPMultiViewItemsAccessibility.GetAccessibleName: string;
begin
  Result := '';
  if HasLinkObject then
  begin
    Result := MultiView.Name;
    if Result.IsEmpty then
      Result := FLinkObject.ClassName;

    if not Result.IsEmpty then
      Result := Result + '_Items';

  end;
end;

function TAPMultiViewItemsAccessibility.GetHitTest(const aScreenX, aScreenY: Integer; out aChildIndex: Integer): THitTest;
begin
  Result := htChild;
  aChildIndex := 0;
end;

function TAPMultiViewItemsAccessibility.IsSimpleElement: Boolean;
begin
  Result := True;
end;

function TAPMultiViewItemsAccessibility.GetChildAccessibleName(const aIndex: Integer): string;
begin
  Result := Format('Item_%d', [aIndex]);

end;

function TAPMultiViewItemsAccessibility.GetChildAccessibleRoleID(const aIndex: Integer): integer;
begin
  Result := ROLE_SYSTEM_GRAPHIC;
end;

function TAPMultiViewItemsAccessibility.GetChildScreenRectangle(const aIndex: Integer): TRect;
begin
  if HasLinkObject then
  begin
    Result := MultiView.ImageRect[aIndex];
    Result.TopLeft := MultiView.ClientToScreen(Result.TopLeft);
    Result.BottomRight := MultiView.ClientToScreen(Result.BottomRight);
  end else
    Result := TRect.Empty;

end;

function TAPMultiViewItemsAccessibility.DoChildDefaultAction(const aIndex: Integer): Boolean;
begin
  Result := False;
end;

function TAPMultiViewItemsAccessibility.GetChildVisible(const aIndex: Integer): Boolean;
begin
  if HasLinkObject then
    Result := MultiView.IsVisible(aIndex)
  else
    Result := False;

end;

function TAPMultiViewItemsAccessibility.GetChildSelected(const aIndex: Integer): Boolean;
begin
  if HasLinkObject then
    Result := MultiView.IsSelected(aIndex)
  else
    Result := False;

end;

{ TAPPhotoBrowserItemsAccessibility }

function TAPPhotoBrowserItemsAccessibility.GetChildAccessibleValue(const aIndex: Integer): string;
var
  pageNr: Integer;
begin
  pageNr := PhotoBrowser.UsedOnPage[aIndex];
  if pageNr<>0 then
    Result := Format('OnPage %d', [pageNr])
  else
    Result := 'NotOnPage';
end;

function TAPPhotoBrowserItemsAccessibility.GetPhotoBrowser: TAPPhotoBrowser;
begin
  Result := TAPPhotoBrowser(FLinkObject);
end;

end.











