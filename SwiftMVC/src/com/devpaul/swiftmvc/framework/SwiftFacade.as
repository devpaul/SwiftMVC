package com.devpaul.swiftmvc.framework
{
	import com.devpaul.swiftmvc.injector.IInjector;
	import com.devpaul.swiftmvc.injector.SwiftInjector;
	
	import org.puremvc.as3.multicore.interfaces.IFacade;
	import org.puremvc.as3.multicore.interfaces.IMediator;
	import org.puremvc.as3.multicore.interfaces.IProxy;
	import org.puremvc.as3.multicore.patterns.facade.Facade;
	
	/**
	 * Extends the PureMVC <code>Facade</code> with the SwiftSuspenders injector
	 * 
	 * @author pshannon
	 */
	public class SwiftFacade extends Facade implements IFacade
	{
		public static function getInstance(key:String):SwiftFacade
		{
			if ( Facade.instanceMap[ key ] == null ) Facade.instanceMap[ key ] = new SwiftFacade( key );
			return Facade.instanceMap[ key ];
		}
		
		
		
		/** parent injector for this multiton key context */
		protected var _injector:SwiftInjector;
		
		public function SwiftFacade(key:String)
		{
			super(key);
		}
		
		/**
		 * @return a reference to the parent injector of this context
		 */
		public function get injector():SwiftInjector
		{
			return this._injector;
		}
		
		/**
		 * Initialize the <code>Injector</code>
		 * 
		 * Override this initialization method to pass an injection XML definition
		 * to the injector.
		 */
		protected function initializeInjector():void
		{
			this._injector = new SwiftInjector();
		}
		
		/**
		 * @inheritDoc 
		 */
		protected override function initializeFacade():void
		{
			super.initializeFacade();
			initializeInjector();
		}
		
		/**
		 * @inheritDoc 
		 */
		protected override function initializeController():void
		{
			if (this.controller != null)
				return;
			
			this.controller = SwiftController.getInstance(this.multitonKey);
		}
		
		/**
		 * @inheritDoc 
		 */
		protected override function initializeModel():void
		{
			if(this.model != null)
				return;
			
			this.model = SwiftModel.getInstance(this.multitonKey);
		}
		
		/**
		 * @inheritDoc 
		 */
		protected override function initializeView():void
		{
			if(this.view != null)
				return;
			
			this.view = SwiftView.getInstance(this.multitonKey);
		}
	}
}