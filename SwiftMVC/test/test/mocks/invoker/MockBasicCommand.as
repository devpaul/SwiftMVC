package test.mocks.invoker
{
	public class MockBasicCommand
	{
		public var numExecuteCalls:int = 0;
		
		public function MockBasicCommand()
		{
		}
		
		[Execute]
		public function execute():void
		{
			this.numExecuteCalls++;
		}
	}
}