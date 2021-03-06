package com.devpaul.swiftmvc.migration.puremvc.support.controller.handlers
{
    import com.devpaul.swiftmvc.framework.handlers.IHandler;
    import com.devpaul.swiftmvc.migration.puremvc.support.events.NotificationEvent;

    import flash.events.IEventDispatcher;

    import org.puremvc.as3.multicore.interfaces.IFacade;

    public class NotificationHandler implements IHandler
	{
		protected var _facade:IFacade;

		[Inject]
		public function NotificationHandler(facade:IFacade) {
			this._facade = facade;
		}

		public function watchTarget(target:IEventDispatcher):void {
			if(target)
				target.addEventListener(NotificationEvent.SEND_NOTIFICATION, onNotificationEvent);
		}

		private function onNotificationEvent(event:NotificationEvent):void {
            this._facade.sendNotification(event.getName(), event.getBody(), event.getType());
		}
	}
}