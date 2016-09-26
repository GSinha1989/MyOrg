trigger Session4 on Student__C (before insert, after insert,before update ,after update, before delete , after delete) {

if(Trigger.isBefore){
    if(Trigger.isInsert){
        Set<id> classid = new Set<id>();
        for(Student__c s:Trigger.new){
            classid.add(s.Class__c);            
        }
        Map<Id,Class__c> cl= new Map<Id,Class__c>([Select MaxSize__c, Number_of_students__c 
                                                from class__c
                                                where id in :classid]);
                                
       for(Student__c s:Trigger.new){
           if(cl.get(s.class__C).MaxSize__c<=cl.get(s.class__C).Number_of_students__c){
           	s.addError('Cannot insert the student as class is full');
           }        
        }
    }else if(Trigger.isUpdate){
    
     
                                          
    }else if(Trigger.isDelete){
        
    }
}
else{
   if(Trigger.isInsert){
         Set<id> classid = new Set<id>();
        for(Student__c s:Trigger.new){
            classid.add(s.Class__c);            
        }
        List<class__C> cl = new List<class__C>();
        for(Class__C c: [select MyCount__c from class__C where id in :classid]){
        	if(c.MyCount__c!=null)
        	c.MyCount__c = c.MyCount__c + 1;
        	else
        	c.MyCount__c = 1;
        	cl.add(c);
        }
        update cl;
    }else if(Trigger.isUpdate){
        Set<id> classid = new Set<id>();
        for(Student__c s:Trigger.old){
            classid.add(s.Class__c);            
        }
        List<class__C> cl = new List<class__C>();
        for(Class__C c: [select MyCount__c from class__C where id in :classid]){
        	c.MyCount__c = c.MyCount__c + 1;
        	cl.add(c);
        }
        update cl;
    }else if(Trigger.isDelete){
        
    } 
}
}