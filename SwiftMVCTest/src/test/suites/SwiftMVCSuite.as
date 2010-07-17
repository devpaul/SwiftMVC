package test.suites
{
	import com.devpaul.swiftmvc.framework.SwiftFacadeTest;
	import com.devpaul.swiftmvc.injector.SwiftInjectorTest;
	
	[Suite]
	[RunWith("org.flexunit.runners.Suite")]
	public class SwiftMVCSuite
	{
		public var test1:com.devpaul.swiftmvc.framework.SwiftFacadeTest;
		public var test2:com.devpaul.swiftmvc.injector.SwiftInjectorTest;
		
	}
}