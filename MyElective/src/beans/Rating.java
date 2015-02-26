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
	
	/** The invidual rating for the course*/
	private int rating;
	/** The amount of hours for this course */
	private int hoursPerWeek;
	/** The comment for the course */
	private String comment;
	/** The date the rating was made */
	private Date date;
	/** The course ID that the rating is linked too */
	private int electiveID;

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
	 * Getter for the rating submittion date
	 * @return submittion date
	 */
	public Date getDate() {
		return date;
	}
	
	/**
	 * Setter for the rating submittion date
	 * @param date
	 */
	public void setDate(Date date) {
		this.date = date;
	}
	
	
	/**
	 * Getter for the Course ID the rating is for
	 * @return Course ID
	 */
	public int getElectiveID() {
		return electiveID;
	}

	/**
	 * Setter for the Course ID the rating is for
	 * @param electiveID
	 */
	public void setElectiveID(int electiveID) {
		this.electiveID = electiveID;
	}
}