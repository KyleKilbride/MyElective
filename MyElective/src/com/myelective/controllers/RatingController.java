package com.myelective.controllers;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import beans.Elective;
import beans.Rating;

import com.myelective.jbdc.DBUtility;

/**
 * A class used to access, return and add Rating data to
 * the SQL Database.
 * 
 * @author Matthew Boyd
 * @version 0.2
 *
 */

/**
 * A class used to access, return and add Rating data to
 * the SQL Database.
 * 
 * @author Matthew Boyd
 * @version 0.2
 *
 */
public class RatingController {
	
	private Connection dbConnection;
	
	/** Select statement for returning the 4 most recent Ratings from database*/
	private String SQL_GET_RECENT_RATINGS = "SELECT * FROM ratings ORDER BY id DESC LIMIT ?";

	/**
	 * Default Constructor
	 */
	public RatingController(){
		dbConnection = DBUtility.getConnection();
	}
	
	/**
	 * Returns the most recent specified number of ratings from the database in an ArrayList of Rating objects
	 * 
	 * @param numberOf	The number of ratings to be returns
	 * @return an ArrayList of the most recent Rating objects from database
	 */
	public ArrayList<Rating> getRecentRating(int numberOf){
		ArrayList<Rating> ratingBeanAL = new ArrayList<Rating>();
		
		try{
			PreparedStatement pSt1 = dbConnection.prepareStatement(SQL_GET_RECENT_RATINGS);
			pSt1.setInt(1, numberOf);
			ResultSet result1 = pSt1.executeQuery();
			
			if(result1.last()){ //True if at least one row is returned, and sets the cursor to the last row in the result set
				int returnedRowNum = result1.getRow();
				
				if(numberOf >= returnedRowNum){ //if query returns fewer than requested Ratings
					numberOf = returnedRowNum;
				}
				
				//Creates specified number of Rating objects from result set and adds them to Arraylist
				for(int i = 0; i < numberOf; i++){	
					Rating ratingBean = new Rating(); // creates a new Rating object
					
					//Sets fields for Rating objects
					ratingBean.setRating(result1.getInt("rating"));
					ratingBean.setHoursPerWeek(result1.getInt("hours_per_week"));
					ratingBean.setComment(result1.getString("comment"));
					ratingBean.setElectiveID(result1.getInt("electives_id"));
					
					ratingBeanAL.add(ratingBean); //adds Rating object to ArrayList
					result1.previous(); //moves cursor to previous row in result set
				}
			}
		}catch(Exception e){
			System.out.println(e);
		}
		
		return ratingBeanAL;
	}
	
	public Elective getElective(int num) throws SQLException{
		PreparedStatement query = dbConnection.prepareStatement("SELECT elective_name FROM electives WHERE id=?");
		query.setInt(1, num);
		ResultSet r = query.executeQuery();
		
		if(r != null){
			Elective e = new Elective();
			r.next();
			e.setName(r.getString("elective_name"));
			
			return e;
		}else
			return null;
	}
}
