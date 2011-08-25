package com.devpaul.swiftmvc.framework.process
{
	import org.flexunit.assertThat;
	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertNotNull;
	import org.flexunit.asserts.assertNull;
	import org.flexunit.asserts.assertTrue;

	public class ProcessMapTest
	{
		protected var _map:ProcessMap;
		
		[Before]
		public function setUp():void
		{
			this._map = new ProcessMap();
		}
		
		[Test]
		public function testRegisterTwoProcess_returnsUniqueProcessId():void
		{
			assertThat(this._map.registerProcess(anyObject) != this._map.registerProcess(anyObject));
		}
		
		[Test]
		public function testRegisterProcess_hasProcessId():void
		{
			var id:int = this._map.registerProcess(anyObject);
			assertTrue(this._map.hasProcessById(id));
		}
		
		[Test]
		public function testRegisterProcess_hasProcess():void
		{
			var process:Object = anyObject;
			this._map.registerProcess(process);
			assertTrue(this._map.hasProcess(process));
		}
		
		[Test]
		public function testRegisterTwoProcesses_hasBothProcess():void
		{
			var process1:Object = anyObject;
			var process2:Object = anyObject;
			this._map.registerProcess(process1);
			this._map.registerProcess(process2);
			assertTrue(this._map.hasProcess(process1));
			assertTrue(this._map.hasProcess(process2));
		}
		
		[Test]
		public function testRegisterProcess_lookupIdByProcess():void
		{
			var process:Object = anyObject;
			var id:int = this._map.registerProcess(process);
			assertEquals(id, this._map.getProcessId(process));
		}
		
		[Test]
		public function testLookupIdWithProcessNotInMap_returnsNegativeNumber():void
		{
			assertEquals(ProcessMap.NON_EXISTANT_PROCESS_ID, this._map.getProcessId(anyObject));
		}
		
		[Test]
		public function testRegisterSameProcessTwice_ReturnsSameProcessId():void
		{
			var process:Object = anyObject;
			assertEquals(this._map.registerProcess(process), this._map.registerProcess(process));
		}
		
		[Test(expected="flash.errors.IllegalOperationError")]
		public function testRegisterNullProcess_throwsError():void
		{
			this._map.registerProcess(null);
		}
		
		[Test]
		public function testRegisterProcess_LookupProcessById():void
		{
			var process:Object = anyObject;
			var id:int = this._map.registerProcess(process);
			assertNotNull(this._map.getProcess(id));
			assertEquals(process, this._map.getProcess(id));
		}
		
		[Test]
		public function testLookUpUnregisteredProcessById_ReturnsNull():void
		{
			assertNull(this._map.getProcess(int.MAX_VALUE));
		}
		
		[Test]
		public function testReleaseProcessWhenIdDoesntExist_returnsNull():void
		{
			assertNull(this._map.releaseProcess(int.MAX_VALUE));
		}
		
		[Test]
		public function testReleaseProcessById_returnsProcess():void
		{
			var process:Object = anyObject;
			var id:int = this._map.registerProcess(process);
			assertEquals(process, this._map.releaseProcess(id));
		}
		
		[Test]
		public function testNoProcesses_EmptyKeyList():void
		{
			assertProcessIdList([], this._map.getRegisteredProcessIds());
		}
		
		[Test]
		public function testAddProcess_MatchesKeyList():void
		{
			var id:int = this._map.registerProcess(anyObject);
			assertProcessIdList([id], this._map.getRegisteredProcessIds());
		}
		
		[Test]
		public function testAddTwoProcesses_MatchesKeyList():void
		{
			var expectedIds:Array = [
				this._map.registerProcess(anyObject),
				this._map.registerProcess(anyObject)];
			var actualIds:Array = this._map.getRegisteredProcessIds();
			
			assertProcessIdList(expectedIds, actualIds);
		}
		
		private function assertProcessIdList(expected:Array, actual:Array):void
		{
			assertNotNull(expected);
			assertNotNull(actual);
			assertEquals(expected.length, actual.length);
			expected.sort();
			actual.sort();
			for(var i:int = expected.length - 1; i >= 0; --i)
				assertEquals(expected[i], actual[i]);
		}
		
		[Test]
		public function testAddRemoveProcess_EmptyKeyList():void
		{
			var id:int = this._map.registerProcess(anyObject);
			this._map.releaseProcess(id);
			assertProcessIdList([], this._map.getRegisteredProcessIds());
		}
		
		private function get anyObject():Object
		{
			return new Object();
		}
	}
}