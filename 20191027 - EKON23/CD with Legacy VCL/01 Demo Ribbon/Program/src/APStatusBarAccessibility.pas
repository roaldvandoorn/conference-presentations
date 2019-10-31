unit APStatusBarAccessibility;
// Date             : 16-09-2016
// Developer        : J.P. Bone (Albumprinter)
// Release          : 1.00
// History          : 1.0 - Initial version 16-09-2016
//
// Unit description : Implementation of an IAccessible interface to the
//                    TAdvOfficeStatusBar control to make it's methods, properties and
//                    children accessible for automation testing
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
  dxStatusBar,
  APLog.Log;

type
  TAPStatusBarAccessibility = class(TAPBaseWinControlExAccessibility, IAccessible, IAPBaseAccessibility)
  protected
    function GetStatusBar: TdxStatusBar;
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

  public
    property StatusBar: TdxStatusBar read GetStatusBar;
  end;


implementation

uses
  Vcl.Forms;

{ TAPStatusBarAccessibility }

function TAPStatusBarAccessibility.GetAccessibleRoleID: Integer;
begin
  Result := ROLE_SYSTEM_STATUSBAR;
end;

function TAPStatusBarAccessibility.GetStatusBar: TdxStatusBar;
begin
  Result := TdxStatusBar(FLinkObject);
end;

function TAPStatusBarAccessibility.GetChildLinkObject(const aIndex: Integer): TObject;
begin
  if HasLinkObject then
    Result := StatusBar.Panels[aIndex]
  else
    Result := nil;

end;

function TAPStatusBarAccessibility.GetChildCount: Integer;
begin
  if HasLinkObject then
    Result := StatusBar.Panels.Count
  else
    Result := 0;
end;

function TAPStatusBarAccessibility.GetAccessibleName: string;
begin
  Result := '';
  if HasLinkObject then
  begin
    Result := StatusBar.Name;
    if Result.IsEmpty then
      Result := FLinkObject.ClassName;

  end;
end;

function TAPStatusBarAccessibility.GetHitTest(const aScreenX, aScreenY: Integer; out aChildIndex: Integer): THitTest;
begin
  Result := htChild;
  aChildIndex := 0;
end;

function TAPStatusBarAccessibility.IsSimpleElement: Boolean;
begin
  Result := True;
end;

function TAPStatusBarAccessibility.GetChildAccessibleName(const aIndex: Integer): string;
begin
  Result := Format('panel_%d', [aIndex]);
end;

function TAPStatusBarAccessibility.GetChildAccessibleRoleID(const aIndex: Integer): integer;
begin
  Result := ROLE_SYSTEM_STATUSBAR;
end;

function TAPStatusBarAccessibility.GetChildAccessibleValue(const aIndex: Integer): string;
var
  panel: TdxStatusBarPanel;
begin
  panel := TdxStatusBarPanel(GetChildLinkObject(aIndex));
  if Assigned(panel) then
    Result := panel.Text
  else
    Result := '';

end;


type
  TProtectedStatusBar = class(TdxStatusBar)
public
  property ViewInfo;
end;

function TAPStatusBarAccessibility.GetChildScreenRectangle(const aIndex: Integer): TRect;
var
  panel: TdxStatusBarPanelViewInfo;
begin
  panel := TProtectedStatusBar(StatusBar).ViewInfo.PanelViewInfo[aIndex];
  if Assigned(panel) then
  begin
//    LogVerbose('GetChildScreenRectangle panel found');
    Result.TopLeft := StatusBar.ClientToScreen(panel.Bounds.TopLeft);
    Result.BottomRight := StatusBar.ClientToScreen(panel.Bounds.BottomRight);
  end else
    Result := TRect.Empty;


//  LogVerbose('GetChildScreenRectangle panel ' + AIndex.ToString + ' : ' + Result.Top.ToString + ',' + Result.Left.ToString + ',' + Result.Height.ToString + ',' + Result.Width.ToString);
end;

function TAPStatusBarAccessibility.GetChildVisible(
  const aIndex: Integer): Boolean;
begin
  Result := StatusBar.Panels.Items[AIndex].Visible;
end;

function TAPStatusBarAccessibility.DoChildDefaultAction(const aIndex: Integer): Boolean;
begin
  Result := False;
end;

end.
