package com.devpaul.swiftmvc.support.events
{
	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertFalse;
	import org.flexunit.asserts.assertNotNull;
	import org.flexunit.asserts.assertTrue;

	public class ExecuteCommandEventTest
	{
		[Test]
		public function testConstruction_defaultValues():void
		{
			var event:ExecuteCommandEvent = new ExecuteCommandEvent(ExecuteCommandEvent.EXECUTE_COMMAND, anyObject);
			assertNotNull(event.command);
			assertEquals(ExecuteCommandEvent.EXECUTE_COMMAND, event.type);
		}
		
		[Test]
		public function testConstructionWithClass():void
		{
			var event:ExecuteCommandEvent = new ExecuteCommandEvent(ExecuteCommandEvent.EXECUTE_COMMAND, ExecuteCommandEventTest);
			var cmdClass:Class = event.command as Class;
			assertEquals(ExecuteCommandEventTest, cmdClass);
		}
		
		private function get anyObject():Object
		{
			return new Object();
		}
	}
}