@isTest
private class LeadProcessorTest {
    @testSetup 
    static void setup() {
        List<Lead> leads = new List<Lead>();
        //List<Contact> contacts = new List<Contact>();
        // insert 10 accounts
        for (Integer i=0;i<200;i++) {
            leads.add(new Lead(LastName='TestLast '+i, 
                Company='Square'));
        }
        insert leads;
        // find the account just inserted. add contact for each
        //for (Account account : [select id from account]) {
          //  contacts.add(new Contact(firstname='first', 
            //    lastname='last', accountId=account.id));
        //}
        //insert contacts;
    }
    static testmethod void test() {        
        Test.startTest();
        LeadProcessor lp = new LeadProcessor();
        Id batchId = Database.executeBatch(lp);
        Test.stopTest();
        // after the testing stops, assert records were updated properly
        System.assertEquals(200, [select count() from Lead]);
    }    
}