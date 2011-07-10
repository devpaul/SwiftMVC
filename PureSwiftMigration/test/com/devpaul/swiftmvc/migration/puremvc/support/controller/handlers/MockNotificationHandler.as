package com.devpaul.swiftmvc.migration.puremvc.support.controller.handlers
{
	import org.puremvc.as3.multicore.interfaces.IFacade;
	
	public class MockNotificationHandler extends NotificationHandler
	{
		public function MockNotificationHandler(facade:IFacade)
		{
			super(facade);
		}
		
		public function mock_getFacade():IFacade
		{
			return this._facade;
		}
		
		
	}
}