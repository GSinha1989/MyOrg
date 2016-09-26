public class TestWebService {
    public String sessionToken{get;set;}
    public String dateString{get;set;}
    public string signature{get;set;}
    public string result{get;set;}
    public string url{get;set;}
    public string portal = 'icappirio.csod.com';
public string userName = 'jdouglas';
public string apiToken='1qkhw2effdvyj';
public string apiSecret='CBrCE2u68VGGvzOqxiW+Pg9/ONbeo+/KpJ4kXlnTRDbgg5y6u0ivlC/wyBE4/cp1pwtFojGMFo9sXIeUHWPc7A==';
    public TestWebService(){
        sessionToken='';
        dateString='';
        signature='';
        result='';
        url='https://icappirio.csod.com/services/dwdata/Transcript?$select=TranscriptStatus';
    }
    Blob getSign(String token, String strintoSign){
    	String str = '';
    	Blob mac = Crypto.generateMac('hmacSHA512', Blob.valueOf(strintoSign), Blob.valueOf(token));
    	//str = crypto.createHmac('sha512', new Buffer(secretString, 'base64')).update(new Buffer(stringToSign)).digest('base64');
    	
    	return mac;
    	
    }
    public void generateSession(){
         Datetime cDT = System.now();
		String  LongDate = cDT.format('DDMMYYYhhmmss');
    	String relativeUrl = 'https://'+ portal + '/services/api/sts/GenerateSession/'+userName+'/'+username+LongDate;
    	System.debug('relativeUrl====>'+relativeUrl);
    	Http h = new Http();
// Instantiate a new HTTP request, specify the method (GET) as well as the endpoint
HttpRequest req = new HttpRequest();
req.setEndpoint(relativeUrl);//?validate=All
// Send the request, and return a response
// 

String utc =DateTime.newInstance(system.currentTimeMillis()).format('yyyy-MM-dd\'T\'hh:mm:ss.000');
String stringToSign = 'GET' + '\n' + 'x-csod-api-key:' + apiToken + '\n' + 'x-csod-date:' + utc + '\n' + relativeUrl;
Blob signature = getSign(apiSecret,stringToSign);
System.debug('stringToSign===>'+stringToSign);
System.debug('apiToken====>'+apiToken);
System.debug('utc====>'+utc);
System.debug('signature====>'+signature);

req.setHeader('x-csod-api-key', apiToken);
req.setHeader('x-csod-date', utc);
req.setHeader('x-csod-signature', String.valueOf(signature));
req.setMethod('GET');
   req.setTimeout(120000);
//system.debug('*****bodyText>'+bodyText);
HttpResponse res = h.send(req);
        if(res!=null)
            result=res.getBody();
system.debug('*****>>'+ res.getBody());
    }
    public  void callout(){
//'http://api.dev.deltafaucet.com/ecommerce/order?validate=All',
Http h = new Http();
// Instantiate a new HTTP request, specify the method (GET) as well as the endpoint
HttpRequest req = new HttpRequest();
req.setEndpoint(url);//?validate=All
// Send the request, and return a response
// 
String da =DateTime.newInstance(system.currentTimeMillis()).format('yyyy-MM-dd\'T\'hh:mm:ss+00:00');
req.setHeader('x-csod-session-token', sessionToken);
req.setHeader('x-csod-date', dateString);
req.setHeader('x-csod-signature', signature);
req.setMethod('GET');
/*String stringToSign = ;
stringToSign.Append(HttpMethod).Append("\n")
.AppendFormat("x-csod-api-key:{0}", apiId).Append("\n")
.AppendFormat("x-csod-date:{0}", DateTime.UtcNow.ToString("yyyy-MM-ddTHH:mm:ss.000")).Append("\n")
.Append(HttpUrl);*/
//req.setHeader('Content-Type','application/json');
       //req.setClientCertificateName('Mosco');
      //  String bodyText='{"writeOrder":false,"valid":null,"tax":null,"source":"S","snappayAuthorizationUUID":null,"shiptoNumber":"321495","shippingTaxPercent":null,"shippingTax":null,"shippingServiceLevel":"STD","shippingOriginAddress":{"zip5":"47396","zip4":"9225","valid":null,"state":"IN","messages":null,"fullName":"Jeannie Armstrong","city":"Yorktown","address2":null,"address1":"7770 W River Rd"},"shippingCharge":null,"shippingAddress":{"zip5":"47396","zip4":"9225","valid":null,"state":"IN","messages":null,"fullName":"Jeannie Armstrong","city":"Yorktown","address2":null,"address1":"7770 W River Rd"},"quickShip":false,"priorityAccessCode":"N","phone":null,"orderTotal":null,"orderSubTotal":null,"orderPlaced":null,"orderNumber":null,"orderItems":[{"unitPrice":16.0718,"trackingNumber":null,"taxPercent":0.0,"taxCode":null,"tax":0.0,"skuCode":"RP1991","quantity":1,"promoCode":"W6","orderStatus":null,"onReceiptQuantity":null,"onHandQuantity":null,"listPrice":null,"lineTotal":null,"lineNumber":null,"extendedPrice":null,"description":"STEM UNIT","committedQuantity":null,"carrierWebsite":null,"carrier":null,"branchPlant":"0301","availableQuantity":null,"activityNumber":"00TM000000Hn6wF"}],"maxLeadTime":null,"errors":null,"email":"jeannie@jeannie.com","documentType":null,"customerOrderNumber":null,"customerID":"gsinh","couponDiscount":null,"coupon":null,"companyNumber":null,"ccType":null,"ccNumber":null,"ccName":null,"ccLastFour":null,"ccExpireYear":null,"ccExpireMonth":null,"ccConfirmationCode":null,"cartID":null,"billtoNumber":null,"billingAddress":{"zip5":"11373","zip4":"4426","valid":null,"state":"NY","messages":null,"fullName":"Jeannie Armstrong","city":"Elmhurst","address2":null,"address1":"5542 Seabury St"},"activityCode":null}';
//req.setBody(bodyText    );
        req.setTimeout(120000);
//system.debug('*****bodyText>'+bodyText);
HttpResponse res = h.send(req);
        if(res!=null)
            result=res.getBody();
system.debug('*****>>'+ res.getBody());

    }
}