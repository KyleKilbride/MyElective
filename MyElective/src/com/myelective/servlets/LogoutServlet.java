package com.myelective.servlets;

import java.io.IOException; 
  


import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;  
import javax.servlet.http.HttpServlet;  
import javax.servlet.http.HttpServletRequest;  
import javax.servlet.http.HttpServletResponse;  
import javax.servlet.http.HttpSession;  

public class LogoutServlet extends HttpServlet {  
	
	private static final long serialVersionUID = 1L;
	
        protected void doGet(HttpServletRequest request, HttpServletResponse response)  
                                throws ServletException, IOException {  
            response.setContentType("text/html");
            
            HttpSession session=request.getSession();  
            String ref = (String) session.getAttribute("viewid");
            session.invalidate();  
              
            RequestDispatcher rd=request.getRequestDispatcher(ref); //send user back to Account Creation page 
			rd.include(request,response);
    }  
} 