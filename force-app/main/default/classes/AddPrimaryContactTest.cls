@isTest
public class AddPrimaryContactTest {
    @testSetup 
    static void setup() {
        List<Account> accounts = new List<Account>();
        for (Integer i = 0; i < 50; i++) {
               accounts.add(new Account(Name='Test Account'+i,BillingState ='NY')); 
        }
        for (Integer j = 0; j < 50; j++) {
               accounts.add(new Account(Name='Test Account'+j,BillingState ='CA')); 
        }
            
        insert accounts;
    }
    
    static testmethod void testQueueable() {
        // query for test data to pass to queueable class
        String state = 'CA';
        Contact contact = new Contact(LastName='SafariKid');
        insert contact;
        // Create our Queueable instance
        AddPrimaryContact updater = new AddPrimaryContact(contact, state);
        // startTest/stopTest block to force async processes to run
        Test.startTest();        
        System.enqueueJob(updater);
        Test.stopTest();        
        // Validate the job ran. Check if record have correct parentId now
        System.assertEquals(50, [select count() from contact WHERE accountId IN (Select id from Account WHERE BillingState =:state)]);
    }
}