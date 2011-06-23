package com.devpaul.swiftmvc.migration.puremvc.support.events
{
	import mx.utils.UIDUtil;
	
	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertNull;

	public class SendNotificationEventTest
	{
		[Test]
		public function testConstruction_defaultProperties():void
		{
			var noteType:String = anyString;
			var event:SendNotificationEvent = new SendNotificationEvent(noteType);
			assertEquals(event.notificationName, noteType);
			assertEquals(SendNotificationEvent.EXECUTE_NOTIFICATION, event.type);
			assertNull(event.body);
			assertNull(event.notificationType);
		}
		
		[Test]
		public function testConstruction_assignedProperties():void
		{
			var noteType:String = anyString;
			var subType:String = noteType;
			var body:Object = new Object();
			var event:SendNotificationEvent = new SendNotificationEvent(noteType, body, subType);
			assertEquals(event.notificationName, noteType);
			assertEquals(SendNotificationEvent.EXECUTE_NOTIFICATION, event.type);
			assertEquals(event.body, body);
			assertEquals(event.notificationType, subType);
		}
		
		private function get anyString():String
		{
			return UIDUtil.createUID();
		}
	}
}