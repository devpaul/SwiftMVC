package com.devpaul.swiftmvc.framework
{
	import com.devpaul.swiftmvc.injector.IInjector;
	
	import org.puremvc.as3.multicore.core.Controller;
	import org.puremvc.as3.multicore.interfaces.ICommand;
	import org.puremvc.as3.multicore.interfaces.IController;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.facade.Facade;
	
	/**
	 * Extends the PureMVC <code>Controller</code> with the SwiftSuspenders injector
	 * 
	 * @author pshannon
	 */
	public class SwiftController extends Controller implements IController
	{
		public static function getInstance(key:String):SwiftController
		{
			if ( Controller.instanceMap[ key ] == null ) Controller.instanceMap[ key ] = new SwiftController( key );
			return Controller.instanceMap[ key ];
		}
		
		
		
		public function SwiftController(key:String)
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
			this.view = SwiftView.getInstance(this.multitonKey);
		}
		
		/**
		 * @return provides a reference to the context's parent injector
		 */
		protected function get injector():IInjector
		{
			var facade:SwiftFacade = Facade.getInstance(this.multitonKey) as SwiftFacade;
			return facade.injector;
		}
	}
}