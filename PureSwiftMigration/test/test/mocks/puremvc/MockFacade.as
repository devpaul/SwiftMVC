package test.mocks.puremvc {
    import com.devpaul.swiftmvc.migration.puremvc.framework.PureController;
    import com.devpaul.swiftmvc.migration.puremvc.framework.PureFacade;
    import com.devpaul.swiftmvc.migration.puremvc.framework.PureModel;
    import com.devpaul.swiftmvc.migration.puremvc.framework.PureView;

    import org.puremvc.as3.multicore.patterns.facade.Facade;

    import org.puremvc.as3.multicore.patterns.observer.Notification;

    public class MockFacade extends PureFacade {
        public var notificationStack:Array = [];

        public function MockFacade(key:String) {
            super(key);
        }

        public function removeFacade():void {
            Facade.removeCore(multitonKey);
        }

        public override function sendNotification(notificationName:String, body:Object = null, type:String = null):void {
            this.notificationStack.unshift(new Notification(notificationName, body, type));
            super.sendNotification(notificationName, body, type);
        }

        public function get __name():String {
            return multitonKey;
        }

        public function get __view():PureView {
            return PureView(view);
        }

        public function get __controller():PureController {
            return PureController(controller);
        }

        public function get __model():PureModel {
            return PureModel(model);
        }
    }
}