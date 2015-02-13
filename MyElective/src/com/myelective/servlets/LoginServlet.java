package com.myelective.servlets;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;  
import javax.servlet.ServletException;  
import javax.servlet.http.HttpServlet;  
import javax.servlet.http.HttpServletRequest;  
import javax.servlet.http.HttpServletResponse;  
import javax.servlet.http.HttpSession; 

import com.myelective.doa.UserDAO;

/**
 * Gets login info from page and attempts to validate
 * with the database
 * 
 * @author Matthew Boyd, Kyle Kilbride
 * @version 0.1
 *
 */
public class LoginServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
	private boolean success = true;
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
		
		UserDAO userDAO = new UserDAO();
		
		//Gets username and password from page
		String name = (String) request.getParameter("user_name");
		String pass = (String) request.getParameter("user_pass");
		
		//Validates username/password in database
		String userName = userDAO.validate(name, pass);
		
		if(userName == null){ //if login is unsuccessful
			setSuccess(false);
            RequestDispatcher rd=request.getRequestDispatcher("SplashPage.jsp");
            rd.include(request,response);
            response.sendRedirect("SplashPage.jsp");
		} else {
			
			session.setAttribute("user", userName);
			response.sendRedirect("index.jsp");
		}
        
        out.close();
	}
	public boolean isSuccess() {
		return success;
	}
	public void setSuccess(boolean success) {
		this.success = success;
	}
	
	

}
