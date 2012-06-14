package test {
    import mx.utils.UIDUtil;

    [Ignore]
    public final class TestUtil {
        public static function get anyString():String {
            return UIDUtil.createUID();
        }
    }
}
