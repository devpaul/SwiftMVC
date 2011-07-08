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
			assertNotNull(this._map.getRegisteredProcessIds());
			assertEquals(0, this._map.getRegisteredProcessIds().length);
		}
		
		[Test]
		public function testAddProcess_MatchesKeyList():void
		{
			var id:int = this._map.registerProcess(anyObject);
			assertNotNull(this._map.getRegisteredProcessIds());
			assertEquals(1, this._map.getRegisteredProcessIds().length);
			assertEquals(id, this._map.getRegisteredProcessIds()[0]);
		}
		
		[Test]
		public function testAddRemoveProcess_EmptyKeyList():void
		{
			var id:int = this._map.registerProcess(anyObject);
			this._map.releaseProcess(id);
			assertNotNull(this._map.getRegisteredProcessIds());
			assertEquals(0, this._map.getRegisteredProcessIds().length);
		}
		
		private function get anyObject():Object
		{
			return new Object();
		}
	}
}