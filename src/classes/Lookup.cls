public class Lookup{
    
    public Lookup(){ 
        loadData();
    }
    public String temp {get;set;}
    public Opportunity opp {get;set;}
    public Id i {get;set;}
    private  Opportunity opp1 = new Opportunity();
    
    public void save(){
        temp = Apexpages.currentPage().getParameters().get('one');
        System.debug('Previous vale - '+ opp1.BillToContact__c);
        System.debug('New Value -- '+temp);
        opp1.BillToContact__c = (Id)temp ;
        update opp;
    }

    public void clear(){
        System.debug('Method Clear Started'+opp.BillToContact__c);
        String tem = (String)opp.BillToContact__c;
        if( tem!= null  || tem != '')
        opp.BillToContact__c =null;
        System.debug('Method Before Update'+opp.BillToContact__c);
        update opp;
        System.debug('Method After Update'+opp.id);
    }
    public void loadData(){
        
        Map<String, String> UrlParameterMap = ApexPages.currentPage().getParameters();
        // check for a specific parameter
        System.debug('size'+UrlParameterMap.size());
        
        if (UrlParameterMap.containsKey('aid')){
          //do something with the parameter... UrlParameterMap.get('urlparm')
         
          i = (Id)UrlParameterMap.get('aid'); System.debug('accidp---'+i);
          listRecords = [Select id , Name from Contact where accountid =: i];
        }
        if (UrlParameterMap.containsKey('oppid')){
          //do something with the parameter... UrlParameterMap.get('urlparm')
          i = (Id)UrlParameterMap.get('oppid');
          opp = [select id,Name,BillToContact__c from Opportunity where id=:i];
          opp.id = i;
          opp1 = opp;
           System.debug('oppid--'+i+'Contact'+ opp.BillToContact__c);
        }
    }
    
    public List<Contact> listRecords{get;set;}


}