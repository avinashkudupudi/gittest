/**
* @description       : 1) Send Emails to M&A Queue members when Closed Date of Opportunity is Updated.
* @Story No          : Phase 1 - 169
* @author            : 
* @group             : 
* @last modified on  : 02-09-2022
* @last modified by  : 
**/
public class OptyHistoryEmail {
    @InvocableMethod(label='SampleClosedDate')
    //Create an apex method 
    //InvocalbleMethod Annotation can be used only once in one class. 
    //the method should be static. and either public or global
    //the method can only have atmost one input.
    //Method to send Mails when Closed Date is Updated.
    public static void sendMails(List<OpportunityFieldHistory> Oppty){
        //Creating list to store Mails.
        list<Messaging.SingleEmailMessage> mailList = new list<Messaging.SingleEmailMessage>();
        List<Id>userIds = new List<Id>();
        userIds.add(UserInfo.getUserId());
       
        List<User> users = [SELECT ID,Username,Email FROM User WHERE ID IN : userIds];
        //Creating list to store mail Ids of all the group members.
        List<String>mailIds = new List<String>();
        mailIds.add('avinashkudupudi@gmail.com');        
        Map<Id, String> oppMap = new Map<Id,String>();
        List<ID> oppId = new List<ID>();
        for(OpportunityFieldHistory op1 : Oppty){
            oppId.add(op1.OpportunityId);
        }
        
        for(Opportunity opp : [SELECT Id, Name FROM Opportunity WHERE id IN: oppId]){
            if(!oppMap.containsKey(opp.Id)){
                oppMap.put(opp.Id, opp.Name);
            }
        }
        
        //Creating email message to be sent.
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setSubject('Opportunity Closed Date updated !');
        String outputMail = 'Hi ' + ', ';
        outputMail += '<br>Closed Date has been updated for the below Opportunities.<br/><br/>';
        outputMail += '<table border="solid black" style="border-collapse: collapse"> <tr> <th style="width: 200px" > Name </th> <th style="width: 200px" > Old Closed Date </th> <th style="width: 200px" > New Closed Date </th> </tr>';
       
        for(OpportunityFieldHistory o: Oppty){ 
            String recordURL = System.URL.getSalesforceBaseUrl().toExternalForm() + '/'+o.OpportunityId;
            outputMail = outputMail +' <tr> <td style="width: 200px; text-align:center" > <a href ='+recordURL+' > '+oppMap.get(o.OpportunityId)+' </a>  </td> <td style="width: 200px; text-align:center" > '+ o.OldValue +' </td>  </td> <td style="width: 200px; text-align:center" > '+ o.NewValue +' </td> </tr> ';
        }
        
        mail.setHtmlBody(outputMail);
        mail.setToAddresses(mailIds);
        //Add each email message to the List created to store the emails.
        mailList.add(mail); 
        
        
        // if(!mailList.isEmpty())
       // Messaging.sendEmail(mailList);
        
                Messaging.SendEmailResult[] results = Messaging.sendEmail(mailList);
        if (results[0].success) {
            System.debug('The email was sent successfully.');
        } else {
            System.debug('The email failed to send: '
                         + results[0].errors[0].message);
        }
        
    }    
}