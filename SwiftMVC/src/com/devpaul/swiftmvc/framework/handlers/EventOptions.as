package com.devpaul.swiftmvc.framework.handlers
{
	public class EventOptions implements IEventOptions
	{
		protected var _useCapture:Boolean;
		
		protected var _priority:int;
		
		protected var _useWeakRef:Boolean;
		
		public function EventOptions(useCapture:Boolean = false, priority:int = 0, useWeakRef:Boolean = false)
		{
			this._useCapture = useCapture;
			this._priority = priority;
			this._useWeakRef = useWeakRef;
		}
		
		public function get useCapture():Boolean
		{
			return this._useCapture;
		}
		
		public function get priority():int
		{
			return this._priority;
		}
		
		public function get useWeakReference():Boolean
		{
			return this._useWeakRef;
		}
	}
}