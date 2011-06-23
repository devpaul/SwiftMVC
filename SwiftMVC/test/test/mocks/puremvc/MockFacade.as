package test.mocks.puremvc
{
	import com.devpaul.swiftmvc.migration.puremvc.framework.PureFacade;
	
	import org.puremvc.as3.multicore.patterns.observer.Notification;
	
	public class MockFacade extends PureFacade
	{
		public var notificationStack:Array = [];
		
		public function MockFacade(key:String)
		{
			super(key);
		}
		
		public override function sendNotification(notificationName:String, body:Object=null, type:String=null):void
		{
			this.notificationStack.unshift(new Notification(notificationName, body, type));
			super.sendNotification(notificationName, body, type);
		}
	}
}