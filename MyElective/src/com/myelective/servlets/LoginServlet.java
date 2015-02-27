package com.myelective.servlets;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;  
import javax.servlet.ServletException;  
import javax.servlet.http.HttpServlet;  
import javax.servlet.http.HttpServletRequest;  
import javax.servlet.http.HttpServletResponse;  
import javax.servlet.http.HttpSession; 

import com.myelective.controllers.UserController;

import beans.User;

/**
 * Gets login info from page and attempts to validate
 * with the database
 * 
 * @author Matthew Boyd, Kyle Kilbride
 * @version 0.2
 *
 */
public class LoginServlet extends HttpServlet {
	
	private static final long serialVersionUID = 12L;
	
	/**
	 * Gets user_name and user_pass from the page and validates it with
	 * the database. If the login info is valid, gets the username and
	 * redirects to index.jsp. If login info is invalid, redirects back
	 * to login page.
	 */
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		HttpSession session = request.getSession(false);
		
		UserController userDAO = new UserController();
		User user = new User();
		
		//Gets username and password from page
		String name = (String) request.getParameter("user_name");
		String pass = (String) request.getParameter("user_pass");
		
		//Validates username/password in database
		user = userDAO.validate(name, pass);
		

		if(user.getUsername() == null){ //if login is unsuccessful
            RequestDispatcher rd=request.getRequestDispatcher("SplashPage.jsp");    

            rd.include(request,response);
            response.sendRedirect("SplashPage.jsp");
		} else {
			session.setAttribute("user", user);
			response.sendRedirect("index.jsp");
		}
        
        out.close();
	}
}
