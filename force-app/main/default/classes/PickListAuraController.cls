public with sharing class PickListAuraController {
    @AuraEnabled
    /*******************************************************************************************************
    * @description:
    * @param objectType
    * @param selectedField
    * @return: List
    *******************************************************************************************************/   
    public static String getPickListValuesIntoList(String objectType, String selectedField){
        List<Option> pickListValuesList = new List<Option>();
        Schema.SObjectType convertToObj = Schema.getGlobalDescribe().get(objectType);
        Schema.DescribeSObjectResult res = convertToObj.getDescribe();
        System.debug(JSON.serialize(res.fields.getMap().keySet()));
        Schema.DescribeFieldResult fieldResult = res.fields.getMap().get(selectedField.toLowerCase()).getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        for( Schema.PicklistEntry pickListVal : ple){
            pickListValuesList.add(new Option(pickListVal.getLabel(), pickListVal.getValue()));
        }
        return JSON.serialize(pickListValuesList);
    }

    public class Option {
        @AuraEnabled
        public String label;
        @AuraEnabled
        public String value;

        public Option(String lbl, String vlu) {
            label = lbl;
            value = vlu;
        }
    }
}