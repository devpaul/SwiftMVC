package test.mocks.invoker
{
	public class MockBasicMultipleCommand
	{
		public var numExecutes:int = 0;
		
		public var object:Object;
		
		public function MockBasicMultipleCommand()
		{
		}
		
		[Execute]
		public function execution1():void
		{
			numExecutes++;
		}
		
		[Execute]
		public function execution2(obj:Object):void
		{
			execution1();
			this.object = obj;
		}
	}
}