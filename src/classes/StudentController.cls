public with sharing class StudentController 
{
	
	public Boolean check{get;set;}
    private ApexPages.StandardSetController standardController;

    public StudentController(ApexPages.StandardSetController standardController)
    {
        this.standardController = standardController;
    }
    
	public List<Student__c> selectedStudent{get;set;} 

    public PageReference bumpStudent()
    {       
        // Get the selected records (optional, you can use getSelected to obtain ID's and do your own SOQL)
        Set<Student__c> temp = new Set<Student__c>((List<Student__c>) standardController.getSelected());
       
		if(temp.size()!=0){
			check = false;
			  
		}else{
			check=true;
			ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'No records'));
		}
		
		System.debug(check);
		
		selectedStudent = [Select id, Name, First_Name__c,Last_Name__c, Class__c from Student__c where id in : temp];
		System.debug(selectedStudent);System.debug('asdasdasd');
        // Update records       
        for(Student__c s : selectedStudent)
        {
          // System.debug(s.Name);
        }       

        return null;        
    }
	public PageReference doCancel()
  {
    return standardController.cancel();
  }
    public PageReference updateStudent()
    {       
    	System.debug('Deleting Student '+selectedStudent );
    	delete selectedStudent;
    	System.debug('Student Delted'+ selectedStudent);
        // Call StandardSetController 'save' method to update (optional, you can use your own DML)
        return null;  
    }
}