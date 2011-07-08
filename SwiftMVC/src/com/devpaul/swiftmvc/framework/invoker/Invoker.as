package com.devpaul.swiftmvc.framework.invoker
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.utils.describeType;
	
	import org.swiftsuspenders.Injector;
	
	/**
	 * The Invoker is responsible for executing methods taged with the [Execute] metadata.
	 * The [Execute] tag works exactly how [Inject] is used.
	 * 
	 * ROADMAP: Add ability to order execution; Add chained execution in the same execution context
	 * 
	 * @author pshannon
	 */
	public class Invoker extends EventDispatcher
	{
		protected var _injector:Injector;
		
		[Inject]
		public function Invoker(injector:Injector)
		{
			super();
			this._injector = injector;
		}
		
		public function execute(cmd:Object, context:ExecutionContext = null):void
		{
			if(!cmd)
				throw new ArgumentError("Null command");
			
			if(!context)
				context = this._injector.instantiate(ExecutionContext);
			
			if(cmd is Class)
				cmd = this._injector.instantiate(cmd as Class);
			
			for each(var execution:ExecutionPoint in getExecutionPoints(cmd))
				execution.applyInjection(cmd, context.injector);
		}
		
		protected function getExecutionPoints(cmd:Object):Array
		{
			return findExecutionPoints(cmd);
		}
		
		protected function findExecutionPoints(cmd:Object):Array
		{
			var points:Array = [];
			
			var description:XML = describeType(cmd);
			var executionPoint:ExecutionPoint;
			for each (var node:XML in description.method.metadata.(@name == 'Execute'))
			{
				executionPoint = new ExecutionPoint(node, this._injector);
				points.push(executionPoint);
			}
			return points;
		}
	}
}