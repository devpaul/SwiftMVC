package com.devpaul.swiftmvc.framework.process
{
	import flash.utils.Dictionary;
	
	import org.flexunit.assertThat;
	import org.flexunit.asserts.assertEquals;
	import org.flexunit.async.Async;

	public class ProcessManagerTest
	{
		protected var _mgr:ProcessManager;
		
		[Before]
		public function setUp():void
		{
			this._mgr = new ProcessManager();
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
		
		[Test(async)]
		public function testAddProcess_eventDispatched():void
		{
			var passthru:Dictionary = new Dictionary();
			var process:Object = new Object();
			passthru['process'] = process;
			var func:Function = Async.asyncHandler(this, onRegisterProcess, 500, passthru);
			this._mgr.addEventListener(ProcessEvent.PROCESS_REGISTERED, func);
			var id:int = this._mgr.registerProcess(process);
			assertEquals(id, passthru['id']);
		}
		
		[Test(async)]
		public function testReleaseProcess_eventDispatched():void
		{
			var process:Object = new Object();
			var id:int = this._mgr.registerProcess(process);
			var passthru:Dictionary = new Dictionary();
			passthru['id'] = id;
			passthru['process'] = process;
			var func:Function = Async.asyncHandler(this, onReleaseProcess, 500, passthru);
			this._mgr.addEventListener(ProcessEvent.PROCESS_RELEASED, func);
			assertEquals(process, this._mgr.releaseProcess(id));
		}
		
		private function onRegisterProcess(event:ProcessEvent, passthru:Object):void
		{
			assertEquals(event.process, passthru['process']);
			passthru['id'] = event.processId;
		}
		
		private function onReleaseProcess(event:ProcessEvent, passthru:Object):void
		{
			assertEquals(event.process, passthru['process']);
			assertEquals(event.processId, passthru['id']);
		}
	}
}