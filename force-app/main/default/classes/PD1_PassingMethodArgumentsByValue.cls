public class PD1_PassingMethodArgumentsByValue {
	
	public static void primitiveVariable(){
		String string1 = 'Original Value';
		assignValue(string1);
		System.debug(string1);
	}	

	public static void nonPrimitiveVariable(){
		List<Integer> Integer1 = new List<Integer>();
		System.debug(Integer1.size());
		assignValue(Integer1);
		System.debug(Integer1.size());
	}

	public static void assignValue(String string2){
		string2 = 'Modified Value';
	}

	public static void assignValue(List<Integer> Integer2){
		Integer2.add(1);
		Integer2.add(2);
		Integer2.add(3);
		Integer2.add(4);
		Integer2.add(5);
	}

	public static void assignValue2(List<Integer> Integer2){
		List<Integer> Integer3 = new List<Integer>{1,2,3,4,5};
		Integer2 = Integer3;
	}
}