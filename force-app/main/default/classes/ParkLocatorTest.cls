@isTest
private class ParkLocatorTest {
    @isTest static void testCallout() {              
        // This causes a fake response to be generated
        Test.setMock(WebServiceMock.class, new ParkServiceMock());
        // Call the method that invokes a callout
        String str = 'Spain';
        List<String> result = ParkLocator.country(str);
        // Verify that a fake result is returned
        System.assertEquals('park1', result[0]); 
    }
}