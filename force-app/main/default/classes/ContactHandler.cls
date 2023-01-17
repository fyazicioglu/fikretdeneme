public with sharing class ContactHandler {
    public static void CountContacts(list<Contact> contactList) {
       
        Set<Id> acctIds = new Set<Id>();


          
       for (Contact c : contactList) {
             //accountu olmayan contact olabilir
            if (c.AccountId != null) {
            acctIds.add(c.AccountId);
        }
      }

       //1.active fieldinin kontrol etmeyi querye ekledim çünkü yukarıda olduğu zaman active fieldi false ise query çalışmıyor
       //2.accountları sorgulayalım contact childlarından active olanları subquery ile sorgulayalım
      List<Account> acctsToRollup  = [SELECT Id, Active_Contacts__c, (SELECT Id FROM Contacts WHERE Active__c=true) 
                                     FROM Account 
                                     WHERE Id in: acctIds];
      
      for (Account acc : acctsToRollup ){
        if(!acc.Contacts.isEmpty()){
            //3.orgu sonucunda Contacts doluysa active contactlar vardır ve onların sayısını alalım
            acc.Active_Contacts__c = acc.Contacts.size();
        }else{
            //4.sorgu sonucunda contacts boşsa active contacts yoktur ve 0 yazarız.
            acc.Active_Contacts__c=0;
        }

       }
       
       update acctsToRollup;


    }

}