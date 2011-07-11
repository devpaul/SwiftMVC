package com.devpaul.swiftmvc.framework.handlers
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertFalse;
	import org.flexunit.asserts.assertNull;
	import org.flexunit.asserts.assertTrue;
	
	import test.mocks.handlers.MockAction;

	public class EventHandlerTest
	{
		private static const EVENT_TYPE:String = "test";
		protected var handler:EventHandler;
		
		protected var action:MockAction;
		
		protected var point:EventHandlerPoint;
		
		protected var target:IEventDispatcher;
		
		[Before]
		public function setUp():void
		{
			handler = new EventHandler();
			action = new MockAction();
			point = new EventHandlerPoint(EVENT_TYPE, action);
			target = new EventDispatcher();
		}
		
		[Test]
		public function testWatchTarget():void
		{
			handler.addEventPoint(point);
			assertFalse(target.willTrigger(EVENT_TYPE));
			handler.watchTarget(target);
			assertEquals(target, handler.target);
			assertTrue(target.willTrigger(EVENT_TYPE));
			
			assertEquals(0, action.count);
			dispatchTestEvent();
			assertEquals(1, action.count);
		}
		
		[Test]
		public function testWatchTarget_multplePointsDifferentActionSameEventType_handlesBoth():void
		{
			var point2:EventHandlerPoint = new EventHandlerPoint(EVENT_TYPE, new MockAction());
			handler.addEventPoint(point);
			handler.addEventPoint(point2);
			handler.watchTarget(target);
			
			assertEquals(0, action.count);
			dispatchTestEvent();
			assertEquals(1, action.count);
			assertEquals(1, MockAction(point2.action).count);
		}
		
		[Test]
		public function testUnWatchTarget():void
		{
			testWatchTarget();
			handler.unwatchTarget();
			assertNull(handler.target);
			assertFalse(target.willTrigger(EVENT_TYPE));
			
			action.count = 0;
			dispatchTestEvent();
			assertEquals(0, action.count);
		}
		
		private function dispatchTestEvent():void
		{
			target.dispatchEvent(new Event(EVENT_TYPE));
		}
	}
}