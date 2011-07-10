package com.devpaul.swiftmvc.migration.puremvc.injector
{
	import flexunit.framework.Assert;
	
	import org.swiftsuspenders.Injector;
	
	import test.mocks.MockFactory;
	import test.mocks.MockMediator;

	public class PureInjectorTest
	{
		[Test]
		public function injectorTest():void
		{
			var injector:Injector = new Injector();
			MockFactory.prepInjector(injector);
			
			var testObj:MockMediator = new MockMediator(MockMediator.NAME);
			
			injector.injectInto(testObj);
			
			Assert.assertTrue(injector.hasMapping(String, "strDep1"));
			Assert.assertEquals("dependency1", testObj.strDep1);
			Assert.assertEquals("dependency2", testObj.strDep2);
			Assert.assertEquals("dependency3", testObj.getStringDep3());
		}
	}
}