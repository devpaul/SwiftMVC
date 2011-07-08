package test.mocks.invoker
{
	public class MockNamedParamCommand extends MockParamCommand
	{
		public function MockNamedParamCommand()
		{
			super();
		}
		
		[Execute(name="namedObject")]
		public override function execute(obj:Object):void
		{
			this.object = obj;
		}
	}
}