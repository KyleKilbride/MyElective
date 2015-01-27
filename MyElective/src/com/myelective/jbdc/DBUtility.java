package com.myelective.jbdc;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBUtility {
	
	private static Connection connection = null;
	
	public static Connection getConnection() {
		
		if (connection != null){
			return connection;
		}else {
		
			try{
				String url = "jdbc:mysql://localhost:3306/";  
				String dbName = "my_elective";  
				String driver = "com.mysql.jdbc.Driver";  
				String userName = "root";  
				String password = "";
				
				Class.forName(driver).newInstance();
				connection = DriverManager  
	                    .getConnection(url + dbName, userName, password);  
        
		} catch (Exception e){
			e.printStackTrace();
		}
		
		return connection;
		}
	}

}
