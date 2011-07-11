package com.devpaul.swiftmvc.framework.handlers
{
	import com.devpaul.swiftmvc.framework.handlers.actions.IHandlerAction;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertFalse;
	
	import test.mocks.handlers.MockAction;

	public class EventHandlerPointTest
	{		
		public static const EVENT_TYPE:String = "test";
		
		[Test(expects="ArgumentError")]
		public function testConstruction_nullEventType_throwsError():void
		{
			new EventHandlerPoint(null, action);
		}
		
		[Test(expects="ArgumentError")]
		public function testConstrcution_nullAction_throwsError():void
		{
			new EventHandlerPoint(EVENT_TYPE, null);
		}
		
		[Test]
		public function testConstruction_defaultOptions():void
		{
			var point:EventHandlerPoint = new EventHandlerPoint(EVENT_TYPE, action);
			assertFalse(point.eventOptions.useCapture)
			assertFalse(point.eventOptions.useWeakReference);
			assertEquals(0, point.eventOptions.priority);
		}
		
		[Test]
		public function testConstruction_withOptions():void
		{
			var options:EventOptions = new EventOptions(true, 100, true);
			var point:EventHandlerPoint = new EventHandlerPoint(EVENT_TYPE, action, options);
			assertEquals(options, point.eventOptions);
		}
		
		[Test]
		public function testWatchTarget():void
		{
			var action:MockAction = this.action as MockAction;
			var point:EventHandlerPoint = new EventHandlerPoint(EVENT_TYPE, action);
			var target:EventDispatcher = new EventDispatcher();
			point.watchTarget(target);
			target.dispatchEvent(new Event(EVENT_TYPE));
			assertEquals(1, action.count);
		}
		
		[Test]
		public function testUnwatchTarget():void
		{
			var action:MockAction = this.action as MockAction;
			var point:EventHandlerPoint = new EventHandlerPoint(EVENT_TYPE, action);
			var target:EventDispatcher = new EventDispatcher();
			point.watchTarget(target);
			point.unwatchTarget(target);
			target.dispatchEvent(new Event(EVENT_TYPE));
			assertEquals(0, action.count);
		}
		
		[Test]
		public function testWatchTarget_nullValue_doesNothing():void
		{
			var point:EventHandlerPoint = new EventHandlerPoint(EVENT_TYPE, action);
			point.watchTarget(null);
		}
		
		[Test]
		public function testUnwatchTarget_nullValue_doesNothing():void
		{
			var point:EventHandlerPoint = new EventHandlerPoint(EVENT_TYPE, action);
			point.unwatchTarget(null);
		}
		
		private function get action():IHandlerAction
		{
			return new MockAction();
		}
	}
}