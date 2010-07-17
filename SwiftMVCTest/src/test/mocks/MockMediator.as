package test.mocks
{
	import flash.utils.getTimer;
	
	import org.puremvc.as3.multicore.interfaces.IMediator;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	
	public class MockMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "MockInjectableMediator";
		
		protected var _strDep3:String;
		
		public function MockMediator(mediatorName:String=null, viewComponent:Object=null)
		{
			super(mediatorName, viewComponent);
		}
		
		[Inject(name="strDep1")]
		public var strDep1:String;
		
		[Inject(name="strDep2")]
		public var strDep2:String;
		
		[Inject(name="strDep3")]
		public function set strDep3(value:String):void
		{
			this._strDep3 = value;
		}
		
		public function getStringDep3():String
		{
			return this._strDep3;
		}
		
		public function getTimer():int
		{
			return flash.utils.getTimer();
		}
	}
}