package com.devpaul.swiftmvc.migration.puremvc.support.controller.handlers
{
	import com.devpaul.swiftmvc.framework.handlers.IHandler;
	import com.devpaul.swiftmvc.migration.puremvc.support.events.SendNotificationEvent;
	
	import flash.events.IEventDispatcher;
	
	import org.puremvc.as3.multicore.interfaces.IFacade;

	public class NotificationHandler implements IHandler
	{
		protected var _facade:IFacade;
		
		[Inject]
		public function NotificationHandler(facade:IFacade)
		{
			this._facade = facade;
		}
		
		public function watchTarget(target:IEventDispatcher):void
		{
			if(target) {
				target.addEventListener(SendNotificationEvent.EXECUTE_NOTIFICATION, onNotificationEvent);
			}
		}
		
		private function onNotificationEvent(event:SendNotificationEvent):void
		{
			this._facade.sendNotification(event.notificationName, event.body, event.notificationType);
		}
	}
}