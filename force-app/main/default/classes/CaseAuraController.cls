public class CaseAuraController {
    @AuraEnabled
    public static void saveCase(Case caserec, Level1__c l1rec) {
        Case c1 = new Case();
        c1.Status = caserec.Status;
        c1.Origin = caserec.Origin;
        c1.Subject = caserec.Subject;
        insert c1;
        id caseId = c1.Id;
        Level1__c l1 = new Level1__c();
        l1.Name = l1rec.Name;
        l1.Case__c = caseId;
        insert l1;
    }
}