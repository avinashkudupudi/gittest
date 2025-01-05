public class ContactSearch {
	public static List<Contact> searchForContacts(String lName, String mPostalCode) {

		String lName1 = lName;
		String mPostalCode1 = mPostalCode;
		list<Contact> con = new list<Contact>();
		con = [select Id, FirstName, LastName from Contact where LastName = :lName1 And MailingPostalCode = :mPostalCode1];
		return con;
	}
}