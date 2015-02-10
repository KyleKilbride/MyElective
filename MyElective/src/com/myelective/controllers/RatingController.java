package com.myelective.controllers;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import beans.Elective;
import beans.Rating;

import com.myelective.jbdc.DBUtility;

public class RatingController {
	
	Connection dbConnection;

	public RatingController(){
		dbConnection = DBUtility.getConnection();
	}
	
	public ArrayList<Rating> getRecentRating(int numberOf){
		ArrayList<Rating> ratingBeanAL = new ArrayList<Rating>();
		
		try{
			PreparedStatement pSt1 = dbConnection.prepareStatement("SELECT * FROM ratings ORDER BY id DESC LIMIT ?");
			pSt1.setInt(1, numberOf);
			ResultSet result1 = pSt1.executeQuery();
			if(result1.last()){
				int returnedRowNum = result1.getRow();
				for(int i = 0; i < returnedRowNum; i++){
					Rating ratingBean = new Rating();
					ratingBean.setRating(result1.getInt("rating"));
					ratingBean.setHoursPerWeek(result1.getInt("hours_per_week"));
					ratingBean.setComment(result1.getString("comment"));
					ratingBean.setElectiveID(result1.getInt("electives_id"));
					ratingBeanAL.add(ratingBean); //LOGIC NEEDS A BIT MORE WORK
					result1.previous();
				}
			}
		}catch(Exception e){
			System.out.println(e);
		}
		
		return ratingBeanAL;
	}
}
