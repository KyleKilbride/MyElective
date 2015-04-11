package com.myelective.servlets;

import java.io.IOException;

import javax.servlet.ServletException;  
import javax.servlet.http.HttpServlet;  
import javax.servlet.http.HttpServletRequest;  
import javax.servlet.http.HttpServletResponse;  
import javax.servlet.http.HttpSession; 

/**
 * Switches session language variable and directs the user back to the page
 * 
 * @version 1.0
 *
 */

public class LanguageServlet extends HttpServlet{
	
	private static final long serialVersionUID = 1L;	
	
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		response.setContentType("text/html");
		HttpSession session = request.getSession(false);
		
		if(session.getAttribute("language") == "french"){
			session.setAttribute("language", "english");
		}else{
			session.setAttribute("language", "french");
		}
        
		response.sendRedirect(request.getHeader("referer"));
		
	}
}