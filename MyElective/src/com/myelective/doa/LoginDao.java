package com.myelective.doa;

import java.sql.Connection;  
import java.sql.DriverManager;  
import java.sql.PreparedStatement;  
import java.sql.ResultSet;  
import java.sql.SQLException;  

public class LoginDao {

	public static boolean validate(String name, String pass){
		boolean status = false;
		Connection conn = null;  
        PreparedStatement userPass = null;
        PreparedStatement emailPass = null;
        ResultSet rs = null;  
  
        String url = "jdbc:mysql://localhost:3306/";  
        String dbName = "my_elective";  
        String driver = "com.mysql.jdbc.Driver";  
        String userName = "root";  
        String password = "yA540004";  
        
        try {  
            Class.forName(driver).newInstance();  
            conn = DriverManager  
                    .getConnection(url + dbName, userName, password);  
  
            userPass = conn  
                    .prepareStatement("SELECT * FROM users WHERE user_name=? AND password=?");  
            userPass.setString(1, name);  
            userPass.setString(2, pass); 
            
            emailPass = conn  
                    .prepareStatement("SELECT * FROM users WHERE email_address=? AND password=?");  
            emailPass.setString(1, name);  
            emailPass.setString(2, pass);  
  
            rs = userPass.executeQuery();
            status = rs.next();
            
            
  
        } catch (Exception e) {  
            System.out.println(e);  
        } finally {  
            if (conn != null) {  
                try {  
                    conn.close();  
                } catch (SQLException e) {  
                    e.printStackTrace();  
                }  
            }  
            if (userPass != null) {  
                try {  
                	userPass.close();  
                } catch (SQLException e) {  
                    e.printStackTrace();  
                }  
            }  
            if (emailPass != null) {  
                try {  
                	emailPass.close();  
                } catch (SQLException e) {  
                    e.printStackTrace();  
                }  
            } 
            if (rs != null) {  
                try {  
                    rs.close();  
                } catch (SQLException e) {  
                    e.printStackTrace();  
                }  
            }  
        }
		
		return status;
	}
}
