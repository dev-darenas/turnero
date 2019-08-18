/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package lib;
import com.sendgrid.*;
import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.kohsuke.rngom.digested.Main;

/**
 *
 * @author Dahian
 */
public class SendNotification {
    
    public static void sendEmail(String Email) throws IOException{
        Email from = new Email("turnero@bluebank.co");
        String subject = "Es tu turno ";
        Email to = new Email(Email);
        Content content = new Content("text/plain", "Es tu turno en blue bank");
        Mail mail = new Mail(from, subject, to, content);

        SendGrid sg = new SendGrid("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");
        Request request = new Request();
        try {
            request.setMethod(Method.POST);
            request.setEndpoint("mail/send");
            request.setBody(mail.build());
            Response response = sg.api(request);
            System.out.println(response.getStatusCode());
            System.out.println(response.getBody());
            System.out.println(response.getHeaders());
        } catch (IOException ex) {
            System.out.println("lib.SendNotification.sendEmail()");
            throw ex;
        }    
    }
    
    public static void sendSMS(){
        
    }
    
    public static void sendWHT(){
        
    }
    
    public static void main(String[] args) {
        try {
            sendEmail("darenas@softdreams.co");
        } catch (IOException ex) {
            Logger.getLogger(SendNotification.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
