public class EmailMissionSpecialist {
    public void sendEmail(String address, String subject, String body){
        messaging.SingleEmailMessage mail = new messaging.SingleEmailMessage();
        String[] toAddresses = new String[] {address};
        mail.setToAddresses(toAddresses);
        mail.setSubject(subject);
        mail.setPlainTextBody(body);  
        messaging.SendEmailResult[] results = 
            messaging.sendEmail(new messaging.SingleEmailMessage[] {mail});
        inspectResults(results);
    }    
    private static Boolean inspectResults(messaging.SendEmailResult[] results){
        Boolean sendResult = true;
        for(messaging.SendEmailResult res : results){
            if(res.isSuccess()){
                System.debug('Email sent successfully');
            }
            else{
                sendResult = false;
                System.debug('Errors occured is' + res.getErrors());
            }
        }
        return sendResult;
    }
}