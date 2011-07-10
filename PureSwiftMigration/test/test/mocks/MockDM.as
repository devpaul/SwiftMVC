package test.mocks
{
	/**
	 * Maintains a counter for the singleton domain model 
	 * 
	 * @author pshannon
	 */
	public class MockDM
	{
		protected var _count:int = 0;
		
		public function MockDM()
		{
		}
		
		public function get count():int
		{
			return this._count
		}
		
		public function increment():void
		{
			this._count++;
		}
	}
}