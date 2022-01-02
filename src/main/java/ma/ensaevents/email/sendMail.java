package ma.ensaevents.email;

import ma.ensaevents.entity.Event;
import org.springframework.context.annotation.PropertySource;

import java.io.BufferedReader;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintStream;
import java.net.URL;
import java.util.List;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class SendMail {
	
	public static String htmlToString(Event event) {

		SendMail obj = new SendMail();
		Class class1 = obj.getClass();
		URL absolutePath = class1.getResource("../../../email_template/index.html");
		StringBuilder contentBuilder = new StringBuilder();

		try {

		    BufferedReader in = new BufferedReader(new FileReader(absolutePath.getPath().replaceFirst("/","")));
		    String str;
		    while ((str = in.readLine()) != null) {
		        contentBuilder.append(str);
		    }
		    in.close();
		} catch (IOException e) {
		}
		String content = contentBuilder.toString();

		content = content.replaceAll(":event:",event.getName()).replaceAll(":club:", event.getClub().getName()).replaceAll(":date:",event.getDate().toString()).replaceAll(":enddate:",event.getEndDate().toString());
		
		return content;
	}

	public static void SendMail(List<String> recipients, String title, Event event) {
		Thread newThread = new Thread(() -> {

			SendMail obj = new SendMail();
			Class class1 = obj.getClass();
			URL url = class1.getResource("../../../log.txt");

			ByteArrayOutputStream test = new ByteArrayOutputStream();
			PrintStream x = new PrintStream(test);
			PrintStream console = System.out;
			System.setOut(x);
			
			
			// Recipient's email ID needs to be mentioned.
			List<String> to = recipients;

			// Sender's email ID needs to be mentioned
			String from = "ensaevents@gmail.com";

			// Assuming you are sending email from through gmails smtp
			String host = "smtp.gmail.com";

			// Get system properties
			Properties properties = System.getProperties();

			// Setup mail server
			properties.put("mail.smtp.host", host);
			properties.put("mail.smtp.port", "465");
			properties.put("mail.smtp.ssl.enable", "true");
			properties.put("mail.smtp.auth", "true");

			// Get the Session object.// and pass username and password
			Session session = Session.getInstance(properties, new javax.mail.Authenticator() {

				protected PasswordAuthentication getPasswordAuthentication() {

					return new PasswordAuthentication("ensaevents@gmail.com", "testmailevents");

				}

			});

			// Used to debug SMTP issues
			session.setDebug(true);

			try {
				
				FileWriter myWriter = new FileWriter(url.getPath().replaceFirst("/",""),true);
				
				// Create a default MimeMessage object.
				MimeMessage message = new MimeMessage(session);

				// Set From: header field of the header.
				message.setFrom(new InternetAddress(from));

				// Set To: header field of the header.
				for (String destinataire : to) {
					message.addRecipient(Message.RecipientType.TO, new InternetAddress(destinataire));
				}

				// Set Subject: header field
				message.setSubject(title);
				
				message.setContent(htmlToString(event) , "text/html");

				System.out.println("before"+"sending");
				// Send message
				Transport.send(message);
				System.out.println("afeter sending");
				myWriter.write("A email has been sent successfully \n");

			    myWriter.close();
			    
			} catch (Exception mex) {
				mex.printStackTrace();
				FileWriter myWriter;
				try {
					myWriter = new FileWriter(url.getPath().replaceFirst("/",""),true);
					myWriter.write(test.toString());
					myWriter.close();
				} catch (IOException e) {
					e.printStackTrace();
				}

			}finally {
				System.setOut(console);
			}
		});

		newThread.start();
	}

}