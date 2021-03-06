package com.myelective.servlets;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;  
import javax.servlet.ServletException;  
import javax.servlet.http.HttpServlet;  
import javax.servlet.http.HttpServletRequest;  
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import beans.User;

import com.myelective.controllers.UserController;
import com.myelective.jbdc.Security;

/**
 * Gets account creation info from page and attempts to create
 * a new user in the database
 * 
 * @version 1.0
 *
 */
public class SignupServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
	
	/**
	 * Gets new account information, checks that username and email do not
	 * exist in the database, and then attempts to create the user in the
	 * database
	 */
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		HttpSession session = request.getSession(false);
		
		//Gets Account Information from page
		String userName = (String) request.getParameter("user_name_signup");
		String pass = Security.encrypt((String) request.getParameter("user_pass_signup"));
		String firstName = (String) request.getParameter("userFirstName");
		String lastName = (String) request.getParameter("userLastName");
		String program = (String) request.getParameter("prog_signup");
		String email = (String) request.getParameter("email_signup");
		
		UserController userDAO = new UserController();
		
		User user = new User();
		
		boolean usernameInUse = userDAO.checkEmailNotUsed(email); //checks if email exists in database
		boolean emailInUse = userDAO.checkUsername(userName); //checks if username exists in database
		
		if(usernameInUse == false && emailInUse == false){	//If username and email do not exist in database
			// Attempts to create new user in database, returns 1 if successful
			int result = userDAO.createUser(userName, pass, firstName, lastName, email, program, "user");
			if(result == 1){ // if account is created successfully
				
				//Gets username and password from page
				String name = (String) request.getParameter("user_name_signup");
				String password = Security.encrypt((String) request.getParameter("user_pass_signup"));
				
				//Validates username/password in database
				user = userDAO.validate(name, password);
				
			
			}else{ // if account is not created successfully   
				RequestDispatcher rd=request.getRequestDispatcher("SplashPage.jsp"); //send user back to Account Creation page 
				rd.include(request,response);
			}
		}else{
		
			if(userDAO.checkEmailNotUsed(email)){ //If email is used
				if(session.getAttribute("language") == "french"){
					session.setAttribute("error", "Email d�j� utilis�e");
				}else{
					session.setAttribute("error", "Email already in use."); 
				}
				   
				RequestDispatcher rd=request.getRequestDispatcher("SplashPage.jsp");    
				rd.include(request,response);
			}else if(userDAO.checkUsername(userName)){ //If username is used
				if(session.getAttribute("language") == "french"){
					session.setAttribute("error", "Nom d'Utilisateur d�j� utilis�e");
				}else{
					session.setAttribute("error", "Username already in use."); 
				}
				   
				RequestDispatcher rd=request.getRequestDispatcher("SplashPage.jsp"); //send user back to Account Creation page 
				rd.include(request,response);
			}
		
		}
		session.setAttribute("user", user);
		response.sendRedirect("index.jsp"); //send user to Account Creation Success
		
		out.close();
	}

}
