@isTest
private class updateTeacher_Test {

    @isTest static void start(){
        Contact c = new Contact(lastname= 'Sinha ', Subject__c ='Hindi');
        insert c;
        c.FirstName = 'Human';
        try{
            update c;
            System.assert(false,'Expected');
            
        }
        catch(Exception r){
            System.assert(true,'Yaaaa');
        }
    }
}