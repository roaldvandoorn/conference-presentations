unit APMainImageEnViewAccessibilityData;
// Date             : 2-12-2016
// Developer        : J.P. Bone (Albumprinter)
// Release          : 1.00
// History          : 1.0 - Initial version 2-12-2016
//
// Unit description : Data structure for TAPMainImageEnViewAccessibility to access
//                    the single elements of the TAPMainImageEnView control
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
  APLog.Log, iexLayers;

type
  TAPMainViewSpread = class;
//  TAPPageBorders = class
//  protected
//    FParent: TObject;
//  public
//    LeftBorder, TopBorder, RightBorder, BottomBorder: TRect;
//    constructor Create(const aParent: TObject);
//    procedure Clear;
//  end;

  TAPPageItems = class(TList)
  protected
    FParent: TObject;
    FName: string;
  public
    constructor Create(const aParent: TObject; const aName: string);
    property Parent: TObject read FParent;
    property Name: string read FName;
  end;

  TAPMainViewPage = class
  protected
    FAlbumPage: TalbumPage;
    FMainImageSpread: TAPMainViewSpread;
    FMainView: TAPMainImageEnView;
//    FPageBorders: TAPPageBorders;
    FImageItems: TAPPageItems;
    FTextItems: TAPPageItems;
    FBorderItems: TAPPageItems;
    FBackground: TIELayer;
    FName: string;
    function GetMainView: TAPMainImageEnview;
//    function GetBackground: TIELayer;
  public
    PageRect: TRect;
//    LeftBorder, TopBorder, RightBorder, BottomBorder: TRect;
    constructor Create(const aMainImageSpread: TAPMainViewSpread);
    destructor Destroy; override;
    procedure Clear;
    procedure AddItem(const alayer: TIELayer; const aItemRect: TRect);
//    property PageBorders: TAPPageBorders read FPageBorders write FPageBorders;
    property ImageItems: TAPPageItems read FImageItems;
    property TextItems: TAPPageItems read FTextItems;
    property BorderItems: TAPPageItems read FBorderItems;
    property Background: TIELayer read FBackground;
    property Name: string read FName write FName;
    property AlbumPage: TalbumPage read FAlbumPage;
    property MainView: TAPMainImageEnView read GetMainView;
  end;

  TAPMainViewSpread = class
  protected
    FMainView: TAPMainImageEnview;
    FLeftPage: TAPMainViewPage;
    FRightPage: TAPMainViewPage;
  public
    MainRect: TRect;
    constructor Create(const aMainView: TAPMainImageEnview);
    destructor Destroy; override;
    procedure Clear;
    procedure RefreshData;
    property LeftPage: TAPMainViewPage read FLeftPage;
    property RightPage: TAPMainViewPage read FRightPage;
  end;

implementation

//{ TAPPageBorders }
//
//constructor TAPPageBorders.Create(const aParent: TObject);
//begin
//  inherited Create;
//  FParent := aParent;
//end;
//
//procedure TAPPageBorders.Clear;
//begin
//  LeftBorder   := TRect.Empty;
//  TopBorder    := TRect.Empty;
//  RightBorder  := TRect.Empty;
//  BottomBorder := TRect.Empty;
//end;

{ TAPPageItems }

constructor TAPPageItems.Create(const aParent: TObject; const aName: string);
begin
  inherited Create;
  FParent := aParent;
  FName   := aName;
end;

{ TAPMainViewPage }

constructor TAPMainViewPage.Create(const aMainImageSpread: TAPMainViewSpread);
begin
  inherited Create;
  FMainImageSpread := aMainImageSpread;
//  FPageBorders     := TAPPageBorders.Create(Self);
  FImageItems      := TAPPageItems.Create(Self, 'ImageItems');
  FTextItems       := TAPPageItems.Create(Self, 'TextItems');
  FBorderItems       := TAPPageItems.Create(Self, 'BorderItems');
end;

destructor TAPMainViewPage.Destroy;
begin
//  FreeAndNil(FPageBorders);
  FreeAndNil(FImageItems);
  FreeAndNil(FTextItems);
  FreeAndNil(FBorderItems);
  inherited;
end;

function TAPMainViewPage.GetMainView: TAPMainImageEnview;
begin
  Result := FMainImageSpread.FMainView;
end;

//function TAPMainViewPage.GetBackground: TIELayer;
//begin
//  Result := FImageItems[0];
//end;

procedure TAPMainViewPage.Clear;
begin
//  FPageBorders.Clear;
  FImageItems.Clear;
//  FImageItems.Add(nil); // first item reserved for background
  FTextItems.Clear;
  FBorderItems.Clear;
  FBackground := nil;
end;

procedure TAPMainViewPage.AddItem(const alayer: TIELayer; const aItemRect: TRect);
var
  albumObject: TAlbumObject;
  page: TAlbumPage;
begin
  if Integer(aLayer.userdata) > 0 then
  begin
    if TObject(aLayer.userdata) is TAlbumObject then
    begin
      albumObject := TalbumObject(aLayer.userdata);
      page := albumObject.GetParentPage;
      if Assigned(page) then
        FAlbumPage := TalbumPage(albumObject);

      if albumObject is TalbumPage then
        FBackground := aLayer
      else if albumObject is TAlbumPicture then
        FImageItems.Add(aLayer)
      else
        FTextItems.Add(aLayer);

    end;
  end else
    if FBorderItems.Count < 4 then
      FBorderItems.Add(aLayer);

end;

{ TAPMainViewSpread }

constructor TAPMainViewSpread.Create(const aMainView: TAPMainImageEnview);
begin
  inherited Create;
  FMainView       := aMainView;
  FLeftPage       := TAPMainViewPage.Create(Self);
  FLeftPage.Name  := 'LeftPage';
  FRightPage      := TAPMainViewPage.Create(Self);
  FRightPage.Name := 'RightPage';
end;

destructor TAPMainViewSpread.Destroy;
begin
  FreeAndNil(FLeftPage);
  FreeAndNil(FRightPage);
  inherited;
end;


procedure TAPMainViewSpread.Clear;
begin
  MainRect := TRect.Empty;
  FLeftPage.Clear;
  FRightPage.Clear;
end;

procedure TAPMainViewSpread.RefreshData;
var
  layerIdx: Integer;
  layer: TIELayer;
  itemRect: TRect;
  centerX: Integer;
begin
  Clear;
  MainRect := FMainView.ImageRect[0];
  centerX := MainRect.CenterPoint.X - 1;

  FLeftPage.PageRect := MainRect.SplitRect(srLeft, 0.50);
  FRightPage.PageRect := MainRect.SplitRect(srRight, 0.50);

  for layerIdx := 1 to FMainView.LayersCount - 1 do
  begin
    layer := FMainView.Layers[layerIdx];
    if Assigned(layer) then
    begin
      itemRect := FMainView.ImageRect[layerIdx];
      if itemRect.Left < centerX then
        FLeftPage.AddItem(layer, itemRect)
      else
        FRightPage.AddItem(layer, itemRect);

    end;
  end;
end;

end.


