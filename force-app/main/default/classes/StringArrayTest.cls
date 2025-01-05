public class StringArrayTest {

	public static list<string> generateStringArray(integer n) {

		list<String> ListOfStrings = new list<String>();
		Integer s = n;
		Integer i;
		for(i = 0; i<s; i++){
			ListOfStrings.add('Test ' +i);
		}
		return ListOfStrings;
		
	}
}