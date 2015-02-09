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
 * Gets account creation info from page and attempts to create
 * a new user in the database
 * 
 * @author Matthew Boyd
 * @version 0.1
 *
 */
public class SignupServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
	
	/**
	 * Gets new account information, checks that username and email do not
	 * exist in the database, and then attempts to create the user in the
	 * database
	 * 
	 */
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		
		//Gets Account Information from page
		String userName = (String) request.getParameter("user_name_signup");
		String pass = (String) request.getParameter("user_pass_signup");
		String firstName = (String) request.getParameter("userFirstName");
		String lastName = (String) request.getParameter("userLastName");
		String program = (String) request.getParameter("prog_signup");
		String email = (String) request.getParameter("email_signup");
		
		UserDAO userDAO = new UserDAO();
		
		boolean usernameInUse = userDAO.checkEmailNotUsed(email); //checks if email exists in database
		boolean emailInUse = userDAO.checkUsername(userName); //checks if username exists in database
		
		if(usernameInUse == false && emailInUse == false){	//If username and email do not exist in database
			// Attempts to create new user in database, returns 1 if successful
			int result = userDAO.createUser(userName, pass, firstName, lastName, email, program, "user");
			if(result == 1){ // if account is created successfully
				HttpSession session = request.getSession(false);
				session.setAttribute("userName", userName);
				response.sendRedirect("index.jsp"); //send user to Account Creation Success
			}else{ // if account is not created successfully
				out.print("<p style=\"color:red\">Sorry, Error while creating account");    
				RequestDispatcher rd=request.getRequestDispatcher("SplashPage.jsp"); //send user back to Account Creation page 
				rd.include(request,response);
			}
		}else{
		
			if(userDAO.checkEmailNotUsed(email)){ //If email is used
				out.print("<p style=\"color:red\">Sorry, Email already is use.</p>");    
				RequestDispatcher rd=request.getRequestDispatcher("SplashPage.jsp");    
				rd.include(request,response);
			}else if(userDAO.checkUsername(userName)){ //If username is used
				out.print("<p style=\"color:red\">Sorry, username already is use.</p>");    
				RequestDispatcher rd=request.getRequestDispatcher("SplashPage.jsp"); //send user back to Account Creation page 
				rd.include(request,response);
			}
		
		}

		
		out.close();
	}

}
