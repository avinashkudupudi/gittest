public class NewCaseListController {

	public list<Case> getNewCases() {

		List<Case> newCases = new List<Case>([select Id, CaseNumber from case where Status = 'New' limit 1000]);
		return newCases;

	}
}