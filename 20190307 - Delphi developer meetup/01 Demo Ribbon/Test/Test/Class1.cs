using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Ranorex;
using Ranorex.Core;
using TechTalk.SpecFlow;

namespace Test
{
    [Binding]
    public sealed class Hooks
    {
        private static void InitResolver()
        {
            Ranorex.Core.Resolver.AssemblyLoader.Initialize();
        }

        private static void RanorexInit()
        {
            TestingBootstrapper.SetupCore();
        }

        [BeforeTestRun]
        public static void BeforeTestSuite()
        {
            InitResolver();
            RanorexInit();

        }
    }
}
