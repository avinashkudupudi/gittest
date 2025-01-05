public class ContactAndLeadSearch {
	public static List<List<SObject>> searchContactsAndLeads(String str) {

		String str1 = str;
		Contact con = new Contact(LastName = 'Smith');
		Lead lead = new Lead(LastName = 'Smith', Company = 'Smith Corp.');
		insert con;
		insert lead;
		List<List<SObject>> searchList = new List<List<SObject>>();
		searchList = [Find :str1 in ALL FIELDS RETURNING Contact(FirstName,LastName), Lead(FirstName, LastName)];
		return searchList;
	}
}