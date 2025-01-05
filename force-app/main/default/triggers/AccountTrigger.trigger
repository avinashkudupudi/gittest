trigger AccountTrigger on Account (before insert, before update, before delete, after insert, after update, after delete, after undelete) 
{

    if(Trigger.isAfter){

        if(Trigger.isInsert)
        {
            AccountTriggerHandler.isAfterInsert(Trigger.new);
        } else if(Trigger.isUpdate)
        {
            AccountTriggerHandler.isAfterUpdate(Trigger.new);
        } else if(Trigger.isDelete)
        {
        } else if(Trigger.isUndelete)
        {

        }
    } else if(Trigger.isBefore){

        if(Trigger.isInsert)
        {
            AccountTriggerHandler.isBeforeInsert(Trigger.new);

        } else if(Trigger.isUpdate)
        {

        } else if(Trigger.isDelete)
        {

        }
    }
}