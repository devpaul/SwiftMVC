package com.devpaul.swiftmvc.support.model
{
	import com.devpaul.swiftmvc.framework.context.Context;
	
	import flash.errors.IllegalOperationError;
	import flash.utils.Dictionary;

	public class ContextMap
	{
		private var _length:int = 0;
		
		private var _map:Dictionary = new Dictionary();
		
		public function ContextMap()
		{
		}
		
		public function get length():int
		{
			return this._length;
		}
		
		/**
		 * This method executes in O(n) time
		 * 
		 * @return a list of all the registered context names
		 */
		public function get contextNames():Array
		{
			var names:Array = [];
			
			for(var key:String in this._map)
				names.push(key);
				
			return names;
		}
		
		public function hasContext(name:String):Boolean
		{
			return getContext(name) != null;
		}
		
		public function addContext(context:Context):void
		{
			if(hasContext(context.name))
				throw new IllegalOperationError("Context with same name already registered");
			
			this._length++;
			this._map[context.name] = context;
		}
		
		public function getContext(name:String):Context
		{
			return this._map[name];
		}
		
		public function removeContext(name:String):Context
		{
			if(!hasContext(name))
				throw new IllegalOperationError("Context cannot be removed -- never registered");
			
			return removeExistingContext(name);
		}
		
		public function removeContextIfExists(name:String):Context
		{
			if(!hasContext(name))
				return null;
			
			return removeExistingContext(name);
		}
		
		private function removeExistingContext(name:String):Context
		{
			var context:Context = getContext(name);
			this._length--;
			delete this._map[name];
			return context;
		}
	}
}