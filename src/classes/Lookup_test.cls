@isTest
private class Lookup_test {
	
    @isTest static void pageTest(){
        PageReference pageRef = Page.LookupPage;
        Test.setCurrentPage(pageRef);
      	// Test Data Creation
      	Account account = new Account(name='Human');
        insert account;
        Opportunity opp = new Opportunity(Name='Human opportunity', accountid = account.id,CloseDate=Date.newInstance(2015, 02, 01)
                                          ,stageName='Needs Analysis',custom_Status__c ='Open');
        insert opp;
        opp.custom_status__c = 'Reset';
        update opp;
        Contact contact1 = new Contact(Lastname='George',accountid =account.id);
        insert contact1;
        Contact contact2 = new Contact(Lastname='Seinfield',accountid =account.id);
        insert contact2;
        Contact contact3 = new Contact(Lastname='Mia',accountid =account.id);
        insert contact3;
       	Test.startTest();
        //String nextPage = controller.save();

        // Verify that page fails without parameters
        //System.assertEquals('/apex/failure?error=noParam', nextPage);

        // Add parameters to page URL
        ApexPages.currentPage().getParameters().put('aid', opp.AccountId);
        ApexPages.currentPage().getParameters().put('oppid', opp.Id);
        
        Lookup controller = new Lookup();
        System.debug(' Before Clear'+controller.opp);
        ApexPages.currentPage().getParameters().put('one', contact1.Id);
        controller.save();
        System.debug(' After Clear'+controller.opp);
        System.assert(controller.opp.BillToContact__c==contact1.Id);
         controller.clear();
         System.assert(controller.opp.BillToContact__c==null);
        Test.stopTest();
    }
}