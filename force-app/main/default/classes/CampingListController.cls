public with sharing class CampingListController {
	
	@AuraEnabled

	public static list<Camping_Item__c> getItems(){
		String[] fieldsToCheck = new String[] {'Id','Name','Price__c','Quantity__c','Packed__c','CreatedDate'};
		Map<String, Schema.SObjectField> fieldTokens = Schema.SObjectType.Camping_Item__c.fields.getMap();

		for(String field:fieldsToCheck){
			if(!fieldTokens.get(field).getDescribe().isAccessible()){
				throw new system.NoAccessException();
				return null;
			}
		}
		return [select Id, Name, Price__c, Quantity__c, Packed__c, CreatedDate from Camping_Item__c];
		
	}

	@AuraEnabled
	public static Camping_Item__c saveItem(Camping_Item__c item){
		upsert item;
		return item;
	}
}