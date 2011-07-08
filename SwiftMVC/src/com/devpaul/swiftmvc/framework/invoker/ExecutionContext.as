package com.devpaul.swiftmvc.framework.invoker
{
	import org.swiftsuspenders.Injector;

	public class ExecutionContext
	{
		private var _injector:Injector;
		
		[Inject]
		public function ExecutionContext(injector:Injector)
		{
			this._injector = injector;
		}
		
		public function get injector():Injector
		{
			return this._injector;
		}
	}
}