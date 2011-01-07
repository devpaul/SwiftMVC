package test.suites
{
	import com.devpaul.swiftmvc.migration.puremvc.framework.PureFacadeTest;
	import com.devpaul.swiftmvc.migration.puremvc.injector.PureInjectorTest;
	
	[Suite]
	[RunWith("org.flexunit.runners.Suite")]
	public class PureMigrationSuite
	{
		public var test1:com.devpaul.swiftmvc.migration.puremvc.framework.PureFacadeTest;
		public var test2:com.devpaul.swiftmvc.migration.puremvc.injector.PureInjectorTest;
		
	}
}