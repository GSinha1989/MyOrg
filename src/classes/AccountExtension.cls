public class AccountExtension {
   public list <account> acc {get;set;}  
   public string searchstring {get;set;}  
   public string BillingState {get;set;}  
   public string BillingCity {get;set;}  
   public string BillingCountry {get;set;}  
   public AccountExtension(ApexPages.StandardController controller) {  
   }  
   public void search(){  
       string searchquery = null;
           if( (BillingState!=''&& BillingState!=null)  || ( BillingCity !='' && BillingCity!=null) || ( BillingCountry != ''&& BillingCountry !=null) ){
                  searchquery='select name,id,BillingCity,BillingState,BillingCountry from account where '+//name like \'%'+searchstring+'%\'' +
                                    '  BillingState like \'%'+BillingState+'%\' '+
                                    ' AND BillingCity like \'%'+BillingCity+'%\'' +
                                    ' AND BillingCountry like \'%'+BillingCountry+'%\' '+
                                    ' Limit 100';  
        }else
            searchquery='select name,id,BillingCity,BillingState,BillingCountry from account limit 100';
        System.debug(searchquery);

    //searchquery='select name,id,BillingCity,BillingState,BillingCountry from account limit 100';
     acc= Database.query(searchquery); 

   }  
   public void clear(){  
   acc.clear();  
   }  

}