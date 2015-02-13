package com.myelective.controllers;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
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
	 * Returns a randomly selected Elective object from the database
	 * 
	 * @return random Elective
	 */
	public Elective getFeaturedElective(){
		int firstID = 0; //id of first returned row
		int lastID = 0; //id of last returned row
		int randomID;
		Elective electiveBean = new Elective();
		Random random = new Random();
		try{
			PreparedStatement pSt1 = dbConnection.prepareStatement(SQL_SELECT_ID);
			PreparedStatement pSt2 = dbConnection.prepareStatement(SQL_SELECT_ALL);
			ResultSet result1 = pSt1.executeQuery();
			
			//Gets ID of first returned row
			if(result1.first()){
				firstID = Integer.parseInt(result1.getString("id"));
			}
			//Gets ID of last returned row
			if(result1.last()){
				lastID = Integer.parseInt(result1.getString("id"));
			}
			
			//If values returned for both first and last IDs
			if(firstID != 0 && lastID != 0){
				randomID = random.nextInt(lastID - firstID) + firstID; //Gets random ID within the proper range
				pSt2.setString(1, Integer.toString(randomID));
				ResultSet result2 = pSt2.executeQuery();
				//If a row is returned
				if(result2.next()){
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
