package com.devpaul.swiftmvc.migration.puremvc.support.events {
    import flash.events.Event;

    import org.puremvc.as3.multicore.interfaces.INotification;

    public class NotificationEvent extends Event {
        public static const SEND_NOTIFICATION:String = "sendNotification";
        public static const SENT_NOTIFICATION:String = "sentNotification";

        private var _notification:INotification;

        public function NotificationEvent(type:String, notification:INotification) {
            super(type);
            _notification = notification;
        }

        public function get notification():INotification {
            return _notification;
        }

        public function get notificationName():String {
            return _notification.getName();
        }

        public function get body():Object {
            return _notification.getBody();
        }

        public function get notificationType():String {
            return _notification.getType();
        }

        override public function clone():Event {
            return new NotificationEvent(type, _notification);
        }
    }
}