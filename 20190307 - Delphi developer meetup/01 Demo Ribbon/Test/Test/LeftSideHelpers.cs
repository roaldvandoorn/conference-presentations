using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Ranorex;

namespace WindowsEditorTestSuite.Supports
{
    class LeftSideHelpers
    {
        EditorHelpers helper = new EditorHelpers();

        //Left side assets options
        public const string LeftSideEditorForm = "/form[@controlname='MainDesignRibbonForm']/?/?/form[@controlname='EditForm']";
        public const string PhotosButtonPath = LeftSideEditorForm + "//element[@controlname='btnSelectPhotos']/button[@accessiblename='Foto''s']";
        public const string FramesButtonPath = LeftSideEditorForm + "//element[@controlname='btnSelectFrames']/button[@accessiblename='Kaders']";
        public const string MaskButtonPath = LeftSideEditorForm + "//element[@controlname='btnSelectMask']/button[@accessiblename='Sjablonen']";
        public const string BackgroundButtonPath = LeftSideEditorForm + "//element[@controlname='btnSelectBackgrounds']/button[@accessiblename='Achtergronden']";
        public const string ClipArtButtonPath = LeftSideEditorForm + "//element[@controlname='btnSelectClipArt']/button[@accessiblename='Clipart']";
        public const string LayoutButtonPath = LeftSideEditorForm + "//element[@controlname='btnSelectLayouts']/button[@accessiblename='Indelingen']";
        public const string MyLayoutButtonPath = LeftSideEditorForm + "//element[@controlname='btnSelectMyLayouts']/button[@accessiblename='Eigen indelingen']";
        
        //to click on the buttons
        public void PhotoButton()
        {
            helper.ClickButton(PhotosButtonPath);
        }
        public void BackgroundsButton()
        {
            helper.ClickButton(BackgroundButtonPath);
        }
        public void MasksButton()
        {
            helper.ClickButton(MaskButtonPath);
        }
        public void FramesButton()
        {
            helper.ClickButton(FramesButtonPath);
        }
        public void ClipArtsButton()
        {
            helper.ClickButton(ClipArtButtonPath);
        }
        public void LayoutsButton()
        {
            helper.ClickButton(LayoutButtonPath);
        }
        public void MyLayoutsButton()
        {
            helper.ClickButton(MyLayoutButtonPath);
        }
    }
}
