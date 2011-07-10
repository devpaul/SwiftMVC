package test.mocks
{
	import org.puremvc.as3.multicore.interfaces.ICommand;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	
	public class MockCommand2 extends SimpleCommand implements ICommand
	{
		public function MockCommand2()
		{
			super();
		}
	}
}