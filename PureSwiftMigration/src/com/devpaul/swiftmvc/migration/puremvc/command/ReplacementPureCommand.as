package com.devpaul.swiftmvc.migration.puremvc.command {
import com.devpaul.swiftmvc.migration.puremvc.support.events.NotificationEvent;

import flash.events.IEventDispatcher;

import org.puremvc.as3.multicore.interfaces.INotification;

public class ReplacementPureCommand {
    [Inject]
    public var eventBus:IEventDispatcher;

    public function execute(notification:INotification):void { }

    public function sendNotification(notificationName:String, body:Object = null, type:String = null):void {
        var event:NotificationEvent = new NotificationEvent(NotificationEvent.SEND_NOTIFICATION, notificationName,
                                                            body, type);
        eventBus.dispatchEvent(event);
    }
}
}
