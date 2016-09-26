public with sharing class ContactCl {


public static String putCommaSeparatedValues(Id key){
	String str = '';
	String previousValue = null;	
	Account ac = [Select ContactIds__c 
				  from Account 
				  where id =: key];
	integer lv_flag;	
 	previousValue = ac.ContactIds__c;
	for(Contact c : [Select id
	    			 from Contact 
				     where accountid =: ac.id]){
		if(ac.ContactIds__c == null && lv_flag!=4){
			lv_flag =4;
			str= c.id+',';
		}
		else 
		str = str + c.id + ',';
		System.debug(' Loop '+ str);
	}	
	System.debug(' lOved like anything' + str+' Previous Values '+previousValue);
	ac.ContactIds__c = str.substring(0,str.length()-1);
	str = ac.ContactIds__c ;
	ac.accountnumber = '12345678';
	if(previousValue == null ||!previousValue.equals(str)){
        update ac;
        System.debug('I m in the block');
	}
	System.debug(str+' out block ===='+ac.ContactIds__c);
	return str;
	}
	
	public static void triggerUpdate(List<Opportunity> opp){
		Set<Id> cont = new Set<ID>();
		for(Opportunity o : opp){
			cont.add((Id)o.BillToContact__c);
		} 
		Map<Id,Contact> m = new Map<Id,Contact>([Select accountid
												 from contact
												 where id in : cont]);
		for(Opportunity o : opp){
			if(o.BillToContact__c !=null&& o.Manager__c == null){
				o.Manager__c = m.get(o.BillToContact__c).accountid;
			}
		}
	}
}