using System;
using TechTalk.SpecFlow;
using System.Diagnostics;
using Ranorex.Controls;
using Ranorex;

namespace UITests.Steps
{
    [Binding]
    public class HelloWorldSteps
    {
        [Given]
        public void GivenTheApplicationIsStarted()
        {
            Process.Start("P:\\Demo\\HelloWorldUI\\Win32\\Debug\\HelloWorldUI.exe");
        }
        
        [When]
        public void WhenIClickTheHelloWorldButton()
        {
            Button hwButton = "/form[@name='Form1']/button[@name='Button1']";
            hwButton.Click();
        }

        [Then]
        public void ThenTheLabelShouldShowHelloWorld()
        {
            Ranorex.Text lblCaption = "/form[@name='Form1']/text[@name='Label1']";
            Validate.Equals(lblCaption.TextValue, "Hello World!");
        }

        [Given]
        public void GivenTheHelloWorldTextIsVisible()
        {
            Button hwButton = "/form[@name='Form1']/button[@name='Button1']";
            hwButton.Click();
        }

        [When]
        public void WhenIClickTheClearButton()
        {
            Button clearButton = "/form[@name='Form1']/button[@name='Button2']";
            clearButton.Click();
        }

        [Then]
        public void ThenTheLabelIsEmpty()
        {
            Ranorex.Text lblCaption = "/form[@name='Form1']/text[@name='Label1']";
            Validate.Equals(lblCaption.TextValue, "");
        }
    }
}
