package com.devpaul.swiftmvc.migration.puremvc.context
{
	import com.devpaul.swiftmvc.migration.puremvc.framework.PureFacade;
	import com.devpaul.swiftmvc.migration.puremvc.support.events.SendNotificationEvent;
	
	import mx.utils.UIDUtil;
	
	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertNotNull;
	import org.puremvc.as3.multicore.interfaces.IFacade;
	import org.puremvc.as3.multicore.patterns.facade.Facade;
	import org.puremvc.as3.multicore.patterns.observer.Notification;
	import org.swiftsuspenders.Injector;
	
	import test.MockFactory;
	import test.mocks.puremvc.MockFacade;

	public class PureContextTest
	{		
		[Before]
		public function setUp():void
		{
		}
		
		[After]
		public function tearDown():void
		{
		}
		
		[BeforeClass]
		public static function setUpBeforeClass():void
		{
		}
		
		[AfterClass]
		public static function tearDownAfterClass():void
		{
		}
		
		[Test]
		public function testConstruction():void
		{
			var facade:PureFacade = anyFacade;
			var name:String = anyString;
			var context:PureContext = new PureContext(name, facade);
			assertEquals(facade, context.facade);
			assertNotNull(name, context.name);
		}
		
		[Test]
		public function testFacadeInjectorMatchesContextInjector():void
		{
			var context:PureContext = new PureContext(anyString, anyFacade);
			assertNotNull(context.facade.injector);
			assertEquals(context.facade.injector, context.injector, context.injector.getInstance(Injector),
			             context.injector.getInstance(Injector, context.name));
		}
		
		[Test]
		public function testFacadeAsADependency():void
		{
			var context:PureContext = new PureContext(anyString, anyFacade);
			assertNotNull(context.facade);
			assertEquals(context.facade, context.injector.getInstance(PureFacade),
			             context.injector.getInstance(PureFacade, context.name),
						 context.injector.getInstance(Facade),
						 context.injector.getInstance(Facade, context.name),
						 context.injector.getInstance(IFacade),
						 context.injector.getInstance(IFacade, context.name));
		}
		
		[Test]
		public function testNotificationHandler():void
		{
			var facade:MockFacade = MockFactory.createMockFacade();
			var context:PureContext = new PureContext(anyString, facade);
			var event:SendNotificationEvent = new SendNotificationEvent(anyString);
			context.eventBus.dispatchEvent(event);
			
			assertEquals(1, facade.notificationStack.length);
			assertEquals(event.notificationName, Notification(facade.notificationStack[0]).getName());
		}
		
		private function get anyFacade():PureFacade
		{
			var facade:PureFacade = new PureFacade(anyString);
			return facade;
		}
		
		private function get anyString():String
		{
			return UIDUtil.createUID();
		}
	}
}