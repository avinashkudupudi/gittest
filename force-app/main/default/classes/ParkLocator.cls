public class ParkLocator {
    public static List<String> country (String c) {
        ParkService.ParksImplPort p = 
            new ParkService.ParksImplPort();
        return p.byCountry(c);
    }
}