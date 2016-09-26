trigger updateTeacher on Contact (before update) {

	for(Contact c : Trigger.new){
		String subjects = c.Subject__c;
	       if(subjects.contains('Hindi'))
	          c.addError('You cant update details as subject is Hindi');
		}
}