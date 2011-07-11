package com.devpaul.swiftmvc.framework.handlers
{
	import com.devpaul.swiftmvc.framework.handlers.actions.IHandlerAction;
	
	import flash.events.IEventDispatcher;

	public class EventHandlerPoint implements IHandler
	{
		private static const DEFAULT_OPTIONS:IEventOptions = new EventOptions();
		
		private var _eventType:String;
		
		private var _action:IHandlerAction;
		
		private var _options:IEventOptions;
		
		public function EventHandlerPoint(eventType:String, action:IHandlerAction, options:IEventOptions = null)
		{
			if(!eventType)
				throw new ArgumentError("eventType cannot be null");
			
			if(!action)
				throw new ArgumentError("no action defined");
			
			this._eventType = eventType;
			this._action = action;
			this._options = (options ? options : DEFAULT_OPTIONS);
		}
		
		public function get eventType():String
		{
			return this._eventType;
		}
		
		public function get action():IHandlerAction
		{
			return this._action;
		}
		
		public function get eventOptions():IEventOptions
		{
			return this._options;
		}
		
		public function watchTarget(target:IEventDispatcher):void
		{
			if(target) {
				target.addEventListener(eventType, action.onEvent, eventOptions.useCapture, eventOptions.priority, eventOptions.useWeakReference);
			}
		}
		
		public function unwatchTarget(target:IEventDispatcher):void
		{
			if(target) {
				target.removeEventListener(eventType, action.onEvent, eventOptions.useCapture);
			}
		}
	}
}