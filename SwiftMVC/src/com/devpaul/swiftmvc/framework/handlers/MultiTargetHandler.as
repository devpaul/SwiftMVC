package com.devpaul.swiftmvc.framework.handlers
{
	import flash.events.IEventDispatcher;
	
	public class MultiTargetHandler extends BaseEventHandler implements IHandler
	{
		public function MultiTargetHandler()
		{
		}
		
		public function watchTarget(target:IEventDispatcher):void
		{
			if(!target)
				throw new ArgumentError("target cannot be null");
			
			watchTargetDispatcher(target);
		}
		
		public function unwatchTarget(target:IEventDispatcher):void
		{
			if(!target)
				throw new ArgumentError("target cannot be null");
			
			unwatchTargetDispatcher(target);
		}
	}
}