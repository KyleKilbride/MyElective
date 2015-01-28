package com.elective.servlets;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;  
import javax.servlet.ServletException;  
import javax.servlet.http.HttpServlet;  
import javax.servlet.http.HttpServletRequest;  
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.catalina.Session;

import com.myelective.doa.UserDAO;

public class SignupServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
	
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.print("gets here");
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		
		String userName = (String) request.getParameter("user_name_signup");
		String pass = (String) request.getParameter("user_pass_signup");
		String firstName = (String) request.getParameter("userFirstName");
		String lastName = (String) request.getParameter("userLastName");
		String program = (String) request.getParameter("prog_signup");
		String email = (String) request.getParameter("email_signup");
		
		System.out.println(userName);
		System.out.println(pass);
		System.out.println(firstName);
		System.out.println(lastName);
		System.out.println(lastName);
		System.out.println(email);
		
		
		UserDAO userDAO = new UserDAO();
		
		boolean usernameInUse = userDAO.checkEmailNotUsed(email);
		boolean emailInUse = userDAO.checkUsername(userName);
		
		if(usernameInUse == false && emailInUse == false){
			int result = userDAO.createUser(userName, pass, firstName, lastName, email, program, "user");
			if(result == 1){
				HttpSession session = request.getSession(false);
				session.setAttribute("userName", userName);
				System.out.print("gets here");
				response.sendRedirect("index.jsp"); //send user to Account Creation Success
			}
		}else{
		
			if(userDAO.checkEmailNotUsed(email)){
				//If email is used
				out.print("<p style=\"color:red\">Sorry, Email already is use.</p>");    
				RequestDispatcher rd=request.getRequestDispatcher("SplashPage.jsp");    
				rd.include(request,response);
				System.out.print("WRONG");
			}else if(userDAO.checkUsername(userName)){
				//If username is used
				out.print("<p style=\"color:red\">Sorry, username already is use.</p>");    
				RequestDispatcher rd=request.getRequestDispatcher("SplashPage.jsp");    
				rd.include(request,response);
				System.out.print("WRONG");
			}
		
		}

		
		out.close();
	}

}
