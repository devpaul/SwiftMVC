package com.devpaul.swiftmvc.framework.invoker
{
	import org.swiftsuspenders.Injector;
	import org.swiftsuspenders.injectionpoints.MethodInjectionPoint;

	/**
	 * Identifies a point of execution for the <code>Invoker</code>
	 * 
	 * NOTE: I'll add more here as more functionality is added to invocation
	 * 
	 * @author pshannon
	 */
	public class ExecutionPoint extends MethodInjectionPoint
	{
		public function ExecutionPoint(node:XML, injector:Injector = null)
		{
			super(node, injector);
		}
	}
}