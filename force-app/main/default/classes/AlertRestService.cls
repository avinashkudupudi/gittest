@RestResource(urlMapping='/CreateAlert/*')
global with sharing class AlertRestService {
    @HttpPost
    global static list<Id> doPost(List<AlertWrapper> AlertMap) {
        List<Alert__c> AlertsToInsert = new List<Alert__c>();

		for (AlertWrapper alert : AlertMap) {
			AlertsToInsert.add(alert.getAlert());
		}
		insert AlertsToInsert;

		Map<Id, Alert__c> AMap = new Map<Id, Alert__c>(AlertsToInsert);
		return new List<Id>(AMap.keySet());
    }
    global class AlertWrapper {
		public String Alert;
		public String Message;
        public String AssetNumber;
		public Alert__c getAlert() {
			Alert__c al = new Alert__c();
            al.Alert__c  = this.Alert;
		    al.Message__c  = this.Message;
            Asset aRef = new Asset(Asset_Number__c = this.AssetNumber); 
            al.Asset__r  = aRef;
            return al;
		}
	}


}