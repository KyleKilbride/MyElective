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

public class LoginServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
	
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		
		String name = (String) request.getParameter("user_name");
		String pass = (String) request.getParameter("user_pass");
		
		System.out.print(name);
		System.out.print(pass);
		
		HttpSession session = request.getSession(false);  
        if(session!=null)  
        session.setAttribute("name", name);
        
        if(LoginDao.validate(name, pass)){
        	RequestDispatcher rd=request.getRequestDispatcher("index.jsp");    
            rd.forward(request,response);  
        }else{
        	out.print("<p style=\"color:red\">Sorry username or password error</p>");    
            RequestDispatcher rd=request.getRequestDispatcher("LoginSignup.jsp");    
            rd.include(request,response);
        }
        
        out.close();
	}

}
