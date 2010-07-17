package com.devpaul.swiftmvc.framework
{
	import com.devpaul.swiftmvc.injector.SwiftInjector;
	
	import flash.utils.getDefinitionByName;
	
	import org.puremvc.as3.multicore.core.Model;
	import org.puremvc.as3.multicore.interfaces.IModel;
	import org.puremvc.as3.multicore.interfaces.IProxy;
	import org.puremvc.as3.multicore.patterns.facade.Facade;
	import org.swiftsuspenders.Reflector;
	
	/**
	 * Extends the PureMVC <code>Model</code> with the SwiftSuspenders injector
	 * 
	 * @author pshannon
	 */
	public class SwiftModel extends Model implements IModel
	{
		public static function getInstance(key:String):SwiftModel
		{
			if ( Model.instanceMap[ key ] == null ) Model.instanceMap[ key ] = new SwiftModel( key );
			return Model.instanceMap[ key ];
		}
		
		
		
		protected var _reflector:Reflector = new Reflector();
		
		public function SwiftModel(key:String)
		{
			super(key);
		}
		
		/**
		 * @inheritdoc
		 */
		public override function registerProxy(proxy:IProxy):void
		{
			this.injector.injectInto(proxy);
			super.registerProxy(proxy);
			this.injector.mapValue(this._reflector.getClass(proxy), proxy, proxy.getProxyName());
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
		protected function get injector():SwiftInjector
		{
			return SwiftFacade.getInstance(this.multitonKey).injector;
		}
	}
}