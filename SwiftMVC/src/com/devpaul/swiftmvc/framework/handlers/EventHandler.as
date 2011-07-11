package com.devpaul.swiftmvc.framework.handlers
{
	import com.devpaul.swiftmvc.framework.handlers.actions.IHandlerAction;
	
	import flash.events.IEventDispatcher;
	import flash.utils.Dictionary;

	public class EventHandler extends BaseEventHandler implements IHandler
	{
		protected var _target:IEventDispatcher = null;
		
		public function EventHandler()
		{
		}
		
		public function get target():IEventDispatcher
		{
			return this._target;
		}
		
		public function watchTarget(target:IEventDispatcher):void
		{
			if(target == this._target)
				return;
			
			if(this._target)
				unwatchTargetDispatcher(this._target);
			
			if(target) {
				this._target = target;
				watchTargetDispatcher(this._target);
			}
		}
		
		public function unwatchTarget():void
		{
			if(this._target)
				unwatchTargetDispatcher(this._target);
			
			this._target = null;
		}
	}
}