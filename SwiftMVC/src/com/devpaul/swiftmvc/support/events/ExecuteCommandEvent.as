package com.devpaul.swiftmvc.support.events
{
	import flash.events.Event;
	
	/**
	 * An event sent to a context's EventBus to request that a command is executed
	 * 
	 * @author pshannon
	 */
	public class ExecuteCommandEvent extends Event
	{
		public static const EXECUTE_COMMAND:String = "executeCommand";
		
		protected var _cmd:Object;
		
		public function ExecuteCommandEvent(type:String, cmd:Object)
		{
			super(type, false, false);
			this._cmd = cmd;
		}
		
		public function get command():Object
		{
			return this._cmd;
		}
		
		public override function clone():Event
		{
			return new ExecuteCommandEvent(this.type, this.command);
		}
	}
}