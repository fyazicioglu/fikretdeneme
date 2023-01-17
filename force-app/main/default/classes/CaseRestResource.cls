@RestResource(urlMapping='/CaseManagement/*')
global with sharing class CaseRestResource {

  
    @HttpGet
    global static Case doGet() {
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        String caseId = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
        Case result = [SELECT Id, Subject, Status, Origin, Priority FROM Case WHERE Id = :caseId];
        return result;
        //services/apexrest/CaseManagement/5008d00000GsbSEAAZ kullanarak workbench'te sorgula
    }
    @HttpPost //post=create, put=upsert, patch=update
    global static String doPost(String subject, String status, String origin, String priority) {
        Case newCase = new Case();
        newCase.subject= subject;
        newCase.status= status;
        newCase.origin= origin;
        newCase.priority= priority;

        insert newCase;

        return newCase.Id;
    }
    /*  {
        "subject" : "This case was created using workbench",
        "status" : "New",
        "origin" : "Phone",
        "priority" : "Low"
      }  */ // Request Body ici
  
    @HttpDelete
    global static String deleteCase() {
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        String caseId = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
        Case result = [SELECT Id FROM Case WHERE Id = :caseId];

        delete result;  

        return result.Id;
    }

    @HttpPut
    global static String doPut(String subject, String status, String origin, 
                              String priority, String Id) {
        Case upsertCase = new Case(
        Id=id,
        Subject=subject,
        Status=status,
        Origin=origin,
        Priority=priority);

        upsert upsertCase;

        return upsertCase.Id;  

    }
        /*  {
            "subject" : "Deneme",
            "status" : "New",
            "origin" : "Phone",
            "priority" : "Low",
            "id" : "5008d00000G1dqNAAR"
          }  */
}