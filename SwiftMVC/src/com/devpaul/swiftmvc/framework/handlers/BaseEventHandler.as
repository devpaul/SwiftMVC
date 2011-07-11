package com.devpaul.swiftmvc.framework.handlers
{
	import flash.events.IEventDispatcher;
	
	public class BaseEventHandler
	{
		private var _points:Array = [];
		
		public function BaseEventHandler()
		{
		}
		
		public function addEventPoint(point:EventHandlerPoint):void
		{
			if(!point)
				throw new ArgumentError("Event Handler Point cannot be null");
			
			this._points.push(point);
		}
		
		protected function watchTargetDispatcher(target:IEventDispatcher):void
		{
			if(target)
				for each(var point:EventHandlerPoint in this._points)
					point.watchTarget(target);
		}
		
		protected function unwatchTargetDispatcher(target:IEventDispatcher):void
		{
			if(target)
				for each(var point:EventHandlerPoint in this._points)
					point.unwatchTarget(target);
		}
	}
}