<%@page import="com.myelective.controllers.RatingController"%>
<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="com.myelective.controllers.*, java.util.ArrayList, beans.*"%>

<!DOCTYPE html>

<!-- PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd" -->
<!-- Authors: Kyle Usherwood, Kyle Kilbride -->
<%
	String s = request.getParameter("newsession");

	if (s != null) {
		try {

			response.setHeader("Cache-Control", "no-cache"); //Forces caches to obtain a new copy of the page from the origin server
			response.setHeader("Cache-Control", "no-store"); //Directs caches not to store the page under any circumstance
			response.setDateHeader("Expires", 0); //Causes the proxy cache to see the page as "stale"
			response.setHeader("Pragma", "no-cache"); //HTTP 1.0 backward compatibility
			session.setAttribute("userName", null);
			System.out.println("I got in here s!=null");
			//request.getSession().invalidate(); //session.invalidate(); //do not think this is necessary -- Kyle K
		} catch (Exception e) {
			System.out.println(e.getMessage());
			System.out.println(e);
		}
	} else {
		System.out.println("Here tooooooo");
		request.getSession(false);
		User user = (User) session.getAttribute("user");

		ElectiveController electiveController = new ElectiveController();
		RatingController ratingController = new RatingController();
		ArrayList ratingArrLst = ratingController.getRecentRating(4);
		
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
		<link rel="stylesheet" href="http://yui.yahooapis.com/pure/0.5.0/pure-min.css">
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>MyElective</title>
	</head>
	<body>
		<div id="mainDiv" data-electives="${sessionScope.allElectives}" class="container-fluid">
		<!-- navbar row -->
			<div class="row-fluid" id="navBarRow">
				<div class="col-md-6">
					<nav class="navbar navbar-inverse navbar-fixed-top">
						<div class="container-fluid">
							<div class="navbar-header"> <a class="navbar-brand" href="index.jsp"> MyElective </a>
								<button class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
									<span class="sr-only">Toggle navigation</span> 
									<span class="icon-bar"></span> <span class="icon-bar"></span> 
									<span class="icon-bar"></span>
								</button>
							</div>
							<div class="collapse navbar-collapse">
								<ul class="nav navbar-nav">
									<li><a href="AllElectives.jsp">All Electives</a></li>
								</ul>
								<form class="navbar-form navbar-right" role="search">
									<div class="form-group">
										<link rel="stylesheet" href="//code.jquery.com/ui/1.11.3/themes/smoothness/jquery-ui.css">t>
										
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
										<input type="text" class="form-control" placeholder="Search" id="search">
										<button type="submit" class="btn btn-default">Submit</button>
									</div>
								</form>
							<div id="loginSignupText">
								<p class="navbar-text navbar-right">
									<%
										if (session.getAttribute("userName") == null) {
											System.out.println("gets in if "+ session.getAttribute("userName"));
									%>
									<a href="SplashPage.jsp" class="navbar-link" id="loginText">Log In/Sign Up</a>
									<%
										} else if (session.getAttribute("userName") != null) {
											System.out.println("gets in else "
													+ session.getAttribute("userName"));
									%>
									${sessionScope.user.getFirstName()} <a
										href="index.jsp?newsession" class="navbar-link"
										id="logoutText">Logout</a>
									<%
										}
									%>
								</p>
							</div>
						</div>
					</div>
					<!-- /.container-fluid -->
				</nav>
			</div>
			<!-- /.col-md-12 -->
		</div>
		<!-- /.row-fluid -->
		<!-- featuredElectives row -->
		<div class="row" id="featuredElectivesRow">
			<div class="col-sm-12" id="featuredElectives">
				<h2 id="featuredElectivesHeader">Featured Elective
					${sessionScope.featuredElective.getName()}</h2>
				<div class="col-xs-12">
					<a class="btn btn-default" id="featuredViewButton" href="#">View</a>
				</div>
			</div>
		</div>
		<!-- /.row-fluid -->
		<div class="row-fluid" id="recentReviewsContainer">
			<!-- recentReviewsContainer-->
			<div class="row-fluid" id="recentReviewsRow1">
				<div class="row-fluid" id="recentReviewTitle">
					<h2>Recent Reviews</h2>
				</div>
				<div class="col-sm-6" id="recentReview1">recent review 1 :
					${sessionScope.recentRatingBean1.getComment() }</div>
				<div class="col-sm-6" id="recentReview2">recent review 2</div>
			</div>
			<div class="row-fluid" id="recentReviewsRow2">
				<!-- recentReviewsRow2 TODO this has to be not nested row-->
				<div class="col-sm-6" id="recentReview3">recent review 3</div>
				<div class="col-sm-6" id="recentReview4">recent review 4</div>
			</div>
			<!-- /.recentReviewsRow2 -->
		</div>
		<!-- /.recentReviewsRow -->
	</div>
	<!-- /.container fluid -->
</body>
<script src="js/jquery-1.11.2.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="//code.jquery.com/ui/1.11.3/jquery-ui.js"></script>
</html>
