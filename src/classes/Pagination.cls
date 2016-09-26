public class Pagination
{
private integer totalRecs = 0;
private integer OffsetSize = 0;
private integer LimitSize= 10;
public String BillingCountry{get;set;}
public String BillingCity{get;set;}
public String BillingState{get;set;}
public Pagination()
{
totalRecs = [select count() from account];
}
public List<account> acc {get;set;}
public void search(){
    if( (BillingState == null || BillingState =='' )  && ( BillingCity == null || BillingCity =='') && ( BillingCountry == null || BillingCountry=='') ){
acc = Database.Query('SELECT Name, BillingCity, BillingState, BillingCountry FROM account '+
                                    'LIMIT :LimitSize OFFSET :OffsetSize');
 }else{
     acc = Database.Query('SELECT Name, BillingCity, BillingState, BillingCountry FROM account '+
                                    ' Where   BillingState like \'%'+BillingState+'%\' '+
                                ' AND BillingCity like \'%'+BillingCity+'%\'' +
                                ' AND BillingCountry like \'%'+BillingCountry+'%\' '+
                                    'LIMIT :LimitSize OFFSET :OffsetSize');
}
}
public List<account> getacclit()
{
/*
 if( (BillingState == null || BillingState =='' )  && ( BillingCity == null || BillingCity =='') && ( BillingCountry == null || BillingCountry=='') ){
acc = Database.Query('SELECT Name, BillingCity, BillingState, BillingCountry FROM account '+
                                    'LIMIT :LimitSize OFFSET :OffsetSize');
 }else{
     acc = Database.Query('SELECT Name, BillingCity, BillingState, BillingCountry FROM account '+
                                    ' Where   BillingState like \'%'+BillingState+'%\' '+
                                ' AND BillingCity like \'%'+BillingCity+'%\'' +
                                ' AND BillingCountry like \'%'+BillingCountry+'%\' '+
                                    'LIMIT :LimitSize OFFSET :OffsetSize');*/
 //}
System.debug('Values are ' + acc);
return acc;
}
public void FirstPage()
{
OffsetSize = 0;
search();
}
public void previous()
{
OffsetSize = OffsetSize - LimitSize;
search();
}public void next()
{
OffsetSize = OffsetSize + LimitSize;
search();
}public void LastPage()
{
OffsetSize = totalrecs - math.mod(totalRecs,LimitSize);
search();
}
public boolean getprev()
{
if(OffsetSize == 0)
return true;
else
return false;
}
public boolean getnxt()
{
if((OffsetSize + LimitSize) > totalRecs)
return true;
else
return false;
}
}