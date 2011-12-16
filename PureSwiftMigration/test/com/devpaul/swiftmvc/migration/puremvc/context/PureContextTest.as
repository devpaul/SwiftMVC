package com.devpaul.swiftmvc.migration.puremvc.context {
    import com.devpaul.swiftmvc.migration.puremvc.framework.PureFacade;
    import com.devpaul.swiftmvc.migration.puremvc.support.events.NotificationEvent;

    import flash.events.IEventDispatcher;

    import mx.utils.UIDUtil;

    import org.flexunit.asserts.assertEquals;
    import org.flexunit.asserts.assertNotNull;
    import org.puremvc.as3.multicore.interfaces.IFacade;
    import org.puremvc.as3.multicore.patterns.facade.Facade;
    import org.puremvc.as3.multicore.patterns.observer.Notification;
    import org.swiftsuspenders.Injector;

    import test.mocks.MockFactory;
    import test.mocks.puremvc.MockFacade;

    public class PureContextTest {
        private var facade:MockFacade;

        private var context:PureContext;

        [Before]
        public function setup():void {
            facade = MockFactory.createMockFacade();
            context = new PureContext(facade.__name, facade);
        }

        [After]
        public function teardown():void {
            facade.removeFacade();
        }

        [Test]
        public function construct_testDefaultValues():void {
            assertEquals(facade, context.facade);
            assertNotNull(context.name);
            assertNotNull(facade.notificationBus);
            assertEquals(facade.__name, context.name);
        }

        [Test]
        public function construct_verifyFacadeInjectorMatchesContextInjector():void {
            assertNotNull(context.facade.injector);
            assertEquals(context.facade.injector, context.injector, context.injector.getInstance(Injector),
                    context.injector.getInstance(Injector, context.name));
        }

        [Test]
        public function construct_facadeMappedAsADependency():void {
            assertNotNull(context.facade);
            assertEquals(context.facade, context.injector.getInstance(PureFacade),
                    context.injector.getInstance(PureFacade, context.name),
                    context.injector.getInstance(Facade),
                    context.injector.getInstance(Facade, context.name),
                    context.injector.getInstance(IFacade),
                    context.injector.getInstance(IFacade, context.name));
        }

        [Test]
        public function sendNotificationThroughEventBus_notificationHandlerForwardsNotifcationToFacade():void {
            var event:NotificationEvent = new NotificationEvent(NotificationEvent.SEND_NOTIFICATION, new Notification(anyString));
            context.eventBus.dispatchEvent(event);

            assertEquals(1, facade.notificationStack.length);
            assertEquals(event.notificationName, Notification(facade.notificationStack[0]).getName());
        }

        [Test]
        public function construct_verifyNotificationBusMatchesFacade():void {
            assertEquals(facade.notificationBus, facade.__view.notificationBus, context.notificationBus);
        }

        [Test]
        public function construct_verifyNotificationBusMappedAsDependency():void {
            assertNotNull(context.notificationBus);
            assertEquals(context.notificationBus,
                         context.injector.getInstance(IEventDispatcher, PureContext.NOTIFICATION_BUS_DEPENDENCY_NAME),
                         context.injector.getInstance(IEventDispatcher, PureContext.NOTIFICATION_BUS_DEPENDENCY_NAME+facade.__name));
        }

        private function get anyString():String {
            return UIDUtil.createUID();
        }
    }
}