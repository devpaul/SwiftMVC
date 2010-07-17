package test
{
	import com.devpaul.swiftmvc.framework.SwiftFacade;
	import com.devpaul.swiftmvc.injector.SwiftInjector;
	
	import org.puremvc.as3.multicore.patterns.facade.Facade;
	
	import test.mocks.MockDM;
	import test.mocks.MockPM;
	import test.mocks.MockVO1;
	import test.mocks.MockVO2;

	public class MockFactory
	{
		public static function prepInjector(injector:SwiftInjector):SwiftInjector
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
		
		public static function createMockFacade(name:String):SwiftFacade
		{
			if(Facade.hasCore(name))
			{
				Facade.removeCore(name);
			}
			
			return new SwiftFacade(name);
		}
	}
}