@isTest
private class DailyLeadProcessorTest {
    public static String CRON_EXP = '0 0 0 15 3 ? 2022';
    static testmethod void testScheduledJob() {
        // Create some out of date Opportunity records
        List<lead> leads = new List<lead>();
        for (Integer i=0; i<200; i++) {
            lead l= new lead(
                LastName = 'Last' + i,
                Company = 'Company'+i,
                Status = 'Open - Not Contacted'
            );
            leads.add(l);
        }
        insert leads;
        
        // Get the IDs of the opportunities we just inserted
        Map<Id, Lead> leadMap = new Map<Id, Lead>(leads);
        List<Id> leadIds = new List<Id>(leadMap.keySet());
        Test.startTest();
        // Schedule the test job
        String jobId = System.schedule('ScheduledApexTest',
            CRON_EXP, 
            new DailyLeadProcessor());         
        // Verify the scheduled job has not run yet.
        List<Lead> lt = [SELECT Id 
            FROM Lead 
            WHERE LeadSource = 'Dreamforce'];
        System.assertEquals(0, lt.size(), 'Tasks exist before job has run');
        // Stopping the test will run the job synchronously
        Test.stopTest();
        
        // Now that the scheduled job has executed,
        // check that our tasks were created
        lt = [SELECT Id 
            FROM Lead 
            WHERE LeadSource = 'Dreamforce'];
        System.assertEquals(leadIds.size(), 
            lt.size(), 
            'Tasks were not created');
    }
}