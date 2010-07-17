package com.devpaul.swiftmvc.injector
{
	import flexunit.framework.Assert;
	
	import test.MockFactory;
	import test.mocks.MockMediator;

	public class SwiftInjectorTest
	{
		[Test]
		public function injectorTest():void
		{
			var injector:SwiftInjector = new SwiftInjector();
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