trigger Opportunity on Opportunity (before update,after update) {
/*
Creating the trigger for deleting the 
OpportunityLineItem if the Opportunity contains the 
Status Change to Either CLOSED_WON or CLOSED_LOST
*/

Set<id > ol = new Set<id>();
Integer i =0;
Id test= null;
String status = null;
    EmailTemplate et=[Select id from EmailTemplate where name =:'ApexTriggeredEmail'];
    
for(Opportunity s : Trigger.new){
	if(Trigger.isBefore && Trigger.isUpdate){
            Contactcl.triggerUpdate((List<Opportunity>)Trigger.new);
            System.debug('New Status for X154865'+ s.StageName + s.StageName.contains('Closed Won'));
            status = Trigger.oldMap.get(s.id).StageName;
            System.debug('Old Status for X154865'+ status +status.contains('Closed Lost'));
            if(((!status.contains('Closed Won')) 
                && s.StageName.contains('Closed Won')||
            ((!status.contains('Closed Lost'))
                && s.StageName.contains('Closed Lost'))))
                {
                    s.CloseDate = Date.today();
                    System.debug('Date for X154865'+ s.CloseDate);
                }
    
	}else{
/*
If the status change is to reset then 
Reset delete the Opportunitylineitem
*/		
	status =Trigger.oldMap.get(s.id).custom_status__C;
	System.debug('custom_status__C  neew Status for X154865'+ s.custom_status__C);
	System.debug('custom_status__C old  Status for X154865'+ status);	
		if(status!=null){
			if(!status.contains('Reset') 
			&& s.custom_status__C.contains('Reset')){
				ol.add(s.id);
				test=s.id;
				i = 99;
				}
		}
	}
	if(i==99){
		System.debug('line item in opportunity'+ ol.size()+'Hello Apex'+ Test);
		List<OpportunityLineItem> o1 = [select id 
										from OpportunityLineItem 
										where OpportunityId in :ol];
		if(ol.size()>0){
			delete o1;
		}
	}
    
        /*
         * Sending mail in status
         * if the status changes 
         */
    if(s.custom_status__c!=null){
        if(!s.custom_status__C.equals(status)){
            System.debug('Enter the message '+ String.valueOf(s.Owner.email)+'--'+s.OwnerID);
            
                String[] toAddresses = new String[] {String.valueOf(s.Owner.email)}; 
      			Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
      			mail.setTargetObjectId(s.OwnerID);
                mail.setSenderDisplayName('Salesforce Support');
                mail.setUseSignature(false);
                mail.setBccSender(false);
                mail.setSaveAsActivity(false);
              mail.setTemplateId(et.id);
              Messaging.SendEmailResult [] r = 
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] {mail}); 
            System.debug(r[0]);
        }
}
}
	

}