trigger UpdateCityManager on Loan__c (before insert) {
	List<CityManager__c> cm = new List<CityManager__c>();
    
    
    for(Loan__c l:Trigger.new){
        cm.add(new CityManager__c(City__c = l.City__c, Manger__c=l.Manager__c));
    }
    insert cm;
}