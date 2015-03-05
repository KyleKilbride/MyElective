package beans;

import java.util.ArrayList;

/**
* A class for Elective objects. Contains setters and getters for all fields
*
* @author Matthew Boyd
* @version 0.2
*/
public class Elective {
	/** The id for the class */
	private int id;
	/** The course code for the class */
	private String courseCode;
	/** The name for the class */
	private String name;
	/** The description for the class */
	private String description;
	/** The overall rating for the class */
	private int rating;
	/** A collection for all Comment objects for the class */
	private ArrayList<Rating> comments;
	
	/**
	 *  Default constructor
	 */
	public Elective(){
		
	}
	
	/** 
	 * Getter for the course code
	 * @return	the course code
	 */
	public String getCourseCode() {
		return courseCode;
	}

	/**
	 * Setter for the course code
	 * @param courseCode
	 */
	public void setCourseCode(String courseCode) {
		this.courseCode = courseCode;
	}

	/** 
	 * Getter for the list of course comments
	 * @return	the List of comments
	 */
	public ArrayList<Rating> getComments() {
		return comments;
	}

	/**
	 * Setter for the course code
	 * @param courseCode
	 */
	public void setComments(ArrayList<Rating> comments) {
		this.comments = comments;
	}

	/** 
	 * Getter for the course name
	 * @return	the course name
	 */
	public String getName() {
		return name;
	}

	/**
	 * Setter for the course name
	 * @param courseCode
	 */
	public void setName(String name) {
		this.name = name;
	}

	/** 
	 * Getter for the course description
	 * @return	the course description
	 */
	public String getDescription() {
		return description;
	}

	/**
	 * Setter for the course description
	 * @param courseCode
	 */
	public void setDescription(String description) {
		this.description = description;
	}
	
	/** 
	 * Getter for the course rating
	 * @return	the course rating
	 */
	public int getRating() {
		return rating;
	}

	/**
	 * Setter for the course rating
	 * @param courseCode
	 */
	public void setRating(int rating) {
		this.rating = rating;
	}
	
	/**
	 * @return the id
	 */
	public int getId() {
		return id;
	}


	/**
	 * @param id the id to set
	 */
	public void setId(int id) {
		this.id = id;
	}

}
