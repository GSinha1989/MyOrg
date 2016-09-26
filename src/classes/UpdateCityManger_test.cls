@isTest
private class UpdateCityManger_test {

    @isTest static void start(){
           Profile p = [SELECT Id FROM Profile WHERE Name='Standard User']; 
          User u = new User(Alias = 'standt', Email='standarduser@testorg.com', 
          EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
          LocaleSidKey='en_US', ProfileId = p.Id, 
          TimeZoneSidKey='America/Los_Angeles', UserName='standarduser@gamil.com');
		insert u;
      
        Loan__c l = new Loan__c(City__c = 'jaipur',Manager__c= u.Id	);
        insert l;
        
        CityManager__c cm = [ select City__c, Manger__c from CityManager__c];
        System.assert(cm!= null);
        
		
      
    }
}