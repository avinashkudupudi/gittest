public without sharing class AmazonTextractService {
    public Static Map<String,String> keyText = new Map<String,String>();
    public Static Map<String,String> valueText = new Map<String,String>();
    public Static Map<String,String> keyValueText = new Map<String,String>();
    @AuraEnabled
    public static Map<String,Object> getData(String recordId,String docType){
        Map<String,Object> cleanData = new Map<String,Object>();
        Map<String,Object> obj = new Map<String,Object>();
        Account a = [Select Id,LeaseData__c,LedgerData__c,FASData__c from Account Where Id = :recordId];
        if(docType == 'Lease'){
            obj = (Map<String,Object>)JSON.deserializeUntyped(a.LeaseData__c);
        }else if(docType == 'Ledger'){
            obj = (Map<String,Object>)JSON.deserializeUntyped(a.LedgerData__c);
        }else if(docType == 'FAS'){
            obj = (Map<String,Object>)JSON.deserializeUntyped(a.FASData__c);
        }
        for(String st:obj.KeySet()){
            if(!String.isBlank((String)obj.get(st))){
                cleanData.put(st.replaceAll('[^a-zA-Z0-9\\s+]',''),obj.get(st));
            }   
        }
        return cleanData;
    }
    @AuraEnabled
    public static Map<String,Object> getOverview(String recordId){
        Map<String,Object> cleanData = new Map<String,Object>();
        Account a = [Select Id,LeaseData__c,LedgerData__c,FASData__c  from Account Where Id = :recordId];
        Map<String,Object> obj1 = (Map<String,Object>)JSON.deserializeUntyped(a.LeaseData__c);
        Map<String,Object> obj2 = (Map<String,Object>)JSON.deserializeUntyped(a.LedgerData__c);
        Map<String,Object> obj3 = (Map<String,Object>)JSON.deserializeUntyped(a.FASData__c);
        for(String st:obj1.KeySet()){
            if(st.containsIgnoreCase('resident') && !String.isBlank((String)obj1.get(st))){
                cleanData.put('Renters',obj1.get(st));
            }//else if(st.containsIgnoreCase('rent') && !String.isBlank((String)obj1.get(st))){
            else if(keywordSearch(st, 'rent') && keywordSearch(st, 'month') && !String.isBlank((String)obj1.get(st))){
                cleanData.put('Monthly Rent',obj1.get(st));
            }
        }
        for(String st:obj2.KeySet()){
            if(st.containsIgnoreCase('balance')){
                cleanData.put('Final Balance',obj2.get(st));
            }
        }
        for(String st:obj3.KeySet()){
            if(st.containsIgnoreCase('move')){
                if(st.containsIgnoreCase('out')){
                    cleanData.put('Move Out Date',obj3.get(st));
                }else if(st.containsIgnoreCase('in')){
                    cleanData.put('Lease Start Date',obj3.get(st));
                }
            }else if(st.containsIgnoreCase('lease')){
                if(st.containsIgnoreCase('expire')){
                    cleanData.put('Lease End Date',obj3.get(st));
                }
            }
        }
        return cleanData;
    }
    
    static Boolean keywordSearch(String input, String keywordPhrase){
    return Pattern.compile('(?i)' + keywordPhrase).matcher(input).find();
    }
    @AuraEnabled
    public static Map<String,String> callTextractService(String recordId,String docType){
        Set<String> cdlSet = new Set<String>();
        List<ContentDocumentLink> cdlList = [Select Id,ContentDocumentId From ContentDocumentLink Where LinkedEntityId = :recordId];
        for(ContentDocumentLink cdl:cdlList){
            cdlSet.add(cdl.ContentDocumentId);
        }
        ContentVersion cv = [Select Id,Versiondata From ContentVersion Where ContentDocumentId IN :cdlSet 
                             AND Description = :docType LIMIT 1];
        Map<String,String> allValMap = new Map<String,String>();
        Map<String,List<Object>> keyMap = new Map<String,List<Object>>();
        Map<String,List<Object>> keyValueMap = new Map<String,List<Object>>();
        Map<String,List<Object>> valueMap = new Map<String,List<Object>>();
        //Map<String,String> keyText = new Map<String,String>();
        Map<String,String> valueText = new Map<String,String>();
        //Contentversion cv = [Select id, versiondata from ContentVersion where id = '0686S00000iXLSUQA4'];
        FormDataForAnalyzeId analyzeId = new FormDataForAnalyzeId();
        DocumentClass documentClass = new DocumentClass();
        documentClass.Bytes = EncodingUtil.base64Encode(cv.VersionData);
        //cv.VersionData.toString();
        analyzeId.Document = documentClass;
        analyzeId.FeatureTypes = new List<String>{'FORMS'};
        HttpRequest httpRequest = new HttpRequest();
        httpRequest.setEndpoint('callout:awstextract');
        httpRequest.setMethod('POST');
        httpRequest.setHeader('Content-Type','application/x-amz-json-1.1');
        httpRequest.setHeader('X-Amz-Target','Textract.AnalyzeDocument');
        httpRequest.setBody(JSON.serializePretty(analyzeId));
        Http http = new Http();
        HttpResponse httpResponse = http.send(httpRequest);
        Map<String, Object> obj = (Map<String, Object>) JSON.deserializeUntyped(httpResponse.getBody());
        List<Object> obj2 = (List<Object>)obj.get('Blocks');
        for(object o:obj2){
            Map<String,Object> obj3 = (Map<String,Object>)o;
            if(obj3.get('BlockType') == 'KEY_VALUE_SET'){
                List<Object> k = (List<Object>)obj3.get('EntityTypes');
                List<Object> ob = (List<Object>)obj3.get('Relationships');
                system.debug('id****'+obj3.get('Id'));
                system.debug('rel****'+ob);
                if(k.contains('KEY') && ob != null){
                    for(object o2:ob){
                        Map<String,Object> obj4 = (Map<String,Object>)o2;
                        if(obj4.get('Type') == 'CHILD'){
                            keyMap.put((String)obj3.get('Id'),(list<Object>)obj4.get('Ids'));
                        }else if(obj4.get('Type') == 'VALUE'){
                            keyValueMap.put((String)obj3.get('Id'),(list<Object>)obj4.get('Ids'));
                        }
                    }    
                }else if(k.contains('VALUE') && ob != null){
                    for(object o2:ob){
                    	Map<String,Object> obj4 = (Map<String,Object>)o2;
                    	if(obj4.get('Type') == 'CHILD'){
                            valueMap.put((String)obj3.get('Id'),(list<Object>)obj4.get('Ids'));
                        }
                    }
                }
            }
            else if(obj3.get('BlockType') == 'WORD'){
                system.debug('id****'+obj3.get('Id'));
                system.debug('text****'+obj3.get('Text'));
                allValMap.put((String)obj3.get('Id'),(String)obj3.get('Text'));
            }
        }
        for(String str:keyMap.keySet()){
            printKeys(str,keyMap.get(str),allValMap);
        }
        for(String str:valueMap.keySet()){
            printValues(str,valueMap.get(str),allValMap);
        }
        for(String str:keyValueMap.keySet()){
            printKeyValues(str,keyValueMap.get(str));
        }
        System.debug('****'+keyText);
        System.debug('****'+keyValueText);
        Account a = new Account();
        a.Id = recordId;
        if(docType == 'Lease'){
            a.LeaseData__c = json.serialize(keyValueText);
        }else if(docType == 'Ledger'){
            a.LedgerData__c = json.serialize(keyValueText);
        }else if(docType == 'FAS'){
            a.FASData__c  = json.serialize(keyValueText);
        }
        update a;
        return keyValueText;
    }

    public class FormDataForAnalyzeId{
        public DocumentClass Document;
        public List<String> FeatureTypes; 
    }

    public class DocumentClass{
        public String Bytes;
    }
    public static void printKeys(String keyId,List<Object> keyChild,Map<String,String> allTextMap){
        List<String> k3 = new List<String>();
        for(Object o3:keyChild){
            k3.add((String)allTextMap.get((String)o3));
        }
        keyText.put(keyId,String.join(k3, ' '));
        system.debug('****RawKey'+keyId+'-'+String.join(k3, ' '));
    }
    public static void printValues(String keyId,List<Object> keyChild,Map<String,String> allTextMap){
        List<String> k3 = new List<String>();
        for(Object o3:keyChild){
            k3.add((String)allTextMap.get((String)o3));
        }
        valueText.put(keyId,String.join(k3, ' '));
        system.debug('****RawValue'+keyId+'-'+String.join(k3, ' '));
    }
    public static void printKeyValues(String keyId,List<Object> valueList){
        List<String> k3 = new List<String>();
        for(Object o3:valueList){
            k3.add(valueText.get((String)o3));
        }
        keyValueText.put(keyText.get(keyId),String.join(k3, ' '));
    }
}