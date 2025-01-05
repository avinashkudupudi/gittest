@RestResource(urlMapping='/CreateAccount/*')
global with sharing class AccountRestService {
    @HttpPost
    global static list<Id> doPost(List<AccountWrapper> AccountMap) {
        List<Account> AccountsToInsert = new List<Account>();

		for (AccountWrapper account : AccountMap) {
			AccountsToInsert.add(account.getAccount());
		}
		insert AccountsToInsert;

		Map<Id, Account> AMap = new Map<Id, Account>(AccountsToInsert);
		return new List<Id>(AMap.keySet());
    }
    global class AccountWrapper {
		public String Name;
		public String Site;
		public Account getAccount() {

			return new Account(
				Name = this.Name,
				Site = this.Site
			);
		}
	}

}