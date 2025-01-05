public class AnimalLocator {
    public static String getAnimalNameById (Integer inti) {
        String str = '';
        Http http = new Http();
        String ep = 'https://th-apex-http-callout.herokuapp.com/animals/'+inti;
        HttpRequest request = new HttpRequest();
        request.setEndpoint(ep);
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        // If the request is successful, parse the JSON response.
        if (response.getStatusCode() == 200) {
            // Deserializes the JSON string into collections of primitive data types.
            Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            Map<String, Object> result = (Map<String, Object>)results.get('animal');
            str = (String)result.get('name');
        }
        return str;
    }    
}