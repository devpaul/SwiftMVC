package com.devpaul.swiftmvc.framework.invoker
{
	import com.devpaul.swiftmvc.framework.context.Context;
	
	import mx.utils.UIDUtil;
	
	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertNotNull;
	import org.flexunit.asserts.assertNull;
	import org.swiftsuspenders.Injector;
	
	import test.mocks.invoker.MockBasicCommand;
	import test.mocks.invoker.MockBasicMultipleCommand;
	import test.mocks.invoker.MockNamedParamCommand;
	import test.mocks.invoker.MockParamCommand;

	public class InvokerTest
	{
		private var context:Context;
		private var invoker:Invoker;
		
		[Before]
		public function setUp():void
		{
			this.context = new Context(UIDUtil.createUID());
			this.invoker = new Invoker(context.injector);
			this.context.injector.mapClass(Object, Object);
			this.context.injector.mapSingleton(Object, "namedObject");
		}
		
		[Test]
		public function testExecution_classWithoutExecutionTags():void
		{
			var cmd:Object = new Object();
			invoker.execute(cmd);
		}
		
		[Test]
		public function testExecution_classWithExecuteTag_noParams():void
		{
			var cmd:MockBasicCommand = new MockBasicCommand();
			assertEquals(0, cmd.numExecuteCalls);
			invoker.execute(cmd);
			assertEquals(1, cmd.numExecuteCalls);
		}
		
		[Test]
		public function testExecution_commandClassConstruction():void
		{
			invoker.execute(MockBasicCommand);
		}
		
		[Test]
		public function testExecution_classWithParamertizedExecution():void
		{
			var cmd:MockParamCommand = new MockParamCommand();
			assertNull(cmd.object);
			invoker.execute(cmd);
			assertNotNull(cmd.object);
		}
		
		[Test]
		public function testExecution_commandClassConstructionWithParamExecution():void
		{
			invoker.execute(MockParamCommand);
		}
		
		[Test]
		public function testExecution_multipleExecutionsWithParamExecution():void
		{
			var cmd:MockBasicMultipleCommand = new MockBasicMultipleCommand();
			assertNull(cmd.object);
			assertEquals(0, cmd.numExecutes);
			invoker.execute(cmd);
			assertNotNull(cmd.object);
			assertEquals(2, cmd.numExecutes);
		}
		
		[Test]
		public function testExecution_classWithNamedParam():void
		{
			var cmd:MockNamedParamCommand = new MockNamedParamCommand();
			assertNull(cmd.object);
			invoker.execute(cmd);
			assertNotNull(cmd.object);
			assertEquals(cmd.object, this.context.injector.getInstance(Object, "namedObject"));
		}
	}
}