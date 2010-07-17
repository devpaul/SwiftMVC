package com.devpaul.swiftmvc.injector
{
	import org.swiftsuspenders.InjectionConfig;

	public interface IInjector
	{
		/**
		 * Inject dependencies into the target object
		 * 
		 * @param target the dependency target
		 */
		function injectInto(target : Object) : void;
		
		/**
		 * Instantiate the class and inject dependencies into the target.
		 * Use this method to inject construtor dependencies.
		 * 
		 * @param clazz the target class to instantiate and inject
		 * @return An instance of the class with satisfied dependicies
		 */
		function instantiate(clazz:Class):*;
			
		/**
		 * @param clazz The class of the registered dependency
		 * @param named the name of the registered dependency
		 * @return if the provided class/naming pair represents a mapped dependency
		 */
		function hasMapping(clazz : Class, named : String = '') : Boolean
			
		/**
		 * Provides an instance of a named dependency
		 * 
		 * @param clazz the class of the registered dependency
		 * @param named the name of the registered dependency
		 * @return an instance of a dependency matching the clazz/named combination
		 * 
		 * @throws InjectorError if the dependency does not exist
		 */
		function getInstance(clazz : Class, named : String = '') : *
			
		/**
		 * Removes a mapping with a matching class and name mapping from the injector 
		 * @param clazz the class of the registered dependency
		 * @param named the name of the registered dependency
		 */
		function unmap(clazz : Class, named : String = "") : void
	}
}