package com.devpaul.swiftmvc.migration.puremvc.framework {
    import flexunit.framework.Assert;

    import org.flexunit.asserts.assertNotNull;

    import org.puremvc.as3.multicore.patterns.facade.Facade;
    import org.swiftsuspenders.Injector;

    import test.mocks.MockFactory;
    import test.mocks.MockCommand1;
    import test.mocks.MockCommand2;
    import test.mocks.MockDM;
    import test.mocks.MockMacroCommand;
    import test.mocks.MockMediator;
    import test.mocks.MockProxy;
    import test.mocks.MockVO2;
    import test.mocks.puremvc.MockFacade;

    public class PureFacadeTest {
        public static const FACADE_KEY:String = "test";

        public static const NOTIFICATION1:String = "note1";
        public static const NOTIFICATION2:String = "note2";
        public static const NOTIFICATION3:String = "note3";

        public static var facade:MockFacade;


        [BeforeClass]
        public static function setup():void {
            facade = MockFactory.createMockFacade(FACADE_KEY);
            MockFactory.prepInjector(Injector(facade.injector));
        }

        [AfterClass]
        public static function teardown():void {
            facade.removeFacade();
        }

        [Test]
        public function construct_checkDefaultState():void {
            assertNotNull(facade.notificationBus);
            assertNotNull(facade.injector);
        }


        [Test]
        public function mediatorTest():void {
            var facade:PureFacade = PureFacade.getInstance(FACADE_KEY);

            try {
                var mediator:MockMediator = new MockMediator(MockMediator.NAME);
                facade.registerMediator(mediator);

                Assert.assertEquals("dependency1", mediator.strDep1);
                Assert.assertEquals("dependency2", mediator.strDep2);
                Assert.assertEquals("dependency3", mediator.getStringDep3());

                Assert.assertEquals(facade.injector.getInstance(MockMediator, MockMediator.NAME), mediator);

                facade.removeMediator(MockMediator.NAME);

                Assert.assertFalse(facade.injector.hasMapping(MockMediator, MockMediator.NAME));
                Assert.assertFalse(facade.hasMediator(MockMediator.NAME))
            }
            finally {
                if (facade.hasMediator(MockMediator.NAME)) {
                    facade.removeMediator(MockMediator.NAME);
                }
            }
        }

        [Test]
        public function multipleMediatorRegistrationsTest():void {
            var facade:PureFacade = PureFacade.getInstance(FACADE_KEY);

            try {
                var mediator1:MockMediator = new MockMediator(MockMediator.NAME);
                var mediator2:MockMediator = new MockMediator(MockMediator.NAME);

                facade.registerMediator(mediator1);
                facade.registerMediator(mediator2);

                Assert.assertEquals(facade.injector.getInstance(MockMediator, MockMediator.NAME), mediator1);
                Assert.assertEquals(facade.retrieveMediator(MockMediator.NAME), mediator1);
            }
            finally {
                // cleanup
                facade.removeMediator(MockMediator.NAME);
            }
        }

        [Test]
        public function proxyTest():void {
            var facade:PureFacade = PureFacade.getInstance(FACADE_KEY);

            try {
                var proxy:MockProxy = new MockProxy(MockProxy.NAME);

                facade.registerProxy(proxy);

                Assert.assertEquals(facade.injector.getInstance(MockDM), proxy.dm);
                Assert.assertEquals(facade.injector.getInstance(MockProxy, MockProxy.NAME), facade.retrieveProxy(MockProxy.NAME));

                facade.removeProxy(MockProxy.NAME);

                Assert.assertFalse(facade.injector.hasMapping(MockProxy, MockProxy.NAME));
                Assert.assertFalse(facade.hasProxy(MockProxy.NAME));
            }
            finally {
                // cleanup
                if (facade.hasProxy(MockProxy.NAME)) {
                    facade.removeProxy(MockProxy.NAME);
                }
            }
        }

        [Test]
        public function multipleProxyTest():void {
            var facade:PureFacade = PureFacade.getInstance(FACADE_KEY);

            try {
                var proxy1:MockProxy = new MockProxy(MockProxy.NAME);
                var proxy2:MockProxy = new MockProxy(MockProxy.NAME);

                facade.registerProxy(proxy1);
                facade.registerProxy(proxy2);

                Assert.assertEquals(facade.injector.getInstance(MockProxy, MockProxy.NAME), proxy2);
                Assert.assertEquals(facade.retrieveProxy(MockProxy.NAME), proxy2);
            }
            finally {
                // clean-up
                facade.removeProxy(MockProxy.NAME);
            }
        }

        [Test]
        public function commandTest():void {
            var facade:PureFacade = PureFacade.getInstance(FACADE_KEY);

            try {
                facade.registerCommand(NOTIFICATION1, MockCommand1);

                // register the mediator for MockCommand1 depends
                var mediator:MockMediator = new MockMediator(MockMediator.NAME);
                facade.registerMediator(mediator);

                var body:MockVO2 = new MockVO2();
                Assert.assertNull(body.data);
                facade.sendNotification(NOTIFICATION1, body);
                Assert.assertNotNull(body.data);
            }
            finally {
                // clean-up
                facade.removeMediator(MockMediator.NAME);
                facade.removeCommand(NOTIFICATION1);
            }
        }

        [Test(expects="TypeError", description="This will throw a null exception because a MacroCommand doesn't inject")]
        public function howBadAreMacroCommandsTest():void {
            var facade:PureFacade = PureFacade.getInstance(FACADE_KEY);

            try {
                facade.registerCommand(NOTIFICATION3, MockMacroCommand);

                // register the mediator for MockCommand1 depends
                var mediator:MockMediator = new MockMediator(MockMediator.NAME);
                facade.registerMediator(mediator);

                var body:MockVO2 = new MockVO2();
                facade.sendNotification(NOTIFICATION3, body);
            }
            finally {
                // clean-up
                facade.removeMediator(MockMediator.NAME);
                facade.removeCommand(NOTIFICATION3);
            }
        }
    }
}