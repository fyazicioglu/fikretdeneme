public with sharing class saDetailController {
    
    @AuraEnabled(Cacheable = true)
    public static List <SA_Detail_TR1__c> getSaDetails() {
        return [SELECT Id, Name_TR1__c, Experience_TR1__c, Customer_handled_TR1__c, Date_of_Joining_TR1__c, Location_TR1__Latitude__s,Location_TR1__Longitude__s
                FROM SA_Detail_TR1__c 
                LIMIT 20];

        }    
    @AuraEnabled(Cacheable = true)
    public static List <SA_Detail_TR1__c> findSaDetails(String searchKey) {
    String key = '%' + searchKey + '%';
    return [SELECT Id, Name_TR1__c, Experience_TR1__c, Customer_handled_TR1__c, Date_of_Joining_TR1__c, Location_TR1__Latitude__s,Location_TR1__Longitude__s
    FROM SA_Detail_TR1__c 
    WHERE Name_TR1__c 
    LIKE:key LIMIT 20];
    
        } 
}