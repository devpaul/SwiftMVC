package com.devpaul.swiftmvc.framework.handlers
{
    import test.mocks.handlers.MockAction;

    public class BaseEventHandlerTest
	{		
		protected var handler:BaseEventHandler;
		
		[Before]
		public function setUp():void
		{
			handler = new BaseEventHandler();
		}
		
		[Test(expects="ArgumentError")]
		public function testAddEventPoint_nullValue_throwsArgumentError():void
		{
			handler.addEventPoint(null);
		}
		
		[Test]
		public function testAddEventPoint():void
		{
			var action:MockAction = new MockAction();
			var point:EventHandlerPoint = new EventHandlerPoint("test", action);
			handler.addEventPoint(point);
		}
	}
}