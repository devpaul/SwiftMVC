package com.devpaul.swiftmvc.injector
{
	import org.swiftsuspenders.Injector;
	
	public class SwiftInjector extends Injector implements IInjector
	{
		public function SwiftInjector(xmlConfig:XML=null)
		{
			super(xmlConfig);
		}
	}
}