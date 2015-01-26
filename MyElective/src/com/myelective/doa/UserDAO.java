package com.myelective.doa;

import java.sql.Connection; 
import java.sql.PreparedStatement;  
import java.sql.ResultSet;  

import com.myelective.jbdc.DBUtility;

public class UserDAO {
	
	private Connection dbConnection;
	
	private String SQL_SELECT_EMAIL = "SELECT * FROM users WHERE email_address=? AND password=?";
	private String SQL_SELECT_USER = "SELECT * FROM users WHERE user_name=? AND password=?";
	
	private String SQL_SELECT_CHECKUSER = "SELECT * FROM users WHERE user_name=?";
	private String SQL_SELECT_CHECKEMAIL = "SELECT * FROM users WHERE email_address=?";
	
	private String SQL_INSERTUSER = "INSERT INTO users (user_name, password, first_name, last_name, program, email_address, status) VALUES (?,?,?,?,?,?,?)";
	
	public UserDAO(){
		dbConnection = DBUtility.getConnection();
	}

	public String validate(String name, String pass){
		String userName = null;
        PreparedStatement userPassPST = null;
        PreparedStatement emailPassPST = null;
   
        try { 
        	emailPassPST = dbConnection.prepareStatement(SQL_SELECT_EMAIL);
        	emailPassPST.setString(1, name);
        	emailPassPST.setString(2, pass);
        	ResultSet rsEmailPass = emailPassPST.executeQuery();
        	while(rsEmailPass.next()){
        		userName = rsEmailPass.getString("user_name");
        	}
        	
        	if(userName == null){
        		userPassPST = dbConnection.prepareStatement(SQL_SELECT_USER);
        		userPassPST.setString(1, name);
        		userPassPST.setString(2, pass);
        		ResultSet rsUserPass = userPassPST.executeQuery();
        		while(rsUserPass.next()){
        			userName = rsUserPass.getString("user_name");
        		}
        	}
        } catch (Exception e) {  
            System.out.println(e);  
        }
		
		return userName;
	}
	
	public boolean checkEmailNotUsed(String email){
		boolean emailUsed = true;
		PreparedStatement emailPST = null;
		
		try{
			emailPST = dbConnection.prepareStatement(SQL_SELECT_CHECKEMAIL);
			emailPST.setString(1, email);
			ResultSet rsEmail = emailPST.executeQuery();
			emailUsed = rsEmail.next();
		} catch (Exception e) {  
            System.out.println(e);  
        }
		
		return emailUsed;
	}
	
	public boolean checkUsername(String username){
		boolean usernameUsed = false;
		PreparedStatement usernamePST = null;
		
		try{
			usernamePST = dbConnection.prepareStatement(SQL_SELECT_CHECKUSER);
			usernamePST.setString(1, username);
			ResultSet rsUser = usernamePST.executeQuery();
			usernameUsed = rsUser.next();
		} catch (Exception e) {  
            System.out.println(e);  
        }
		
		return usernameUsed;
	}
	
	public int createUser(String username, String password, String first_name, String last_name, String email, String program, String userType){
		int result = 0;
		PreparedStatement insertUserPST = null;
		
		try{
			insertUserPST = dbConnection.prepareStatement(SQL_INSERTUSER);
			insertUserPST.setString(1, username);
			insertUserPST.setString(2, password);
			insertUserPST.setString(3, first_name);
			insertUserPST.setString(4, last_name);
			insertUserPST.setString(5, program);
			insertUserPST.setString(6, email);
			insertUserPST.setString(7, userType);
			
			result = insertUserPST.executeUpdate();
		} catch (Exception e) {  
            System.out.println(e);  
        }
		
		return result;
	}
}
