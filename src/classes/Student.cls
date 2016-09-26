public with sharing class Student {

/*
 * Method to take all the Student for a class
 * Create a class and a static function which take classid as argument and returns all names of the 
 * students in that class as a list.
 */ 
	public static List<String> getAllStudent(Class__c cl){
		
		List<String> studentNames = new List<String>();
		for(Student__c student : [Select  s.First_Name__c 
								From Student__c s 
								where s.Class__c =: cl.Id ]){
			studentNames.add(student.First_Name__c);
		}
		
		return studentNames;
		
	} 
    // Method to return the Map of class id and Student id 
    // The fucntion executes based on the class Id
	public static Map<String,Set<id>> returnMap(Class__C cl){
		
		Map<String,Set<id>> m = new Map<String,Set<id>>();
	 final String DEBUG1 = 'MY POINT GAURAV;';
		for(class__C classRecord : [Select Id, Name, 
									(Select  Id from students__r ) 
									from Class__c where id =:cl.id ]){
			if(classRecord.students__r != null){
				for(Student__c sd : classRecord.students__r){
					
					System.debug(sd);
					System.debug(DEBUG1);
					if(m.containsKey(classRecord.Id)){
						m.get(classRecord.Id).add(sd.Id);
					}
					else{
						m.put(classRecord.Id, new Set<Id>{sd.Id});
					}
				}
			}
		}		
		return m;
	}
	
//array of seven boolean indicating working days, Monday is index 0
private static final List<Boolean> isWorkingDay;
//count of the number of working days in the array
private static final Integer workingDaysInWeek;
static {
    //my real implementation uses the Salesforce BusinessHours Object to populate this array
    isWorkingDay = new List<Boolean> { true, true, true, true, true, false, false };
    //You will have real problems if this number does not match the number of true flags in the array
    workingDaysInWeek = 5;
}

private static final Date monday = Date.newInstance(1900, 1, 1);
private static Integer getDayOfWeek(Date value) {
	System.debug('--------'+monday.daysBetween(value));
    return Math.mod(monday.daysBetween(value), 7);
}

public static Integer getWorkingDays(Date startDate, Date endDate) {
    //save some calculations when the number of working days is 0
    if(workingDaysInWeek == 0 || startDate == null || endDate == null) {
        return 0;
    } else {
        Integer difference = startDate.daysBetween(endDate);
        System.debug('difference'+difference);
        if(difference == 0) {
            //If the 2 dates are the same day check if the day is a working day or not
            return isWorkingDay[getDayOfWeek(startDate)] ? 1 : 0;
        } else if(workingDaysInWeek == 7) {
            //when every day is a working day return the difference
            return difference;
        } else {
            //The guts of the solution
            Integer wholeWeeks = Math.floor(difference / 7).intValue();
            System.debug('wholeWeeks'+wholeWeeks);
            Integer workingDays = wholeWeeks * workingDaysInWeek;
            Integer dayOfWeek = getDayOfWeek(endDate);
            System.debug('dayOfWeek-----'+dayOfWeek);
            System.debug('Reminder'+Math.mod(difference, 7));
            for(Integer remainder = Math.mod(difference, 7); remainder >= 0; remainder--) {
                if(isWorkingDay[dayOfWeek]) {
                    workingDays++;
                }
                dayOfWeek--;
                if(dayOfWeek < 0) {
                    dayOfWeek = 6;
                }
            }
            return workingDays;
        }
    }
}

public static List<Schema.SObjectType> getSobject(){
	List<Schema.SObjectType> sobj = new List<Schema.SObjectType>();
	Map<String, Schema.SObjectType> gd = Schema.getGlobalDescribe(); 
	Set<String> keySet = gd.keySet() ;
		for(String k : keySet){
			String str = 'Key is '+ k;
			//System.debug(str);
			sobj.add(gd.get(k));
			System.debug(gd.get(k));
		}
		return sobj;
	}
	
	public static Account cloneAccountDetails(Account acc){
		String whereClause = 'id =\''+acc.id+'\'';
		System.debug('where Clause X154865'+whereClause);
		String selAccount = getCreatableFieldsSOQL('Account',whereClause);
		Account a = (Account)Database.query(selAccount);
		Account a1 =a.clone(false,true);
		a1.AccountNumber = '99887776';
		System.debug('Before => '+a1.Id+'A--'+a.Id);
		insert a1;
		System.debug('After =>'+a1.Id+'A--'+a.Id);
		 // Contact clone 
		 whereClause = 'AccountId =\''+acc.id+'\'';
		 System.debug('where Clause X154865  => '+whereClause);
		 selAccount = getCreatableFieldsSOQL('Contact',whereClause);
		 List<Contact> cont = (List<Contact>)Database.query(selAccount);
		 List<Contact> cont1 = new List<Contact>();
		 for(Contact c : cont.deepClone(false,false,false)){
		 	c.FirstName = c.FirstName + ' = X154865';
		 	c.Accountid = a1.id;
		 	cont1.add(c);
		 	System.debug('Contact Befores=> X154865  => '+c.Id+'A--'+c.AccountId + 'Name=>  ' +c.FirstName);
		 }
		 insert cont1;
		 for(Contact c : cont1){
		 	
		 	System.debug('Contact After=> '+c.Id+'A--'+c.AccountId+ 'Name=>  ' +c.FirstName);
		 }
		 // Opportunity Clone
		 selAccount = getCreatableFieldsSOQL('Opportunity',whereClause);
		 List<Opportunity> opp = (List<Opportunity>)Database.query(selAccount);
		 List<Opportunity> opp1 = new List<Opportunity>();
		 for(Opportunity o : opp.deepClone(false,false,false)){
		 //	o.name = o.name + ' X154865';
		 	o.accountid = a1.id;
		 	opp1.add(o);
		 	System.debug('Opportunity Befores=> => '+o.Id+'A--'+o.AccountId + 'Name=>  ' +o.Name);
		 }
		 insert opp1;
		 for(Opportunity o : opp1){
		 	System.debug('Opportunity After=> => '+o.Id+'A--'+o.AccountId+ 'Name=>  ' +o.Name);
		 }
        return a1;
	}
	
	public static string getCreatableFieldsSOQL(String objectName, String whereClause){
         
        String selects = '';
         
        if (whereClause == null || whereClause == ''){ return null; }
         
        // Get a map of field name and field token
        Map<String, Schema.SObjectField> fMap = Schema.getGlobalDescribe().get(objectName.toLowerCase()).getDescribe().Fields.getMap();
        list<string> selectFields = new list<string>();
         
        if (fMap != null){
            for (Schema.SObjectField ft : fMap.values()){ // loop through all field tokens (ft)
                Schema.DescribeFieldResult fd = ft.getDescribe(); // describe each field (fd)
                if (fd.isCreateable()){ // field is creatable
                    selectFields.add(fd.getName());
                }
            }
        }
         
        if (!selectFields.isEmpty()){
            for (string s:selectFields){
                selects += s + ',';
            }
            if (selects.endsWith(',')){selects = selects.substring(0,selects.lastIndexOf(','));}
             
        }
         
        return 'SELECT ' + selects + ' FROM ' + objectName + ' WHERE ' + whereClause;
         
    }
}