package com.knowhoon.util;

import java.util.Random;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Component;

@Component
public class Util {
	@Autowired
	private JavaMailSender mailSender;
	
	public String getIP(HttpServletRequest request) {
		String ip = request.getHeader("X-FORWARDED");
		if(ip == null) {
			ip = request.getHeader("Proxy-Client-IP");
		}
		if(ip == null) {
			ip = request.getHeader("WL-Proxy-Client_IP");
		}
		if(ip == null) {
			ip = request.getHeader("HTTP_CLIENT_IP");
		}
		if(ip == null) {
			ip = request.getHeader("HTTP_X_FORWARDED_FOR");
		}
		if(ip == null) {
			ip = request.getRemoteAddr();
		}
		return ip;
	}
	
	public int str2Int(String str) {
		try {
			return Integer.parseInt(str);			
		} catch (Exception e) {
			return 0;
		}
	}
	
	public boolean str2Intb(String str) {
		try {
			Integer.parseInt(str);
			return true;
		} catch (Exception e) {
			return false;
		}
	}
	
	public String replace(String content) {
		if(content != null) {
			content = content.replaceAll(">", "&gt;");
			content = content.replaceAll("<", "&lt;");
			content = content.replaceAll("/", "&#47;");
			content = content.replaceAll("\n", "<br>");
		}		
		return content;		
	}
	
	public String getUserIp(HttpServletRequest request) {
		String ip = request.getHeader("X-FORWARDED-FOR");
		if(ip == null) {
			ip = request.getHeader("Proxy-Client-IP");
		}
		if(ip == null) {
			ip = request.getHeader("WL-Proxy-Client-IP");
		}
		if(ip == null) {
			ip = request.getHeader("HTTP_CLIENT_IP");
		}
		if(ip == null) {
			ip = request.getHeader("HTTP_X-FORWARDED_FOR");
		}
		if(ip == null) {
			ip = request.getRemoteAddr();
		}
		return ip;
	}
	//수정2
	public String getAuthCode(int size) {
	        Random random = new Random();
	        StringBuffer buffer = new StringBuffer();
	        int num = 0;

	        while(buffer.length() < size) {
	            num = random.nextInt(10);
	            buffer.append(num);
	        }
	        return buffer.toString();
	}
	
	public String sendEmail(String authCode, String email, String subject, String content) {
		String from = "knowhoon@gmail.com";
		try {
			MimeMessage mail = mailSender.createMimeMessage();
			MimeMessageHelper mailHelper = new MimeMessageHelper(mail,true, "UTF-8");
			mailHelper.setFrom(from);
			mailHelper.setTo(email);
		    mailHelper.setSubject(subject);
		    mailHelper.setText(content,true);
		    mailSender.send(mail);
		} catch (Exception e) {
			authCode = "error";
			e.printStackTrace();
		}
		return authCode;
	}
	public static String generateSalt() {
		Random random = new Random();
		
		byte[] salt = new byte[8];
		random.nextBytes(salt);
		
		StringBuffer sb = new StringBuffer();
		for (int i = 0; i < salt.length; i++) {
			// byte 값을 Hex 값으로 바꾸기.
			sb.append(String.format("%02x",salt[i]));
		}
		
		return sb.toString();
	}
}
