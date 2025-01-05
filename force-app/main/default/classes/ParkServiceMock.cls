@isTest
global class ParkServiceMock implements WebServiceMock {
   global void doInvoke(
           Object stub,
           Object request,
           Map<String, Object> response,
           String endpoint,
           String soapAction,
           String requestName,
           String responseNS,
           String responseName,
           String responseType) {
        // start - specify the response you want to send
        ParkService.byCountryResponse  response_x = 
            new ParkService.byCountryResponse ();
        List<String> ls = new List<String>();
        ls.add('park1');
        ls.add('park2');       
        response_x.return_x = ls;
        // end
        response.put('response_x', response_x); 
   }
}