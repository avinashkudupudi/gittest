public class PD2_OptySetController {
	public ApexPages.StandardSetController setcon {
		get{
			if(setcon == null){
				setcon = new ApexPages.StandardSetController(Database.getQueryLocator([select Name, Amount from Opportunity]));
			}
			return setcon;
		}
		set;	
		}

	public list<Opportunity> getOpportunities(){
		return (list<Opportunity>)setcon.getRecords();
	}	
}