package test.mocks
{
	/**
	 * We use the mock DM to create a count for the presentation model.
	 * Were this production code we might make input bindable and allow
	 * the mockDM count to announce when it changes so the view may update
	 * automagically.
	 * 
	 * @author pshannon
	 */
	public class MockPM
	{
		[inject]
		public var mockDM:MockDM;
		
		public function MockPM()
		{
		}
		
		public function get input():String
		{
			return "Count: " + this.mockDM.count.toString();
		}
	}
}