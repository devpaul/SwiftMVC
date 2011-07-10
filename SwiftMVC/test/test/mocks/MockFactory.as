package test.mocks
{
	import com.devpaul.swiftmvc.framework.context.Context;
	
	import mx.utils.UIDUtil;
	
	import org.swiftsuspenders.Injector;

	public class MockFactory
	{
		public static const DEFAULT_MOCK_FACADE_NAME:String = "defaultMockFacadeName";
		
		public static function prepInjector(injector:Injector):Injector
		{
			injector.mapValue(String, "dependency1", "strDep1");
			injector.mapValue(String, "dependency2", "strDep2");
			injector.mapValue(String, "dependency3", "strDep3");
			injector.mapClass(MockVO1, MockVO1);
			injector.mapValue(MockVO2, new MockVO2());
			injector.mapSingleton(MockDM);
			injector.mapSingleton(MockPM);
			
			return injector;
		}
		
		public static function createContext():Context
		{
			return new Context(UIDUtil.createUID());
		}
	}
}