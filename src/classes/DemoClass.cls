public class DemoClass {
 public String countries = '';

    public List<Student__c> stu {get;set;}
    public String fname{get;set;}
     
    public Student__c student = new Student__c();
          
    public DemoClass(){
        stu = [select name,First_name__c, Last_Name__c,Age__c,Sex__c from Student__c limit 10];
        //student = new Student__c();
        
    }
    
    public PageReference test() {
        return null;
    }
            
    public Student__c getstudent(){
        return student;
    }
    public List<SelectOption> getItems() {
        List<SelectOption> options = new List<SelectOption>();

        for(Student__c temp:stu){
            options.add(new SelectOption(String.valueOf(temp.ID),temp.name));
        }            
        return options;
    }
    
    public String getCountries() {
        student = getS();fname=student.First_name__c;
       // student.First_name__c = '222222';
        return countries;
    }
    
    public void setCountries(String countries) {
        setS((ID)countries);
        this.countries = countries;
    }
    
     public Student__c getS() {
           // countries = 'asdasda';
            System.debug('x154865 the loop'+student);
            return student;
        }
    public void setS(ID rec) {
        //  countries = '11111';
        Student__c temp1 = null;
        System.debug('before the loop '+ rec);
        for(Student__c temp:stu){
            if(rec==temp.id){
                System.debug('inside the loop '+ rec);
                temp1=temp;
            }
        }
        this.student = temp1;
        System.debug('X154865'+temp1+' - '+this.student);
    }

}