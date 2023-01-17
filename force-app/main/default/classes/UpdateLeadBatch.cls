public class UpdateLeadBatch implements Schedulable, Database.Batchable<SObject>{
    
    //önce start metodu implement edilir
    public Database.QueryLocator start(Database.BatchableContext bc){
        //SOQL yazacağız Lead Source fieldi boş olan leadleri sorgulayacağız
        return Database.getQueryLocator('SELECT Id, LeadSource FROM Lead WHERE LeadSource = null');

    }

    //ikinci olarak execute metodu implement edilir
    public void execute(Database.BatchableContext bc, List<Lead> leadList){
        
        for(Lead w: leadList){
            w.LeadSource ='Manual';
        }
        update leadList;  
    }

    //son olarak finish methodu implement edilir
    public void finish(Database.BatchableContext bc){
        System.debug('Güncelleme başarili');
    }

    //schedulable class'i ayrı yazabiliriz ama schedulable implement edersek metodu burada da yazabiliriz.
    public void execute(SchedulableContext scope){
        UpdateLeadBatch myBatch = new UpdateLeadBatch();
        Database.executeBatch(myBatch,2000);

        //çalıştırılması:
        //UpdateLeadBatch m = new UpdateLeadBatch();
        //String sch = '0 0 23 ? * *';
         //String jobID = System.schedule('Lead Update Job', sch, m);

    }
}