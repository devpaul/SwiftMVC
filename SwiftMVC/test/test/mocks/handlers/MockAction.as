package test.mocks.handlers
{
	import com.devpaul.swiftmvc.framework.handlers.actions.IHandlerAction;
	
	import flash.events.Event;
	
	public class MockAction implements IHandlerAction
	{
		public var count:int = 0;
		
		public function MockAction()
		{
		}
		
		public function onEvent(event:Event):void
		{
			count++;
		}
	}
}