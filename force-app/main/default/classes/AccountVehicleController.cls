public class AccountVehicleController {
	public Account currentAccount { get; set; }
	public list<Vehicle__c> vehicleList { get; set; }
	public boolean showRecords { get; set; }
	public id currentRecordId { get; set; }
	public string accountName { get; set; }
	
	public AccountVehicleController(Apexpages.standardController stdController) {

		currentAccount = (Account)stdController.getRecord();
		vehicleList = new list<Vehicle__c>();
		showRecords = false;
		currentRecordId  = ApexPages.CurrentPage().getparameters().get('id');
		accountName = [select id,Name from Account where id = :currentRecordId limit 1000].Name;
			
	}

	public PageReference Init(){

		if(currentAccount != null){
		vehicleList = [select Name, Model__c from Vehicle__c where Account_Name__c = :currentRecordId limit 1000];
	}

	return null;

	}

	public PageReference redirectToVehicle(){
		PageReference pageRef;
		if(currentAccount != null){
			pageRef = new PageReference('/a0C/e?CF00Ni000000FiwV0='+accountName+'&CF00Ni000000FiwV0_lkid='+currentRecordId);
		}
		
		return pageRef;
	}

}