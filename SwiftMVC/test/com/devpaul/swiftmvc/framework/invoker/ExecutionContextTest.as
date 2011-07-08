package com.devpaul.swiftmvc.framework.invoker
{
	import org.swiftsuspenders.Injector;

	public class ExecutionContextTest
	{		
		[Test]
		public function testConstruction():void
		{
			new ExecutionContext(new Injector());
		}
	}
}