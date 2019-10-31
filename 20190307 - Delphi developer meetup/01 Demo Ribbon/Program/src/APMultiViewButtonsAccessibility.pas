unit APMultiViewButtonsAccessibility;
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
  APLog.Log,
  APMultiViewButtons;

type
  TAPMultiViewBaseButtonAccess = class(TAPMultiViewBaseButton);

  TAPMultiViewButtonsAccessibility = class(TAPBaseAccessibility, IAccessible, IAPBaseAccessibility)
  protected
    function GetMultiView: TAPMultiView;
    function GetMultiViewButton: TAPMultiViewBaseButtonAccess;
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
    function GetChildEnabled(const aIndex: Integer): Boolean; override;

  public
    property MultiView: TAPMultiView read GetMultiView;
    property MultiViewButton: TAPMultiViewBaseButtonAccess read GetMultiViewButton;
  end;

implementation

//uses
//  APMultiViewButtons;



{ TAPMultiViewButtonsAccessibility }

function TAPMultiViewButtonsAccessibility.GetAccessibleRoleID: Integer;
begin
  Result := ROLE_SYSTEM_LIST;
end;

function TAPMultiViewButtonsAccessibility.GetMultiView: TAPMultiView;
begin
  if HasLinkObject and (MultiViewButton.Owner is TAPMultiView) then
    Result := TAPMultiView(MultiViewButton.Owner)

  else
    Result := nil;

end;

function TAPMultiViewButtonsAccessibility.GetMultiViewButton: TAPMultiViewBaseButtonAccess;
begin
  Result := TAPMultiViewBaseButtonAccess(FLinkObject);
end;

//function TAPMultiViewButtonsAccessibility.GetChildLinkObject(const aIndex: Integer): TObject;
//begin
//  Result := nil;
//end;

function TAPMultiViewButtonsAccessibility.GetChildCount: Integer;
begin
  if HasLinkObject then
    Result := MultiView.ImageCount
  else
    Result := 0;

end;

function TAPMultiViewButtonsAccessibility.GetAccessibleName: string;
begin
  Result := '';
  if HasLinkObject then
  begin
    Result := MultiViewButton.Name;
    if Result.IsEmpty then
      Result := FLinkObject.ClassName;

  end;
end;

function TAPMultiViewButtonsAccessibility.GetHitTest(const aScreenX, aScreenY: Integer; out aChildIndex: Integer): THitTest;
begin
  Result := htChild;
  aChildIndex := 0;
end;

function TAPMultiViewButtonsAccessibility.IsSimpleElement: Boolean;
begin
  Result := True;
end;

function TAPMultiViewButtonsAccessibility.GetChildAccessibleName(const aIndex: Integer): string;
begin
  Result := Format('Button_%d', [aIndex]);

end;

function TAPMultiViewButtonsAccessibility.GetChildAccessibleRoleID(const aIndex: Integer): integer;
begin
  Result := ROLE_SYSTEM_PUSHBUTTON;
end;

function TAPMultiViewButtonsAccessibility.GetChildScreenRectangle(const aIndex: Integer): TRect;
begin
  if HasLinkObject then
  begin
    Result := MultiViewButton.GetButtonRect(aIndex, True);
    Result.TopLeft := MultiView.ClientToScreen(Result.TopLeft);
    Result.BottomRight := MultiView.ClientToScreen(Result.BottomRight);
  end else
    Result := TRect.Empty;

end;

function TAPMultiViewButtonsAccessibility.DoChildDefaultAction(const aIndex: Integer): Boolean;
begin
  if HasLinkObject and MultiViewButton.Enabled then
    MultiViewButton.PressButton(aIndex);

  Result := True;
end;

function TAPMultiViewButtonsAccessibility.GetChildVisible(const aIndex: Integer): Boolean;
begin
  if HasLinkObject then
    Result := MultiViewButton.IsButtonVisible(aIndex)
  else
    Result := False;

end;

function TAPMultiViewButtonsAccessibility.GetChildEnabled(const aIndex: Integer): Boolean;
begin
  if HasLinkObject then
    Result := MultiViewButton.IsButtonEnabled(aIndex)
  else
    Result := False;

end;


end.











