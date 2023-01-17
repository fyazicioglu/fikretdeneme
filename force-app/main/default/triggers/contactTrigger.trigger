trigger contactTrigger on CONTACT (after insert, after update, after delete, after undelete) {
if(Trigger.isAfter&&(Trigger.isInsert||Trigger.isUpdate||Trigger.isUndelete)){
ContactHandler.CountContacts(Trigger.new);
}
if(Trigger.isAfter&&Trigger.isDelete){
    ContactHandler.CountContacts(Trigger.old);
    }
}