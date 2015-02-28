package com.myelective.controllers;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

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
	
	public User getUser(int id) throws SQLException{
		PreparedStatement query = dbConnection.prepareStatement("SELECT * FROM users WHERE id=?");
		query.setInt(1, id);
		ResultSet r = query.executeQuery();
		
		if(r != null){
			User u = new User();
			r.next();
			u.setFirstName(r.getString("first_name"));
			u.setLastName(r.getString("last_name"));
			u.setEmailAddress(r.getString("email_address"));
			u.setPassword(r.getString("password"));
			u.setProgram(r.getString("program"));
			u.setUsername(r.getString("user_name"));
			
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
			e.setId(r.getInt("id"));
			e.setName(r.getString("elective_name"));
			e.setRating(r.getInt("average_rating"));
			e.setCourseCode(r.getString("course_code"));
			e.setDescription(r.getString("description"));
			e.setComments(this.getRatings(id));
			return e;
		}else
			return null;
	}
	
	public Elective getElectiveByString(String selectedElective) throws SQLException{
		if(selectedElective.contains("'")){
			selectedElective = selectedElective.replace("'", "''");
		}
		PreparedStatement query = dbConnection.prepareStatement("SELECT * FROM electives WHERE elective_name=?");
		query.setString(1, selectedElective);
		ResultSet r = query.executeQuery();
		
		if(r != null){
			Elective e = new Elective();
			r.next();
			e.setId(r.getInt("id"));
			e.setName(r.getString("elective_name"));
			e.setRating(r.getInt("average_rating"));
			e.setCourseCode(r.getString("course_code"));
			e.setDescription(r.getString("description"));
		//	e.setComments(this.getRatings(id));
			return e;
		}else
			return null;
	}
	
	public ArrayList<Rating> getRatings(int id) throws SQLException{
		PreparedStatement query = dbConnection.prepareStatement("SELECT * FROM ratings WHERE electives_id=?");
		query.setInt(1, id);
		ResultSet r = query.executeQuery();
		
		ArrayList<Rating> ratingList = new ArrayList<Rating>();
		
		while(r.next()){
			Rating rating = new Rating();
			rating.setComment(r.getString("comment"));
			rating.setRating(r.getInt("rating"));
			rating.setHoursPerWeek(r.getInt("hours_per_week"));
			rating.setElectiveID(r.getInt("electives_id"));
			//rating.setDate(r.getDate("date_modified"));
			rating.setUserID(r.getInt("users_id"));
			ratingList.add(rating);
		}
		
		return ratingList;
	}
	
	public void editElectiveName(String newName, String currentName)throws SQLException{
		if(newName.contains("'")){
			newName = newName.replace("'", "''");
		}
		if(currentName.contains("'")){
			currentName = currentName.replace("'", "''");
		}
		PreparedStatement query = dbConnection.prepareStatement("UPDATE electives SET elective_name = '" + newName + "' WHERE elective_name = '" + currentName + "'");
		query.executeUpdate();
		return;
	}

	public void editElectiveCourseCode(String newCode, String currentCode)throws SQLException{
		if(newCode.contains("'")){
			newCode = newCode.replace("'", "''");
		}
		if(currentCode.contains("'")){
			currentCode = currentCode.replace("'", "''");
		}
		PreparedStatement query = dbConnection.prepareStatement("UPDATE electives SET course_code = '" + newCode + "' WHERE course_code = '" + currentCode + "'");
		query.executeUpdate();
		return;
	}

	public void editElectiveDescription(String newDesc, String currentDesc)throws SQLException{
		if(newDesc.contains("'")){
			newDesc = newDesc.replace("'", "''");
		}
		if(currentDesc.contains("'")){
			currentDesc = currentDesc.replace("'", "''");
		}
		PreparedStatement query = dbConnection.prepareStatement("UPDATE electives SET description = '" + newDesc + "' WHERE description = '" + currentDesc + "'");
		query.executeUpdate();
		return;
	}
	
	public void removeElective(String electiveName)throws SQLException{
		if(electiveName.contains("'")){
			electiveName = electiveName.replace("'", "''");
		}
		PreparedStatement query = dbConnection.prepareStatement("DELETE FROM electives WHERE elective_name = '" + electiveName + "'");
		query.executeUpdate();
		return;
	}
	
	public void addElective(String electiveName, String electiveCode, String electiveDesc)throws SQLException{
		if(electiveName.contains("'")){
			electiveName = electiveName.replace("'", "''");
		}
		if(electiveCode.contains("'")){
			electiveCode = electiveName.replace("'", "''");
		}
		if(electiveName.contains("'")){
			electiveDesc = electiveDesc.replace("'", "''");
		}
		PreparedStatement query = dbConnection.prepareStatement("INSERT INTO electives (course_code, elective_name, description, average_rating) VALUES ('" + electiveCode + "', '" + electiveName + "', '" + electiveDesc + "', '0')");
		query.executeUpdate();
		return;
	}
}
