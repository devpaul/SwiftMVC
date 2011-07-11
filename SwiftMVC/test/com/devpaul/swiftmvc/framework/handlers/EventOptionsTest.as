package com.devpaul.swiftmvc.framework.handlers
{
	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertFalse;
	import org.flexunit.asserts.assertTrue;

	public class EventOptionsTest
	{		
		[Test]
		public function testConstruction_default():void
		{
			var options:EventOptions = new EventOptions();
			assertEquals(0, options.priority);
			assertFalse(options.useCapture);
			assertFalse(options.useWeakReference);
		}
		
		[Test]
		public function testConstruction_setAllValues():void
		{
			var priority:int = anyInt;
			var options:EventOptions = new EventOptions(true, priority, true);
			assertEquals(priority, options.priority);
			assertTrue(options.useCapture);
			assertTrue(options.useWeakReference);
		}
		
		[Test]
		public function testConstruction_setUseCaptureValue():void
		{
			var options:EventOptions = new EventOptions(true);
			assertEquals(0, options.priority);
			assertTrue(options.useCapture);
			assertFalse(options.useWeakReference);
		}
		
		[Test]
		public function testConstruction_setPriority():void
		{
			var priority:int = anyInt;
			var options:EventOptions = new EventOptions(true, priority);
			assertEquals(priority, options.priority);
			assertTrue(options.useCapture);
			assertFalse(options.useWeakReference);
		}
		
		private function get anyInt():int
		{
			return int(Math.random() * 1000 - 500);
		}
	}
}