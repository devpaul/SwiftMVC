package com.devpaul.swiftmvc.migration.puremvc.support.events {
    import flash.events.Event;

    import org.puremvc.as3.multicore.interfaces.INotification;

    public class NotificationEvent extends Event implements INotification {
        public static const SEND_NOTIFICATION:String = "sendNotification";
        public static const SENT_NOTIFICATION:String = "sentNotification";

        private var _notificationName:String;
        private var _notificationBody:Object;
        private var _notificationType:String;

        public function NotificationEvent(type:String, notificationName:String, notificationBody:Object = null, 
                                          notificationType:String = null) {
            super(type);
            _notificationName = notificationName;
            _notificationBody = notificationBody;
            _notificationType = notificationType;
        }

        public function getType():String {
            return _notificationType;
        }

        public function getName():String {
            return _notificationName;
        }

        public function setBody(body:Object):void {
            _notificationBody = body;
        }

        public function getBody():Object {
            return _notificationBody;
        }

        public function setType(type:String):void {
            _notificationType = type;
        }

        override public function clone():Event {
            return new NotificationEvent(type, getName(), getBody(), getType());
        }
    }
}