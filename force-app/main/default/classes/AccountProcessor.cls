public class AccountProcessor {

    @future
    public static void countContacts(list<Id> acctIds){
        Map<Id, Account> accMap = new Map<Id, Account>([Select Id, (Select Id, FirstName from Contacts) from Account where id in: acctIds]);
        list<Account> accUpList = new list<Account>();
        for(Id ar :acctIds){
            If(accMap.containskey(ar)){
               accUpList.add(new Account(Id = ar,Number_of_Contacts__c = accMap.get(ar).Contacts.size())); 
            } 
        }
        if(accUpList.size()>0){
            update accUpList;
        }
    } 
    
}