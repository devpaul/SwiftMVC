package com.devpaul.swiftmvc.migration.puremvc.command {
    import com.devpaul.swiftmvc.migration.puremvc.support.events.NotificationEvent;

    import flash.events.EventDispatcher;
    import flash.events.IEventDispatcher;

    import org.flexunit.asserts.assertEquals;
    import org.flexunit.async.Async;

    import test.TestUtil;

    public class ReplacementPureCommandTest {
        private var cmd:ReplacementPureCommand;
        private var bus:IEventDispatcher;

        [Before]
        public function setUp():void {
            cmd = new ReplacementPureCommand();
            bus = new EventDispatcher();
            cmd.eventBus = bus;
        }

        [Test(async)]
        public function sendNotification_dispatchesNotificationEvent_toEventBus():void {
            Async.proceedOnEvent(this, bus, NotificationEvent.SEND_NOTIFICATION);
            cmd.sendNotification(TestUtil.anyString);
        }

        [Test(async)]
        public function sendNotification_dispatchesNotificationEvent_dataIsCorrect():void {
            var notificationName:String = TestUtil.anyString;
            var notificationBody:Object = new Object();
            var notificationType:String = TestUtil.anyString;
            var testHandler = Async.asyncHandler(this, function (event:NotificationEvent, ...unused):void {
                assertEquals(notificationName, event.getName());
                assertEquals(notificationBody, event.getBody());
                assertEquals(notificationType, event.getType());
            }, 500);
            bus.addEventListener(NotificationEvent.SEND_NOTIFICATION, testHandler);
            cmd.sendNotification(notificationName, notificationBody, notificationType);
        }
    }
}
