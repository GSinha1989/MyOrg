@isTest
private class ContactCl_Test {
	
    @isTest static void test_putCommaSeparatedValues(){
        Account account = new Account(name = 'First');
        insert account;
        Contact c1 = new Contact(Lastname = 'C1',accountid=account.id);
        insert c1;
        Contact c2 = new Contact(LastName='C2',accountid=account.id);
        insert c2;
        String st=c1.id+','+c2.id;
        String temp=ContactCl.putCommaSeparatedValues(account.id);
        System.assert(temp.contains(String.valueOf(c1.Id))||temp.contains(String.valueOf(c1.Id)));
    }
}