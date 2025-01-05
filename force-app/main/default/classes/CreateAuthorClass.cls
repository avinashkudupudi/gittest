public class CreateAuthorClass {
    public static void CreateAuthor(){
        Author__c author = new author__c();
        author.Name = 'TestJSONTest';
        insert author;      
    }
}