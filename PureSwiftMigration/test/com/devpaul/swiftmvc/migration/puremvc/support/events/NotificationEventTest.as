package com.devpaul.swiftmvc.migration.puremvc.support.events {
    import flash.events.Event;

    import mx.utils.UIDUtil;

    import org.flexunit.asserts.assertEquals;
    import org.flexunit.asserts.assertFalse;
    import org.flexunit.asserts.assertTrue;
    import org.puremvc.as3.multicore.interfaces.INotification;
    import org.puremvc.as3.multicore.patterns.observer.Notification;

    public class NotificationEventTest {
        [Test]
        public function construct_propertiesAssignedCorrectly():void {
            var noteName:String = anyString;
            var noteType:String = noteName;
            var body:Object = new Object();
            var notification:INotification = new Notification(noteName, body, noteType);
            var event:NotificationEvent = new NotificationEvent(NotificationEvent.SEND_NOTIFICATION, notification);
            assertEquals(NotificationEvent.SEND_NOTIFICATION, event.type);
            assertEquals(event.notificationName, noteName);
            assertEquals(event.body, body);
            assertEquals(event.notificationType, noteType);
            assertEquals(event.notification, notification);
        }

        [Test]
        public function clone_allFieldsCopied():void {
            var expected:NotificationEvent = new NotificationEvent(anyString, new Notification(anyString));
            var actual:Event = expected.clone();
            assertFalse(expected == actual);
            assertTrue(actual is NotificationEvent);
            assertEquals(expected.type, actual.type);
            assertEquals(expected.notification, actual['notification']);
        }

        private function get anyString():String {
            return UIDUtil.createUID();
        }
    }
}