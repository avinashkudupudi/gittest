public class DmlSamples {
   public static List<Database.upsertResult> upsertLeads(List<Lead> leads)  {
      List<Database.upsertResult> uResults = Database.upsert(leads,false);
      List<Task> tasks = new List<Task>();
      for(Database.upsertResult result:uResults) {
         if (result.isSuccess() && result.isCreated())
              tasks.add(new Task(Subject = 'Follow-up', WhoId = result.getId()));
}
      /* If there are tasks to be inserted, insert them */
      Database.insert(tasks);
      return uResults;

}
}