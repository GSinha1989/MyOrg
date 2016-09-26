@isTest
public class Student_Test {
	/*
	 * Testing Student.getAllStudent
	 */ 
    @isTest static void testStudentClass(){
        // Creating the teacher
        Contact contact = new Contact(Experience__c=12,Languages__c='Maths', LastName = 'Sinha');
        insert contact;
        //Creating the class
        Class__c cl    = new Class__c(Class_teacher__c = contact.Name,MaxSize__c = 34,NameCustom__c = 'Enimen');
        insert cl;
        //Creating the students
        Student__c student1 = new Student__c(Last_name__c = 'George',Class__c=cl.id, First_name__c = 'George');
        insert student1;
        Student__c student2 = new Student__c(Last_name__c = 'Bob',Class__c=cl.id, First_name__c = 'Bob');
        insert student2;
        
        Test.startTest();
        List<String> str = Student.getAllStudent(cl);
        for(String s: str){
            System.assert(s=='Bob'||s=='George');
        }
        Map<String,Set<id>> mapname = Student.returnMap(cl);
   
         for(String id: mapname.keyset()){
            Set<id> stringset= mapname.get(id);
    			for(Id a: stringset){
					System.assert(student1.Id==a||student2.id==a);
   			}
         }
        // Testing working days between date
        Integer a = Student.getWorkingDays(Date.newInstance(2015,01,01),Date.newInstance(2015,02,01));
        System.assert(a==22);
        
        student2.First_name__c = 'Sam';
        update student2;
        Class__c te = [Select MyCount__c  from Class__c where id =:student2.Class__c];
        System.debug('-----------'+te.MyCount__c);
        System.assert(te.MyCount__c==3);
        
        
        Test.stopTest();
        
    }
    @isTest static void testClone(){
        System.debug('--------------------TestClone------------------');
        Account a = new Account(name = 'Sinha Account',AccountNumber='99887776');
        insert a;
        Contact c = new Contact(LastName = 'Gaurav',AccountId=a.id,Experience__c = 23);
        insert c;
        Opportunity opp = new Opportunity(Accountid = a.id, Name='Gaurav Opportunity',CloseDate=Date.newInstance(2015, 02, 12),stageName='Qualification');
        insert opp;
        
        Account a1 = Student.cloneAccountDetails(a);
        System.debug('--------------------TestClone Getting Account ------------------');
        System.debug('Clone Account is '+a1);
        System.debug('Origional Account is '+a);
        System.assert(a1.name==a.name&&a1.AccountNumber==a.AccountNumber);
        
        
        Contact c1 = [ Select LastName,accountid,Experience__c from Contact where accountid =: a1.Id];
        System.debug('Contact is  '+c1);
        System.assert(c1.Lastname==c.LastName&&c1.Experience__c==c.Experience__c);
        
        
        Opportunity o1 = [Select accountid,name,closeDate,StageName from Opportunity where accountid =:a1.id];
        System.debug('Opportunit is '+o1);
        System.assert(o1.Name==opp.Name&&o1.CloseDate==opp.CloseDate&&opp.StageName==o1.StageName);
        
        
        
    }
    
}