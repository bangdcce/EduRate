package Models;

import static Models.VerifyCode.generateVerificationCode;
import java.sql.Date;
import java.util.Properties;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class Email {

    public void sendEmail(String to,String verifiCode) {
        //passSendGrid=pfX42qFC3uRj7D-A
        //recovery code:KW12B77TWXXV1GQ5BQMXVXEU
        final String from = "rateedu10@gmail.com";
        final String pass = "tbfisqjhozbiqltr";

        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        Authenticator auth =new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(from, pass);
            }
        };
         Session session =Session.getInstance(props,auth);
         MimeMessage msg =new MimeMessage(session); 
         try {
            msg.addHeader("Content-type","text/HTML;charset=UTF-8");
            
            msg.setFrom(from);
            
            msg.setRecipients(Message.RecipientType.TO,InternetAddress.parse(to,false));
            
            msg.setSubject("Test email");
            
            msg.setSentDate(new java.util.Date());
            msg.setText("This is content "+verifiCode,"UTF-8");
            
            
             Transport.send(msg);
            
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
