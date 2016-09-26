public with sharing class JSONClass {

	public Account account { get; private set; }
	public Id aid{get;set;}
	public String Object_name{get;set;}
	public String Out{get;set;}
	private String Quer;
	public JSONClass() {
		
		Id id = ApexPages.currentPage().getParameters().get('aid');
		
		
	}
	public void JSON() {
	try {
		//Quer = getCreatableFieldsSOQL(Object_name,whereClause);
	//upsert(account);
	String whereClause = 'id =\''+aid+'\''; 
	Quer = getCreatableFieldsSOQL(Object_name,whereClause);
	System.debug(Quer);
	List<sObject>  val = Database.Query(Quer);
	Out = JSON.serializePretty(val);
	
	} catch(System.DMLException e) {
	ApexPages.addMessages(e);
	//return null;
	}
	// After Save, navigate to the default view page:
	//return (new ApexPages.StandardController(account)).view();
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