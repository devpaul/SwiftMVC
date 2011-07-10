package com.devpaul.swiftmvc.migration.puremvc.context
{
	import com.devpaul.swiftmvc.framework.context.Context;
	import com.devpaul.swiftmvc.migration.puremvc.framework.PureFacade;
	import com.devpaul.swiftmvc.migration.puremvc.support.controller.handlers.NotificationHandler;
	
	import org.puremvc.as3.multicore.interfaces.IFacade;
	import org.puremvc.as3.multicore.patterns.facade.Facade;
	import org.swiftsuspenders.InjectionConfig;
	import org.swiftsuspenders.Injector;
	
	public class PureContext extends Context
	{
		protected var _facade:PureFacade;
		
		public function PureContext(name:String, facade:PureFacade)
		{
			this._facade = facade;
			super(name);
		}
		
		public function get facade():PureFacade
		{
			return this._facade;
		}
		
		protected override function initializeContext():void
		{
			this._injector = this._facade.injector;
		}
		
		protected override function initializeDependencies():void
		{
			super.initializeDependencies();
			
			var rule:InjectionConfig;
			rule = this.injector.mapValue(PureFacade, this._facade);
			this.injector.mapRule(PureFacade, rule, this.name);
			this.injector.mapRule(Facade, rule);
			this.injector.mapRule(Facade, rule, this.name);
			this.injector.mapRule(IFacade, rule);
			this.injector.mapRule(IFacade, rule, this.name);
		}
		
		protected override function initializeFramework():void
		{
			var noteHandler:NotificationHandler = this.injector.instantiate(NotificationHandler);
			noteHandler.watchTarget(this.eventBus);
		}
	}
}