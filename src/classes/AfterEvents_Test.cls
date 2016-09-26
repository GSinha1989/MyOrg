@isTest
private class AfterEvents_Test {

    @isTest static void dmlAcc(){
        Account parent= new Account(name='Parent');
        insert parent;
        Account parent1= new Account(name='Parent1');
        insert parent1;
        Test.startTest();
        // Insertion Test
        Account child = new Account(name='Child', parentid = parent.Id);
        insert child;
        Account test1 = [ select childCount__c from Account where id =:parent.Id];
        System.assert(test1.childCount__c ==1);
        // Updation Test
        child.parentid = parent1.id;
        update child;
        test1 = [ select childCount__c from Account where id =:parent.Id];
        System.debug(test1.childCount__c);
        System.assert(test1.childCount__c ==null||test1.childCount__c==0);
        // Test for the Delte Trigger
        delete child;
        test1 = [ select childCount__c from Account where id =:parent1.Id];
        System.debug(test1.childCount__c);
        System.assert(test1.childCount__c ==null||test1.childCount__c==0);
        Test.stopTest();
        
    }
}