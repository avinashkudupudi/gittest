public class UpdateContactLeadSource {
    list<contact> lc = new list<contact>();
    list<contact> listcon = [select id from contact where department='Finance'];
    {for(contact con : listcon)
        {
    	if(con.Department == 'Finance')
    {
        con.LeadSource = 'Internal';
            lc.add(con);        
    }
        }
    update lc;
    }}