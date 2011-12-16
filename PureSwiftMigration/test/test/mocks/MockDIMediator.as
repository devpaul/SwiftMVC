package test.mocks {
    import com.devpaul.swiftmvc.migration.puremvc.framework.PureFacade;

    import org.puremvc.as3.multicore.interfaces.IFacade;
    import org.puremvc.as3.multicore.patterns.mediator.Mediator;

    public class MockDIMediator extends Mediator {
        public static const NAME:String = "MockDIMediator";

        [Inject]
        public var pureFacade:PureFacade;

        public function MockDIMediator() {
            super(NAME);
        }
    }
}
