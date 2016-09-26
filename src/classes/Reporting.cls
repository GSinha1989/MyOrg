public class Reporting {
	
    public List<Element> report {get;set;}
    @TestVisible public class Element{
        public Id accId{get; set; }
        public String accName{ get; set;}
        public String oppName{ get; set;}
        public Decimal sum{ get; set;}
        
        public Element(Id accId,String name, Decimal sum,String oppName){
            System.debug('1234'+ accId+'=='+name+'--'+sum);
            this.accId = accid;
            this.accName = name;
            this.sum = sum;
            this.oppName=oppName;
        }
        
      
    }
    
    public Reporting(){
        report = new List<Element>();
    }
    
    public void getRecords(){
        List<Account> li = [SELECT Id, Name, (SELECT Id,Name, Amount FROM Opportunities ) FROM Account limit 10];
        Decimal sum =0;
        String temp='';
        for(Account a : li){
            System.debug(a);
            for(Opportunity  o : a.Opportunities){
                System.debug(o);
                sum = sum + o.Amount;
                temp=temp+o.Name+';';
            }
            System.debug('X154865  '+ a.id+' - Name ='+a.Name+' Sum -'+sum);
            Element e = new Element(a.id,a.Name,sum,temp.substring(0, temp.length()-1));
            System.debug('Object '+ e);
            report.add(e);
            sum=0;
        }
        
        System.debug(sum);
    }
}