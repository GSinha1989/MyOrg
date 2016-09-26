global class ReadInboundFile implements Messaging.InboundEmailHandler {
         
     	 
     public static final String FIELD1_TAG = 'fname';
     public static final String FIELD2_TAG = 'lname';
     public static final String FIELD3_TAG = 'subject';
     public static final String FIELD4_TAG = 'experience';
     public static final String FIELD5_TAG = 'email';     
     
     
     public class ContactReader {
        String fname;
        String lname;
        String subject;
        String exp;
        String email;
    }

    public void parseContacts(XmlStreamReader reader) {
         System.debug('Enter the message parseContacts');
        ContactReader[] contacts = new ContactReader[0];
        boolean isSafeToGetNextXmlElement = true;
        while(isSafeToGetNextXmlElement) {
            // Start at the beginning of the book and make sure that it is a book
            if (reader.getEventType() == XmlTag.START_ELEMENT) {
                if (FIELD1_TAG == reader.getLocalName()||
                    FIELD2_TAG == reader.getLocalName()||
                   FIELD3_TAG == reader.getLocalName()||
                   FIELD4_TAG == reader.getLocalName()||
                   FIELD5_TAG == reader.getLocalName()||
                   'Contact' == reader.getLocalName()) {
                    // Pass the book to the parseBook method (below) 
                    // 
                    System.debug('Tags found - '+reader.getLocalName());
                     parseContact(reader,reader.getLocalName());
                   // contact.add(contact);
                }
            }
            // Always use hasNext() before calling next() to confirm 
            // that we have not reached the end of the stream
            if (reader.hasNext()) {
                reader.next();
            } else {
                isSafeToGetNextXmlElement = false;
                break;
            }
        }
        
    }
    ContactReader contact   ;
    // Parse through the XML, determine the author and the characters
    void parseContact(XmlStreamReader reader,String str) {
        System.debug('Enter the message parseContact');
    
        //contact.author = reader.getAttributeValue(null, 'author');
        boolean isSafeToGetNextXmlElement = true;
        while(isSafeToGetNextXmlElement) {
            if (reader.getEventType() == XmlTag.END_ELEMENT) {
                System.debug(' End Tag ===='+reader.getLocalName() );
                if( FIELD5_TAG == reader.getLocalName()){
                    System.debug('jasdiuashd ======-----' +contact);
                	saveContact(contact);
                 contact   = new ContactReader();
                }
                break; 
            } else if (reader.getEventType() == XmlTag.CHARACTERS) {
                System.debug('Value ofr the tags is - '+reader.getText()+ '3w333' +str);
                if(FIELD1_TAG == str)
                     contact.fname = reader.getText();
                if(FIELD2_TAG == str)
                     contact.lname = reader.getText();
                if(FIELD3_TAG == str)
                     contact.subject = reader.getText();
                  if(FIELD4_TAG == str)
                     contact.exp = reader.getText();
                if(FIELD5_TAG == str)
                     contact.email = reader.getText();
               
            }
            // Always use hasNext() before calling next() to confirm 
            // that we have not reached the end of the stream
            if (reader.hasNext()) {
                reader.next();
            } else {
                isSafeToGetNextXmlElement = false;
                break;
            }
        }
    }
     List<String> created = new List<String>();
	  global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email, Messaging.InboundEnvelope envelope) {
         	contact= new ContactReader();
          Messaging.InboundEmailResult result = new Messaging.InboundEmailresult();
          Messaging.InboundEmail.TextAttachment[] tAttachments = email.textAttachments;
          Messaging.InboundEmail.BinaryAttachment[] bAttachments = email.BinaryAttachments;
          String xmlBody='';
          System.debug('Enter the message handleInboundEmail');
          if(bAttachments !=null){
              System.debug('Binary attachemnt');
              for(Messaging.InboundEmail.BinaryAttachment btt : bAttachments){
                  System.debug('this looks like a binary attachment'); 
                  if(btt.filename.endsWith('.xml')){
                      xmlBody = btt.body.toString();
                      System.debug('Binary attachemnt');
                  }
              }
              
          }
          else if(tAttachments !=null){
              System.debug('Text attachemnt');
              for(Messaging.InboundEmail.TextAttachment ttt : tAttachments){
                  System.debug('this looks like a text attachment');
                  if(ttt.filename.endsWith('.xml')){
                      xmlBody = ttt.body; 
                      
                  }
                 
              }
          }
          System.debug('Parsing start of ='+xmlBody);
          XmlStreamReader reader = new XmlStreamReader(xmlBody);
          parseContacts(reader);
          String body = ' Records created ids are ';
          for(String s : created){
              body = (String)body + String.valueOf(s)+'/n';
          }
          Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
          String [] toAddress = new String [] {email.fromAddress };
		  //String[] ccAddress= new String [] {'gsinha@appirio.com'};
		  mail.setToAddresses(toAddress);
		 // mail.setCcAddresses(ccAddress);
		  
		  mail.setReplyTo( 'Support@salesforce.com');
		  mail.setSenderDisplayName('Salesforce Support');
		  
		  mail.setSubject('Email Received ');
		  mail.setBccSender(false);
		  mail.setUseSignature(false);
		  
		  mail.setPlainTextBody(body);
		  mail.setHtmlBody('Thanks for the <b>Email.</b> We will revert you with reply.Hello Plain Body Your quoted text : </br>'+body );
		  
		  Messaging.sendEmail(new Messaging.SingleEmailMessage[]{mail});
          return result;
      } 

     
    
     public void saveContact(ContactReader contact){
         System.debug('Enter the message saveContact'+contact);
         Contact c = new Contact(Experience__c = Integer.valueOf(contact.exp),Email = contact.email);
         System.debug(c);
             c.firstName = contact.fname;
         	 c.lastName = contact.lname;
         	 c.Subject__c = 	 contact.subject;
         //String [] temp = contact.subject.split(',');
         	 //for(String s : temp)
         	 	//c.Subject__c = s;
         
         	insert c;
         created.add(c.id);
     }
 }