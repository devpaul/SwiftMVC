package com.devpaul.swiftmvc.migration.puremvc.support.controller.handlers {
    import com.devpaul.swiftmvc.migration.puremvc.support.events.NotificationEvent;

    import flash.events.EventDispatcher;
    import flash.events.IEventDispatcher;

    import mx.utils.UIDUtil;

    import org.flexunit.asserts.assertEquals;
    import org.puremvc.as3.multicore.interfaces.IFacade;
    import org.puremvc.as3.multicore.patterns.observer.Notification;

    import test.TestUtil;

    import test.mocks.MockFactory;
    import test.mocks.puremvc.MockFacade;

    public class NotificationHandlerTest {
        [Before]
        public function setUp():void {
        }

        [Test]
        public function testConstruction():void {
            var facade:IFacade = MockFactory.createMockFacade();
            var handler:MockNotificationHandler = new MockNotificationHandler(facade);
            assertEquals(facade, handler.mock_getFacade());
        }

        [Test]
        public function testHandlingSendNotification_sendsNotifictionToFacade():void {
            var facade:MockFacade = MockFactory.createMockFacade();
            var handler:NotificationHandler = new NotificationHandler(facade);
            var dispatcher:IEventDispatcher = new EventDispatcher();
            handler.watchTarget(dispatcher);
            var event:NotificationEvent = new NotificationEvent(NotificationEvent.SEND_NOTIFICATION, TestUtil.anyString);
            dispatcher.dispatchEvent(event);

            assertEquals(1, facade.notificationStack.length);
            assertEquals(event.getName(), Notification(facade.notificationStack[0]).getName());
        }
    }
}