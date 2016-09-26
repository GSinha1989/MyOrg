public with sharing class quickTableHandler {
 
    public String columnFields { get; set; }
    public String columnTitles { get; set; }
 	public String ContainerId { get; set;}
    public List<Account> records{ get; set;}
    public static Integer Offset = 0;
    public static Integer Limitset= 5;
    private integer totalRecs = 0;
    private String orderby='Name';
    public quickTableHandler()
    { 
        fetchAccounts();
        
        String strQuery ='SELECT Id From Account';
        
         if(totalRecs !=null && totalRecs ==0){
            List<Account> accTemp = Database.query(strQuery);
            totalRecs = (accTemp !=null &&accTemp.size()>0)?accTemp.size():0;
         }
    }
    public List<String> columnFieldsList {
        get {
            if(columnFieldsList == null && columnFields != null) {
                columnFieldsList = columnFields.split(',');
                for(Integer x = 0; x < columnFieldsList.size(); x++) {
                    columnFieldsList[x] = columnFieldsList[x].trim();
                }
            }
            return columnFieldsList;
        }
        set;
    }
     
    public List<String> columnTitlesList {
        get {
            if(columnTitlesList == null && columnTitles != null) {
                columnTitlesList = columnTitles.split(',');
                for(Integer x = 0; x < columnTitlesList.size(); x++) {
                    columnTitlesList[x] = columnTitlesList[x].trim();
                }
            }
            return columnTitlesList;
        }
        set;
    }
 
    
    public void fetchAccounts()
    {
        records = Database.query('select Id, Name, AccountNumber from Account ORDER BY '+orderby+' Limit :Limitset OFFSET:Offset');
    }
    public void sortByName()
    {
        orderby = 'Name';
        fetchAccounts();
    }
    public void sortByNumber()
    {
        orderby = 'AccountNumber';
        fetchAccounts();
    }
    public void Prev()
    {
        Offset = Offset-Limitset;
        fetchAccounts();
    }
    public void Next()
    {
        Offset = Offset+Limitset;
        fetchAccounts();
    }
    public void First()
    {
        Offset = 0;
        fetchAccounts();
    }
    public void Last()
    {
        Offset = totalrecs - math.mod(totalRecs,Limitset);
        fetchAccounts();
    }
     public boolean getprev()
    {
        if(Offset == 0){
            return true;
        }
        else {
            return false;
        }
    }
    public boolean getnxt()
    {
    	if((Offset + Limitset) > totalRecs){
    	    return true;
    	}
    	else {
        return false;
    	}
    }
}