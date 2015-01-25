package com.elective.servlets;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;  
import javax.servlet.ServletException;  
import javax.servlet.http.HttpServlet;  
import javax.servlet.http.HttpServletRequest;  
import javax.servlet.http.HttpServletResponse;  
import javax.servlet.http.HttpSession; 

import com.myelective.doa.LoginDao;

public class SignupServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
	
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		/**
		 * 	<input type="text" class="input" name="user_name_signup" autocomplete="off" placeholder="Username"></br>
							<input type="text" class="input" name="userFirstName" autocomplete="off" placeholder="First Name"></br>
							<input type="text" class="input" name="userLastName" autocomplete="off" placeholder="Last Name"></br>
							<input type="text" class="input" name="email_signup" autocomplete="off" placeholder="Email"></br>
							<input type="text" class="input" name="prog_signup" autocomplete="off" placeholder="Program of Study"></br>
							<input type="password" class="input" name="user_pass_signup" autocomplete="off" placeholder="Password"></br>
							<input type="submit" class="button" value="Sign up">
		 */
		String userName = (String) request.getParameter("user_name_signup");
		String pass = (String) request.getParameter("user_pass_signup");
		String firstName = (String) request.getParameter("userFirstName");
		String lastName = (String) request.getParameter("userLastName");
		String program = (String) request.getParameter("prog_signup");
		String email = (String) request.getParameter("email_signup");
		
		HttpSession session = request.getSession(false);  
        if(session!=null){  
//	        session.setAttribute("name", userName);
//	        session.setAttribute("password", pass);
//	        session.setAttribute("first", firstName);
//	        session.setAttribute("last", lastName);      not sure what this stuff does, explain?
//	        session.setAttribute("program", program);
//	        session.setAttribute("email", email);
        }
        
        //TODO validate the information in the sign up form. 
        if(LoginDao.validate(userName, pass)){
        	RequestDispatcher rd=request.getRequestDispatcher("index.jsp");    
            rd.forward(request,response);  
        }else{
//        	out.print("<p style=\"color:red\">Sorry username or password error</p>");    
            RequestDispatcher rd=request.getRequestDispatcher("LoginSignup.jsp");    
            rd.include(request,response);
        }
        
        out.close();
	}

}
