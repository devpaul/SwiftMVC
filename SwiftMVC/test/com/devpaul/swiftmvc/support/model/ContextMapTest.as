package com.devpaul.swiftmvc.support.model
{
	import com.devpaul.swiftmvc.framework.context.Context;
	
	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertFalse;
	import org.flexunit.asserts.assertNull;
	import org.flexunit.asserts.assertTrue;
	
	import test.mocks.MockFactory;

	public class ContextMapTest
	{		
		private var _map:ContextMap;
		
		[Before]
		public function setUp():void
		{
			this._map = new ContextMap();
		}
		
		[Test]
		public function testConstruct_0Length():void
		{
			assertEquals(this._map.length, 0);
		}
		
		[Test]
		public function testAddItem_lengthIncreases():void
		{
			this._map.addContext(anyContext);
			assertEquals(this._map.length, 1);
		}
		
		[Test]
		public function testAddMultipleItems_lengthCorrect():void
		{
			var expectedLen:int = fillMapWithNonZeroNumberOfItems();
			assertEquals(expectedLen, this._map.length);
		}
		
		[Test]
		public function testHasItemTrueForAddedItem():void
		{
			var context:Context = anyContext;
			this._map.addContext(context);
			assertTrue(this._map.hasContext(context.name));
		}
		
		[Test]
		public function testHasItemFalseForItemNotAdded():void
		{
			fillMapWithNonZeroNumberOfItems();
			assertFalse(this._map.hasContext(anyContext.name));
		}
		
		[Test(expected="flash.errors.IllegalOperationError")]
		public function testAddSameContextTwice_throwsException():void
		{
			var context:Context = anyContext;
			this._map.addContext(context);
			this._map.addContext(context);
		}
		
		[Test]
		public function testGetContext():void
		{
			var context:Context = anyContext;
			this._map.addContext(context);
			assertEquals(context, this._map.getContext(context.name));
		}
		
		[Test]
		public function testGetContextOnUnrecogonizedName_returnsNull():void
		{
			var context:Context = anyContext;
			assertNull(this._map.getContext(context.name));
		}
		
		[Test]
		public function testRemoveAddedContext():void
		{
			var context:Context = anyContext;
			this._map.addContext(context);
			assertEquals(context, this._map.removeContext(context.name));
		}
		
		[Test(expected="flash.errors.IllegalOperationError")]
		public function testRemoveUnregisteredContext_throwsError():void
		{
			this._map.removeContext(anyContext.name);
		}
		
		[Test]
		public function testRemoveIfExistsOnAddedContext():void
		{
			var context:Context = anyContext;
			this._map.addContext(context);
			assertEquals(context, this._map.removeContextIfExists(context.name));
		}
		
		[Test]
		public function testRemoveIfExistsOnUnregisteredContext_returnsNull():void
		{
			assertNull(this._map.removeContextIfExists(anyContext.name));
		}
		
		[Test]
		public function testConstruct_emptyContextNames():void
		{
			assertEquals(0, this._map.contextNames.length);
		}
		
		[Test]
		public function testContextNames_addOneContext():void
		{
			var context:Context = anyContext;
			this._map.addContext(context);
			var names:Array = this._map.contextNames;
			assertEquals(1, names.length);
			assertEquals(context.name, names[0]);
		}
		
		
		private function get anyContext():Context
		{
			return MockFactory.createContext();
		}
		
		private function fillMapWithNonZeroNumberOfItems():int
		{
			var total:int = Math.random() * 20 + 1
			for(var n:int = total; n > 0; --n)
				this._map.addContext(anyContext);
			return total;
		}
	}
}