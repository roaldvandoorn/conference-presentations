unit APImageEnViewAccessibility;
// Date             : 2-12-2016
// Developer        : J.P. Bone (Albumprinter)
// Release          : 1.00
// History          : 1.0 - Initial version 2-12-2016
//
// Unit description : Implementation of an IAccessible interface to the
//                    TAPImageEnView control to make it's methods,
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
  APImageEnHelpers,
  APLog.Log;

type
  TAPImageEnViewAccessibility = class(TAPBaseWinControlAccessibility, IAccessible, IAPBaseAccessibility)
  protected
    function GetImageEnView: TImageEnView;
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
    function DoChildDefaultAction(const aIndex: Integer): Boolean; override;
    function GetChildVisible(const aIndex: Integer): Boolean; override;
    function GetChildSelected(const aIndex: Integer): Boolean; override;

  public
    property ImageEnView: TImageEnView read GetImageEnView;
  end;


implementation

{ TAPImageEnViewAccessibility }

function TAPImageEnViewAccessibility.GetAccessibleRoleID: Integer;
begin
  Result := ROLE_SYSTEM_LIST;
end;

function TAPImageEnViewAccessibility.GetImageEnView: TImageEnView;
begin
  Result := TImageEnView(FLinkObject);
end;

function TAPImageEnViewAccessibility.GetChildLinkObject(const aIndex: Integer): TObject;
begin
  Result := nil;
end;

function TAPImageEnViewAccessibility.GetChildCount: Integer;
begin
  if HasLinkObject then
    Result := ImageEnView.LayersCount
  else
    Result := 0;

end;

function TAPImageEnViewAccessibility.GetAccessibleName: string;
begin
  Result := '';
  if HasLinkObject then
  begin
    Result := ImageEnView.Name;
    if Result.IsEmpty then
      Result := FLinkObject.ClassName;

  end;
end;

function TAPImageEnViewAccessibility.GetHitTest(const aScreenX, aScreenY: Integer; out aChildIndex: Integer): THitTest;
begin
  Result := htChild;
  aChildIndex := 0;
end;

function TAPImageEnViewAccessibility.IsSimpleElement: Boolean;
begin
  Result := True;
end;

function TAPImageEnViewAccessibility.GetChildAccessibleName(const aIndex: Integer): string;
begin
  Result := Format('Item_%d', [aIndex]);

end;

function TAPImageEnViewAccessibility.GetChildAccessibleRoleID(const aIndex: Integer): integer;
begin
  Result := ROLE_SYSTEM_GRAPHIC;
//  ROLE_SYSTEM_TEXT
end;

function TAPImageEnViewAccessibility.GetChildScreenRectangle(const aIndex: Integer): TRect;
begin
  if HasLinkObject then
  begin
    Result := ImageEnView.ImageRect[aIndex];
    Result.TopLeft := ImageEnView.ClientToScreen(Result.TopLeft);
    Result.BottomRight := ImageEnView.ClientToScreen(Result.BottomRight);
  end else
    Result := TRect.Empty;

end;

function TAPImageEnViewAccessibility.DoChildDefaultAction(const aIndex: Integer): Boolean;
begin
  Result := False;
end;

function TAPImageEnViewAccessibility.GetChildVisible(const aIndex: Integer): Boolean;
begin
  if HasLinkObject then
    Result := ImageEnView.Layers[aIndex].Visible
  else
    Result := False;

end;

function TAPImageEnViewAccessibility.GetChildSelected(const aIndex: Integer): Boolean;
begin
  if HasLinkObject then
    Result := (ImageEnView.LayersCurrent = aIndex)
  else
    Result := False;

end;


end.

