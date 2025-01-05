public with sharing class PD1_Account_Training {

public static void createAccountDML(){

	Account acc1 = new Account();
	acc1.Name = 'Costco';
	acc1.Phone = '(444) 567-6789';
	insert acc1;

	acc1 = [select Name from Account where id =:acc1.id];
	System.debug('Account name is ' +acc1.Name);
	acc1.Name = 'Costco Wholesale';
	update acc1;

	acc1 = [select Name from Account where id =:acc1.id];
	System.debug('Account name is ' +acc1.Name);
	System.assertEquals('Costco Wholesale', acc1.Name);
}

public static void createAccountDBClass(){

	list<Account> acc2 = new list<Account>();
	acc2.add(new Account(Name = 'Safeway', Phone = '(425) 444-5678'));
	acc2.add(new Account(Name = 'Walmart', Phone = '(425) 555-5678'));
	Database.SaveResult[] sResult = Database.insert(acc2, false);

	for(Database.SaveResult sr: sResult){
		if(sr.isSuccess()){
			System.debug('Account is inserted with id ' +sr.getId());
		}
		else{
			for(Database.Error err : sr.getErrors()){
				System.debug('Insert failed due to ' +err.getStatusCode());
			}
		}
	}
}

public static void updateAccountsList(){

	list<Account> acc3 = new list<Account>();
	list<Account> acc5 = new list<Account>();
	list<Account> accountList = new list<Account>();
	set<id> ids = new set<id>();
	Integer i;

	acc3.add(new Account(Name = 'Verizon'));
	acc3.add(new Account(Name = 'AT&T'));
	insert acc3;

	for(Account accounts1 : acc3){
		ids.add(accounts1.id);
	}

	list<Account> acc4 = new list<Account>([select Id, Name, Active__c from account where id in :ids]);

	System.debug('Name of first account is ' +acc4[0].Name +' and ' +acc4[0].Active__c);
	System.debug('Name of second account is ' +acc4[1].Name +' and ' +acc4[0].Active__c);
	System.debug('Inserted ids are ' +acc4[0].Id +' and ' +acc4[1].Id);

	for(Account accounts2 : acc4){

		accounts2.Active__c = 'Yes';
		accountList.add(accounts2);
	}

	Database.update(accountList, false);

	acc5 = [select Id, Name, Active__c from account where id in :ids];
	System.debug('Name of first account is ' +acc5[0].Name +' and ' +acc5[0].Active__c);
	System.debug('Name of second account is ' +acc5[1].Name +' and ' +acc5[0].Active__c);

}

}