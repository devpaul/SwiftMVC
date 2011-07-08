package com.devpaul.swiftmvc.framework.process
{
	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertFalse;

	public class ProcessEventTest
	{		
		[Test]
		public function testConstruction():void
		{
			var process:Object = new Object();
			var id:int = anyInt;
			var event:ProcessEvent = new ProcessEvent(ProcessEvent.PROCESS_REGISTERED, id, process);
			assertEquals(id, event.processId);
			assertEquals(process, event.process);
			assertFalse(event.bubbles);
			assertFalse(event.cancelable);
			assertEquals(ProcessEvent.PROCESS_REGISTERED, event.type);
		}
		
		[Test]
		public function testClone():void
		{
			var event:ProcessEvent = new ProcessEvent(ProcessEvent.PROCESS_RELEASED, anyInt, new Object());
			var clone:ProcessEvent = ProcessEvent(event.clone());
			
			assertEquals(event.type, clone.type);
			assertEquals(event.processId, clone.processId);
			assertEquals(event.process, clone.process);
		}
		
		private function get anyInt():int
		{
			return int(Math.random() * 20);
		}
	}
}