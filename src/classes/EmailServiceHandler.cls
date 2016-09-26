global class EmailServiceHandler implements Messaging.InboundEmailHandler {
	  global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email, Messaging.InboundEnvelope envelope) {
		  Messaging.InboundEmailResult result = new Messaging.InboundEmailresult();
		  
		  Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
		  String [] toAddress = new String [] {email.fromAddress };
		  String[] ccAddress= new String [] {'gsinha@appirio.com'};
		  mail.setToAddresses(toAddress);
		  mail.setCcAddresses(ccAddress);
		  
		  mail.setReplyTo( 'Support@salesforce.com');
		  mail.setSenderDisplayName('Salesforce Support');
		  
		  mail.setSubject('Email Received ');
		  mail.setBccSender(false);
		  mail.setUseSignature(false);
		  
		  mail.setPlainTextBody('Thanks for the Email. We will revert you with reply.Hello Plain Body');
		  mail.setHtmlBody('Thanks for the <b>Email.</b> We will revert you with reply.Hello Plain Body Your quoted text : </br>'+email.htmlBody );
		  
		  Messaging.sendEmail(new Messaging.SingleEmailMessage[]{mail});
		  
          return result;
      }
  }