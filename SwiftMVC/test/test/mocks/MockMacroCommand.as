package test.mocks
{
	import org.puremvc.as3.multicore.interfaces.ICommand;
	import org.puremvc.as3.multicore.patterns.command.MacroCommand;
	
	public class MockMacroCommand extends MacroCommand implements ICommand
	{
		public function MockMacroCommand()
		{
			super();
		}
		
		protected override function initializeMacroCommand():void
		{
			addSubCommand(MockCommand1);
			addSubCommand(MockCommand2);
		}
	}
}