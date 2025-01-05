public class PD2_Opty_Wiz_Controller {
	
	Private Account acc;
	Private Contact con;
	Private Opportunity opp;

	public account getAccount(){
		if(acc == null){
			acc = new Account();
		}
		return acc;
	}

	public contact getContact(){
		if(con == null){
			con = new Contact();
		}
		return con;
	}
		
	public opportunity getOpportunity(){
		if(opp == null){
			opp = new Opportunity();
		}
		return opp;		
	}
	public pageReference page1(){
		pageReference optyPage1 = page.PD2_Opty_Wiz_Page1;
		optyPage1.setRedirect(true);
		return optyPage1;
	}

	public pageReference page2(){
		pageReference optyPage2 = page.PD2_Opty_Wiz_Page2;
		optyPage2.setRedirect(true);
		return optyPage2;
	}

	public pageReference page3(){
		pageReference optyPage3 = page.PD2_Opty_Wiz_Page3;
		optyPage3.setRedirect(true);
		return optyPage3;
	}

	public pageReference cancel(){
		return null;
	} 
}