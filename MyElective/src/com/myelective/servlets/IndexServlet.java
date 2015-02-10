package com.myelective.servlets;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.myelective.doa.ElectiveDAO;

public class IndexServlet extends HttpServlet {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		ElectiveDAO electiveDao = new ElectiveDAO();
		
		session.setAttribute("featuredElective", electiveDao.getFeaturedElective());
		
		session.setAttribute("recentElective", electiveDao.getRecentElectives(4)); //methods argument is max number of electives returned
		
		response.sendRedirect("index.jsp");
	}

}
