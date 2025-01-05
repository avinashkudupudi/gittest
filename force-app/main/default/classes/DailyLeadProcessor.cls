global class DailyLeadProcessor implements Schedulable {
    global void execute(SchedulableContext ctx) {
        list<lead> lead = new list<lead>();
        for(Lead leads: [SELECT Id, LeadSource FROM Lead WHERE LeadSource = '' limit 200]){
            //Lead lead = new Lead();
            leads.LeadSource = 'Dreamforce';
            lead.add(leads);
        }
        update lead;
           
    }
    
}