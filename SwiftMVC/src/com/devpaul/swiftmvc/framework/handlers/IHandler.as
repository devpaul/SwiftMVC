package com.devpaul.swiftmvc.framework.handlers
{
	import flash.events.IEventDispatcher;

	public interface IHandler
	{
		function watchTarget(target:IEventDispatcher):void;
	}
}