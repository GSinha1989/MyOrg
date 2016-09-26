@isTest
private class AccountExtension_test {
    @isTest static void testAccExt(){
        // Test Data Creation
      Account acc = new Account(Name ='Maybe');
      insert acc;
      Account acc1 = new Account(Name ='Call me ');
      insert acc1;
      Account acc2 = new Account(Name='Baby');
      acc2.BillingCity = 'Jaipur';
      acc2.BillingCountry ='India';
      acc2.BillingState='Raj';
      insert acc2;
        
      acc2 = new Account(Name='Morning');
      acc2.BillingCity = 'Jaipur';
      acc2.BillingCountry ='India';
      acc2.BillingState='Raj';
      insert acc2;
      
      AccountExtension ae= new AccountExtension(null);
      ae.search();
      System.assert(ae.acc.size()==4);
        ae.BillingCity = 'Jaipur';
        ae.search();
        for(Account a : ae.acc){
            System.assert(a.Name=='Morning'||a.Name=='Baby');
        }
      ae.clear();
        System.assert(ae.acc.size()==0);
        
      
      
    }
}