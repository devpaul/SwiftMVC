package com.devpaul.swiftmvc.framework.handlers
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertFalse;
	import org.flexunit.asserts.assertTrue;
	
	import test.mocks.handlers.MockAction;

	public class MultiTargetHandlerTest
	{
		protected static const EVENT_TYPE:String = "test";
		
		protected var handler:MultiTargetHandler;
		
		protected var target:IEventDispatcher;
		
		protected var action:MockAction;
		
		protected var point:EventHandlerPoint;
		
		[Before]
		public function setUp():void
		{
			this.handler = new MultiTargetHandler();
			this.target = new EventDispatcher();
			this.action = new MockAction();
			this.point = new EventHandlerPoint(EVENT_TYPE, action);
			handler.addEventPoint(point);
		}
		
		[Test(expects="ArgumentError")]
		public function testWatchTarget_nullValue_throwsArgumentError():void
		{
			handler.watchTarget(null);
		}
		
		[Test(expects="ArgumentError")]
		public function testUnwatchTarget_nullValue_throwsArgumentError():void
		{
			handler.unwatchTarget(null);
		}
		
		[Test]
		public function testWatchTarget():void
		{
			this.handler.watchTarget(target);
			assertTrue(target.willTrigger(EVENT_TYPE));
			dispatchTestEvent();
			assertEquals(1, action.count);
		}
		
		[Test]
		public function testUnwatchTarget():void
		{
			this.handler.watchTarget(target);
			this.handler.unwatchTarget(target);
			assertEquals(0, action.count);
			dispatchTestEvent();
			assertEquals(0, action.count);
			assertFalse(target.willTrigger(EVENT_TYPE));
		}
		
		[Test]
		public function testWatchMultipleTargets():void
		{
			var target2:IEventDispatcher = new EventDispatcher();
			this.handler.watchTarget(target);
			this.handler.watchTarget(target2);
			assertEquals(0, action.count);
			dispatchTestEvent();
			assertEquals(1, action.count);
			target2.dispatchEvent(new Event(EVENT_TYPE));
			assertEquals(2, action.count);
		}
		
		private function dispatchTestEvent():void
		{
			this.target.dispatchEvent(new Event(EVENT_TYPE));
		}
	}
}