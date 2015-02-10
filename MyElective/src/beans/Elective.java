package beans;

import java.util.ArrayList;

public class Elective {
	
	private String courseCode;
	private String name;
	private String description;
	private int rating;
	private ArrayList<Rating> comments;
	
	public Elective(){
		
	}
	
	public String getCourseCode() {
		return courseCode;
	}

	public void setCourseCode(String courseCode) {
		this.courseCode = courseCode;
	}

	
	public ArrayList<Rating> getComments() {
		return comments;
	}

	public void setComments(ArrayList<Rating> comments) {
		this.comments = comments;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}
	
	public int getRating() {
		return rating;
	}

	public void setRating(int rating) {
		this.rating = rating;
	}

}
