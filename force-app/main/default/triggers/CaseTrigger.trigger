trigger CaseTrigger on Case (before insert) {
      
      CaseTriggerHandler.CreateParentCase(Trigger.new);
}