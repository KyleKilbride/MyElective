package com.myelective.doa;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Random;

import beans.Elective;

import com.myelective.jbdc.DBUtility;

public class ElectiveDAO {

	private Connection dbConnection;
	
	public ElectiveDAO(){
		dbConnection = DBUtility.getConnection();
	}
	
	public Elective getFeaturedElective(){
		int a = 0;
		int b = 0;
		int randomID;
		Elective electiveBean = new Elective();
		Random random = new Random();
		try{
			PreparedStatement pSt1 = dbConnection.prepareStatement("SELECT id FROM electives");
			PreparedStatement pSt2 = dbConnection.prepareStatement("SELECT * FROM electives WHERE id=?");
			ResultSet result1 = pSt1.executeQuery();
			if(result1.first()){
				a = Integer.parseInt(result1.getString("id"));
			}
			if(result1.last()){
				b = Integer.parseInt(result1.getString("id"));
			}
			
			if(a != 0 && b != 0){
				randomID = random.nextInt(b - a) + a;
				pSt2.setString(1, Integer.toString(randomID));
				ResultSet result2 = pSt2.executeQuery();
				if(result2.next()){
					electiveBean.setCourseCode(result2.getString("course_code"));
					electiveBean.setName(result2.getString("elective_name"));
					electiveBean.setDescription(result2.getString("description"));
					//electiveBean.setRating(Integer.parseInt(result2.getString("rating")));
				}
			}
			
		}catch (Exception e) {  
            System.out.println(e);  
        }

		return electiveBean;
	}
	
	public ArrayList<Elective> getRecentElectives(int numberOf){
		ArrayList<Elective> electiveBeanAL = new ArrayList<Elective>();
		
		try{
			PreparedStatement pSt1 = dbConnection.prepareStatement("SELECT * FROM electives");
			ResultSet result1 = pSt1.executeQuery();
			if(result1.last()){
				for(int i = 0; i < numberOf; i++){
					Elective electiveBean = new Elective();
					electiveBean.setCourseCode(result1.getString("course_code"));
					electiveBean.setName(result1.getString("elective_name"));
					electiveBean.setDescription(result1.getString("description"));
					//electiveBean.setRating(Integer.parseInt(result1.getString("rating")));
					electiveBeanAL.add(electiveBean); //LOGIC NEEDS A BIT MORE WORK
				}
			}
		}catch(Exception e){
			System.out.println(e);
		}
		
		return null;
	}
}
