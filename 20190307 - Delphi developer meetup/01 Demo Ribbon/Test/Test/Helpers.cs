using System;
using System.IO;
using System.Text.RegularExpressions;

namespace WindowsEditorTestSuite.Supports
{
    class Helpers
    {
        const string BasePath = "C:\\RanorexTests\\TestBooks\\win\\";
        const string AlbumExt = ".ALB";
        const string PdfExt = ".PDF";
        const string MyLayoutExt = ".APL";

        public string AlbumsBasePath()
        {
            if (File.Exists("PathConfig.txt"))
            {
                string filePath = File.ReadAllText("PathConfig.txt");
                filePath.Replace(System.Environment.NewLine, "");
                return filePath;
            } else
            {  
                throw new Exception("Please copy Default.PathConfig.txt to " + Directory.GetCurrentDirectory() + "\\PathConfig.txt and adjust to your local situation.");
            }
        }
        public static string BuildAlbumPath(string AlbumName)
        {
            Helpers hlp = new Helpers();
            string albPath = hlp.AlbumsBasePath();
            albPath = albPath + AlbumName + "\\" + AlbumName + AlbumExt;
            albPath = Regex.Replace(albPath, @"\r\n?|\n", "");
            return albPath;
        }
        public static string BuildPdfPath(string albumName, string pdfName)
        {
            Helpers hlp = new Helpers();
            string pdfPath = hlp.AlbumsBasePath();
            pdfPath = pdfPath + albumName + "\\" + pdfName + PdfExt;
            pdfPath = Regex.Replace(pdfPath, @"\r\n?|\n", "");
            return pdfPath;
        }
        //for MyLayout
        public static string BuildMyLayoutPath(string myLayoutFile)
        {
            Helpers hlp = new Helpers();
            string aplPath = hlp.AlbumsBasePath();
            //aplPath = aplPath + "MyLayouts7\\" + myLayoutFile + MyLayoutExt;
            aplPath = aplPath + myLayoutFile + "\\" + myLayoutFile + MyLayoutExt;
            aplPath = Regex.Replace(aplPath, @"\r\n?|\n", "");
            return aplPath;
        }

    }
}
