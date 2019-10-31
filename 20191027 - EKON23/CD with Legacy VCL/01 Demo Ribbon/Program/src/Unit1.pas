unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, dxRibbonSkins, System.Actions, Vcl.ActnList, dxBar,
  cxClasses, dxRibbon, Vcl.StdCtrls, APRibbonAccessibility,
  APRibbonBarAccessibility, APBaseAccessibility, Vcl.Buttons, AdvGlowButton;

  {$DEFINE EnableTest}

type
  TForm1 = class(TForm)
    dxBarManager1: TdxBarManager;
    dxRibbon1Tab1: TdxRibbonTab;
    dxRibbon1: TdxRibbon;
    dxRibbon1Tab2: TdxRibbonTab;
    dxBarManager1Bar1: TdxBar;
    dxBarManager1Bar2: TdxBar;
    dxBarLargeButton1: TdxBarLargeButton;
    ActionList1: TActionList;
    Action1: TAction;
    dxBarLargeButton2: TdxBarLargeButton;
    Action2: TAction;
    Label1: TButton;
    SpeedButton1: TSpeedButton;
    AdvGlowButton1: TAdvGlowButton;
    procedure Action1Execute(Sender: TObject);
    procedure Action2Execute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
{$IFDEF EnableTest}
    FRibbonAccessibility: IAPBaseAccessibility;
{$ENDIF}
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation



{$R *.dfm}

procedure TForm1.Action1Execute(Sender: TObject);
begin
  Label1.Caption := 'Button 1 clicked';

end;

procedure TForm1.Action2Execute(Sender: TObject);
begin
  Label1.Caption := 'Button 2 clicked';
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
{$IFDEF EnableTest}
  FRibbonAccessibility := TAPRibbonAccessibility.Create(nil, dxRibbon1);
{$ENDIF}
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
{$IFDEF EnableTest}
  FRibbonAccessibility := nil;
{$ENDIF}
end;

end.
