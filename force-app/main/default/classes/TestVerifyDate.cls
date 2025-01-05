@isTest
private class TestVerifyDate {
	
	//Date = varDate;
	@isTest static void test_check_dates1() {

		Date varDate = VerifyDate.CheckDates(Date.parse('01/01/2017'),Date.parse('01/15/2017'));
		system.assertEquals(Date.parse('01/15/2017'),varDate);
	}
	
	@isTest static void test_check_dates2() {

		Date varDate = VerifyDate.CheckDates(Date.parse('01/01/2017'),Date.parse('02/10/2017'));
		system.assertEquals(Date.parse('01/31/2017'),varDate);
	}
	
}