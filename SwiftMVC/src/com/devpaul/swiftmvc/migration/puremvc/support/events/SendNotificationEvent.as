package com.devpaul.swiftmvc.migration.puremvc.support.events
{
	import flash.events.Event;
	
	public class SendNotificationEvent extends Event
	{
		public static const EXECUTE_NOTIFICATION:String = "executeNotification";
		
		private var _notificationName:String;
		
		private var _body:Object;
		
		private var _notificationType:String;
		
		public function SendNotificationEvent(notificationName:String, body:Object = null, notificationType:String = null)
		{
			super(EXECUTE_NOTIFICATION);
			this._notificationName = notificationName;
			this._body = body;
			this._notificationType = notificationType;
		}
		
		public function get notificationName():String
		{
			return this._notificationName;
		}
		
		public function get body():Object
		{
			return this._body;
		}
		
		public function get notificationType():String
		{
			return this._notificationType;
		}
	}
}