public with sharing class PD2_AccountController_AccCreateUpdate {

	public Account account { get; private set; }
	public PD2_AccountController_AccCreateUpdate() {
		Id id = ApexPages.CurrentPage().getParameters().get('id');
		account = (id == null) ? new Account() :[select id, name, industry from Account where Id =:id];	
	}

	public pageReference save(){
		try{
			upsert account;
		}
		catch(System.DmlException e){
			ApexPages.addmessages(e);
			return null;
		}
		pageReference result = new ApexPages.StandardController(Account).view();
		return (result);
	}
}