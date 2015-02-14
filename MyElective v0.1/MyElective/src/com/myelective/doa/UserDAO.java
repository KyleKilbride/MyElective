package com.myelective.doa;

import java.sql.Connection; 
import java.sql.PreparedStatement;  
import java.sql.ResultSet;  

import com.myelective.jbdc.DBUtility;

/**
 * A class used to access, return and add user data to
 * the SQL Database.
 * 
 * @author Matthew Boyd
 * @version 0.1
 *
 */
public class UserDAO {
	
	private Connection dbConnection;
	
	//Select statement used to verify email and password match for login
	private String SQL_SELECT_EMAIL = "SELECT * FROM users WHERE email_address=? AND password=?";
	//Select statement used to verify username and password match for login
	private String SQL_SELECT_USER = "SELECT * FROM users WHERE user_name=? AND password=?";
	
	//Select statement used to see if username exists in database
	private String SQL_SELECT_CHECKUSER = "SELECT * FROM users WHERE user_name=?";
	//Select statement used to see if email exists in database
	private String SQL_SELECT_CHECKEMAIL = "SELECT * FROM users WHERE email_address=?";
	
	//Insert statement used to add a new user into the database
	private String SQL_INSERTUSER = "INSERT INTO users (user_name, password, first_name, last_name, program, email_address, status) VALUES (?,?,?,?,?,?,?)";
	
	
	public UserDAO(){
		dbConnection = DBUtility.getConnection();
	}
	
	/**
	 * Checks if username/pass or email/pass combinations are in the database
	 * 
	 * @param name	email or username specified for login
	 * @param pass	password specified for login
	 * @return		null for unsuccessful login, username for
	 * 				successful login.
	 */
	public String validate(String name, String pass){
		String userName = null;
        PreparedStatement userPassPST = null;
        PreparedStatement emailPassPST = null;
   
        try { 
        	emailPassPST = dbConnection.prepareStatement(SQL_SELECT_EMAIL);
        	emailPassPST.setString(1, name);
        	emailPassPST.setString(2, pass);
        	ResultSet rsEmailPass = emailPassPST.executeQuery();
        	while(rsEmailPass.next()){	//if a row is returned from the SELECT statement
        		userName = rsEmailPass.getString("user_name");
        	}
        	
        	if(userName == null){	//if email/pass doesn't return a User
        		userPassPST = dbConnection.prepareStatement(SQL_SELECT_USER);
        		userPassPST.setString(1, name);
        		userPassPST.setString(2, pass);
        		ResultSet rsUserPass = userPassPST.executeQuery();
        		while(rsUserPass.next()){	//if a row is returned from the SELECT statement
        			userName = rsUserPass.getString("user_name");
        		}
        	}
        } catch (Exception e) {  
            System.out.println(e);  
        }
		
		return userName;
	}
	
	/**
	 * Checks if email is in the database
	 * 
	 * @param email		email being used for account creation
	 * @return			true if email is in database, false if email
	 * 					is not in database.
	 */
	public boolean checkEmailNotUsed(String email){
		boolean emailUsed = true;
		PreparedStatement emailPST = null;
		
		try{
			emailPST = dbConnection.prepareStatement(SQL_SELECT_CHECKEMAIL);
			emailPST.setString(1, email);
			ResultSet rsEmail = emailPST.executeQuery();
			emailUsed = rsEmail.next(); //true if SELECT if returns a row
		} catch (Exception e) {  
            System.out.println(e);  
        }
		
		return emailUsed;
	}
	
	/**
	 * Checks if username is in the database
	 * 
	 * @param username	username being used for account creation
	 * @return			true if email is in database, false if
	 * 					username is not in database.
	 */
	public boolean checkUsername(String username){
		boolean usernameUsed = false;
		PreparedStatement usernamePST = null;
		
		try{
			usernamePST = dbConnection.prepareStatement(SQL_SELECT_CHECKUSER);
			usernamePST.setString(1, username);
			ResultSet rsUser = usernamePST.executeQuery();
			usernameUsed = rsUser.next(); //true if SELECT if returns a row
		} catch (Exception e) {  
            System.out.println(e);  
        }
		
		return usernameUsed;
	}
	
	/**
	 * Attempts to add a new user into the database
	 * 
	 * @param username		username used for account creation
	 * @param password		password used for account creation
	 * @param first_name	first name used for account creation
	 * @param last_name		last name used for account creation
	 * @param email			email address used for account creation
	 * @param program		Program of Study used for account creation
	 * @param userType		User type used for account creation
	 * @return				1 for successful account creation, 0 for
	 * 						unsuccessful account creation
	 */
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
			
			result = insertUserPST.executeUpdate(); // row count of INSERT statement
		} catch (Exception e) {  
            System.out.println(e);  
        }
		
		return result;
	}
}
