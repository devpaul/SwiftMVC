package com.devpaul.swiftmvc.migration.puremvc.framework {
    import com.devpaul.swiftmvc.migration.puremvc.support.events.NotificationEvent;

    import flash.errors.IllegalOperationError;
    import flash.events.EventDispatcher;
    import flash.events.IEventDispatcher;

    import org.puremvc.as3.multicore.core.View;
    import org.puremvc.as3.multicore.interfaces.IMediator;
    import org.puremvc.as3.multicore.interfaces.INotification;
    import org.puremvc.as3.multicore.interfaces.IView;
    import org.puremvc.as3.multicore.patterns.facade.Facade;
    import org.swiftsuspenders.Injector;
    import org.swiftsuspenders.Reflector;

    /**
     * Extends the PureMVC <code>View</code> with the SwiftSuspenders injector
     *
     * @author pshannon
     */
    public class PureView extends View implements IView {
        protected static const REREGISTERED_MEDIATOR:String = "A mediator with the same name is already registered.";

        public static function getInstance(key:String):PureView {
            if (View.instanceMap[ key ] == null) View.instanceMap[ key ] = new PureView(key);
            return View.instanceMap[ key ];
        }

        protected var _reflector:Reflector = new Reflector();

        private var _notificationBus:IEventDispatcher = new EventDispatcher();

        public function PureView(key:String) {
            super(key);
        }

        public function get notificationBus():IEventDispatcher {
            return _notificationBus;
        }

        override public function notifyObservers(notification:INotification):void {
            sendNotificationThruBus(notification);
            super.notifyObservers(notification);
        }

        private function sendNotificationThruBus(notification:INotification):void {
            var name:String = notification.getName();
            if (name && _notificationBus.hasEventListener(name))
                _notificationBus.dispatchEvent(new NotificationEvent(name, notification));
            if (_notificationBus.hasEventListener(NotificationEvent.SENT_NOTIFICATION))
                _notificationBus.dispatchEvent(new NotificationEvent(NotificationEvent.SENT_NOTIFICATION, notification));
        }

        /**
         * Instantiates a <code>IMediator</code>, registers the proxy and returns a copy
         *
         * @param clazz a class that implements <code>IMediator</code> and self-assigns a name
         * @return a reference to the instantiated proxy
         * @throws IllegalOperationError if a mediator by the same name is already registered
         */
        public function registerMediatorClass(clazz:Class):IMediator {
            var mediator:IMediator = this.injector.instantiate(clazz);

            if (mediatorMap[ mediator.getMediatorName() ] == null) {
                mapMediator(mediator);
                return mediator;
            }
            else {
                throw new IllegalOperationError(REREGISTERED_MEDIATOR);
            }
        }

        /**
         * @inheritdoc
         */
        public override function registerMediator(mediator:IMediator):void {
            // do not allow re-registration (you must to removeMediator fist)
            if (mediatorMap[ mediator.getMediatorName() ] != null) return;

            this.injector.injectInto(mediator);
            mapMediator(mediator);
        }

        public override function removeMediator(mediatorName:String):IMediator {
            var mediator:IMediator = super.removeMediator(mediatorName);
            this.injector.unmap(this._reflector.getClass(mediator), mediatorName);
            return mediator;
        }

        /**
         * @return provides a reference to the context's parent injector
         */
        protected function get injector():Injector {
            return PureFacade.getInstance(this.multitonKey).injector;
        }

        protected function mapMediator(mediator:IMediator):void {
            super.registerMediator(mediator);
            this.injector.mapValue(this._reflector.getClass(mediator), mediator, mediator.getMediatorName());
        }
    }
}