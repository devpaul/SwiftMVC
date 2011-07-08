package com.devpaul.swiftmvc.framework.context
{
	import com.devpaul.swiftmvc.framework.invoker.Invoker;
	
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import org.swiftsuspenders.InjectionConfig;
	import org.swiftsuspenders.Injector;

	/**
	 * The Application Context holds the injector and other information necessary for initializing and
	 * executing the framework.
	 * 
	 * @author pshannon
	 */
	public class Context
	{
		protected var _name:String;
		
		protected var _injector:Injector;
		
		public function Context(name:String)
		{
			if(!name)
				throw new ArgumentError("Context name cannot be null");
			
			this._name = name;
			
			// Initialization
			initializeContext();
			initializeDependencies();
			initializeFramework();
		}
		
		/**
		 * @return the name of this context
		 */
		public function get name():String
		{
			return this._name;
		}
		
		public function get injector():Injector
		{
			return this._injector;
		}
		
		public function get eventBus():IEventDispatcher
		{
			return this._injector.getInstance(IEventDispatcher);
		}
		
		public function get invoker():Invoker
		{
			return this._injector.getInstance(Invoker);
		}
		
		/**
		 * The first phase in the initialization sequence instantiates dependencies for
		 * using the context 
		 * 
		 * @param name the name of this context
		 */
		protected function initializeContext():void
		{
			this._injector = new Injector();
		}
		
		/**
		 * The second phase in the initialization sequence 
		 * 
		 */
		protected function initializeDependencies():void
		{
			var rule:InjectionConfig;
			
			// Injector dependency
			rule = this.injector.mapValue(Injector, this.injector);
			this.injector.mapRule(Injector, rule, name);
			
			// Event bus dependency
			rule = this.injector.mapValue(EventDispatcher, new EventDispatcher());
			this.injector.mapRule(IEventDispatcher, rule);
			this.injector.mapRule(EventDispatcher, rule, this.name);
			this.injector.mapRule(IEventDispatcher, rule, this.name);
			
			// Context dependency
			rule = this.injector.mapValue(Context, this);
			this.injector.mapRule(Context, rule, name);
			
			// Invoker dependency
			rule = this.injector.mapSingleton(Invoker);
			this.injector.mapRule(Invoker, rule, name);
		}
		
		/**
		 * The third phase in the initialization framework
		 */
		protected function initializeFramework():void
		{
			
		}
	}
}