trigger CaseUpdateOpportunity on Case( after insert, after update ) 
{
 Map<ID,Opportunity> OptyToUpdate = new Map<ID,Opportunity>(); 
 List<Id> listIds = new List<Id>();

    for(Case c : trigger.new)
    { 
     listIds.add(c.Opportunity__c);
    }

    OptyToUpdate = new Map<ID,Opportunity>([select id,(select status from cases__r) from opportunity where id in :listIds]);

    for (Case c1 : trigger.new)
    {
    Opportunity opp = OptyToUpdate.get(c1.Opportunity__c);
    if(c1.status=='Working')
    {
    opp.StageName ='Closed Won';}
    }
    {
    update OptyToUpdate.values();
    }
}