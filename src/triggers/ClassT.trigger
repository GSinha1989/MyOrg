trigger ClassT on class__C (before delete) {
					 
	for (AggregateResult ard: [Select count(id) ce, class__c classId from student__C
							where 		class__c in :Trigger.oldMap.keySet() 
							and   		Sex__c = 'Female' 
							group by 	class__C]){
			System.debug('The result for x154865 ' + ((Integer)ard.get('ce')))		;						
			if(((Integer)ard.get('ce')) > 1){
				Trigger.oldMap.get((Id)ard.get('classId')).addError('Unable to delete as there are more than Female student');
				//ard.addError('Unable to delete as there are more than Female student');
			}				 
		}
					 
					 
}