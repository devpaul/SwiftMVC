package com.devpaul.swiftmvc.migration.puremvc.patterns.command
{
	import com.devpaul.swiftmvc.migration.puremvc.framework.PureFacade;
	
	import org.puremvc.as3.multicore.interfaces.ICommand;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	import org.swiftsuspenders.Injector;
	
	/**
	 * Extends <code>SimpleCommand</code> to provide a reference to the injector
	 * 
	 * @author pshannon
	 * 
	 * @see SimpleCommand
	 */
	public class PureCommand extends SimpleCommand implements ICommand
	{
		public function PureCommand()
		{
			super();
		}
		
		/**
		 * @return a reference to the SwiftMVC injector
		 */
		protected function get injector():Injector
		{
			return PureFacade(this.facade).injector as Injector;
		}
	}
}