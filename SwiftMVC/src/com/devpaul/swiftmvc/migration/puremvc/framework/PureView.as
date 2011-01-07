package com.devpaul.swiftmvc.migration.puremvc.framework
{
	import org.puremvc.as3.multicore.core.View;
	import org.puremvc.as3.multicore.interfaces.IMediator;
	import org.puremvc.as3.multicore.interfaces.IView;
	import org.puremvc.as3.multicore.patterns.facade.Facade;
	import org.swiftsuspenders.Injector;
	import org.swiftsuspenders.Reflector;
	
	/**
	 * Extends the PureMVC <code>View</code> with the SwiftSuspenders injector
	 * 
	 * @author pshannon
	 */
	public class PureView extends View implements IView
	{
		public static function getInstance(key:String):PureView
		{
			if ( View.instanceMap[ key ] == null ) View.instanceMap[ key ] = new PureView( key );
			return View.instanceMap[ key ];
		}
		
		
		
		protected var _reflector:Reflector = new Reflector();
		
		public function PureView(key:String)
		{
			super(key);
		}
		
		/**
		 * @inheritdoc
		 */
		public override function registerMediator(mediator:IMediator):void
		{
			// do not allow re-registration (you must to removeMediator fist)
			if ( mediatorMap[ mediator.getMediatorName() ] != null ) return;
			
			this.injector.injectInto(mediator);
			super.registerMediator(mediator);
			this.injector.mapValue(this._reflector.getClass(mediator), mediator, mediator.getMediatorName());
		}
		
		public override function removeMediator(mediatorName:String):IMediator
		{
			var mediator:IMediator = super.removeMediator(mediatorName);
			this.injector.unmap(this._reflector.getClass(mediator), mediatorName);
			return mediator;
		}
		
		/**
		 * @return provides a reference to the context's parent injector
		 */
		protected function get injector():Injector
		{
			return PureFacade.getInstance(this.multitonKey).injector;
		}
	}
}