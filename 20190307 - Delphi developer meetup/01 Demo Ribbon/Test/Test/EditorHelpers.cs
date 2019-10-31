using NUnit.Framework;
using Ranorex;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Windows.Forms.VisualStyles;
using WindowsEditorTestSuite.Supports;

namespace WindowsEditorTestSuite.Supports
{
    class EditorHelpers
    {
        //MainForm
        public const string MainFormPath = "/form[@controlname='MainDesignRibbonForm']";
        public const string CloseEditorButtonPath = MainFormPath + "/?/?/button[@accessiblename='Close']";
        //public const string FileOpenFilenamePath = "/form[@title=' Open']/?/?/text[@controlid='1148']";
        public const string FileOpenFilenamePath = "/form[@title=' Open']/?/?/text[@controlid='1148']";
        public const string FileOpenMyLayoutFilenamePath = "/form[@title='Open']/?/?/text[@controlid='1148']";
       
        //Ribbon
        public const string RibbonPath = MainFormPath + "/element[@controlname='MainRibbon']";
        public const string UndoQATButtonPath = RibbonPath + "//toolbar[@accessiblename='BarQAT']/button[@accessiblename='btnUndo']";
        public const string RedoQATButtonPath = RibbonPath + "//toolbar[@accessiblename='BarQAT']/button[@accessiblename='btnRedo']";

        //Product tab
        public const string ProductTabPath = RibbonPath + "/?/?/tabpage[@accessiblename='tabProduct']";
        //Product tab - buttons
        public const string OpenProductButtonPath        = RibbonPath + "//toolbar[@accessiblename='BarWelcomeProducts']/button[@accessiblename='btnOpenProduct']";
        public const string NewProductButtonPath         = RibbonPath + "//toolbar[@accessiblename='BarProductBestand']/button[@accessiblename='btnNewProduct']";
        public const string ConvertToHardCoverButtonPath = RibbonPath + "//toolbar[@accessiblename='BarProductCurrent']/button[@accessiblename='btnConvertToHardcover']";
        public const string WarningsButtonPath           = RibbonPath + "//toolbar[@accessiblename='BarProductOrder']/button[@accessiblename='btnWarnings']";
        public const string ProductExtraButtonPath       = RibbonPath + "//toolbar[@accessiblename='BarProductCurrent']/button[@accessiblename='btnOptions']";
        public const string SaveAlbumButtonPath          = RibbonPath + "//toolbar[@accessiblename='BarProductBestand']/button[@accessiblename='btnSave']";

        //Design tab
        public const string DesignTabPath = RibbonPath + "/?/?/tabpage[@accessiblename='tabDesign']";
        //Design tab - buttons
        public const string AlignTopPath               = RibbonPath + "//toolbar[@accessiblename='BarDesignAlign']/button[@accessiblename='btnAlignTop']";
        public const string AlignLeftPath              = RibbonPath + "//toolbar[@accessiblename='BarDesignAlign']/button[@accessiblename='btnAlignLeft']";
        public const string AlignRightPath             = RibbonPath + "//toolbar[@accessiblename='BarDesignAlign']/button[@accessiblename='btnAlignRight']";
        public const string AlignBottomPath            = RibbonPath + "//toolbar[@accessiblename='BarDesignAlign']/button[@accessiblename='btnAlignBottom']";
        public const string ShadowBottomRightPath      = RibbonPath + "//toolbar[@accessiblename='BarDesignShadow']/button[@accessiblename='btnShadowBottomRight']";
        public const string CornersRoundPath           = RibbonPath + "//toolbar[@accessiblename='BarDesignCorners']/button[@accessiblename='btnCornersRound']";
        public const string EditButtonPath             = RibbonPath + "//toolbar[@accessiblename=\'BarDesignObject\']/button[@accessiblename=\'btnEditPicture\']";
        public const string FreeRotationButtonPath     = RibbonPath + "//toolbar[@accessiblename='BarDesignObject']/button[@accessiblename='btnRotateCustom']";
        public const string ResizeToFillPageButtonPath = RibbonPath + "//toolbar[@accessiblename='BarDesignSize']/button[@accessiblename='btnResizeToFillPage']";
        public const string BringToFrontButtonPath     = RibbonPath + "//toolbar[@accessiblename='BarDesignPosition']/button[@accessiblename='btnBringToFront']";
        public const string SendToBackButtonPath       = RibbonPath + "//toolbar[@accessiblename='BarDesignPosition']/button[@accessiblename='btnSendToBack']";
        public const string ToLargestButtonPath        = RibbonPath + "//toolbar[@accessiblename='BarDesignSize']/button[@accessiblename='btnResizeToLargest']";
        public const string ToSmallestButtonPath       = RibbonPath + "//toolbar[@accessiblename='BarDesignSize']/button[@accessiblename='btnResizeToSmallest']";
        public const string SameHeightButtonPath       = RibbonPath + "//toolbar[@accessiblename='BarDesignSize']/button[@accessiblename='btnResizeSameheight']";
        public const string SameWidthButtonPath        = RibbonPath + "//toolbar[@accessiblename='BarDesignSize']/button[@accessiblename='btnResizeSameWidth']";
        public const string TransparencyButtonPath          = DesignTabPath + "//toolbar[@accessiblename='BarDesignObject']/button[@accessiblename='btnTransparencySubmenu']";
        public const string CenterHorizonallyPageButtonPath = DesignTabPath + "//toolbar[@accessiblename='BarDesignDistribute']/button[@accessiblename='btnCenterHorizontallyPage']";
        public const string CenterVerticallyPageButtonPath  = DesignTabPath + "//toolbar[@accessiblename='BarDesignDistribute']/button[@accessiblename='btnCenterVertically']";

        //Insert tab
        public const string InsertTabPath = RibbonPath + "/?/?/tabpage[@accessiblename='tabInsert']";
        //Insert tab - buttons
        public const string AddTextButtonPath        = InsertTabPath + "//toolbar[@accessiblename='BarInsertNew']/button[@accessiblename='btnInsertText']";
        public const string AddPlaceholderButtonPath = InsertTabPath + "//toolbar[@accessiblename='BarInsertNew']/button[@accessiblename='dxBarLargeButton32']";
        public const string TextMaskButtonPath       = InsertTabPath + "/toolbar[@accessiblename='BarInsertDecoration']/button[@accessiblename='btnTextMask']";

        //Page tab
        public const string PageTabPath = RibbonPath + "/?/?/tabpage[@accessiblename='tabPage']";
        //Page tab - buttons
        public const string LockPageButtonPath     = PageTabPath + "/toolbar[@accessiblename='BarPagePage']/button[@accessiblename='btnProtect']";
        public const string AddPagesButtonPath     = PageTabPath + "/toolbar[@accessiblename='BarPageExtraPages']/button[@accessiblename='btnAddPages']";
        public const string PageNumbersButtonPath  = PageTabPath + "/toolbar[@accessiblename='BarPagePage']/button[@accessiblename='btnPageNumbers']";
        public const string MovePagesButtonPath    = PageTabPath + "/toolbar[@accessiblename=\'BarPagePage\']/button[@accessiblename=\'btnMovePages\']";
        public const string SwitchPagesButtonPath  = PageTabPath + "/toolbar[@accessiblename='BarPagePage']/button[@accessiblename='btnSwitchPages']";
        public const string MirrorLayoutButtonPath = PageTabPath + "/toolbar[@accessiblename='BarPageLayouts']/button[@accessiblename='btnMirrorLayout']";
        public const string SaveLayoutButtonPath = RibbonPath + "//toolbar[@accessiblename='BarPageLayouts']/button[@accessiblename='btnSaveLayout']";

//"/form[@controlname='MainDesignRibbonForm']/element[@controlname='MainRibbon']//toolbar[@accessiblename='BarPageLayouts']/button[@accessiblename='btnSaveLayout']"
//"/form[@controlname='MainDesignRibbonForm']/element[@controlname='MainRibbon']//toolbar[@accessiblename='BarPagePage']/button[@accessiblename='btnSwitchPages']"

        //Welcome tab
        public const string WelcomeScreenPath = RibbonPath + "/?/?/tabpage[@accessiblename='tabWelkom']";

        //Help and options tab
        public const string HelpTabPath = RibbonPath + "/?/?/tabpage[@accessiblename='tabHelp']";
        //Help and options tab - buttons
        public const string SettingButtonPath = RibbonPath + "//toolbar[@accessiblename='BarHelpOptions']/button[@accessiblename='btnSettings']";

        //EditForm
        public const string EditFormPath           = MainFormPath + "/?/?/form[@controlname = \'EditForm\']";
        public const string OrderButtonPath        = EditFormPath + "/container[@controlname='pnlRight']/container[@controlname='dockNavigate']//button[@accessiblename='Bestellen']";
        public const string FirstPictureItemPath   = EditFormPath + "/element[@controlname='svImageSources']//container[@controlname='pgcImages']/container[@controlname='tbsPictures']/?/?/list[@accessiblename='TAPPhotoBrowser']/picture[@accessiblename='Item_0']";
        public const string EmptyLeftPagePath      = EditFormPath + "/container[@controlname='pnlRight']/container[@controlname='pnlMainImg']//container[@accessiblename='LeftPage']";
        public const string ImageItemsPath         = LeftSideHelpers.LeftSideEditorForm + "/container[@controlname='pnlRight']/container[@controlname='pnlMainImg']//container[@accessiblename='RightPage']/list[@accessiblename='ImageItems']";
        public const string PageOnePath            = EditFormPath + "/container[@controlname='pnlRight']/container[@controlname='pnlMainImg']//container[@accessiblename='RightPage']";
        public const string FirstItemMyLayoutPath  = EditFormPath + "/element[@controlname='svImageSources']//container[@controlname='pnlDockMyLayouts']/?/?/container[@controlname='pnlMain']/?/?/list[@accessiblename='TAPPhotoBrowser']/picture[@accessiblename='Item_0']";
        public const string NextPageButtonPath     = EditFormPath + "/container[@controlname='pnlRight']/container[@controlname='dockNavigate']/?/?/element[@controlname='btNext']/button[@accessiblerole='PushButton']";
        public const string PreviousPageButtonPath = EditFormPath + "/container[@controlname='pnlRight']/container[@controlname='dockNavigate']/?/?/element[@controlname='btPrev']/button[@accessiblerole='PushButton']";
        public const string FirstPageButtonPath    = EditFormPath + "/container[@controlname='pnlRight']/container[@controlname='dockNavigate']/?/?/element[@controlname='btFirst']/button[@accessiblerole='PushButton']";
        public const string LastPageButtonPath     = EditFormPath + "/container[@controlname='pnlRight']/container[@controlname='dockNavigate']/?/?/element[@controlname='btLast']/button[@accessiblerole='PushButton']";
        public const string ChoosePageButtonPath   = EditFormPath + "/container[@controlname='pnlRight']/container[@controlname='dockNavigate']//button[@accessiblename='1 van 24']";
        public const string Picture1Path           = EditFormPath + "/container[@controlname='pnlRight']/container[@controlname='pnlMainImg']//container[@accessiblename='RightPage']/list[@accessiblename='ImageItems']/picture[@accessiblename='Image_0']";
        
        //EditForm - StatusBar
        public const string CoverOptionPath   = MainFormPath + "/element[@controlname='StatusbarMain']/?/?/statusbar[@accessiblename='panel_4']";
        public const string LayFlatOptionPath = MainFormPath + "/element[@controlname='StatusbarMain']/?/?/statusbar[@accessiblename='panel_5']";
        //EditForm - RightClick ContextMenu
        public const string ImageContextMenuSizePath = "/contextmenu[@class='#32768' and @instance='1']/?/?/menuitem[@accessiblename='Omvang']";
        public const string OriginalAspectRatioMenuPath = "/contextmenu[@class='#32768' and @instance='0']/?/?/menuitem[@accessiblename='Toon volledige foto']";

        //EditPlaceholderForm - Buttons on placeholder
        public const string SwapPlaceholderButtonPath = "/form[@controlname='MainDesignRibbonForm']/?/?/form[@controlname='EditForm']/container[@controlname='pnlRight']/container[@controlname='pnlMainImg']//element[@controlname='btnSwap']/button[@accessiblerole='PushButton']";
        public const string MenuPlaceholderButtonPath = "/form[@controlname='MainDesignRibbonForm']/?/?/form[@controlname='EditForm']/container[@controlname='pnlRight']/container[@controlname='pnlMainImg']//element[@controlname='btnMenu']/button[@accessiblerole='PushButton']";
        public const string EditPlaceholderButtonPath = "/form[@controlname='MainDesignRibbonForm']/?/?/form[@controlname='EditForm']/container[@controlname='pnlRight']/container[@controlname='pnlMainImg']//element[@controlname='btnEdit']/button[@accessiblerole='PushButton']";
        
        //EditTextForm
        public const string FontNameComboPath = RibbonPath + "/element[@class = 'TdxRibbonGroupsDockControlSite']/element[6]//element[@controlname='edFont']/?/?/text[@accessiblerole='Text']";
        public const string FontSizeComboPath = RibbonPath + "/element[@class = 'TdxRibbonGroupsDockControlSite']/element[6]//element[@controlname='edFontSize']/?/?/text[@accessiblerole='Text']";
        public const string SetDefaultButtonPath = RibbonPath + "//toolbar[@accessiblename='BarTextSave']/button[@accessiblename='btnTextDefault']";
        public const string TextCancelButtonPath = MainFormPath + "/form[@controlname = 'EditTextform']/?/?/button[@controlname = 'btcancel']";
        public const string TextSaveButtonPath = MainFormPath + "/form[@controlname = 'EditTextform']/?/?/button[@controlname = 'btsave']";

        //EditPictureForm
        public const string EditPictureTabPath = MainFormPath + "/element[@controlname='MainRibbon']/?/?/tabpage[@accessiblename='tabEditPicture']";
        public const string EffectsButtonPath = MainFormPath + "/element[@controlname='MainRibbon']//toolbar[@accessiblename='BarPictureMore']/button[@accessiblename='barSubEffects']";
        public const string PictureEditSaveButtonPath = MainFormPath + "/element[@controlname='MainRibbon']//toolbar[@accessiblename='BarPictureSave']/button[@accessiblename='btnPictureSave']";
        public const string PluginButtonPath = MainFormPath + "/element[@controlname='MainRibbon']//toolbar[@accessiblename='BarPictureMore']/button[@accessiblename='barSubPlugins']";

        //StoryBoard

        //OrderForm
        public const string OrderContinueButtonPath = RibbonPath + "//toolbar[@accessiblename='BarOrder']/button[@accessiblename='btnOrderContinue']";

        //SettingsForm
        public const string SettingsFormPath = MainFormPath + "/?/?/form[@controlname='SettingsForm']";
        public const string AdvancedSettingButtonPath = SettingsFormPath + "/container[@controlname='pcSettings']/?/?/tabpage[@accessiblename='Geavanceerd']";
        public const string ImportMyLayoutButtonPath  = SettingsFormPath + "/container[@controlname='pcSettings']/container[@controlname='opAdvancedSettings']//button[@controlname='btnImportLayouts']";
        public const string SaveButtonForSettingWindowPath = RibbonPath + "//toolbar[@accessiblename='BarSettings']/button[@accessiblename='btnSettingsApply']";

        //Popup Forms
        //Popup Form - ProductExtras
        public const string OkButtonForProductExtraPath = "/form[@controlname='FrmAPProductExtras']/?/?/button[@controlname='btnOk']";
        public const string AddCoverRadioBtnPath = "/form[@controlname='FrmAPProductExtras']/container[@controlname='pnlCover']/?/?/radiobutton[@controlname='rbAddCover']";
        public const string AddLayFlatRadioBtnPath = "/form[@controlname='FrmAPProductExtras']/container[@controlname='pnlLayFlat']/?/?/radiobutton[@controlname='rbAddLayflat']";
        public const string NoLayFlatRadioButtonPath = "/form[@controlname='FrmAPProductExtras']/container[@controlname='pnlLayFlat']/?/?/radiobutton[@controlname='rbNoLayFlat']";
        public const string OkButtonForUpsellWindowPath = "/form[@controlname='FrmAPProductExtras']/?/?/button[@controlname='btnOk']";
        //Popup Form - AddPagesForm
        public const string AddPagesOkButtonPath = "/form[@controlname='AddPagesForm']/?/?/button[@controlname='btnOK']";
        public const string NewAmountOfPageNumberPath = "/form[@controlname='AddPagesForm']/container[@controlname='pnlMain']//text[@accessiblerole='Text']";
        //Popup Form - WarningsForm
        public const string WarningsScrollBoxPath = "/form[@controlname='WarningForm']/?/?/container[@controlname='ScrollBox']";
        //Popup Form - ConvertToHardCover
        public const string ConvertToHardCoverFormPath = "/form[@controlname=\'CoverConversionForm\']";
        public const string ConvertToHardCoverApplyButtonPath = "/form[@controlname=\'CoverConversionForm\']/?/?/button[@controlname=\'btnOK\']";
        public const string OkButtonConvertToHardcoverrPath = "/form[@controlname='CoverConversionForm']/?/?/button[@controlname='btnOK']";
        public const string CancelButtonConvertToHardcoverrPath = "/form[@controlname='CoverConversionForm']/?/?/button[@controlname='btnCancel']";
        //Popup Form - PageNumberForm
        public const string OkButtonForPageNumberPath = "/form[@controlname='PageNumberForm']/?/?/button[@controlname='btnOK']";
        //PopupForm - SaveRenderedPdf
        public const string RenderPdfFileNamePath = "/form[@title=\'Render\']/element[@class=\'DUIViewWndClassName\']//combobox[@class=\'ComboBox\']/text[@controlid=\'1001\']";
        public const string SaveButtonForPdfRenderPath = "/form[@title='Render']/button[@text='&Save']";
        //PopupForm - MovePages
        public const string MovePagesFormPath = "/form[@controlname='MovePagesForm']";
        public const string MovePagesFormOkButtonPath = MovePagesFormPath + "/?/?/button[@controlname=\'Button1\']";
        //PopupForm - SwitchPages
        public const string SwitchPagesFormPath = "/form[@controlname=\'SwitchPagesForm\']";
        public const string SwitchPagesFormOkButtonPath = SwitchPagesFormPath + "/?/?/button[@controlname=\'btnOK\']";
        //PopupForm - SaveLayout warning
        public const string SaveLayoutWarningFormPath = "/form[@title='Waarschuwing']";
        public const string SaveLayoutWarningFormOkButtonPath = SaveLayoutWarningFormPath + "/button[@controlname='OK']";

        //unorganised or unknown where they are situated **************************************************************************************
        public const string CheckoutTitlePath = "/form[@title~'^Opties\\ voor\\ je\\ bestelling']";
        public const string NoButtonSaveAfterRenderPath = "/form[@title='Bevestiging']/button[@controlname='No']";
        public const string OkButtonForSuccessMyLayoutImportPath = "/form[@title='Informatie']/button[@controlname='OK']";
        public const string OpenButtonForFilesPath = "/form[@title=' Open']/button[@text='&Open']";
        public const string InformationFormPath = "/form[@title='Informatie']";
        public const string WarningFormPath = "/form[@title='Waarschuwing']";
        

        public EditorHelpers()
        {
            Adapter.DefaultSearchTimeout = 25000;
        }
        public void GoToNextPage()
        {
            ClickButton(NextPageButtonPath);
        }
        public void GoToPreviousPage()
        {
            ClickButton(PreviousPageButtonPath);
        }
        public void GoToLastPage()
        {
            ClickButton(LastPageButtonPath);
        }
        public void GoToFirstPage()
        {
            ClickButton(FirstPageButtonPath);
        }

        public void GoToChoosePage()
        {
            ClickButton(ChoosePageButtonPath);
        }
        public void ClickImage1()
        {
            var imagePath1 =
                "/form[@controlname='MainDesignRibbonForm']/?/?/form[@controlname='EditForm']/container[@controlname='pnlRight']/container[@controlname='pnlMainImg']//container[@accessiblename='RightPage']/list[@accessiblename='ImageItems']/picture[@accessiblename='Image_0']";
            Picture Picture1 = imagePath1;
            Picture1.Click(Location.CenterLeft); //remove focus from the ribbon to the image to enable the hotkey
        }
        public void ClickRightPage()
        {
            Container pageOne = PageOnePath;
            pageOne.Click(Location.CenterLeft);
        }
        public void ClickLeftPage()
        {
            Container leftPage = EmptyLeftPagePath;
            leftPage.Click(Location.CenterLeft);
        }
        public void RightClickImage1()
        {
            var imagePath1 =
                "/form[@controlname='MainDesignRibbonForm']/?/?/form[@controlname='EditForm']/container[@controlname='pnlRight']/container[@controlname='pnlMainImg']//container[@accessiblename='RightPage']/list[@accessiblename='ImageItems']/picture[@accessiblename='Image_0']";
            Picture Picture1 = imagePath1;
            Picture1.Click(MouseButtons.Right, Location.CenterLeft);
        }
        public void ClickImage2()
        {
            var imagePath2 =
                "/form[@controlname='MainDesignRibbonForm']/?/?/form[@controlname='EditForm']/container[@controlname='pnlRight']/container[@controlname='pnlMainImg']//container[@accessiblename='RightPage']/list[@accessiblename='ImageItems']/picture[@accessiblename='Image_1']";
            Picture Picture2 = imagePath2;
            Picture2.Click(Location.CenterLeft); //remove focus from the ribbon to the image to enable the hotkey
        }
        public void FreeRotationPicture()
        {
            ClickButton(FreeRotationButtonPath);
            //Add degree for free rotation
            Text rotationDegree = "/form[@controlname='FreeRotateForm']/container[@controlname='pnlMain']//text[@accessiblerole='Text']";
            rotationDegree.Focus();
            rotationDegree.PressKeys("45");
            ClickButton("/form[@controlname='FreeRotateForm']/?/?/button[@controlname='btnOK']");
        }
        public void ApplyTextMaskOnPicture()
        {
            ClickButton(TextMaskButtonPath);
            Text textMask = "/form[@controlname='FrmTxtMask']/text[@controlname='edtMask']";
            textMask.TextValue = "ui";
            ClickButton("/form[@controlname='FrmTxtMask']/?/?/button[@controlname='btnOk']");
        }
        public void ClickButton(string buttonpath)
        {
            Ranorex.Button btn = buttonpath;
            btn.Click();        
        }

        public void DoubleClick(string picturePath)
        {
            Picture item = picturePath;
            item.DoubleClick();
        } 

        public void HotkeyRender()
        {
            Keyboard.Press("{ControlKey down}{Alt down}{Shift down}");
            Keyboard.Press(Keys.R);
            Keyboard.Press("{ControlKey up}{Alt up}{Shift up}");
        }

        public void ClickTab(string tabpath)
        {
            Ranorex.TabPage tab = tabpath;
            tab.Click();                
        }
        public void ClickRadioButton(string radiobuttonpath)
        {
            Ranorex.RadioButton rdbtn = radiobuttonpath;
            rdbtn.Click();
        }
        public void LoadAlbum(string albumName)
        {
            //This function assumes that we are in the homepage / productselection of the editor
            //The UAT / Test itself should guarantee this by navigating to "New Product" or restarting the editor.
            ClickButton(OpenProductButtonPath);
            Delay.Seconds(10);

            Text filename = FileOpenFilenamePath;
            string albFileName = Helpers.BuildAlbumPath(albumName);
            if (File.Exists(albFileName))
            {
                filename.TextValue = albFileName;
                ClickButton(OpenButtonForFilesPath);
            }
            else
            {
                throw new Exception(albFileName + "not found!");
            }
        }
        
        //import my layouts
        public void ImportMyLayout(string myLayoutFile)
        {
            GoToHelpAndOptionTab();
            ClickButton(SettingButtonPath);
            ClickTab(AdvancedSettingButtonPath);
            ClickButton(ImportMyLayoutButtonPath);
            Delay.Seconds(5);
 
            Text filename = FileOpenMyLayoutFilenamePath;
            string aplFileName = Helpers.BuildMyLayoutPath(myLayoutFile);
            if (File.Exists(aplFileName))
            {
                filename.TextValue = aplFileName;
                ClickButton("/form[@title='Open']/button[@text='&Open']");
            }
            else
            {
                throw new Exception(aplFileName + "not found!");
            }
        }
        public void DeletePdf(string TestAlbum, string pdfName)
        {
            string pdf = Helpers.BuildPdfPath(TestAlbum, pdfName);
            if (File.Exists(pdf))
            {
                File.Delete(pdf);
            }
        }

        public bool ComparePdf(string TestAlbum, string pdfName1, string pdfName2)
        {
            string pdf1 = Helpers.BuildPdfPath(TestAlbum, pdfName1);
            string pdf2 = pdfName2;
            if (!pdfName2.Contains("\\"))
            {
                pdf2 = Helpers.BuildPdfPath(TestAlbum, pdfName2);
            }
            int byte1;
            int byte2;
            FileStream stream1;
            FileStream stream2;

            if (pdf1 == pdf2)
            {
                Console.WriteLine("Pdf's have the same name");
                return false;   //we should not compare same file
            }

            stream1 = new FileStream(pdf1, FileMode.Open, FileAccess.Read);
            stream2 = new FileStream(pdf2, FileMode.Open, FileAccess.Read);

            if (stream1.Length != stream2.Length)
            {
                stream1.Close();
                stream2.Close();
                Console.WriteLine("Pdf's have different size");
                return false;
            }

            string NameString = "";
            string TypeString = "";
            Boolean Skipping = false;
            do
            {
                byte1 = stream1.ReadByte();
                byte2 = stream2.ReadByte();

                if ((byte1 >= 9) && (byte1 < 256))
                {
                    if (Skipping)
                    {
                        byte2 = byte1;
        
                        TypeString = TypeString + Convert.ToChar(byte1);
                        if (TypeString == "/BitsPerComp")
                        {
                            Skipping = false;
                            NameString = "";
                        }
                        else
                        {
                            if (TypeString.Length > 11)
                            {
                                TypeString = TypeString.Substring(1, 11);
                            }
                        }
                    }
                    else
                    {
                        NameString = NameString + Convert.ToChar(byte1);
                        if (NameString == "/APImageName")
                        {
                            Skipping = true;
                            TypeString = "";
                        }
                        else
                        {
                            if (NameString.Length > 11)
                            {
                                NameString = NameString.Substring(1, 11);
                            }
                        }
                    }
                }
            } while ((byte1 == byte2) && (byte1 != -1));

            stream1.Close();
            stream2.Close();

            if ((byte1 - byte2) != 0)
            {
                Console.WriteLine("Content of the PDF's is different");
            }
            return ((byte1 - byte2) == 0);

        }

        public void GoToProductTab()
        {
            ClickTab(ProductTabPath);
        }
        public void GoToDesignTab()
        {
            ClickTab(DesignTabPath);
        }
        public void GoToInsertPath()
        {
            ClickTab(InsertTabPath);
        }
        public void GoToPageTab()
        {
            ClickTab(PageTabPath);
        }
        public void GoToHelpAndOptionTab()
        {
            ClickTab(HelpTabPath);
        }
        public void GoToNewProductSelection()
        {
            ClickButton(NewProductButtonPath);
        }
        public void CloseEditor(bool ASaveChanges)
        {
            ClickButton(CloseEditorButtonPath);
        }
        public void AddAPlaceholder()
        {
            ClickTab(InsertTabPath);
            ClickButton(AddPlaceholderButtonPath);
        }
        public void AddTextBox()
        {
            ClickTab(InsertTabPath);
            ClickButton(AddTextButtonPath);
        }
        public void SaveAlbum()
        {            
            ClickButton(SaveAlbumButtonPath);
        }      
        public void NoLayFlat()
        {
            ClickRadioButton(NoLayFlatRadioButtonPath);
            Delay.Seconds(5);
            ClickButton(OkButtonForUpsellWindowPath);
        }
        public void Upload()
        {
            ClickButton(OrderButtonPath);
            //Delay.Seconds(10);
            
            NoLayFlat();
            Delay.Seconds(5);
            ClickButton(OrderContinueButtonPath);    
        }
        public void AddCover()
        {
            ClickButton(ProductExtraButtonPath);
            ClickRadioButton(AddCoverRadioBtnPath);
            ClickButton(OkButtonForProductExtraPath);
        }
        public void AddLayFlat()
        {
            ClickButton(ProductExtraButtonPath);
            ClickRadioButton(AddLayFlatRadioBtnPath);
            ClickButton(OkButtonForProductExtraPath);
        }
        //TBD
        public void AddExtraPages()
        {
            ClickButton(AddPagesButtonPath);
            ClickButton(AddPagesOkButtonPath);
        }
        public void WaitForPopup(string axPath)
        {
            int retries = 0;
            bool found = false;
            while ((!found) && (retries < 10))
            {
                try
                {
                    Ranorex.Form Popup = axPath;
                    found = true;
                }
                catch
                {
                    retries++;
                    if (retries == 10)
                    {
                        throw new Exception("Popup '" + axPath + "' not found yet");
                    }
                }
            }
        }
        //wait for 
        public void WaitForEditorMode(string axPath)
        {
            int retries = 0;
            bool found = false;
            while ((!found) && (retries < 10))
            {
                try
                {
                   // Ranorex.Form Popup = axPath;
                    Ranorex.TabPage tab = axPath;
                    found = true;
                }
                catch
                {
                    retries++;
                    if (retries == 10)
                    {
                        throw new Exception("Editor mode is not shown");
                    }
                }
            }
        }
       
        public void WaitForWelcomeScreen(string axPath)
        {
            int retries = 0;
            bool found = false;
            while ((!found) && (retries < 10))
            {
                try
                {
                    // Ranorex.Form Popup = axPath;
                    Ranorex.TabPage tab = axPath;
                    found = true;
                }
                catch
                {
                    retries++;
                    if (retries == 10)
                    {
                        throw new Exception("Wellcome screen is not shown");
                    }
                }
            }
        }

        public void SelectAllObjects()
        {
            ClickRightPage();
            Keyboard.Press("{ControlKey down}");
            Keyboard.Press(Keys.A);
            Keyboard.Press("{ControlKey up}");
        }

        public void DeleteImage()
        {
            Keyboard.Press(Keys.Delete);
            Keyboard.Press(Keys.Delete);
        }

        public void CopyObeject()
        {
            Keyboard.Press("{ControlKey down}");
            Keyboard.Press((Keys.C));
            Keyboard.Press("{ControlKey up}");
        }

        public void PasteObject()
        {
            Keyboard.Press("{ControlKey down}");
            Keyboard.Press((Keys.V));
            Keyboard.Press("{ControlKey up}");
        }
    }
}