trigger AfterEvents on Account (after insert,after update,after delete) {
    Set<Id> parentID = new Set<ID>();
    List<Account> upd = new List<Account>();
	if(Trigger.isInsert){
        for(Account acc : Trigger.new){System.debug('Insert Account '+acc);
            parentID.add(acc.ParentId);
        }
        for(Account acc : [ Select  ParentId,childCount__c from Account where id in : parentID]){
            System.debug('Insert 2 Account '+acc);
            if(acc.childCount__c!=null)
				acc.childCount__c +=1; 	
            else
                acc.childCount__c = 1;
            upd.add(acc);
        }
    }else if(Trigger.isUpdate){
        Id temp = null;
        Set<Id> ins = new Set<Id>();
        Set<Id> del = new Set<Id>();
        Set<Id> all = new Set<Id>();
    	for(Account acc : Trigger.new){
            System.debug('Update Account '+acc);
            temp = (Trigger.oldMap.get(acc.ID)).ParentId;
            if(temp!=acc.ParentId){
				ins.add(acc.ParentId);
                if(temp!=null){
                    all.add(temp);
                    del.add(temp);
            	}
                all.add(acc.ParentId);
                
             //      parentID.add(acc.ParentID);
            }
        }
        if(all.size()!=0){
            System.debug(' ins '+ins);
            System.debug('Del '+del);
            for(Account acc : [ select id,parentID, childCount__c from Account where id in :all]){
                if(ins.contains(acc.id)){System.debug('ins Account '+acc);
                    if(acc.childCount__c!=null)
                    	acc.childCount__c +=1; 	
                    else
                        acc.childCount__c =1;
            		upd.add(acc);
                }else if(del.contains(acc.id)){System.debug('Del Account '+acc);
                    if(acc.childCount__c>0&&acc.childCount__c!=null){
                    	acc.childCount__c -=1; 	
            			upd.add(acc);
                    }
                }
            System.debug('Update Account 2 '+acc);
            }
        }
         // If the trigeer is for delete         
    }else if(Trigger.isDelete){
        for(Account acc : Trigger.old){System.debug('Delete Account '+acc);
            parentID.add(acc.ParentId);
        }
        for(Account acc : [ Select  id,ParentId,childCount__c from Account where id in : parentID]){
            System.debug('Delete 2  Account '+acc);
			if(acc.childCount__c>0&&acc.childCount__c!=null){
                acc.childCount__c -=1; 	
            	upd.add(acc);
            }
        }
    }
    update upd;

}