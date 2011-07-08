package test.mocks.invoker
{
	public class MockParamCommand
	{
		public var object:Object = null;
		
		public function MockParamCommand()
		{
		}
		
		[Execute]
		public function execute(obj:Object):void
		{
			this.object = obj;
		}
	}
}