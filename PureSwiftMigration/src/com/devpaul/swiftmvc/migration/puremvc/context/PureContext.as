package com.devpaul.swiftmvc.migration.puremvc.context {
    import com.devpaul.swiftmvc.framework.context.Context;
    import com.devpaul.swiftmvc.migration.puremvc.framework.PureFacade;
    import com.devpaul.swiftmvc.migration.puremvc.support.controller.handlers.NotificationHandler;

    import flash.events.IEventDispatcher;

    import org.puremvc.as3.multicore.interfaces.IFacade;
    import org.puremvc.as3.multicore.patterns.facade.Facade;
    import org.swiftsuspenders.InjectionConfig;

    public class PureContext extends Context {
        public static const NOTIFICATION_BUS_DEPENDENCY_NAME:String = "notificationBus";

        protected var _facade:PureFacade;

        public function PureContext(name:String, facade:PureFacade) {
            _facade = facade;
            super(name);
        }

        public function get facade():PureFacade {
            return _facade;
        }

        public function get notificationBus():IEventDispatcher {
            return _facade.notificationBus;
        }

        protected override function initializeContext():void {
            _injector = _facade.injector;
        }

        protected override function initializeDependencies():void {
            super.initializeDependencies();
            mapFacade();
            mapNotificationBus();
        }

        protected override function initializeFramework():void {
            var noteHandler:NotificationHandler = injector.instantiate(NotificationHandler);
            noteHandler.watchTarget(eventBus);
        }

        private function mapNotificationBus():void {
            var rule:InjectionConfig;
            rule = injector.mapValue(IEventDispatcher, notificationBus, NOTIFICATION_BUS_DEPENDENCY_NAME);
            injector.mapRule(IEventDispatcher, rule, NOTIFICATION_BUS_DEPENDENCY_NAME + name);
        }

        private function mapFacade():void {
            var rule:InjectionConfig;
            rule = injector.mapValue(PureFacade, _facade);
            injector.mapRule(PureFacade, rule, name);
            injector.mapRule(Facade, rule);
            injector.mapRule(Facade, rule, name);
            injector.mapRule(IFacade, rule);
            injector.mapRule(IFacade, rule, name);
        }
    }
}