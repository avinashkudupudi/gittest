trigger ClosedOpportunityTrigger on Opportunity (before insert, before update, before delete, after insert, after update, after delete, after undelete) {

	if(Trigger.isAfter && (Trigger.isInsert || Trigger.isUpdate)){
		List<Task> optyTasks = new List<Task>();
		for(Opportunity opp : Trigger.new){
			if(opp.StageName == 'Closed Won'){
				optyTasks.add(new Task(Subject = 'Follow Up Test Task', WhatId = opp.Id));
			}
		}
		insert optyTasks;
	}

}