package com.myelective.servlets;

import java.io.IOException;
import java.sql.SQLException;
import java.text.ParseException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import beans.Rating;
import beans.User;

import com.myelective.controllers.RatingController;

/**
 * Gets the elective comment and rating from the page,
 * and adds the information to the database and redirects the user
 * back to the elective page.
 * 
 * @version 1.0
 */
@WebServlet("/CommentServlet")
public class CommentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private RatingController ratingController;
    private Rating rating;
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CommentServlet() {
        super();
        
        ratingController = new RatingController();
        rating = new Rating();
        
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 * 
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		
		try {		
			/**
			 * create rating from form in fullElective.jsp and add it to the list of ratings 
			 */
			User user = (User)session.getAttribute("user");
			rating.setDate(System.currentTimeMillis()/1000);
			rating.setElectiveID(Integer.parseInt(session.getAttribute("ElectiveID").toString()));
			rating.setHoursPerWeek(Integer.parseInt(request.getParameter("hoursAWeek").toString()));
			rating.setComment(request.getParameter("reviewText").toString());
			rating.setRating(Integer.parseInt(request.getParameter("reviewRating").toString()));	
			rating.setUserID(user.getUserID());
			ratingController.addRating(rating);
		} catch (NumberFormatException | SQLException | ParseException e) {
			e.printStackTrace();
		}
		
		response.sendRedirect("FullElective.jsp?ElectiveID=" + session.getAttribute("ElectiveID"));
	}

}
