trigger BatchApexErrorTrigger on BatchApexErrorEvent (after insert) {
    list<BatchLeadConvertErrors__c> batchErrors = new list< BatchLeadConvertErrors__c>();
    for(BatchApexErrorEvent errorList:Trigger.new){
       batchErrors.add(new BatchLeadConvertErrors__c(AsyncApexJobId__c = errorList.AsyncApexJobId, Records__c = errorList.JobScope, 
                                                    StackTrace__c  = errorList.StackTrace )); 
    }
    insert batchErrors;
}