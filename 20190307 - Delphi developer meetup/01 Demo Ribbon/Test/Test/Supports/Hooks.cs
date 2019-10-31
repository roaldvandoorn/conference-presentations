using Ranorex;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using TechTalk.SpecFlow;

namespace WindowsEditorTestSuite.Supports
{
    [Binding]
    public sealed class Hooks
    {
        // For additional details on SpecFlow hooks see http://go.specflow.org/doc-hooks
        public static string GetApcPath()
        {
            return Environment.GetFolderPath(Environment.SpecialFolder.LocalApplicationData) + "\\Albelli Fotoboeken\\";
        }
        public static void KillEditorProcess()
        {
            foreach (var process in System.Diagnostics.Process.GetProcessesByName("apc"))
            {
                process.Kill();
            }
        }
        public static void DeleteBackupFile()
        {
            string recoveryPath = GetApcPath() + "recovery\\";
            
            System.IO.DirectoryInfo di = new DirectoryInfo(recoveryPath);

            foreach (FileInfo file in di.GetFiles())
            {
                file.Delete();
            }
        }
        public static void DeleteMyLayoutFile()
        {
            string recoveryPath = GetApcPath() + "MyLayouts7\\";

            System.IO.DirectoryInfo di = new DirectoryInfo(recoveryPath);

            foreach (FileInfo file in di.GetFiles())
            {
                file.Delete();
            }
        }

        [BeforeScenario]
        public static void BeforeStartTest()
        {
            //implement logic that has to run before executing each scenario
            string path = GetApcPath();
            Console.Write("Start editor before test, path: " + path);            
            Host.Local.RunApplication(path + "apc.bat", "", path, true);
            Delay.Seconds(5);           
        }

        [BeforeTestRun]
        public static void BeforeStartSuite()
        {
            CheckEditorBatchFile();  
            //Kill the editor
            Console.Write("Kill editor before start suite;");
            KillEditorProcess();
            DeleteBackupFile();
            DeleteMyLayoutFile();
        }

        private static void CheckEditorBatchFile()
        {
            if (System.IO.File.Exists(GetApcPath() + "apc.bat"))
            {
                System.IO.File.Delete(GetApcPath() + "apc.bat");
            }
            // create start line
            string lines = "\"" + GetApcPath() + "apc.exe\" /noupdate /dtap=t";
            // create batch file
            System.IO.StreamWriter file = new System.IO.StreamWriter(GetApcPath() + "apc.bat");
            file.WriteLine(lines);
            file.Close();
            
        }

        [AfterScenario]
        public static void AfterEndTest()
        {
            //implement logic that has to run after executing each scenario
            //Kill the editor
            Console.Write("Kill after run test");
            KillEditorProcess();
        }        
    }
}
