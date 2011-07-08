package com.devpaul.swiftmvc.framework.process
{
	import flash.events.Event;
	
	/**
	 * Reports on register/release actions by the ProcessManager
	 */
	public class ProcessEvent extends Event
	{
		public static const PROCESS_REGISTERED:String = "processRegistered";
		
		public static const PROCESS_RELEASED:String = "processReleased";
		
		protected var _pid:int;
		
		protected var _process:Object;
		
		public function ProcessEvent(type:String, procid:int, process:Object)
		{
			super(type, false, false);
			this._pid = procid;
			this._process = process;
		}
		
		public function get processId():int
		{
			return this._pid;
		}
		
		public function get process():Object
		{
			return this._process;
		}
		
		public override function clone():Event
		{
			return new ProcessEvent(this.type, this._pid, this._process);
		}
	}
}