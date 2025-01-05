public class testPullValueJson {
    public static void pullJson(){
        Account a = [Select id,Description from Account Where Id = '001i00000256r0sAAA'];
        Map<String, Object> m = (Map<String, Object>)JSON.deserializeUntyped(a.Description);
        system.debug('****'+m.get('tlElectedBenefitAmt'));
    }
}