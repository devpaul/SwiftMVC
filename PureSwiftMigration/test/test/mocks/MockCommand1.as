package test.mocks
{
	import org.puremvc.as3.multicore.interfaces.ICommand;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	
	public class MockCommand1 extends SimpleCommand implements ICommand
	{
		[Inject(name="MockInjectableMediator")]
		public var mediator:MockMediator;
		
		public function MockCommand1()
		{
			super();
		}
		
		public override function execute(notification:INotification):void
		{
			var body:MockVO2 = MockVO2(notification.getBody());
			
			body.data = this.mediator.getTimer().toString();
		}
	}
}