package com.elective.servlets;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;  
import javax.servlet.ServletException;  
import javax.servlet.http.HttpServlet;  
import javax.servlet.http.HttpServletRequest;  
import javax.servlet.http.HttpServletResponse;  
import javax.servlet.http.HttpSession; 

import com.myelective.doa.UserDAO;

public class LoginServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
	
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		HttpSession session = request.getSession(false);
		UserDAO userDAO = new UserDAO();
		
		String name = (String) request.getParameter("user_name");
		String pass = (String) request.getParameter("user_pass");
		
		String userName = userDAO.validate(name, pass);
		
		if(userName == null){
			out.print("<p style=\"color:red\">Sorry username or password error</p>");    
            RequestDispatcher rd=request.getRequestDispatcher("LoginSignup.jsp");    
            rd.include(request,response);
		} else {
			session.setAttribute("user", userName);
			response.sendRedirect("index.jsp");
		}
        
        out.close();
	}

}
