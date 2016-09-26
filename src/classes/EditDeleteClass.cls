public class EditDeleteClass {

    private String CurrTime;
    
    public String test{get;set;}
    public String getCurrTime()
    {
        return currTime;
    }
    public void setCurrTime()
    {
        currTime = System.now().format('EEEE, MMMM d, yyyy - hh:mm:ss');
    }
    
    public void setTest()
    {
        
    }
    
    public void update2(){
        
    }
    public String SelectedClasslId {get;set;}
public Class__c ins{get;set;}

public List<Class__c> allClass {get;set;}
public EditDeleteClass(){
    getData();
}
public List<Class__c> getData(){
    allClass = [Select Id, name, Fee__c ,Board__c,Class_Teacher__c,MaxSize__c,MyCount__c,NameCustom__c from Class__c];
    System.debug(allClass.size());
    return allClass;
} 
public void save(){
    
}

    public void EditClass(){
        if(SelectedClasslId==null){
        return ;
    }
    for(Class__c temp: allClass){
        if(SelectedClasslId==temp.id){
        ins= temp;
            break;
        }
    }
               

    }
    public void updateRecord(){
    
    update ins;
    
    }
public void DeleteClass(){
    if(SelectedClasslId==null){
        return ;
    }
    
Class__c cl = [Select Id, name, Board__c,Class_Teacher__c,MaxSize__c,MyCount__c,NameCustom__c 
               from Class__c
               where id=: SelectedClasslId];
               
delete cl;
getData();
               
}
}