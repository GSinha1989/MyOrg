public class PurchaseOrderDetail {
    public PurchaseOrder__c  poHeader{get;set;}
    public List<LineItem__c> poLine{get;set;}
    public List<Material__c> material{get;set;}
    public String category {get;set;}
    
    ID poId;
    public void find(){
        getMaterial();
    }
    public List<SelectOption> getOptions(){
        List<SelectOption> so = new List<SelectOption>();
        so.add(new SelectOption('BoS','BoS'));
        so.add(new SelectOption('Mat1','Mat1'));
        so.add(new SelectOption('Mat2','Mat2'));
        so.add(new SelectOption('Mat3','Mat3'));
        so.add(new SelectOption('Mat4','Mat4'));
        
        return so;
    }
    
    public PurchaseOrder__c getPO(){
       PurchaseOrder__c temp= [Select PurchaseOrder__c.Id, PurchaseOrder__c.Description__c,
                               PurchaseOrder__c.ForUser__c,PurchaseOrder__c.PO_Name__c,PurchaseOrder__c.Vendor__c 
                               /* (Select LineItem__c.Id,LineItem__c.Name,LineItem__c.Material__c,LineItem__c.Quantity__c 
from PurchaseOrder__c.LineItems__r )*/
                               from PurchaseOrder__c 
                               where id =:poId];
        return temp;
    }
    public List<LineItem__c> getItem(){
       List<LineItem__c> temp= [Select PurchaseOrder__c,Quantity__c,Material__c, Material__r.Name 
                  ,Material__r.AvailableUnits__c,Material__r.Text__c,Material__r.MaterialType__c,Material__r.PricePerUnit__c
                  from LineItem__c where LineItem__c.PurchaseOrder__r.id=:poId];
        return temp;
        
    }
    public PurchaseOrderDetail(){
        
    	poId= ApexPages.currentPage().getParameters().get('id');
        // Header Details for the Purcahse Order
        poHeader = getPO();
                
        // Line Item Details
        poLine = getItem();
        
		getMaterial();
    }
   public  void getMaterial(){
        Set<ID> temp= new Set<ID>();
        // getting Existing Material in the PO
        
        for(LineItem__c item : poLine){
            temp.add(item.Material__c);
        }
        // Material Details
 		if(category==null)
        material = [Select Name,AvailableUnits__c,Text__c,MaterialType__c,PricePerUnit__c 
                    from Material__c 
                    where AvailableUnits__c <> 0
                    and   id not in : temp];
        else
         	       material = [Select Name,AvailableUnits__c,Text__c,MaterialType__c,PricePerUnit__c 
                    from Material__c 
                    where AvailableUnits__c <> 0
                    and   id not in : temp
                    and   MaterialType__c =: category];
            
    }
    public Id matid{get;set;} 
    public String matname{get;set;} 
    // Funtion to remove the Line items
    public void removeItem(){
        matid = ApexPages.currentPage().getParameters().get('lineId');
        LineItem__c temp = new LineItem__c(id = matid);
        delete temp;
        poLine = getItem();
        getMaterial();
        
    }
    public PageReference  addToLineItem(){
        matid = ApexPages.currentPage().getParameters().get('matid');
         matname = ApexPages.currentPage().getParameters().get('matname');
        System.debug('Matid = '+matid+' Matanme'+matname);

        LineItem__c temp = new LineItem__c(Material__c = matid,Quantity__c = 1, PurchaseOrder__c = poId);
        insert temp;
           poLine = getItem();
       
        Integer i=0;
        for(Material__c mat: material){
            i++;
            if(mat.id==matid)
                break;
        }
        i--;
        material.remove(i);
        
        return null;
    }
    
    public void save(){
        update poLine;
        getItem();
    }

    

}