@isTest
private class AnimalLocatorTest {
    @isTest static  void testGetCallout() {
        // Associate the callout with a mock response
        Test.setMock(HttpCalloutMock.class, new AnimalLocatorMock());
        // Call method to test
        String result = AnimalLocator.getAnimalNameById(1);
        String expectedValue = '{"animal":{"id":1,"name":"chicken","eats":"chicken food","says":"cluck cluck"}}'; 
		System.assertEquals(expectedValue, result);        
    }    
}