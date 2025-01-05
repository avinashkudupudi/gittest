@IsTest
private class AccountManagerTest {
    @isTest static void testGetCaseById() {
        Id recordId = createTestRecord();
        // Set up a test request
        RestRequest request = new RestRequest();
        request.requestUri =
            'https://avinash22-dev-ed.my.salesforce.com/services/apexrest/Accounts/'
            + recordId +'/contacts';
        request.httpMethod = 'GET';
        RestContext.request = request;
        // Call the method to test
        Account thisAccount = AccountManager.getAccount();
        // Verify results
        System.assert(thisAccount != null);
        System.assertEquals('Test Account', thisAccount.Name);
    }
	static Id createTestRecord() {
        // Create test record
        Account accountTest = new Account(
            Name='Test Account');
        insert accountTest;
        Contact contactTest = new Contact(
        	FirstName = 'Frist',LastName = 'Last',AccountId = accountTest.Id);
        insert contactTest;
        return accountTest.Id;  
    }

}