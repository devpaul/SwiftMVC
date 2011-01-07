package test.mocks
{
	import org.puremvc.as3.multicore.interfaces.IProxy;
	import org.puremvc.as3.multicore.patterns.proxy.Proxy;
	
	/**
	 * Holds the Mock Domain Model.  If this were a real proxy the DM might send out
	 * events when the count changes and the Proxy could send notifications.  Typically
	 * we wouldn't create a proxy to just hold a reference to a DM; we'd rely on the
	 * injector to hold and create it.
	 * 
	 * @author pshannon
	 */
	public class MockProxy extends Proxy implements IProxy
	{
		public static const NAME:String = "MockProxy";
		
		protected var _dm:MockDM = null;
		
		public function MockProxy(proxyName:String=null, data:Object=null)
		{
			super(proxyName, data);
		}
		
		[Inject]
		public function initialize(mockDM:MockDM):void
		{
			if(this._dm == null)
			{
				this._dm = mockDM;
			}
		}
		
		public function get dm():MockDM
		{
			return this._dm;
		}
	}
}