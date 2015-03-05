package com.myelective.servlets;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;  
import javax.servlet.http.HttpServlet;  
import javax.servlet.http.HttpServletRequest;  
import javax.servlet.http.HttpServletResponse;  
import javax.servlet.http.HttpSession; 

import beans.Elective;

import com.myelective.controllers.ElectiveController;
import com.myelective.controllers.RatingController;

public class SearchServlet extends HttpServlet{

	private static final long serialVersionUID = 1L;
	RatingController rc = new RatingController();
	ElectiveController ec = new ElectiveController();
	Elective elective;
	
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {	
		HttpSession session = request.getSession(false);
		
		String electiveName = (String) request.getParameter("search");

		if (electiveName.intern() != "") {
			try {
				elective = rc.getElectiveByString(request.getParameter("search"));
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}	
		session.setAttribute("searchElective", elective);
		response.sendRedirect("FullElective.jsp?ElectiveID="+elective.getId());
	}
		
}
