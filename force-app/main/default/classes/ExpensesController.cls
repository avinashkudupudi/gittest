public with sharing class ExpensesController {
	
	@AuraEnabled

	public static list<Expense__c> getExpenses(){
		String[] fieldsToCheck = new String[] {'Id','Name','Amount__c','Client__c','Date__c','Reimbursed__c','CreatedDate'};
		Map<String, Schema.SObjectField> fieldTokens = Schema.SObjectType.Expense__c.fields.getMap();

		for(String field:fieldsToCheck){
			if(!fieldTokens.get(field).getDescribe().isAccessible()){
				throw new system.NoAccessException();
				return null;
			}
		}
		return [select Id, Name, Amount__c, Client__c, Date__c, Reimbursed__c, CreatedDate from Expense__c];
		
	}

	@AuraEnabled
	public static Expense__c saveExpense(Expense__c expense){
		upsert expense;
		return expense;
	}
}