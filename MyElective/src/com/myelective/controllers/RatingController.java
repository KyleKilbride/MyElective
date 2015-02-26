package com.myelective.controllers;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;

import beans.Elective;
import beans.Rating;
import beans.User;


import com.myelective.jbdc.DBUtility;

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
	
	private String SQL_SELECT_ALL_FOR_ELECTIVE = "SELECT * FROM ratings WHERE electives_id=?";

	/**
	 * Default Constructor
	 */
	public RatingController(){
		dbConnection = DBUtility.getConnection();
	}
	
	public ArrayList<Rating> getElectiveRatings(int electiveID){
		
		ArrayList<Rating> ratings = new ArrayList<Rating>();
		
		try{
			
			PreparedStatement pSt1 = dbConnection.prepareStatement(SQL_SELECT_ALL_FOR_ELECTIVE);
			pSt1.setInt(1, electiveID);
			ResultSet result1 = pSt1.executeQuery();
			
			while (result1.next()) {
				Rating rating = new Rating();
				rating.setRating(result1.getInt("rating"));
				rating.setHoursPerWeek(result1.getInt("hours_per_week"));
				rating.setComment(result1.getString("comment"));
				rating.setElectiveID(result1.getInt("electives_id"));
				rating.setDate(new Date(result1.getInt("date")));
				rating.setUserID(result1.getInt("users_id"));
				ratings.add(rating);
			}
			
		}catch(Exception e){
			System.out.println(e);
		}
		
		return ratings;
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
	
	public User getUser(int id) throws SQLException{
		PreparedStatement query = dbConnection.prepareStatement("SELECT * FROM users WHERE id=?");
		query.setInt(1, id);
		ResultSet r = query.executeQuery();
		
		if(r != null){
			User u = new User();
			r.next();
			u.setFirstName("first_name");
			u.setLastName("last_name");
			u.setEmailAddress("email_address");
			u.setPassword("password");
			u.setProgram("program");
			u.setUsername("username");
			
			return u;
		}
		
		return null;
	}
	
	public Elective getElective(int id) throws SQLException{
		PreparedStatement query = dbConnection.prepareStatement("SELECT * FROM electives WHERE id=?");
		query.setInt(1, id);
		ResultSet r = query.executeQuery();
		
		if(r != null){
			Elective e = new Elective();
			r.next();
			e.setName(r.getString("elective_name"));
			e.setRating(r.getInt("average_rating"));
			e.setDescription(r.getString("description"));
			
			return e;
		}else
			return null;
	}
	
	public ArrayList<Rating> getRatings(){
		
		
		
		return null;
	}
}
