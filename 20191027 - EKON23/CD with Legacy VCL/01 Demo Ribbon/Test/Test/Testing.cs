namespace WindowsEditorTestSuite.Supports
{
    class Testing
    {
       public const string OmvangPath = "/contextmenu[@class='#32768' and @instance='1']/?/?/menuitem[@accessiblename='Omvang']";
       public const string PageOnePath = "/form[@controlname='MainDesignRibbonForm']/?/?/form[@controlname='EditForm']/container[@controlname='pnlRight']/container[@controlname='pnlMainImg']//container[@accessiblename='RightPage']";

       public const string CloseButtonSpecRunPopupPath = "/form[@name~'^TechTalk\\.SpecRun\\.ConsoleR']/?/?/button[@automationid='CommandButton_1112']";
       public const string techTalkSpecRunConsoleRunner = "/form[@name~'^TechTalk\\.SpecRun\\.ConsoleR']";
       public const string saveReminderDialogPath = "/form[@title='Bevestiging']";
       public const string noButtonSaveReminderPath = "/form[@title='Bevestiging']/button[@controlname='No']";
      
        public void CloseUpdateCheckDialog(Ranorex.Core.RxPath myPath, Ranorex.Core.Element myElement)
        {
            myElement.As<Ranorex.Button>().Click();
        }
        //Try to close unexpected dialogues/windows 
        //Popup dialogue window
        //Form techTalkSpecRunConsoleRunner = "/form[@name~'^TechTalk\\.SpecRun\\.ConsoleR']";
        //Popup window
        //Container window = "/form[@name~'^TechTalk\\.SpecRun\\.ConsoleR']/container[@automationid='Window']";
        //Close button

        //public void ChooseMenu()
        //{
        //    // Container pageOnePath = PageOnePath;
        //    var imagePath1 =
        //         "/form[@controlname='MainDesignRibbonForm']/?/?/form[@controlname='EditForm']/container[@controlname='pnlRight']/container[@controlname='pnlMainImg']//container[@accessiblename='RightPage']/list[@accessiblename='ImageItems']/picture[@accessiblename='Image_0']";
        //    Picture Picture1 = imagePath1;

        //    Mouse.MoveTo(Picture1);
        //    Mouse.Click(MouseButtons.Right);

        //    //Keyboard.Press(Keys.O);
        //    //Delay.Seconds(2);
        //    //Keyboard.Press(Keys.P);
        //    //Delay.Seconds(3);

        ////Mouse.MoveTo(omvang);
        //    //Mouse.Click(MouseButtons.Left);

        //    //omvang.Select();
        //}

        //public static void imagesCompare(Bitmap expected, Bitmap actual, String success, String error)
        //{
        //    Bitmap image2 = Imaging.Load("D:/GitRepositories/CE-TestBooks/win/Testing");

        //    if (Imaging.Compare(expected, actual) == 1)
        //        Report.Success(success);
        //    else
        //    {
        //        Report.Failure(error);
        //        Report.LogData(ReportLevel.Error, "Expected", expected);
        //        Report.LogData(ReportLevel.Error, "Actual", actual);
        //    }
        //}
        //Bitmap current = Imaging.CaptureImage(repo.FormOIS_WinStation_11_EyeSca.Element59648);
        //Bitmap image = Imaging.Load("TC244.png");
        //imagesCompare(image, current, "TC244: correct image", "TC244: image is incorrect!");
    }
}
