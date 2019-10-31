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
        EditorHelpers helper = new EditorHelpers();

        [Given(@"I have am on Tab(.*)")]
        public void GivenIHaveAmOnTab(int p0)
        {
            helper.ClickTab("/form[@controlname='Form1']/element[@controlname='dxRibbon1']/?/?/tabpage[@accessiblename='dxRibbon1Tab2']");
        }
        
        [When(@"I click button(.*)")]
        public void WhenIClickButton(int p0)
        {
            helper.ClickButton("/form[@controlname='Form1']/element[@controlname='dxRibbon1']//toolbar[@accessiblename='dxBarManager1Bar2']/button[@accessiblename='dxBarLargeButton2']");
        }
        
        [Then(@"the label should say button(.*)clicked")]
        public void ThenTheLabelShouldSayButtonclicked(int p0)
        {
            Button btn = "/form[@controlname='Form1']/button[@controlname='Label1']";
            Assert.IsTrue(btn.Text == "Button 2 clicked");
        }
    }
}
