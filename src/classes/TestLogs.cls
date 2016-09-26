public class  TestLogs {
    public static void dologs(){
        Account a = new Account();
        try{
            insert a;
        }catch(Exception e ){
            
apexLogHandler.apexLog log = new apexLogHandler.apexLog('TestLogs','dologs','Reference Id',System.LoggingLevel.ERROR);
log.logException(e);
log.saveLogs();
        }
    }
}