public  class RandomContactFactory {

	public static list<Contact> generateRandomContacts(integer i,string str) {
		
		list<Contact> con = new list<Contact>();
		for(integer j=1;j<=i;j++){
			con.add(new Contact(FirstName='Test' + j, LastName = str));
		}

		return con;
	}
}