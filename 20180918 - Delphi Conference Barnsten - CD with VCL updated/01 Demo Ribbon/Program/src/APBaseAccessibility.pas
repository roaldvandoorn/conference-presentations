unit APBaseAccessibility;
// Date             : 14-08-2016
// Developer        : J.P. Bone (Albumprinter)
// Release          : 1.00
// History          : 1.0 - Initial version 14-08-2016
//
// Unit description : Base class to implement an IAccessible interface to user interface
//                    controls to make it's methods, properties and children accessible
//                    for automation testing
// -----------------------------------------------------------------------------



interface

uses
  System.Types,
  System.Variants,
  System.Classes,
  System.Generics.Collections,
  Winapi.Windows,
  Winapi.ActiveX,
  Winapi.oleacc,
  Winapi.Messages,
  Vcl.Controls;

const
  ObjectSelfID = 0;


type
  TChildID = Integer;
  THitTest = (htNone, htSelf, htChild);

  TAPBaseAccessibility = class;

  IAPBaseAccessibility = interface(IAccessible)
    ['{103F3FC2-0C86-4357-833A-A1C66D45D254}']
    function GetChild(const aIndex: Integer): IAPBaseAccessibility;
    function GetChildCount: Integer;
    function GetChildIndex(const aChild: TAPBaseAccessibility): Integer;
    function GetAccessibleName: string;
//    function GetAccessibleDescription: string;
//    function GetAccessibleRoleID: integer;
//    function GetAccessibleState: integer;
//    function GetScreenRectangle: TRect;
//    function GetHitTest(const aScreenX, aScreenY: Integer; out aChildIndex: Integer): THitTest;
//    function DoDefaultAction: Boolean;
//    function IsSimpleElement: Boolean;
    function GetIntf: IAPBaseAccessibility;
    function GetLinkObject: TObject;
    procedure ClearLinkObject;
    procedure RefreshData;
  end;

  TAPBaseAccessibilityClass = class of TAPBaseAccessibility;

  TAPBaseAccessibility = class(TInterfacedObject, IInterface, IDispatch, IAccessible, IAPBaseAccessibility)
  protected
    // IInterface
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;
    // IDispatch
    function GetIDsOfNames(const IID: TGUID; Names: Pointer;
      NameCount, LocaleID: Integer; DispIDs: Pointer): HResult; stdcall;
    function GetTypeInfo(Index, LocaleID: Integer; out TypeInfo): HResult; stdcall;
    function GetTypeInfoCount(out Count: Integer): HResult; stdcall;
    function Invoke(DispID: Integer; const IID: TGUID; LocaleID: Integer;
      Flags: Word; var Params; VarResult, ExcepInfo, ArgErr: Pointer): HResult; stdcall;
    // IAccessible
    function Get_accParent(out ppdispParent: IDispatch): HResult; stdcall;
    function Get_accChildCount(out pcountChildren: Integer): HResult; stdcall;
    function Get_accChild(varChild: OleVariant; out ppdispChild: IDispatch): HResult; stdcall;
    function Get_accName(varChild: OleVariant; out pszName: WideString): HResult; stdcall;
    function Get_accValue(varChild: OleVariant; out pszValue: WideString): HResult; stdcall;
    function Get_accDescription(varChild: OleVariant; out pszDescription: WideString): HResult; stdcall;
    function Get_accRole(varChild: OleVariant; out pvarRole: OleVariant): HResult; stdcall;
    function Get_accState(varChild: OleVariant; out pvarState: OleVariant): HResult; stdcall;
    function Get_accHelp(varChild: OleVariant; out pszHelp: WideString): HResult; stdcall;
    function Get_accHelpTopic(out pszHelpFile: WideString; varChild: OleVariant;
                              out pidTopic: Integer): HResult; stdcall;
    function Get_accKeyboardShortcut(varChild: OleVariant; out pszKeyboardShortcut: WideString): HResult; stdcall;
    function Get_accFocus(out pvarChild: OleVariant): HResult; stdcall;
    function Get_accSelection(out pvarChildren: OleVariant): HResult; stdcall;
    function Get_accDefaultAction(varChild: OleVariant; out pszDefaultAction: WideString): HResult; stdcall;
    function accSelect(flagsSelect: Integer; varChild: OleVariant): HResult; stdcall;
    function accLocation(out pxLeft: Integer; out pyTop: Integer; out pcxWidth: Integer;
                         out pcyHeight: Integer; varChild: OleVariant): HResult; stdcall;
    function accNavigate(navDir: Integer; varStart: OleVariant; out pvarEndUpAt: OleVariant): HResult; stdcall;
    function accHitTest(xLeft: Integer; yTop: Integer; out pvarChild: OleVariant): HResult; stdcall;
    function accDoDefaultAction(varChild: OleVariant): HResult; stdcall;
    function Set_accName(varChild: OleVariant; const pszName: WideString): HResult; stdcall;
    function Set_accValue(varChild: OleVariant; const pszValue: WideString): HResult; stdcall;
    // IAPBaseAccessibility
    function GetChild(const aIndex: Integer): IAPBaseAccessibility; virtual;
    function GetChildCount: Integer; virtual;
    function GetChildIndex(const aChild: TAPBaseAccessibility): Integer; virtual;
    function GetAccessibleName: string; virtual;
    function GetAccessibleDescription: string; virtual;
    function GetAccessibleRoleID: integer; virtual;
    function GetAccessibleState: integer; virtual;
    function GetAccessibleDefaultAction: string; virtual;
    function GetAccessibleValue: string; virtual;
    function GetScreenRectangle: TRect; virtual;
    function GetHitTest(const aScreenX, aScreenY: Integer; out aChildIndex: Integer): THitTest; virtual;
    function DoDefaultAction: Boolean; virtual;
    function DoMouseClickAction: Boolean; virtual;

    function IsSimpleElement: Boolean; virtual;
    function GetIntf: IAPBaseAccessibility;
    function GetLinkObject: TObject;
    procedure ClearLinkObject;
    procedure RefreshData; virtual;
    // Simple element
    function GetChildAccessibleName(const aIndex: Integer): string; virtual;
    function GetChildAccessibleDescription(const aIndex: Integer): string; virtual;
    function GetChildAccessibleRoleID(const aIndex: Integer): integer; virtual;
    function GetChildAccessibleState(const aIndex: Integer): integer; virtual;
    function GetChildAccessibleDefaultAction: string; virtual;
    function GetChildAccessibleValue(const aIndex: Integer): string; virtual;
    function GetChildScreenRectangle(const aIndex: Integer): TRect; virtual;
    function DoChildDefaultAction(const aIndex: Integer): Boolean; virtual;
    function DoChildMouseClickAction(const aIndex: Integer): Boolean; virtual;
    function GetChildVisible(const aIndex: Integer): Boolean; virtual;
    function GetChildSelected(const aIndex: Integer): Boolean; virtual;
    function GetChildChecked(const aIndex: Integer): Boolean; virtual;
    function GetChildEnabled(const aIndex: Integer): Boolean; virtual;

  strict private
    class var
      FAccessibilityObjects: TObjectList<TAPBaseAccessibility>;
      FListDestroying: Boolean;
  protected
    FParent: TAPBaseAccessibility;
    FLinkObject: TObject;
//    FChildObjects: TList<IAPBaseAccessibility>;
    function GetAccessibilityObjectByLinkObject(const aLinkObject: TObject): IAPBaseAccessibility;
    function GetOwnerObjectWindow: HWND; virtual;
    function CheckReturnString(const aString: WideString): HResult;
    function GetVisible: Boolean; virtual;
    function GetSelected: Boolean; virtual;
    function GetChecked: Boolean; virtual;
    function GetEnabled: Boolean; virtual;

    function GetParent: IAPBaseAccessibility; virtual;

    function HasLinkObject: Boolean;
    function CreateChild(const aLinkObject: TObject): IAPBaseAccessibility; virtual;
    function GetChildLinkObject(const aIndex: Integer): TObject; virtual;
    procedure LoadChilds; virtual;
//---------------------------------------
  public
    constructor Create(const aParent: TAPBaseAccessibility; const aLinkObject: TObject); virtual;
    destructor Destroy; override;
    class constructor Create;
    class destructor Destroy;
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;

    property LinkObject: TObject read FLinkObject;
    property Parent: TAPBaseAccessibility read FParent;
    property Intf: IAPBaseAccessibility read GetIntf;
  end;

  TAPBaseWinControlAccessibility = class(TAPBaseAccessibility, IAccessible, IAPBaseAccessibility)
  protected
    function GetWinControl: TWinControl;
    function GetAccessibleName: string; override;
    function GetScreenRectangle: TRect; override;
    function GetOwnerObjectWindow: HWND; override;
    function GetVisible: Boolean; override;
  public
    constructor Create(const aParent: TAPBaseAccessibility; const aLinkObject: TObject); override;
    property WinControl: TWinControl read GetWinControl;
  end;

  TAPBaseWinControlExAccessibility = class(TAPBaseWinControlAccessibility, IAccessible, IAPBaseAccessibility)
  private
    FOrgWndProc: TWndMethod;
  protected
    procedure WndProc(var Message: TMessage);
    procedure WMGetObject(var Message: TMessage);
    procedure WMDestroyLink(var Message: TMessage);
  public
    constructor Create(const aParent: TAPBaseAccessibility; const aLinkObject: TObject); override;
    destructor Destroy; override;
  end;


function GetWindowRectFromHandle(aHandle: THandle): TRect;
function GetHandleText(const aHandle: HWND): string;
function GetWindowClassName(Window: HWND): string;

implementation

uses
  Menus, SysUtils;

function GetWindowRectFromHandle(aHandle: THandle): TRect;
begin
  if (aHandle = 0) or not GetWindowRect(aHandle, Result) then
    Result := TRect.Empty;

end;

function GetHandleText(const aHandle: HWND): string;
var
  buffer: array[0..255] of Char;
begin
  SetString(Result, buffer, Winapi.Windows.GetWindowText(aHandle, buffer, Length(buffer)));
end;

function GetWindowClassName(Window: HWND): string;
var
  sClassName: array[0..256] of Char;
begin
  SetString(Result, sClassName, Winapi.Windows.GetClassName(Window, sClassName, Length(sClassName)));
end;


{ TAPBaseAccessibility }

constructor TAPBaseAccessibility.Create(const aParent: TAPBaseAccessibility; const aLinkObject: TObject);
begin
  inherited Create;
  FParent := aParent;
  FLinkObject := aLinkObject;
//  FChildObjects := TList<IAPBaseAccessibility>.Create;
  LoadChilds;
end;

destructor TAPBaseAccessibility.Destroy;
begin
//  FreeAndNil(FChildObjects);
  inherited Destroy;
end;

class constructor TAPBaseAccessibility.Create;
begin
  FAccessibilityObjects := TObjectList<TAPBaseAccessibility>.Create;
  FListDestroying := False;
end;

class destructor TAPBaseAccessibility.Destroy;
begin
  FListDestroying := True;

  try
    FreeAndNil(FAccessibilityObjects);
  except
    //Rare in error reports, but sometimes an AV is raised in
    //TAPBaseWinControlExAccessibity.Destroy
    //See also WE-3010.
    //This is NOT a solution, but since the program is closing anyway,
    //it doesn't matter anymore. So for now we can just catch and ignore all
    //exceptions raised in this destructor.
  end;
end;

procedure TAPBaseAccessibility.AfterConstruction;
begin
  inherited;
  FAccessibilityObjects.Add(Self);
end;

procedure TAPBaseAccessibility.BeforeDestruction;
begin
  if not FListDestroying then
    FAccessibilityObjects.Remove(Self);

  inherited;
end;


function TAPBaseAccessibility.CreateChild(const aLinkObject: TObject): IAPBaseAccessibility;
begin
  Result := nil;
end;

function TAPBaseAccessibility.GetAccessibleName: string;
begin
  if HasLinkObject then
  begin
    if FLinkObject.InheritsFrom(TComponent) then
      Result := TComponent(FLinkObject).Name;

    if Result.IsEmpty then
      Result := FLinkObject.ClassName;

  end
  else
    Result := '';

end;

function TAPBaseAccessibility.GetAccessibleDefaultAction: string;
begin
  Result := '';
end;

function TAPBaseAccessibility.GetAccessibleDescription: string;
begin
  Result := '';
end;

function TAPBaseAccessibility.GetAccessibleRoleID: integer;
begin
  Result := 0;
end;

function TAPBaseAccessibility.GetAccessibleState: integer;
begin
  Result := STATE_SYSTEM_NORMAL;

  if not GetVisible then
    Result := Result or STATE_SYSTEM_INVISIBLE;

  if GetSelected then
    Result := Result or STATE_SYSTEM_SELECTED;

  if GetChecked then
    Result := Result or STATE_SYSTEM_CHECKED;

  if not GetEnabled then
    Result := Result or STATE_SYSTEM_UNAVAILABLE;

end;

function TAPBaseAccessibility.GetAccessibleValue: string;
begin
  Result := '';
end;

function TAPBaseAccessibility.DoChildDefaultAction(const aIndex: Integer): Boolean;
begin
  Result := False;
end;

function TAPBaseAccessibility.DoChildMouseClickAction(const aIndex: Integer): Boolean;
var
  rect: TRect;
  point: TPoint;
begin
  rect := GetChildScreenRectangle(aIndex);
  if not rect.IsEmpty then
  begin
    point := rect.CenterPoint;
    SetCursorPos(point.X, point.Y);               // set cursor to center of control
    mouse_event(MOUSEEVENTF_LEFTDOWN,0, 0, 0, 0); // press left button
    mouse_event(MOUSEEVENTF_LEFTUP,0, 0, 0, 0);   // release left button
    Result := True;
  end else
    Result := False;

end;

function TAPBaseAccessibility.DoDefaultAction: Boolean;
begin
  Result := False;
end;

function TAPBaseAccessibility.DoMouseClickAction: Boolean;
var
  rect: TRect;
  point: TPoint;
begin
  rect := GetScreenRectangle;
  if not rect.IsEmpty then
  begin
    point := rect.CenterPoint;
    SetCursorPos(point.X, point.Y);               // set cursor to center of control
    mouse_event(MOUSEEVENTF_LEFTDOWN,0, 0, 0, 0); // press left button
    mouse_event(MOUSEEVENTF_LEFTUP,0, 0, 0, 0);   // release left button
    Result := True;
  end else
    Result := False;

end;

function TAPBaseAccessibility.GetChild(const aIndex: Integer): IAPBaseAccessibility;
var
  linkObject: TObject;
begin
  linkObject := GetChildLinkObject(aIndex);
  Result := GetAccessibilityObjectByLinkObject(linkObject);
end;

function TAPBaseAccessibility.GetChildAccessibleDefaultAction: string;
begin
  Result := '';
end;

function TAPBaseAccessibility.GetChildAccessibleDescription(const aIndex: Integer): string;
begin
  Result := '';
end;

function TAPBaseAccessibility.GetChildAccessibleName(const aIndex: Integer): string;
begin
  Result := '';
end;

function TAPBaseAccessibility.GetChildAccessibleRoleID(const aIndex: Integer): integer;
begin
  Result := 0;
end;

function TAPBaseAccessibility.GetChildAccessibleState(const aIndex: Integer): integer;
begin
  Result := STATE_SYSTEM_NORMAL;

  if not GetChildVisible(aIndex) then
    Result := Result or STATE_SYSTEM_INVISIBLE;

  if GetChildSelected(aIndex) then
    Result := Result or STATE_SYSTEM_SELECTED;

  if GetChildChecked(aIndex) then
    Result := Result or STATE_SYSTEM_CHECKED;

  if not GetChildEnabled(aIndex) then
    Result := Result or STATE_SYSTEM_UNAVAILABLE;

end;

function TAPBaseAccessibility.GetChildAccessibleValue(const aIndex: Integer): string;
begin
  Result := '';
end;

function TAPBaseAccessibility.GetChildVisible(const aIndex: Integer): Boolean;
begin
  Result := GetVisible;
end;

function TAPBaseAccessibility.GetChildSelected(const aIndex: Integer): Boolean;
begin
  Result := False;
end;

function TAPBaseAccessibility.GetChildChecked(const aIndex: Integer): Boolean;
begin
  Result := False;
end;

function TAPBaseAccessibility.GetChildEnabled(const aIndex: Integer): Boolean;
begin
  Result := True;;
end;

function TAPBaseAccessibility.GetChildCount: Integer;
begin
  Result := 0;
end;

function TAPBaseAccessibility.GetChildIndex(const aChild: TAPBaseAccessibility): Integer;
var
  linkObject: TObject;
begin
  if aChild.HasLinkObject then
  begin
    for Result := 0 to GetChildCount - 1 do
    begin
      linkObject := GetChildLinkObject(Result);
      if Assigned(linkObject) and (linkObject = aChild.FLinkObject) then
        Exit;

    end;
  end;
  Result := -1;
end;

function TAPBaseAccessibility.GetParent: IAPBaseAccessibility;
begin
  Result := FParent;
end;

function TAPBaseAccessibility.GetScreenRectangle: TRect;
begin
  if Assigned(FParent) then
    Result := FParent.GetScreenRectangle
  else
    Result := Rect(0, 0, 0, 0);

end;

function TAPBaseAccessibility.GetHitTest(const aScreenX, aScreenY: Integer; out aChildIndex: Integer): THitTest;
begin
  Result := htNone;
end;

function TAPBaseAccessibility.HasLinkObject: Boolean;
begin
  Result := Assigned(FLinkObject);
end;

// IInterface
function TAPBaseAccessibility._AddRef: Integer; stdcall;
begin
  Result := -1; //disable reference counting
end;

function TAPBaseAccessibility._Release: Integer; stdcall;
begin
  Result := -1; //disable reference counting
end;

// IDispatch
function TAPBaseAccessibility.GetIDsOfNames(const IID: TGUID; Names: Pointer;
  NameCount, LocaleID: Integer; DispIDs: Pointer): HResult;
begin
  Result := E_NOTIMPL;
end;

function TAPBaseAccessibility.GetTypeInfo(Index, LocaleID: Integer;
  out TypeInfo): HResult;
begin
  Result := E_NOTIMPL;
end;

function TAPBaseAccessibility.GetTypeInfoCount(out Count: Integer): HResult;
begin
  Result := E_NOTIMPL;
end;

function TAPBaseAccessibility.Invoke(DispID: Integer; const IID: TGUID;
  LocaleID: Integer; Flags: Word; var Params;
  VarResult, ExcepInfo, ArgErr: Pointer): HResult;
begin
  Result := E_NOTIMPL;
end;

function TAPBaseAccessibility.GetChildLinkObject(const aIndex: Integer): TObject;
begin
  Result := nil;
end;

function TAPBaseAccessibility.GetChildScreenRectangle(const aIndex: Integer): TRect;
begin
  Result := GetScreenRectangle;
end;

procedure TAPBaseAccessibility.LoadChilds;
begin
// do nothing
end;

// IAccessible
function TAPBaseAccessibility.accDoDefaultAction(varChild: OleVariant): HResult;
var
  actionResult: Boolean;
begin
  actionResult := False;

  if (VarType(varchild) = VT_I4) and (varChild <= GetChildCount) then
  begin
    if varChild = CHILDID_SELF then
      actionResult := DoDefaultAction

    else if IsSimpleElement then
      actionResult := DoChildDefaultAction(varChild - 1);

    if actionResult then
      Result := S_OK
    else
      Result := DISP_E_MEMBERNOTFOUND;

  end else
    Result := E_INVALIDARG;

end;

function TAPBaseAccessibility.accHitTest(xLeft: Integer; yTop: Integer; out pvarChild: OleVariant): HResult;
// returns the IAccessible object at the given point, if applicable.
var
  childIndex: Integer;
begin
  VariantInit(pvarChild);
  if HasLinkObject then
  begin
    if PtInRect(GetScreenRectangle, Point(xLeft, yTop)) then
    begin
      case GetHitTest(xLeft, yTop, childIndex) of
        htSelf:
          begin
            TVarData(pvarChild).VType := VT_I4;
            pvarChild := CHILDID_SELF;
          end;
        htChild:
          begin
            if IsSimpleElement then
            begin
              TVarData(pvarChild).VType := VT_I4;
              pvarChild := childIndex + 1;
            end else
            begin
              TVarData(pvarChild).VType := VT_DISPATCH;
              pvarChild := GetChild(childIndex).GetIntf;
            end;
          end;
      end;
    end;
    if TVarData(pvarChild).VType <> VT_EMPTY then
      Result := S_OK
    else
      Result := S_FALSE;

  end
  else
    Result := DISP_E_MEMBERNOTFOUND;

end;

function TAPBaseAccessibility.accLocation(out pxLeft: Integer; out pyTop: Integer;
  out pcxWidth: Integer; out pcyHeight: Integer; varChild: OleVariant): HResult;
var
  rect: TRect;
begin
  rect := TRect.Empty;
  if HasLinkObject then
  begin
    if varChild = CHILDID_SELF then
      rect := GetScreenRectangle

    else
    if IsSimpleElement and (VarType(varchild) = VT_I4) and (varChild <= GetChildCount) then
      rect := GetChildScreenRectangle(varChild - 1);

  end;

  pxLeft := rect.Left;
  pyTop := rect.Top;
  pcxWidth := rect.Width;
  pcyHeight := rect.Height;

  if rect.IsEmpty then
    Result := S_FALSE
  else
    Result := S_OK;

end;

function TAPBaseAccessibility.accNavigate(navDir: Integer; varStart: OleVariant;
  out pvarEndUpAt: OleVariant): HResult;
begin
  Result := DISP_E_MEMBERNOTFOUND;
end;

function TAPBaseAccessibility.accSelect(flagsSelect: Integer; varChild: OleVariant): HResult;
begin
  Result := DISP_E_MEMBERNOTFOUND;  // Focus
end;

function TAPBaseAccessibility.Get_accChild(varChild: OleVariant;
  out ppdispChild: IDispatch): HResult;
var
  retIntf: IAPBaseAccessibility;
  intfName: string;
  index: Integer;
  objName: string;
begin
  Result := E_INVALIDARG;
  retIntf := nil;
  if (VarType(varchild) = VT_I4) and (varChild <= GetChildCount) then
  begin
    if varChild = CHILDID_SELF then
      retIntf := GetIntf

    else
    if not IsSimpleElement then
      retIntf := GetChild(varChild - 1).GetIntf;

  end;
  if Assigned(retIntf) then
  begin
    objName := retIntf.GetAccessibleName;
    ppdispChild := retIntf;
    Result := S_OK;
  end else
    objName := '';

  if Supports(ppdispChild, IAccessible) then
    intfName := 'IAccessible'
  else
    intfName := 'None';

  index := varChild;
  //LogVerbose(Format('%s.Get_accChild: name=%s, interface=%s, varChild=%d, Result=%4x', [Self.ClassName, objName, intfName, index, Result]));

end;

function TAPBaseAccessibility.Get_accChildCount(out pcountChildren: Integer): HResult;
begin
  pcountChildren := GetChildCount;
  Result := S_OK;
  //LogVerbose(Format('%s.Get_accChildCount: name=%s, childCount=%d, Result=%4x', [Self.ClassName, GetAccessibleName, pcountChildren, Result]));
end;

function TAPBaseAccessibility.Get_accDefaultAction(varChild: OleVariant;
  out pszDefaultAction: WideString): HResult;
begin
  Result := DISP_E_MEMBERNOTFOUND;
end;

function TAPBaseAccessibility.Get_accDescription(varChild: OleVariant; out pszDescription: WideString): HResult;
begin
  Result := E_INVALIDARG;

  if (VarType(varchild) = VT_I4) and (varChild <= GetChildCount) then
  begin
    if varChild = CHILDID_SELF then
    begin
      pszDescription := GetAccessibleDescription;
      Result := CheckReturnString(pszDescription);
    end else
    if IsSimpleElement then
    begin
      pszDescription := GetChildAccessibleDescription(varChild - 1);
      Result := CheckReturnString(pszDescription);
    end;
  end;
end;

function TAPBaseAccessibility.Get_accFocus(out pvarChild: OleVariant): HResult;
begin
  Result := DISP_E_MEMBERNOTFOUND;
end;

function TAPBaseAccessibility.Get_accHelp(varChild: OleVariant; out pszHelp: WideString): HResult;
begin
  Result := DISP_E_MEMBERNOTFOUND;
end;

function TAPBaseAccessibility.Get_accHelpTopic(out pszHelpFile: WideString;
  varChild: OleVariant; out pidTopic: Integer): HResult;
begin
  Result := DISP_E_MEMBERNOTFOUND;
end;

function TAPBaseAccessibility.Get_accKeyboardShortcut(varChild: OleVariant;
  out pszKeyboardShortcut: WideString): HResult;
begin
  Result := DISP_E_MEMBERNOTFOUND;
end;

function TAPBaseAccessibility.Get_accName(varChild: OleVariant; out pszName: WideString): HResult;
var
  index: Integer;
begin
  Result := E_INVALIDARG;

  if (VarType(varchild) = VT_I4) and (varChild <= GetChildCount) then
  begin
    if varChild = CHILDID_SELF then
    begin
      pszName := GetAccessibleName;
      Result := CheckReturnString(pszName);
    end else
    if IsSimpleElement then
    begin
      pszName := GetChildAccessibleName(varChild - 1);
      Result := CheckReturnString(pszName);
    end;
  end;

  index := varChild;
  //LogVerbose(Format('%s.Get_accName: pszName="%s", varChild=%d, Result=%4x', [Self.ClassName, pszName, index, Result]));
end;

function TAPBaseAccessibility.Get_accParent(out ppdispParent: IDispatch): HResult;
begin
  Result := S_FALSE;
  ppdispParent := nil;
end;

function TAPBaseAccessibility.Get_accRole(varChild: OleVariant; out pvarRole: OleVariant): HResult;
var
  roleID: Integer;
  index: Integer;
  name: string;
begin
  Result := E_INVALIDARG;
  roleID := 0;
  name := '';
  if (VarType(varchild) = VT_I4) and (varChild <= GetChildCount) then
  begin
    if varChild = CHILDID_SELF then
    begin
      roleID := GetAccessibleRoleID;
      name := GetAccessibleName;
    end else
    if IsSimpleElement then
    begin
      roleID := GetChildAccessibleRoleID(varChild - 1);
      name := GetChildAccessibleName(varChild - 1);
    end;
  end;

  if roleID <> 0 then
  begin
    VariantInit(pvarRole);
    TVarData(pvarRole).VType := VT_I4;
    TVarData(pvarRole).VInteger := roleID;
    Result := S_OK;
  end;

  index := varChild;
  //LogVerbose(Format('%s.Get_accRole: name="%s", varChild=%d, role=%d, Result=%4x', [Self.ClassName, name, index, roleID, Result]));
end;

function TAPBaseAccessibility.Get_accSelection(out pvarChildren: OleVariant): HResult;
begin
  Result := DISP_E_MEMBERNOTFOUND;
end;

function TAPBaseAccessibility.Get_accState(varChild: OleVariant; out pvarState: OleVariant): HResult;
var
  state: Integer;
  name: string;
begin
  Result := E_INVALIDARG;
  VariantInit(pvarState);

  state := -1;
  name := '';
  if (VarType(varchild) = VT_I4) and (varChild <= GetChildCount) then
  begin
    if varChild = CHILDID_SELF then
    begin
      name := GetAccessibleName;
      state := GetAccessibleState;
    end else
    if IsSimpleElement then
    begin
      state := GetChildAccessibleState(varChild - 1);
      name := GetChildAccessibleName(varChild - 1);
    end;
  end;

  if state <> -1 then
  begin
    TVarData(pvarState).VType := VT_I4;
    TVarData(pvarState).VInteger := state;
    Result := S_OK;
  end;

  if TVarData(varChild).VType = VT_I4 then
    //LogVerbose(Format('%s.Get_accRole: name="%s", varChild=%d, state=%d, Result=%4x', [Self.ClassName, name, TVarData(varChild).VInteger, state, Result]))
  else
    //LogVerbose(Format('%s.Get_accRole: name="%s", varChildType=%d, state=%d, Result=%4x', [Self.ClassName, name, TVarData(varChild).VType, state, Result]))

end;

function TAPBaseAccessibility.Get_accValue(varChild: OleVariant; out pszValue: WideString): HResult;
begin
  Result := E_INVALIDARG;

  if (VarType(varchild) = VT_I4) and (varChild <= GetChildCount) then
  begin
    if varChild = CHILDID_SELF then
    begin
      pszValue := GetAccessibleValue;
      Result := CheckReturnString(pszValue);
    end else
    if IsSimpleElement then
    begin
      pszValue := GetChildAccessibleValue(varChild - 1);
      Result := CheckReturnString(pszValue);
    end;
  end;
end;

function TAPBaseAccessibility.Set_accName(varChild: OleVariant;
  const pszName: WideString): HResult;
begin
  Result := DISP_E_MEMBERNOTFOUND;
end;

function TAPBaseAccessibility.Set_accValue(varChild: OleVariant; const pszValue: WideString): HResult;
begin
  Result := DISP_E_MEMBERNOTFOUND;
end;

function TAPBaseAccessibility.GetAccessibilityObjectByLinkObject(const aLinkObject: TObject): IAPBaseAccessibility;
var
  index: Integer;
begin
  if Assigned(aLinkObject) then
  begin
    for index := 0 to FAccessibilityObjects.Count - 1 do
    begin
      Result := FAccessibilityObjects[index];
      if Result.GetLinkObject = aLinkObject then
        Exit;

    end;
    Result := CreateChild(aLinkObject);
  end else
    Result := nil;

end;

function TAPBaseAccessibility.GetOwnerObjectWindow: HWND;
begin
  Result := 0;
end;

function TAPBaseAccessibility.IsSimpleElement: Boolean;
begin
  Result := False;
end;

function TAPBaseAccessibility.GetIntf: IAPBaseAccessibility;
begin
  Result := Self;
end;

function TAPBaseAccessibility.GetLinkObject: TObject;
begin
  Result := FLinkObject;
end;

procedure TAPBaseAccessibility.ClearLinkObject;
begin
  FLinkObject := nil;
end;

procedure TAPBaseAccessibility.RefreshData;
begin

end;

function TAPBaseAccessibility.CheckReturnString(const aString: WideString): HResult;
begin
  if Length(aString) = 0 then
    Result := S_FALSE
  else
    Result := S_OK;

end;

function TAPBaseAccessibility.GetVisible: Boolean;
begin
  Result := True;
end;

function TAPBaseAccessibility.GetSelected: Boolean;
begin
  Result := False;
end;

function TAPBaseAccessibility.GetChecked: Boolean;
begin
  Result := False;
end;

function TAPBaseAccessibility.GetEnabled: Boolean;
begin
  Result := True;
end;

{ TAPBaseWinControlAccessibility }

constructor TAPBaseWinControlAccessibility.Create(const aParent: TAPBaseAccessibility; const aLinkObject: TObject);
begin
  inherited Create(aParent, aLinkObject);
  Assert((aLinkObject is TWinControl), 'LinkObject should be inherited from TWinControl');
end;

function TAPBaseWinControlAccessibility.GetWinControl: TWinControl;
begin
  Result := TWinControl(FLinkObject);
end;

function TAPBaseWinControlAccessibility.GetAccessibleName: string;
begin
  if WinControl.HandleAllocated then
    Result := GetHandleText(WinControl.Handle);

  if Result.IsEmpty then
    Result := inherited GetAccessibleName;

end;

function TAPBaseWinControlAccessibility.GetScreenRectangle: TRect;
begin
  if GetVisible and WinControl.HandleAllocated then
    Result := GetWindowRectFromHandle(GetOwnerObjectWindow)
  else
    Result := TRect.Empty;

end;

function TAPBaseWinControlAccessibility.GetOwnerObjectWindow: HWND;
begin
  Result := inherited GetOwnerObjectWindow;
  if HasLinkObject and WinControl.HandleAllocated then
    Result := WinControl.Handle;

end;

function TAPBaseWinControlAccessibility.GetVisible: Boolean;
var
  handle: HWND;
begin
  handle := GetOwnerObjectWindow;
  Result := ((handle <> 0) and IsWindowVisible(handle));

end;

{ TAPBaseWinControlExAccessibility }

constructor TAPBaseWinControlExAccessibility.Create(const aParent: TAPBaseAccessibility; const aLinkObject: TObject);
begin
  inherited Create(aParent, aLinkObject);
  FOrgWndProc := WinControl.WindowProc;
  WinControl.WindowProc := WndProc;
end;

destructor TAPBaseWinControlExAccessibility.Destroy;
begin
  if HasLinkObject then
    WinControl.WindowProc := FOrgWndProc;

  inherited Destroy;
end;

procedure TAPBaseWinControlExAccessibility.WMGetObject(var Message: TMessage);
begin
  if (Message.LParam = Winapi.Windows.LPARAM(OBJID_CLIENT)) and HasLinkObject then
  begin
    Message.Result := LresultFromObject(IAccessible, Message.WParam, Self);
    //LogVerbose(Format('%s.WMGetObject: Message.Result=%8x', [Self.ClassName, DWORD(Message.Result)]));
  end
  else
    FOrgWndProc(Message);

end;

procedure TAPBaseWinControlExAccessibility.WMDestroyLink(var Message: TMessage);
begin
  if HasLinkObject then
  begin
    //LogVerbose(Format('%s.WMDestroyLink: WinControl=%s', [Self.ClassName, WinControl.Name]));
    WinControl.WindowProc := FOrgWndProc;
    ClearLinkObject;
  end;
  FOrgWndProc(Message);
end;

//PROFILE-NO
procedure TAPBaseWinControlExAccessibility.WndProc(var Message: TMessage);
begin
  case Message.Msg of
    WM_GETOBJECT: WMGetObject(Message);
    WM_DESTROY: WMDestroyLink(Message);
  else
    FOrgWndProc(Message);

  end;
end;
//PROFILE-YES

end.
