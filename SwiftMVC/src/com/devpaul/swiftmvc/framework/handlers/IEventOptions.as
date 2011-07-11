package com.devpaul.swiftmvc.framework.handlers
{
	public interface IEventOptions
	{
		function get useCapture():Boolean;
		
		function get priority():int;
		
		function get useWeakReference():Boolean;
	}
}