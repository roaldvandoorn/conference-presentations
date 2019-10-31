using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Ranorex;
using NUnit.Framework;
using WindowsEditorTestSuite.Supports;

namespace WindowsEditorTestSuite.Supports
{
    class RibbonButtonsHelper
    {
        EditorHelpers helpers = new EditorHelpers();

        public void ValidateProductTab()
        {
            Button btnNewProduct = "/form[@controlname='MainDesignRibbonForm']/element[@controlname='MainRibbon']//toolbar[@accessiblename='BarProductBestand']/button[@accessiblename='btnNewProduct']";
            Button btnOpenProduct = "/form[@controlname='MainDesignRibbonForm']/element[@controlname='MainRibbon']//toolbar[@accessiblename='BarProductBestand']/button[@accessiblename='btnOpenProduct']";
            Button btnSave = "/form[@controlname='MainDesignRibbonForm']/element[@controlname='MainRibbon']//toolbar[@accessiblename='BarProductBestand']/button[@accessiblename='btnSave']";
            Button btnSaveAs = "/form[@controlname='MainDesignRibbonForm']/element[@controlname='MainRibbon']//toolbar[@accessiblename='BarProductBestand']/button[@accessiblename='btnSaveAs']";
            Button btnStoryBoard = "/form[@controlname='MainDesignRibbonForm']/element[@controlname='MainRibbon']//toolbar[@accessiblename='BarStoryBoard']/button[@accessiblename='btnStoryBoard']";
            Button btnOptions = "/form[@controlname='MainDesignRibbonForm']/element[@controlname='MainRibbon']//toolbar[@accessiblename='BarProductCurrent']/button[@accessiblename='btnOptions']";
            Button btnScaleProduct = "/form[@controlname='MainDesignRibbonForm']/element[@controlname='MainRibbon']//toolbar[@accessiblename='BarProductCurrent']/button[@accessiblename='btnScaleProduct']";
            Button btnPreview = "/form[@controlname='MainDesignRibbonForm']/element[@controlname='MainRibbon']//toolbar[@accessiblename='BarProductOrder']/button[@accessiblename='btnPreview']";
            Button btnWarnings = "/form[@controlname='MainDesignRibbonForm']/element[@controlname='MainRibbon']//toolbar[@accessiblename='BarProductOrder']/button[@accessiblename='btnWarnings']";
            Button btnOrder = "/form[@controlname='MainDesignRibbonForm']/element[@controlname='MainRibbon']//toolbar[@accessiblename='BarProductOrder']/button[@accessiblename='btnOrder']";

            helpers.GoToProductTab(); //click on product tab

            Validate.IsTrue(btnNewProduct.Enabled, "New product button is enabled");
            Validate.IsTrue(btnOpenProduct.Enabled, "Open product button is enabled");
            Validate.IsFalse(btnSave.Enabled, "Save button is disabled");
            Validate.IsTrue(btnSaveAs.Enabled, "Save as button is enabled");
            Validate.IsTrue(btnOptions.Enabled, "Options button is enabled");
            Validate.IsTrue(btnStoryBoard.Enabled, "Story board button is enabled");
            Validate.IsTrue(btnPreview.Enabled, "Preview button is enabled");
            Validate.IsTrue(btnScaleProduct.Enabled, "Scale product button is enabled");
            Validate.IsTrue(btnWarnings.Enabled, "Warning button is enabled");
            Validate.IsTrue(btnOrder.Enabled, "Order button is enabled");
        }

        public void ValidateDesignTab()
        {

        }
        public void ValidateInsertTab()
        {

        }
        public void ValidatePageTab()
        {

        }
        public void ValidateHelpTab()
        {

        }
    }
}
