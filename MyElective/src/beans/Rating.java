package beans;

import java.util.Date;

/**
* A class for Rating objects. 
* A rating is an individual evaluation of a Course object
* Contains setters and getters for all fields
*
* @author Matthew Boyd
* @version 0.2 
*/
public class Rating {
	
	/** The individual rating for the course*/
	private int rating;
	/** The amount of hours for this course */
	private int hoursPerWeek;
	/** The comment for the course */
	private String comment;
	/** The date the rating was made */
	private long date;
	/** The course ID that the rating is linked too */
	private int electiveID;
	
	private int userID;

	/**
	 * Default Constructor
	 */
	public Rating(){
		
	}
	
	/**
	 * Getter for the individual course rating
	 * @return	rating
	 */
	public int getRating() {
		return rating;
	}
	
	/**
	 * Setter for the individual course rating
	 * @param rating
	 */
	public void setRating(int rating) {
		this.rating = rating;
	}
	
	/**
	 * Getter for the hours per week
	 * @return hours per week
	 */
	public int getHoursPerWeek() {
		return hoursPerWeek;
	}
	
	/**
	 * Setter for the hours per week
	 * @param hoursPerWeek
	 */
	public void setHoursPerWeek(int hoursPerWeek) {
		this.hoursPerWeek = hoursPerWeek;
	}
	
	/**
	 * Getter for the comment text
	 * @return the comment text
	 */
	public String getComment() {
		return comment;
	}
	
	/**
	 * Setter for the comment text
	 * @param comment
	 */
	public void setComment(String comment) {
		this.comment = comment;
	}
	
	/**
	 * Getter for the rating submission date
	 * @return submission date
	 */
	public long getDate() {
		return date;
	}
	
	/**
	 * Setter for the rating submission date
	 * @param date2
	 */
	public void setDate(long date) {
		this.date = date;
	}
	/**
	 * Getter for the rating elective id
	 * @return electiveID
	 */
	public int getElectiveID(){
		return electiveID;
	}
	/**
	 * Setter for the rating elective id
	 * @param n
	 */
	public void setElectiveID(int n){
		this.electiveID = n;
	}
	/**
	 * Getter for the rating user id
	 * @return userID
	 */
	public int getUserID(){
		return userID;
	}
	/**
	 * Setter for the rating user id
	 * @param userID
	 */
	public void setUserID(int userId){
		this.userID = userId;
	}
	

}
