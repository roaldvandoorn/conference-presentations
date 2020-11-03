using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Ranorex;
using TechTalk.SpecFlow;

namespace UITests.Hooks
{
    [Binding]
    public sealed class Hooks
    {
        [BeforeTestRun]
        public static void BeforeStartSuite()
        {
            Ranorex.Core.Resolver.AssemblyLoader.Initialize();
            TestingBootstrapper.SetupCore();
        }
    }
}
