object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 506
  ClientWidth = 861
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  DesignSize = (
    861
    506)
  PixelsPerInch = 96
  TextHeight = 13
  object dxRibbon1: TdxRibbon
    Left = 0
    Top = 0
    Width = 861
    Height = 122
    BarManager = dxBarManager1
    Style = rs2016
    ColorSchemeAccent = rcsaBlue
    ColorSchemeName = 'Colorful'
    Contexts = <>
    TabOrder = 0
    TabStop = False
    object dxRibbon1Tab1: TdxRibbonTab
      Active = True
      Caption = 'Tab1'
      Groups = <
        item
          ToolbarName = 'dxBarManager1Bar1'
        end>
      Index = 0
    end
    object dxRibbon1Tab2: TdxRibbonTab
      Caption = 'Tab2'
      Groups = <
        item
          ToolbarName = 'dxBarManager1Bar2'
        end>
      Index = 1
    end
  end
  object Label1: TButton
    Left = 8
    Top = 256
    Width = 845
    Height = 81
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Label1'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -45
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
  end
  object dxBarManager1: TdxBarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    Categories.Strings = (
      'Default')
    Categories.ItemsVisibles = (
      2)
    Categories.Visibles = (
      True)
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 272
    Top = 168
    PixelsPerInch = 96
    object dxBarManager1Bar1: TdxBar
      Caption = 'Tab1'
      CaptionButtons = <>
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 448
      FloatTop = 364
      FloatClientWidth = 51
      FloatClientHeight = 24
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarLargeButton1'
        end>
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManager1Bar2: TdxBar
      Caption = 'Tab2'
      CaptionButtons = <>
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 895
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarLargeButton2'
        end>
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarLargeButton1: TdxBarLargeButton
      Action = Action1
      Category = 0
      Glyph.SourceDPI = 96
      Glyph.Data = {
        89504E470D0A1A0A0000000D494844520000002000000020080300000044A48A
        C60000001974455874536F6674776172650041646F626520496D616765526561
        647971C9653C00000015744558745469746C6500436865636B3B4D61726B3B54
        69636B0B00C7240000004B504C5445FFFFFFFFFFFFFCFDFD9FC2B6E4EEEBB1CD
        C3E0EBE7FEFFFFA0C2B779A99977A89877A79780AD9E7FAD9EA3C4B97EAC9D76
        A797D4E3DEDFEBE7A2C3B8A6C6BBD5E4DFE3EDE9E3EDEAE2ECE945FDC6340000
        000174524E530040E6D8660000008449444154785ED5D3370E03310C44518FE2
        66E770FF931A368BC11058A9B5D9FE07420575E8CFA9393F0EA60E88656D8218
        F05C15F80E945981EF61D8DD1061DD03DF05CC6E3FBE9D209F47DF05E48AFBA8
        EF1370AB80097601C7074CB00BA0F0DD00C5855D0005BB000A760526D2A75F1B
        07B324848D8980E2B5754E6EFAAF7F41D09D37777D319D27A472A00000000049
        454E44AE426082}
      PaintStyle = psCaptionGlyph
    end
    object dxBarLargeButton2: TdxBarLargeButton
      Action = Action2
      Category = 0
    end
  end
  object ActionList1: TActionList
    Left = 240
    Top = 328
    object Action1: TAction
      Caption = 'Button 1'
      OnExecute = Action1Execute
    end
    object Action2: TAction
      Caption = 'Button 2'
      OnExecute = Action2Execute
    end
  end
end
