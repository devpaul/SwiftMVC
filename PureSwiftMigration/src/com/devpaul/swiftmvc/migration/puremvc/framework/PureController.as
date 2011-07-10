package com.devpaul.swiftmvc.migration.puremvc.framework
{
	import org.puremvc.as3.multicore.core.Controller;
	import org.puremvc.as3.multicore.interfaces.ICommand;
	import org.puremvc.as3.multicore.interfaces.IController;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.facade.Facade;
	import org.swiftsuspenders.Injector;
	
	/**
	 * Extends the PureMVC <code>Controller</code> with the SwiftSuspenders injector
	 * 
	 * @author pshannon
	 */
	public class PureController extends Controller implements IController
	{
		public static function getInstance(key:String):PureController
		{
			if ( Controller.instanceMap[ key ] == null ) Controller.instanceMap[ key ] = new PureController( key );
			return Controller.instanceMap[ key ];
		}
		
		
		
		public function PureController(key:String)
		{
			super(key);
		}
		
		/**
		 * @inheritdoc 
		 */
		public override function executeCommand(note:INotification):void
		{
			var commandClassRef:Class = this.commandMap[ note.getName() ];
			if ( commandClassRef == null ) return;
			
			var commandInstance:ICommand = this.injector.instantiate(commandClassRef) as ICommand;
			commandInstance.initializeNotifier(this.multitonKey);
			commandInstance.execute(note);
		}
		
		/**
		 * @inheritdoc 
		 */
		protected override function initializeController():void
		{
			this.view = PureView.getInstance(this.multitonKey);
		}
		
		/**
		 * @return provides a reference to the context's parent injector
		 */
		protected function get injector():Injector
		{
			var facade:PureFacade = Facade.getInstance(this.multitonKey) as PureFacade;
			return facade.injector;
		}
	}
}