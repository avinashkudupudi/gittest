public with sharing class PD2_AccountController {
	
	private final Account account;

	public PD2_AccountController() {

		account = [select id, name, industry from account where id =:ApexPages.currentPage().getParameters().get('id')];
		
	}

	public account getAccount(){
		return account;
	}

	public pageReference save(){
		update account;
		return null;
	}
}