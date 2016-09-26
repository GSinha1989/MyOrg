@isTest
private class PurchaseOrderDetails_test {
    @isTest static void testPO(){
        PageReference pageRef = Page.POVFPage;
        Test.setCurrentPage(pageRef);
        
        PurchaseOrder__c poData = new PurchaseOrder__c(PO_Name__c ='Test');
        insert poData;
        Material__c mat = new Material__c(Text__c='Test12');
        insert mat;
        Material__c mat1 = new Material__c(Text__c='asd344');
        insert mat1;
        
        ApexPages.currentPage().getParameters().put('id',poData.id);
        PurchaseOrderDetail po = new PurchaseOrderDetail();
        ApexPages.currentPage().getParameters().put('matid',mat.id);
        ApexPages.currentPage().getParameters().put('matname',mat.name);
        po.addToLineItem();
        ApexPages.currentPage().getParameters().put('matid',mat1.id);
        ApexPages.currentPage().getParameters().put('matname',mat1.name);
        po.addToLineItem();
        List<LineItem__c> temp = po.getItem();
        System.assert(temp.size()==2);
        for(LineItem__c t: temp){
            ApexPages.currentPage().getParameters().put('lineId',t.id);
            t.Quantity__c = 34;
            break;
        }

        po.getMaterial();
        for(Material__c m : po.material){
			System.assert(m.Text__c!='Test12'||m.Text__c!='asd344');
        }
        po.removeItem();
        temp = po.getItem();
        System.assert(temp.size()==1);
        
        po.category = 'Mat1';
        po.find();
        for(Material__c m : po.material){
			System.assert(m.MaterialType__c=='Mat1');
            
        }
        
        
    }
}