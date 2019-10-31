using System;
using TechTalk.SpecFlow;
using Ranorex;
using WindowsEditorTestSuite.Supports;
using NUnit.Framework;

namespace Test
{
    [Binding]
    public class SpecFlowFeature1Steps
    {

        static string TabPath = "/form[@name='Form1']/element[@name='dxRibbon1']/?/?/tabpage[@accessiblename='dxRibbon1Tab{0}']";
        static string Buttonpath = "/form[@name='Form1']/element[@name='dxRibbon1']//toolbar[@name='dxBarManager1Bar{0}']/button[@name='dxBarLargeButton{0}']";
        static string LabelPath = "/form[@name='Form1']/button[@name='Label1']";
        static string LabelText = "Button {0} clicked";

        EditorHelpers helper = new EditorHelpers();

        [Given(@"I am on (.*)")]
        public void GivenIAmOn(string p0)
        {
            helper.ClickTab(String.Format(TabPath, p0));
        }
        
        [When(@"I click (.*)")]
        public void WhenIClick(string p0)
        {
            helper.ClickButton(String.Format(Buttonpath, p0));
        }
        
        [Then(@"the label should say (.*)")]
        public void ThenTheLabelShouldSay(string p0)
        {
            Button btn = LabelPath;
            Assert.IsTrue(btn.Text == String.Format(LabelText, p0));
        }
    }
}
