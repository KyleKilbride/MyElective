package beans;

import java.util.Date;

public class Rating {
	
	private int rating;
	private int hoursPerWeek;
	private String comment;
	private Date date;
	private int electiveID;

	public Rating(){
		
	}
	
	public int getRating() {
		return rating;
	}
	
	public void setRating(int rating) {
		this.rating = rating;
	}
	
	public int getHoursPerWeek() {
		return hoursPerWeek;
	}
	
	public void setHoursPerWeek(int hoursPerWeek) {
		this.hoursPerWeek = hoursPerWeek;
	}
	
	public String getComment() {
		return comment;
	}
	
	public void setComment(String comment) {
		this.comment = comment;
	}
	
	public Date getDate() {
		return date;
	}
	
	public void setDate(Date date) {
		this.date = date;
	}
	
	
	public int getElectiveID() {
		return electiveID;
	}

	public void setElectiveID(int electiveID) {
		this.electiveID = electiveID;
	}
	
	
	

}
