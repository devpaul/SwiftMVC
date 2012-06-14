package com.devpaul.swiftmvc.migration.puremvc.support.events {
import mx.utils.UIDUtil;

import org.flexunit.asserts.assertEquals;
import org.flexunit.asserts.assertFalse;
import org.flexunit.asserts.assertNotNull;

    import test.TestUtil;

    public class NotificationEventTest {
        [Test]
        public function construct_propertiesAssignedCorrectly():void {
            var noteName:String = TestUtil.anyString;
            var noteType:String = TestUtil.anyString;
            var body:Object = new Object();
            var event:NotificationEvent = new NotificationEvent(NotificationEvent.SEND_NOTIFICATION, noteName, body, noteType);
            assertEquals(NotificationEvent.SEND_NOTIFICATION, event.type);
            assertEquals(event.getName(), noteName);
            assertEquals(event.getBody(), body);
            assertEquals(event.getType(), noteType);
        }

        [Test]
        public function clone_allFieldsCopied():void {
            var expected:NotificationEvent = new NotificationEvent(TestUtil.anyString, TestUtil.anyString, new Object(), TestUtil.anyString);
            var actual:NotificationEvent = expected.clone() as NotificationEvent;
            assertFalse(expected == actual);
            assertNotNull(actual);
            assertEquals(expected.type, actual.type);
            assertEquals(expected.getBody(), actual.getBody());
            assertEquals(expected.getName(), actual.getName());
            assertEquals(expected.getType(), actual.getType());
        }
    }
}