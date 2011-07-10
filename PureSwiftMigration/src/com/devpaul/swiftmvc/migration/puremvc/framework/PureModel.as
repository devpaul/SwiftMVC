package com.devpaul.swiftmvc.migration.puremvc.framework
{
	import flash.utils.getDefinitionByName;
	
	import org.puremvc.as3.multicore.core.Model;
	import org.puremvc.as3.multicore.interfaces.IModel;
	import org.puremvc.as3.multicore.interfaces.IProxy;
	import org.puremvc.as3.multicore.patterns.facade.Facade;
	import org.swiftsuspenders.Injector;
	import org.swiftsuspenders.Reflector;
	
	/**
	 * Extends the PureMVC <code>Model</code> with the SwiftSuspenders injector
	 * 
	 * @author pshannon
	 */
	public class PureModel extends Model implements IModel
	{
		public static function getInstance(key:String):PureModel
		{
			if ( Model.instanceMap[ key ] == null ) Model.instanceMap[ key ] = new PureModel( key );
			return Model.instanceMap[ key ];
		}
		
		
		
		protected var _reflector:Reflector = new Reflector();
		
		public function PureModel(key:String)
		{
			super(key);
		}
		
		/**
		 * Instantiates a <code>IProxy</code>, registers the mediator and returns a copy
		 * 
		 * @param clazz a class that implements <code>IProxy</code> and self-assigns a name
		 * @return a reference to the instantiated mediator
		 */
		public function registerProxyClass(clazz:Class):IProxy
		{
			var proxy:IProxy = this.injector.instantiate(clazz);
			mapProxy(proxy);
			return proxy;
		}
		
		/**
		 * @inheritdoc
		 */
		public override function registerProxy(proxy:IProxy):void
		{
			this.injector.injectInto(proxy);
			mapProxy(proxy);
		}
		
		public override function removeProxy(proxyName:String):IProxy
		{
			var proxy:IProxy = super.removeProxy(proxyName);
			this.injector.unmap(this._reflector.getClass(proxy), proxyName);
			return proxy;
		}
		
		/**
		 * @return provides a reference to the context's parent injector
		 */
		protected function get injector():Injector
		{
			return PureFacade.getInstance(this.multitonKey).injector;
		}
		
		protected function mapProxy(proxy:IProxy):void
		{
			super.registerProxy(proxy);
			this.injector.mapValue(this._reflector.getClass(proxy), proxy, proxy.getProxyName());
		}
	}
}