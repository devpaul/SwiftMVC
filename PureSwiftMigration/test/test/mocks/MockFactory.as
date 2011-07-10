package test.mocks
{
	import com.devpaul.swiftmvc.framework.context.Context;
	import com.devpaul.swiftmvc.migration.puremvc.framework.PureFacade;
	
	import mx.utils.UIDUtil;
	
	import org.puremvc.as3.multicore.patterns.facade.Facade;
	import org.swiftsuspenders.Injector;
	
	import test.mocks.puremvc.MockFacade;

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
		
		public static function createMockFacade(name:String = null):MockFacade
		{
			if(!name)
				name = DEFAULT_MOCK_FACADE_NAME;
			
			if(Facade.hasCore(name))
			{
				Facade.removeCore(name);
			}
			
			return new MockFacade(name);
		}
		
		public static function createContext():Context
		{
			return new Context(UIDUtil.createUID());
		}
	}
}