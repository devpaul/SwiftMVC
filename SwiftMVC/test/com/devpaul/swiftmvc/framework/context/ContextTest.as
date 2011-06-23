package com.devpaul.swiftmvc.framework.context
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import mx.utils.UIDUtil;
	
	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertNotNull;
	import org.swiftsuspenders.Injector;

	public class ContextTest
	{
		protected var _context:Context;
		
		[Before]
		public function setUp():void
		{
			this._context = new Context(anyString);
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
		public function testConstruction_ContextName():void
		{
			var name:String = anyString;
			var context:Context = new Context(name);
			assertEquals(name, context.name);
		}
		
		[Test(expected="ArgumentError")]
		public function testConstruction_NullName_ThrowsError():void
		{
			new Context(null);
		}
		
		[Test]
		public function testConstruct_InjectorNotNull():void
		{
			assertNotNull(this._context.injector);
		}
		
		[Test]
		public function testInjectorDependency():void
		{
			assertNotNull(this._context.injector);
			assertEquals(this._context.injector, this._context.injector.getInstance(Injector), 
			             this._context.injector.getInstance(Injector, this._context.name));
		}
		
		[Test]
		public function testConstruct_EventBus():void
		{
			assertNotNull(this._context.eventBus);
			assertEquals(this._context.eventBus, this._context.injector.getInstance(IEventDispatcher),
			             this._context.injector.getInstance(IEventDispatcher, this._context.name),
						 this._context.injector.getInstance(EventDispatcher),
						 this._context.injector.getInstance(EventDispatcher, this._context.name));
		}
		
		[Test]
		public function testConstruct_Context():void
		{
			assertEquals(this._context, this._context.injector.getInstance(Context), 
			             this._context.injector.getInstance(Context, this._context.name));
		}
		
		protected function get anyString():String
		{
			return UIDUtil.createUID();
		}
	}
}