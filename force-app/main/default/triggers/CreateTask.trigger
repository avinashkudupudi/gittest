trigger CreateTask on Lead (after insert) 
{
list<Task> tasks = new list<Task>();
for(Lead leadlist : Trigger.new)
{
tasks.add(new Task(Subject = 'Follow-up', Status = 'In Progress', Priority = 'Normal', whoId = leadlist.Id));
}
insert tasks;
}