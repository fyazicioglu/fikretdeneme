public with sharing class OpportunityTriggerHandler {
    public static void CreateNewTask(List<Opportunity> oppList, Map<Id,Opportunity> oppOldMap) {
        list<Task> taskList = new list<task>();

        
        for(Opportunity w: oppList){
            if(w.StageName=='Closed Won' && oppOldMap.get(w.Id).StageName!='Closed Won'){
                Task newTask = new Task(Subject ='Follow up Task', 
                                        ActivityDate =w.CloseDate.addMonths(1),
                                        WhatId =w.Id,
                                        OwnerId =w.OwnerId);
                taskList.add(newTask);
            }
        }

        if(taskList.size()>0){
            insert taskList;
        }

    }
}