public class AddPrimaryContact implements Queueable {
    
    private Contact contact;
    private String state;
    
    public AddPrimaryContact(Contact records, String state) {
        this.contact = records;
        this.state = state;
    }
    public void execute(QueueableContext context) {
        List<Contact> lc = new List<Contact>();
        for (Account account : [Select Id, Name from Account where BillingState = :state limit 200]) {
          Contact con = contact.clone(false,false,false,false);
		  con.AccountId = account.Id;
          lc.add(con);
        }
        If(lc.size()>0){insert lc;}
    }    

}