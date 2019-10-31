unit APMainViewPageItemsAccessibility;
// Date             : 9-12-2016
// Developer        : J.P. Bone (Albumprinter)
// Release          : 1.00
// History          : 1.0 - Initial version 9-12-2016
//
// Unit description : Implementation of an IAccessible interface to make the
//                    page items of the TAPMainImageEnView control accessible
//                    for automation testing
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
  imageenview,
  APImageEnHelpers,
  APObjects,
  APLog.Log;

type
  TAPMainViewPageItemsAccessibility = class(TAPBaseAccessibility, IAccessible, IAPBaseAccessibility)
  protected
    function GetMainView: TImageEnView;
    function GetItemList: Tlist;
    function GetAlbumObject(const aIndex: Integer): TAlbumObject;
    function GetChildLinkObject(const aIndex: Integer): TObject; override;
    function GetChildCount: Integer; override;
    function GetAccessibleName: string; override;
    function GetAccessibleRoleID: Integer; override;
    function GetHitTest(const aScreenX, aScreenY: Integer; out aChildIndex: Integer): THitTest; override;

    // Simple element
    function IsSimpleElement: Boolean; override;
    function GetChildAccessibleName(const aIndex: Integer): string; override;
    function GetChildAccessibleRoleID(const aIndex: Integer): integer; override;
    function GetChildScreenRectangle(const aIndex: Integer): TRect; override;
    function GetChildAccessibleValue(const aIndex: Integer): string; override;
    function DoChildDefaultAction(const aIndex: Integer): Boolean; override;
    function GetChildVisible(const aIndex: Integer): Boolean; override;
    function GetChildSelected(const aIndex: Integer): Boolean; override;

  public
    property MainView: TImageEnView read GetMainView;
    property ItemList: TList read GetItemList;
  end;

  TAPMainViewPageTextItemsAccessibility = class(TAPMainViewPageItemsAccessibility)
  protected
    function GetChildAccessibleName(const aIndex: Integer): string; override;
    function GetChildAccessibleRoleID(const aIndex: Integer): integer; override;
  end;

implementation

uses
  APLabel,
  APMainImageEnViewAccessibilityData,
  iexLayers;

{ TAPMainViewPageItemsAccessibility }

function TAPMainViewPageItemsAccessibility.GetAccessibleRoleID: Integer;
begin
  Result := ROLE_SYSTEM_LIST;
end;

function TAPMainViewPageItemsAccessibility.GetMainView: TImageEnView;
begin
  if HasLinkObject and Assigned(TAPPageItems(FLinkObject).Parent) then
    Result := TAPMainViewPage(TAPPageItems(FLinkObject).Parent).MainView
  else
    Result := nil;

end;

function TAPMainViewPageItemsAccessibility.GetItemList: TList;
begin
  Result := TList(FLinkObject);
end;

function TAPMainViewPageItemsAccessibility.GetAlbumObject(const aIndex: Integer): TAlbumObject;
var
  layer: TIELayer;
begin
  Result := nil;
  if HasLinkObject then
  begin
    layer := TIELayer(ItemList[aIndex]);
    if (Assigned(layer) and (Integer(layer.userdata) > 0)) then
      Result := TAlbumObject(layer.userdata);

  end;
end;

function TAPMainViewPageItemsAccessibility.GetChildLinkObject(const aIndex: Integer): TObject;
begin
  Result := nil;
end;

function TAPMainViewPageItemsAccessibility.GetChildCount: Integer;
begin
  if HasLinkObject then
    Result := ItemList.Count
  else
    Result := 0;

end;

function TAPMainViewPageItemsAccessibility.GetAccessibleName: string;
begin
  Result := '';
  if HasLinkObject then
  begin
    Result := TAPPageItems(ItemList).Name;
//        if Result.IsEmpty then
//      Result := FLinkObject.ClassName;

  end;
end;

function TAPMainViewPageItemsAccessibility.GetHitTest(const aScreenX, aScreenY: Integer; out aChildIndex: Integer): THitTest;
begin
  Result := htChild;
  aChildIndex := 0;
end;

function TAPMainViewPageItemsAccessibility.IsSimpleElement: Boolean;
begin
  Result := True;
end;

function TAPMainViewPageItemsAccessibility.GetChildAccessibleName(const aIndex: Integer): string;
begin
  Result := Format('Image_%d', [aIndex]);
end;

function TAPMainViewPageItemsAccessibility.GetChildAccessibleRoleID(const aIndex: Integer): integer;
begin
  Result := ROLE_SYSTEM_GRAPHIC;
end;

function TAPMainViewPageItemsAccessibility.GetChildScreenRectangle(const aIndex: Integer): TRect;
var
  layer: TIELayer;
begin
  if HasLinkObject then
  begin
    layer := TIELayer(ItemList[aIndex]);
    if Assigned(layer) then
    begin
      Result := layer.ClientAreaBox;
      Result.TopLeft := MainView.ClientToScreen(Result.TopLeft);
      Result.BottomRight := MainView.ClientToScreen(Result.BottomRight);
    end else
      Result := TRect.Empty;

  end else
    Result := TRect.Empty;

end;

function TAPMainViewPageItemsAccessibility.GetChildAccessibleValue(const aIndex: Integer): string;
var
  albumObject: TAlbumObject;
begin
  albumObject := GetAlbumObject(aIndex);
  if Assigned(albumObject) and not albumObject.IsEmpty(True) then
    Result := albumObject.ID
  else
    Result := 'Empty';

end;


function TAPMainViewPageItemsAccessibility.DoChildDefaultAction(const aIndex: Integer): Boolean;
begin
  Result := False;
end;

function TAPMainViewPageItemsAccessibility.GetChildVisible(const aIndex: Integer): Boolean;
var
  layer: TIELayer;
begin
  if HasLinkObject then
  begin
    layer := TIELayer(ItemList[aIndex]);
    if Assigned(layer) then
      Result := layer.Visible
    else
      Result := False;

  end else
    Result := False;

end;

function TAPMainViewPageItemsAccessibility.GetChildSelected(const aIndex: Integer): Boolean;
begin
  try
    if HasLinkObject then
      Result := (MainView.CurrentLayer = TIELayer(ItemList[aIndex]))
    else
      Result := False;
  except
    Result := False;
  end;
end;

{ TAPMainViewPageTextItemsAccessibility }

function TAPMainViewPageTextItemsAccessibility.GetChildAccessibleName(const aIndex: Integer): string;
begin
  Result := Format('Text_%d', [aIndex]);

end;

function TAPMainViewPageTextItemsAccessibility.GetChildAccessibleRoleID(const aIndex: Integer): integer;
begin
  Result := ROLE_SYSTEM_TEXT;
end;

end.

