public class LL_GooglePlacesAPIHelper {
    /**
    * @description Method to getRenderTaskStatus
    * @return String
    */
    public static void getGeoCodes(){
    HttpRequest req  = new HttpRequest();
    HttpResponse res  = new HttpResponse();
        string str = genUrlEncode('1 Main Street,Brooklyn NY');
    req.setEndpoint('https://maps.googleapis.com/maps/api/geocode/json?address='+str+'&key=AIzaSyDNPzXo0L-lP_k1vP8KNe5WWTOcY3adsxE');
    req.setMethod('GET');
    req.setHeader('Content-Encoding', 'UTF-8');
    req.setHeader('Connection', 'keep-alive');
    Http http = new Http();
    res = http.send(req);
    Map<String,Object> results = (Map<String,Object>)JSON.deserializeUntyped(res.getBody());
    System.debug('****'+results);
    }
    public static string genUrlEncode(String str){
        String str1 = EncodingUtil.urlEncode(str,'UTF-8');
        return str1;
    }

}