@isTest
private class ClassT_test {

    @isTest static void testTrigger(){
        //Test Data
        Contact c = new Contact(LastName = 'Morissa');
        insert c;
        
        Class__c cl = new Class__c(class_teacher__c=c.id,NameCustom__c='Mallya',MaxSize__c=40);
        insert cl;
        
        Student__c girl1 = new Student__c(First_name__c='Evanscence',Last_Name__c='Bell Curve',
                                          Class__c = cl.Id,Sex__c='Female');
        insert girl1;
        
        girl1 = new Student__c(First_name__c='Dreams',Class__c = cl.Id,	Last_Name__c='Bell Curve',Sex__c='Female');
        insert girl1;
        
        try{
            delete cl;
            System.assert(false,'Expection Exception');
        }catch(Exception e ){
             System.assert(True,'Expection Exception');
        }
        
    }
}