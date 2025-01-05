public with sharing class AccountUtil {

	public static boolean isExecuting = false;

// Method to update Trigger.new reocrd in before insert context.	
	
	public static void setShippingAddress(Account[] accRecords)
	{
		for(Account accList:accRecords){
			if(accList.Match_Billing_Address__c){
				accList.ShippingStreet = accList.BillingStreet;
				//accList.ShippingCountryCode = accList.BillingCountryCode;
				accList.ShippingCity = accList.BillingCity;
				//accList.ShippingStateCode = accList.BillingStateCode;
				accList.ShippingPostalCode = accList.BillingPostalCode;
			}
		}
	}

// Method example to update Trigger.new record in after insert context

	public static void setNumberofLocations(Account[] accRecords)
	{
		list<Account> accList1 = new list<Account>();
		for(Account accList:accRecords){
			Account acc = new Account();
			acc.Id = accList.Id;
			acc.NumberofLocations__c = 5;
			accList1.add(acc);
		}
		update accList1;
	}

// Method example for after update conetxt

	public static void setSomething(Account[] accRecords)
	{
		if(AccountUtil.isExecuting)
		{
			return;
		}
		AccountUtil.isExecuting = True;
		//Actual logic
	}
// Method to create opportunity after an account is created or updated
    public static void createOpty(list<Account> accList){
        Map<Id, Opportunity> optyMap = new Map<Id, Opportunity>([select id, accountid, name from opportunity where accountid in :accList]);
        Map<Id,Account> acctsWithOpps = new Map<Id,Account>(
        [SELECT Id,(SELECT Id,Name FROM Opportunities) FROM Account WHERE Id IN :Trigger.New]);
        system.debug('****This is the magic1'+acctsWithOpps);
        List<Account> acctsWithOpps1 = 
        [SELECT Id,(SELECT Id,Name,CloseDate FROM Opportunities) 
         FROM Account WHERE Id IN :accList];
        system.debug('****This is the magic2'+acctsWithOpps1);
        /*set<id> aId = new set<id>();
        for(opportunity opty: optyMap.values()){
            aId.add(opty.accountid);
        }
        for(Account acc:accList){
            if(aId.contains(acc.Id)){
                system.debug(+acc.Id);
            }
            else{
                opportunity opp = new opportunity(Name = 'Opty', AccountId = acc.Id);
            }
        }*/
        
    }    
}