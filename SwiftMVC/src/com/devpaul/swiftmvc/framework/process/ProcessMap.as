package com.devpaul.swiftmvc.framework.process
{
	import flash.errors.IllegalOperationError;
	import flash.utils.Dictionary;
	
	/**
	 * Holds a single reference to a process and provides an id to refer back to the process.
	 * When a <code>ProcessMap</code> is held by the context or other singleton it can be used
	 * to keep command and other transitory information in scope during execution.
	 * 
	 * @author pshannon
	 */
	public class ProcessMap
	{
		public static const NON_EXISTANT_PROCESS_ID:int = int.MIN_VALUE;
		
		private var _processId:int = 0;
		
		protected var _idToProcessMap:Dictionary = new Dictionary();
		
		protected var _processToIdMap:Dictionary = new Dictionary();
		
		public function ProcessMap()
		{
			super();
		}
		
		public function registerProcess(process:Object):int
		{
			if(!process)
				throw new IllegalOperationError("Cannot register a null process");
			
			if(hasProcess(process))
				return getProcessId(process);
			
			return mapUniqueProcess(process);
		}
		
		public function releaseProcess(id:int):Object
		{
			var process:Object = getProcess(id);
			
			if(process)
				releaseKnownProcess(id, process);
			
			return process;
		}
		
		public function getRegisteredProcessIds():Array
		{
			var ids:Array = [];
			
			for each(var id:int in this._idToProcessMap)
				ids.push(id);
			
			return ids;
		}
		
		public function hasProcessById(id:int):Boolean
		{
			return this._idToProcessMap[id] != null;
		}
		
		public function hasProcess(process:Object):Boolean
		{
			return this._processToIdMap[process] != null;
		}
		
		public function getProcessId(process:Object):int
		{
			return (hasProcess(process) ? this._processToIdMap[process] : NON_EXISTANT_PROCESS_ID);
		}
		
		public function getProcess(id:int):Object
		{
			return this._idToProcessMap[id];
		}
		
		protected function get uniqueProcessId():int
		{
			return this._processId++;
		}
		
		protected function releaseKnownProcess(id:int, process:Object):void
		{
			delete this._idToProcessMap[id];
			delete this._processToIdMap[process];
		}
		
		protected function mapUniqueProcess(process:Object):int
		{
			var id:int = uniqueProcessId;
			this._idToProcessMap[id] = process;
			this._processToIdMap[process] = id;
			return id;
		}
	}
}