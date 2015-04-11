package com.myelective.servlets;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;  
import javax.servlet.http.HttpServlet;  
import javax.servlet.http.HttpServletRequest;  
import javax.servlet.http.HttpServletResponse;  
import javax.servlet.http.HttpSession; 

import com.myelective.controllers.ElectiveController;
import com.myelective.controllers.RatingController;

/**
 * Handles requests to Create, Update and Remove
 * electives from the database.
 * 
 * @version 1.0
 *
 */

public class AdminServlet extends HttpServlet{

	private static final long serialVersionUID = 1L;
	RatingController rc = new RatingController();
	ElectiveController ec = new ElectiveController();
	
	
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		if (request.getParameter("editElective") != null) {
			session.setAttribute("adminAction", "editElective");
		}
		else if (request.getParameter("removeElective") != null) {
			session.setAttribute("adminAction", "removeElective");
		}
		else if (request.getParameter("addElective") != null) {
			session.setAttribute("adminAction", "addElective");
		}
		else if (request.getParameter("editElectiveNewName") != null){
			try {
				rc.editElectiveName(request.getParameter("editElectiveNewName"), request.getParameter("editElectiveCurrentName"));
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		else if (request.getParameter("editElectiveNewCode") != null){
			try {
				rc.editElectiveCourseCode(request.getParameter("editElectiveNewCode"), request.getParameter("editElectiveCurrentCode"));
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		else if (request.getParameter("editElectiveNewDesc") != null){
			try {
				rc.editElectiveDescription(request.getParameter("editElectiveNewDesc"), request.getParameter("editElectiveCurrentDesc"));
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		else if (request.getParameter("removeElectiveConfirm")!=null){
			if(request.getParameter("removeElectiveConfirm").equals("CONFIRM")){
				try {
					rc.removeElective(request.getParameter("removeElectiveName"));
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}		
		} 				
		else if (request.getParameter("addElectiveName") != null && request.getParameter("addElectiveCode") != null && request.getParameter("addElectiveDesc") != null) {
			try {
				rc.addElective(request.getParameter("addElectiveName"),request.getParameter("addElectiveCode"),request.getParameter("addElectiveDesc"));
			} catch (SQLException e) {
				e.printStackTrace();
			}				
		} 
		
		response.sendRedirect("Admin.jsp");
	}
}
