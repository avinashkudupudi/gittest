@isTest
private class AccountProcessorTest {
    @isTest
    static void testMethod1(){
        Account acc = new Account(Name = 'TestAccFuture');
        insert acc;
        list<Id> ids = new list<Id>();
        ids.add(acc.Id);
        Contact con = new Contact(LastName = 'TestLastFuture',AccountId = acc.Id);
        insert con;
        test.startTest();
            AccountProcessor.countContacts(ids);
        test.stopTest();
    }
}