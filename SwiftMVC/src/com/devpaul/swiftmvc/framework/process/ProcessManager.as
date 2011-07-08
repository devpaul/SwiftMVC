package com.devpaul.swiftmvc.framework.process
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	[Event(name="processRegistered", type="com.devpaul.swiftmvc.framework.process.ProcessEvent")]
	[Event(name="processReleased", type="com.devpaul.swiftmvc.framework.process.ProcessEvent")]
	
	/**
	 * Adds an EventDispatcher to the <code>ProcessMap</code> to notify when process' are registered
	 * so handlers may act on them.
	 * 
	 * ROADMAP: Add time information so the age of a process execution may be known
	 * 
	 * @author pshannon
	 */
	public class ProcessManager extends ProcessMap implements IEventDispatcher
	{
		private var _dispatcher:EventDispatcher;
		
		public function ProcessManager()
		{
			this._dispatcher = new EventDispatcher(this);
		}
		
		protected override function mapUniqueProcess(process:Object):int
		{
			var id:int = super.mapUniqueProcess(process);
			
			dispatchEvent(new ProcessEvent(ProcessEvent.PROCESS_REGISTERED, id, process));
			
			return id;
		}
		
		protected override function releaseKnownProcess(id:int, process:Object):void
		{
			super.releaseKnownProcess(id, process);
			
			dispatchEvent(new ProcessEvent(ProcessEvent.PROCESS_RELEASED, id, process));
		}
		
		public function addEventListener(type:String, listener:Function, useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=false):void
		{
			this._dispatcher.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}
		
		public function removeEventListener(type:String, listener:Function, useCapture:Boolean=false):void
		{
			this._dispatcher.removeEventListener(type, listener, useCapture);
		}
		
		public function dispatchEvent(event:Event):Boolean
		{
			return this._dispatcher.dispatchEvent(event);
		}
		
		public function hasEventListener(type:String):Boolean
		{
			return this._dispatcher.hasEventListener(type);
		}
		
		public function willTrigger(type:String):Boolean
		{
			return this._dispatcher.willTrigger(type);
		}
	}
}