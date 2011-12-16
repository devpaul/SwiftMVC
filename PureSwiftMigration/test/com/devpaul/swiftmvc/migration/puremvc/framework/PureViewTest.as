package com.devpaul.swiftmvc.migration.puremvc.framework {
    import com.devpaul.swiftmvc.migration.puremvc.support.events.NotificationEvent;

    import mx.utils.UIDUtil;

    import org.flexunit.asserts.assertEquals;
    import org.flexunit.asserts.assertFalse;
    import org.flexunit.asserts.assertNotNull;
    import org.flexunit.asserts.assertTrue;
    import org.flexunit.async.Async;
    import org.puremvc.as3.multicore.interfaces.IMediator;
    import org.puremvc.as3.multicore.patterns.mediator.Mediator;

    import test.mocks.MockDIMediator;

    import test.mocks.MockFactory;
    import test.mocks.MockMediator;
    import test.mocks.puremvc.MockFacade;

    public class PureViewTest {
        private var facade:MockFacade;

        private var view:PureView;

        [Before]
        public function setup():void {
            facade = MockFactory.createMockFacade();
            view = facade.__view;
            facade.injector.mapValue(PureFacade, facade);
        }

        [After]
        public function teardown():void {
            facade.removeFacade();
        }

        [Test]
        public function constructFacade_verifyViewConstruction():void {
            assertNotNull(view.notificationBus);
            assertEquals(facade.notificationBus, view.notificationBus);
        }

        [Test(async)]
        public function sendNotification_notifyObservers_sendsNotificationThruBus():void {
            var eventName:String = anyString;
            Async.proceedOnEvent(this, facade.notificationBus, eventName)
            facade.sendNotification(eventName);
        }

        [Test(async)]
        public function sendNotification_notifyObservers_sendsSentNotificationThruBus():void {
            Async.proceedOnEvent(this, facade.notificationBus, NotificationEvent.SENT_NOTIFICATION);
            facade.sendNotification(anyString);
        }

        [Test]
        public function registerMediatorClass_instantiatesAndRegistersMediator():void {
            view.registerMediatorClass(MockDIMediator);
            assertMockDIMediatorRegistered(MockDIMediator.NAME);
        }

        [Test(expects="flash.errors.IllegalOperationError")]
        public function registerMediatorClass_alreadyRegistered_throws():void {
            view.registerMediatorClass(MockDIMediator);
            view.registerMediatorClass(MockDIMediator);
        }

        [Test]
        public function registerMediator_newMediator_isRegistered():void {
            view.registerMediator(new MockDIMediator());
            assertMockDIMediatorRegistered(MockDIMediator.NAME);
        }

        [Test]
        public function removeMediator_noLongerMappedInDI():void {
            view.registerMediatorClass(MockDIMediator);
            assertMockDIMediatorRegistered(MockDIMediator.NAME);
            view.removeMediator(MockDIMediator.NAME);
            assertFalse(facade.hasMediator(MockDIMediator.NAME));
            assertFalse(facade.injector.hasMapping(MockDIMediator, MockDIMediator.NAME));
        }

        private function assertMockDIMediatorRegistered(name:String):void {
            assertTrue(facade.hasMediator(name));
            var mediator:IMediator = facade.retrieveMediator(name);
            assertEquals(mediator, facade.injector.getInstance(MockDIMediator, name));
            assertEquals(facade,  MockDIMediator(mediator).pureFacade);
        }

        private function get anyString():String {
            return UIDUtil.createUID();
        }
    }
}
