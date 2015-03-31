package com.myelective.jbdc;

import java.sql.Connection;
import java.sql.DriverManager;

/**
* A class used to manage the Connection to the SQL Database
*
* @author Matthew Boyd
* @version 0.1 
*/
public class DBUtility {
	
	private static Connection connection = null;
	
	/**
	 * Returns a Connection to the SQL database. If a Connection is already
	 * established, returns the current Connection. If a Connection
	 * is not established, connects to the database and returns the created
	 * Connection
	 * 
	 * @return 		the Connection to the database
	 */
	public static Connection getConnection() {
		
		if (connection != null){
			return connection;
		}else {
		
			try{
				String url = "jdbc:mysql://localhost:3306/";  
				String dbName = "my_elective";  
				String driver = "com.mysql.jdbc.Driver";  
				String userName = "root";  
				String password = "password";
				
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
