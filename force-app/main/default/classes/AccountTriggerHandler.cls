public with sharing class AccountTriggerHandler {
	
	public static void isAfterInsert(Account[] accRecords){
		AccountUtil.setNumberofLocations(accRecords);
        AccountUtil.createOpty(accRecords);
	}
	public static void isAfterUpdate(list<Account> accRecords){
		AccountUtil.createOpty(accRecords);
	}

	public static void isAfterDelete(){
		
	}

	public static void isAfterUnDelete(){
		
	}

	public static void isBeforeInsert(Account[] accRecords){

		AccountUtil.setShippingAddress(accRecords);

	}
}