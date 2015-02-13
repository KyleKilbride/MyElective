package com.myelective.controllers;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Calendar;
import java.util.Random;

import beans.Elective;

import com.myelective.jbdc.DBUtility;

/**
 * A class used to access, return and add Elective data to
 * the SQL Database.
 * 
 * @author Matthew Boyd
 * @version 0.2
 *
 */
public class ElectiveController {

	private Connection dbConnection;
	/** Select statement to return all id numbers Electives table */
	private String SQL_SELECT_ID = "SELECT id FROM electives";
	/** Select statement to return specified row from Electives table */
	private String SQL_SELECT_ALL = "SELECT * FROM electives WHERE id=?";
	
	/**
	 * Default constructor
	 */
	public ElectiveController(){
		dbConnection = DBUtility.getConnection();
	}
	
	/**
	 * Returns a Elective object from the database based on the current date. The featured elective returned
	 * will be different based on the current date
	 * 
	 * @return featured Elective
	 */
	public Elective getFeaturedElective(){
		
		Calendar calendar = Calendar.getInstance();
		int dayOfYear = calendar.get(Calendar.DAY_OF_YEAR); //gets the current nth day of the year
		
		int numRows = 0; //number of rows in the Elective table
		
		Elective electiveBean = new Elective();
		try{
			PreparedStatement pSt1 = dbConnection.prepareStatement(SQL_SELECT_ID);
			PreparedStatement pSt2 = dbConnection.prepareStatement(SQL_SELECT_ALL);
			
			ResultSet result1 = pSt1.executeQuery();
			
			if(result1.last()){ //moves cursor to last returned row and returns true if a valid row
				numRows = result1.getRow();
				for(int i = 0; i< (dayOfYear%numRows); i++){ //moves the cursor to a row based off the algorithm
					result1.previous();
				}
				
				pSt2.setString(1, result1.getString("id")); //Gets the id of the selected row and inserts into the prepared statement
				
				ResultSet result2 = pSt2.executeQuery();
				
				if(result2.next()){ //moves cursor to first(and only) returned row and returns true if a valid row
					//Sets fields for Elective object
					electiveBean.setCourseCode(result2.getString("course_code"));
					electiveBean.setName(result2.getString("elective_name"));
					electiveBean.setDescription(result2.getString("description"));
					electiveBean.setRating(Integer.parseInt(result2.getString("average_rating")));
				}
			}
			
			
		}catch (Exception e) {  
            System.out.println(e);  
        }

		return electiveBean;
	}
	
}
