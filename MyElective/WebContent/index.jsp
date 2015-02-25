<%@page import="com.myelective.controllers.RatingController"%>
<%@page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.myelective.controllers.*, java.util.ArrayList, beans.*"%>

<!DOCTYPE html>

<!-- PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd" -->
<%
	request.getSession(false);
	User user = (User)session.getAttribute("user");
	
	ElectiveController electiveController = new ElectiveController();
	RatingController ratingController = new RatingController();
	
	ArrayList ratingArrLst = ratingController.getRecentRating(4);
	
	session.setAttribute("featuredElective", electiveController.getFeaturedElective());
	
	session.setAttribute("recentRatingBean1", (Rating)ratingArrLst.get(0));
	session.setAttribute("recentRatingBean2", (Rating)ratingArrLst.get(1));
	session.setAttribute("recentRatingBean3", (Rating)ratingArrLst.get(2));
	session.setAttribute("recentRatingBean4", (Rating)ratingArrLst.get(3));
	
	String s = request.getParameter("newsession");

	if(s != null){
		try
	    {	
			
	        response.setHeader("Cache-Control","no-cache"); //Forces caches to obtain a new copy of the page from the origin server
	        response.setHeader("Cache-Control","no-store"); //Directs caches not to store the page under any circumstance
	        response.setDateHeader("Expires", 0); //Causes the proxy cache to see the page as "stale"
	        response.setHeader("Pragma","no-cache"); //HTTP 1.0 backward compatibility
	        session.removeAttribute("userName");
	        System.out.println("I got in here s!=null");
	        //session.invalidate();request.getSession().invalidate(); //do not think this is necessary -- Kyle K
	    }
	    catch(Exception e)
	    {
	        System.out.println(e.getMessage());
	        System.out.println(e);
	    }
	}else{
		System.out.println("Here tooooooo");
		request.getSession(false);
		
		session.setAttribute("allElectives",
				electiveController.getElectiveNames());

		session.setAttribute("featuredElective",
				electiveController.getFeaturedElective());

		session.setAttribute("recentRatingBean1",
				(Rating) ratingArrLst.get(1));

		if (user != null) {
			session.setAttribute("userName", user.getFirstName());
		}
	}
%>
<html>
	<head>
		<link href="css/bootstrap.min.css" rel="stylesheet" type="text/css">
		<link href="css/index.css" rel="stylesheet" type="text/css">
		
		<link rel="stylesheet" href="//code.jquery.com/ui/1.11.3/themes/smoothness/jquery-ui.css">
        <link rel="stylesheet" href="http://yui.yahooapis.com/pure/0.5.0/pure-min.css">
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>MyElective</title>
	</head>
	<body>
		<div class="container-fluid">
			<!-- navbar row -->
			<div class="row-fluid" id="navBarRow">
				<div class="col-md-6">
					<!-- NAVBAR -->
					<nav class="navbar navbar-inverse navbar-fixed-top">
					  <div class="container-fluid">
					    <div class="navbar-header">
					      <a class="navbar-brand" href="#">
					        MyElective
					      </a>
					      <button class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
					        <span class="sr-only">Toggle navigation</span>
					        <span class="icon-bar"></span>
					        <span class="icon-bar"></span>
					        <span class="icon-bar"></span>
					      </button>
					    </div>
					    <div class="collapse navbar-collapse">
						    <ul class="nav navbar-nav">
						    	<li><a href="AllElectives.jsp">All Electives</a></li>
						    </ul>
						    <form class="navbar-form navbar-right" role="search">
							  <div class="form-group">
								  <script type="text/javascript">
										$(function() {
											var electives = document.getElementById("mainDiv"), allElectives;
											allElectives = mainDiv.getAttribute("data-electives");
											allElectives = allElectives.substring(1);
											allElectives = allElectives.substring(0,allElectives.length - 4);
											var names = allElectives.split(", ~, ");
											$("#search").autocomplete({source : names});
										});
								</script>
							    <input type="text" class="form-control" placeholder="Search">
							    <button type="submit" class="btn btn-default">Submit</button>							    
							  </div>
							</form>
						    <div id="loginSignupText">
							    <p class="navbar-text navbar-right">
							    	<%if(session.getAttribute("userName") == null){
							    		System.out.println("gets in if "+ session.getAttribute("userName"));%>
								  		<a href="SplashPage.jsp" class="navbar-link" id="loginText">Log In/Sign Up</a>
								  	<%}else if(session.getAttribute("userName") != null){ 
								  		System.out.println("gets in else " + session.getAttribute("userName"));%>
								  		${sessionScope.user.getFirstName()} <a href="index.jsp?newsession" class="navbar-link" id="logoutText" >Logout</a>
								  	<%}%>
								</p>
							</div>
						</div>
					  </div><!-- /.container-fluid -->
					</nav>
					
				</div><!-- /.col-md-12 -->
			</div><!-- /.row-fluid -->
		
			<!-- CONTENT HEADER -->
			<!-- featuredElectives row -->
			<header class="intro-header" id="featuredElectivesRow">
				<div class="container-fluid">
					<div class="row">
						<div class="col-lg-8 col-lg-offset-2 col-md-10 col-md-offset-1" id="featuredElectives">
							<div class="site-heading">
								<h2 id="featuredElectivesHeader">Featured Elective</h2>
								<h3 id="featuredElectiveTitle">${sessionScope.featuredElective.getName()} -- ${sessionScope.featuredElective.getCourseCode()}</h3>
								<p id="featuredElectiveDescription">${sessionScope.featuredElective.getDescription()}</p>
								<div class="col-xs-12">
			                    	<a class="btn btn-default" id="featuredViewButton" href="#">View</a>
								</div>
							</div>
						</div>
					</div><!-- /.row-fluid -->
				</div>
			</header>
			
			<!-- MAIN CONTENT -->
			<div class="container">
	        	<div class="row">
	           	    <div class="col-lg-8 col-lg-offset-2 col-md-10 col-md-offset-1">
						<h2>Recent Reviews</h2>
	           	    	<div class="post-preview">
	           	    	<a href="#">
	           	    		<h2 class="post-title">Elective id: ${sessionScope.recentRatingBean1.getElectiveID()}</h2>
							<p>Review: ${sessionScope.recentRatingBean1.getComment()}</p>
							<p>Rating out of 10: ${sessionScope.recentRatingBean1.getRating()}</p>
						</a>
	           	    	</div>
	           	    	<hr/>
	           	    	<div class="post-preview">
	           	    	<a href="#">
	           	    		<h2 class="post-title">Elective id: ${sessionScope.recentRatingBean2.getElectiveID()}</h2>
							<p>Review: ${sessionScope.recentRatingBean2.getComment()}</p>
							<p>Rating out of 10: ${sessionScope.recentRatingBean2.getRating()}</p>
						</a>
	           	    	</div>
	           	    	<hr/>
	           	    	<div class="post-preview">
	           	    	<a href="#">
	           	    		<h2 class="post-title">Elective id: ${sessionScope.recentRatingBean3.getElectiveID()}</h2>
							<p>Review: ${sessionScope.recentRatingBean3.getComment()}</p>
							<p>Rating out of 10: ${sessionScope.recentRatingBean3.getRating()}</p>
						</a>
	           	    	</div>
	           	    	<hr/>
	           	    	<div class="post-preview">
	           	    	<a href="#">
	           	    		<h2 class="post-title">Elective id: ${sessionScope.recentRatingBean4.getElectiveID()}</h2>
							<p>Review: ${sessionScope.recentRatingBean4.getComment()}</p>
							<p>Rating out of 10: ${sessionScope.recentRatingBean4.getRating()}</p>
						</a>
	           	    	</div>
	           	    </div>
           	    </div>
          	</div>
<%-- 			<div class="row-fluid" id="recentReviewsContainer"><!-- recentReviewsContainer-->
				<div class="row-fluid" id="recentReviewsRow1">
					<div class="row-fluid" id="recentReviewTitle">
						<h2>Recent Reviews</h2>
					</div>
					<div class="col-sm-6" id="recentReview1">
						<h2>Elective id: ${sessionScope.recentRatingBean1.getElectiveID()}</h2>
						<p>Review: ${sessionScope.recentRatingBean1.getComment()}</p>
						<p>Rating out of 10: ${sessionScope.recentRatingBean1.getRating()}</p>
					</div>
					<div class="col-sm-6" id="recentReview2">
						<h2>Elective id: ${sessionScope.recentRatingBean2.getElectiveID()}</h2>
						<p>Review: ${sessionScope.recentRatingBean2.getComment()}</p>
						<p>Rating out of 10: ${sessionScope.recentRatingBean2.getRating()}</p>
					</div>
				</div>
				<div class="row-fluid" id="recentReviewsRow2">
					<div class="col-sm-6" id="recentReview3">
						<h2>Elective id: ${sessionScope.recentRatingBean3.getElectiveID()}</h2>
						<p>Review: ${sessionScope.recentRatingBean3.getComment()}</p>
						<p>Rating out of 10: ${sessionScope.recentRatingBean3.getRating()}</p>
					</div>
					<div class="col-sm-6" id="recentReview4">
						<h2>Elective id: ${sessionScope.recentRatingBean4.getElectiveID()}</h2>
						<p>Review: ${sessionScope.recentRatingBean4.getComment()}</p>
						<p>Rating out of 10: ${sessionScope.recentRatingBean4.getRating()}</p>
					</div>
				</div><!-- /.recentReviewsRow2 -->
			</div><!-- /.recentReviewsRow --> --%>
			
			
		</div> <!-- /.container fluid -->
	</body>
	<script src="js/jquery-1.11.2.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
</html>
