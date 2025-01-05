@isTest

private class TestRestrictContactByName {

	@isTest
	static void restrictContactTestMethod1()
	{
		Contact con = new Contact(FirstName = 'John', LastName = 'INVALIDNAME');
		//Adding multiple records to a list
		/*list<Contact> con = new list<Contact> { new Contact(FirstName = 'John', LastName = 'INVALIDNAME'), 
		new Contact(FirstName = 'Tom', LastName = 'Smith')};*/ 
		Database.SaveResult result = Database.insert(con,false);

		System.assert(!result.isSuccess());
		System.assert(result.getErrors().size()>0);
		System.debug(result.getErrors()[0].getMessage());
		System.assertEquals('The Last Name "INVALIDNAME" is not allowed for DML',result.getErrors()[0].getMessage());

	}

	@isTest
	static void restrictContactTestMethod2()
	{
		Contact con2 = new Contact(FirstName = 'Tom', LastName = 'Smith');
		insert con2;
		Contact con3 = [select FirstName, LastName from contact where id = :con2.id];
		con3.LastName = 'INVALIDNAME';
		Database.SaveResult result = Database.update(con3,false);
		System.assert(!result.isSuccess());
		System.assert(result.getErrors().size()>0);
		System.debug(result.getErrors()[0].getMessage());
		System.assertEquals('The Last Name "INVALIDNAME" is not allowed for DML',result.getErrors()[0].getMessage());

	}
	
}