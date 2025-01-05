global class CreateContactEmailService implements Messaging.InboundEmailHandler {
	  global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email, Messaging.InboundEnvelope envelope) {
		  Messaging.InboundEmailResult result = new Messaging.InboundEmailresult();
          Contact[] con = new Contact[0];
          try{
              con.add(new Contact(FirstName = 'TestFirst', LastName = 'TestLast', Email = email.fromAddress, AccountId = '001i000000kEaN1AAK'));
              insert con;
              System.debug('New Contact is: ' + con );
          }
          catch (QueryException e) {
          System.debug('Query Issue: ' + e);
         }
          result.success = true;
          return result;
      }
  }