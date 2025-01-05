trigger PD1_BookTrigger on Book__c (before insert, before update, before delete, after insert, after update, after delete, after undelete) 
{
	if(Trigger.isBefore)
	{
		if(Trigger.isInsert)
		{
			Book__c[] books = Trigger.new;
			PD1_BookUtility.applyDiscount(books);
		}
	}

	if(Trigger.isAfter)
	{
		if(Trigger.isInsert)
		{

		}
	}
   
}