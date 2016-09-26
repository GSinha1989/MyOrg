@isTest
private class JSONClass_test {

    @isTest static void testJson(){
        PageReference pageRef   = Page.JSONPage;
        Test.setCurrentPage(pageRef );
        
        Account acc = new Account(name='helloo');
        insert acc;
        ApexPages.currentPage().getParameters().put('id',acc.id);
        
        JSONCLass jc = new JSONClass();
        jc.Object_name = 'Account';
        jc.JSON();
		String quer=JSONCLass.getCreatableFieldsSOQL('Account', 'id=\''+acc.id+'\'');
        List<sObject>  val = Database.Query(quer);
		String out = JSON.serializePretty(val);
        
        System.assert(jc.Out==out);
		        
    }
}