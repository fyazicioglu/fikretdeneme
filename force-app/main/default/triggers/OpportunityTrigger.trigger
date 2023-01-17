trigger OpportunityTrigger on Opportunity (after update) {

    if(Trigger.isAfter&&Trigger.isUpdate){
        OpportunityTriggerHandler.CreateNewTask(Trigger.new, Trigger.oldMap);
    }
}