@isTest
private class Reporting_Test {

    @isTest static void start(){
        // Creating Account Test Data
        Account a = new Account(name='slimshady');
        insert a;
            Opportunity opp = new Opportunity(amount = 12000,Name = '2pac', accountid = a.id, closeDate=date.newInstance(2014, 11, 11), stageName='Needs Analysis');
        insert opp;
        opp = new Opportunity(amount = 12000,Name = '2pac', accountid = a.id, closeDate=date.newInstance(2014, 11, 11), stageName='Needs Analysis');
        insert opp;
      
        Reporting r = new Reporting();
        r.getRecords();
        for(Reporting.Element e : r.report){
            System.assert(e.sum == 24000);
        }
        
        
    }
    
}