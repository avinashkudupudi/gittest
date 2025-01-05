public class AccountHandler {

	public static Account insertNewAccount(String accName) {
		
		String accName1 = accName;
		Account acc1 = new Account(Name = accName1);
			try{	
			insert acc1;
			return acc1;
			}
			catch(DmlException excep){
			System.debug('Insert failed due to ' +excep.getMessage());
			return null;
			}
	}
}