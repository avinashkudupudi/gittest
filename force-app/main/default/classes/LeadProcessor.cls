global class LeadProcessor implements 
    Database.Batchable<sObject>, Database.Stateful {
    
    // instance member to retain state across transactions
    global Integer recordsProcessed = 0;
    global Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator(
            'SELECT ID, LeadSource from Lead'
        );
    }
    global void execute(Database.BatchableContext bc, List<Lead> scope){
        // process each batch of records
        List<Lead> leads = new List<Lead>();
        for (Lead lead : scope) {
            //for (Contact contact : account.contacts) {
                //contact.MailingStreet = account.BillingStreet;
                //contact.MailingCity = account.BillingCity;
                //contact.MailingState = account.BillingState;
                lead.LeadSource  = 'Dreamforce';
                // add contact to list to be updated
                leads.add(lead);
                // increment the instance member counter
                recordsProcessed = recordsProcessed + 1;
            }
        update leads;
    }    
    global void finish(Database.BatchableContext bc){
        //System.debug(recordsProcessed + ' records processed. Shazam!');
        //AsyncApexJob job = [SELECT Id, Status, NumberOfErrors, 
            //JobItemsProcessed,
            //TotalJobItems, CreatedBy.Email
            //FROM AsyncApexJob
            //WHERE Id = :bc.getJobId()];
        // call some utility to send email
        //EmailUtils.sendMessage(job, recordsProcessed);
    }    
}