package com.devpaul.swiftmvc.migration.puremvc.patterns.command
{
	import com.devpaul.swiftmvc.migration.puremvc.framework.PureFacade;
	
	import org.puremvc.as3.multicore.interfaces.ICommand;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.interfaces.INotifier;
	import org.puremvc.as3.multicore.patterns.observer.Notifier;
	import org.swiftsuspenders.Injector;
	
	/**
	 * Provides a drop-in replacement for PureMVC's MacroCommand for when you need injection in
	 * the child commands.  this code was pulled practically verbatim from PureMVC because execute
	 * is marked as final, preventing overriding command creation to provide injection :(.
	 * 
	 * @author PureMVC, pshannon
	 */
	public class PureMacroCommand extends Notifier implements ICommand, INotifier
	{
		protected var subCommands:Array = new Array();
		
		protected var _notification:INotification;
		
		/**
		 * Constructor. 
		 * 
		 * <P>
		 * You should not need to define a constructor, 
		 * instead, override the <code>initializeMacroCommand</code>
		 * method.</P>
		 * 
		 * <P>
		 * If your subclass does define a constructor, be 
		 * sure to call <code>super()</code>.</P>
		 */
		public function PureMacroCommand()
		{
			initializeMacroCommand();
		}
		
		/**
		 * @return a reference to the SwiftMVC injector
		 */
		protected function get injector():Injector
		{
			return PureFacade(this.facade).injector;
		}
		
		/**
		 * Initialize the <code>SwiftMacroCommand</code>.
		 * 
		 * <P>
		 * In your subclass, override this method to 
		 * initialize the <code>MacroCommand</code>'s <i>SubCommand</i>  
		 * list with <code>ICommand</code> class references like 
		 * this:</P>
		 * 
		 * <listing>
		 *		// Initialize MyMacroCommand
		 *		override protected function initializeMacroCommand( ) : void
		 *		{
		 *			addSubCommand( com.me.myapp.controller.FirstCommand );
		 *			addSubCommand( com.me.myapp.controller.SecondCommand );
		 *			addSubCommand( com.me.myapp.controller.ThirdCommand );
		 *		}
		 * </listing>
		 * 
		 * <P>
		 * Note that <i>SubCommand</i>s may be any <code>ICommand</code> implementor,
		 * <code>MacroCommand</code>s or <code>SimpleCommands</code> are both acceptable.
		 */
		protected function initializeMacroCommand():void
		{
		}
		
		/**
		 * Add a <i>SubCommand</i>.
		 * 
		 * <P>
		 * The <i>SubCommands</i> will be called in First In/First Out (FIFO)
		 * order.</P>
		 * 
		 * @param commandClassRef a reference to the <code>Class</code> of the <code>ICommand</code>.
		 */
		protected function addSubCommand( commandClassRef:Class ): void
		{
			this.subCommands.push(commandClassRef);
		}
		
		/**
		 * Instantiate and execute the command
		 * 
		 * @param commandClassRef the command class to instantiate and execute
		 */
		protected function executeCommand(commandClassRef:Class):void
		{
			var commandInstance : ICommand = this.injector.instantiate(commandClassRef);
			commandInstance.initializeNotifier( multitonKey );
			commandInstance.execute( this._notification );
		}
		
		/** 
		 * Execute this <code>MacroCommand</code>'s <i>SubCommands</i>.
		 * 
		 * <P>
		 * The <i>SubCommands</i> will be called in First In/First Out (FIFO)
		 * order. 
		 * 
		 * @param notification the <code>INotification</code> object to be passsed to each <i>SubCommand</i>.
		 */
		public final function execute( notification:INotification ) : void
		{
			this._notification = notification;
			
			while ( subCommands.length > 0) {
				executeCommand(subCommands.shift());
			}
		}
	}
}