<%@page import="com.myelective.controllers.RatingController"%>
<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="com.myelective.controllers.*, java.util.ArrayList, beans.*"%>

<!DOCTYPE html>

<!-- PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd" -->
<!-- Authors: Kyle Usherwood, Kyle Kilbride -->
<%

	request.getSession(false);
	//User user = (User) session.getAttribute("user");

	ElectiveController electiveController = new ElectiveController();
	RatingController ratingController = new RatingController();
	ArrayList ratingArrLst = ratingController.getRecentRating(4);
	ArrayList<String> electiveNames = electiveController.getElectiveNames();

	session.setAttribute("allElectives", electiveController.getElectiveNames());
	session.setAttribute("featuredElective", electiveController.getFeaturedElective());
	session.setAttribute("recentRatingBean1", (Rating) ratingArrLst.get(1));

//	if (user != null) {
//		session.setAttribute("userName", user.getFirstName());
//	}
%>
<html>
	<head>
		<link href="css/bootstrap.min.css" rel="stylesheet" type="text/css">
		<link href="css/grayscale.css" rel="stylesheet" type="text/css">
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
					<nav class="navbar navbar-inverse navbar-fixed-top">
					  <div class="container-fluid">
					    <div class="navbar-header">
					      <a class="navbar-brand" href="index.jsp">
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
								<%if(session.getAttribute("userStatus")!= null && session.getAttribute("userStatus").equals("admin")){%>
						    		<ul class="nav navbar-nav">
						    			<li><a href="AllElectives.jsp">All Electives</a></li>
						    			<li><a href="Admin.jsp">Admin</a></li>
						    		</ul>
						   		<%}
						   		else{%>
						   			<ul class="nav navbar-nav">
						   				<li><a href="AllElectives.jsp">All Electives</a></li>
						    		</ul>
						    	<%}%>
						    <form class="navbar-form navbar-right" role="search">
							  <div class="form-group">
							  		<script src="//code.jquery.com/jquery-1.10.2.js"></script>
									<script src="//code.jquery.com/ui/1.11.3/jquery-ui.js"></script>
								 	<script type="text/javascript" id="searchScript" data-electives="${sessionScope.allElectives}">
										$(function() {
											allElectives = searchScript.getAttribute("data-electives");
											allElectives = allElectives.substring(1);
											allElectives = allElectives.substring(0,allElectives.length - 4);
											var names = allElectives.split(", ");
											$("#search").autocomplete({source : names});
										});
								</script>
							    <input type="text" class="form-control" placeholder="Search" id="search">
							    <button type="submit" class="btn btn-default">Submit</button>							    
							  </div>
							</form>
						    <div id="loginSignupText">
							    <!-- <p class="navbar-text navbar-right"> -->
							    <ul class="nav navbar-nav navbar-right">
							    	<%if(session.getAttribute("userName") == null){
							    		System.out.println("gets in if "+ session.getAttribute("userName"));%>
								  		<li><a href="SplashPage.jsp" class="navbar-link" id="loginText">Log In/Sign Up</a></li>
								  	<%}else if(session.getAttribute("userName") != null){ 
								  		System.out.println("gets in else " + session.getAttribute("userName"));%>
								  		<li><a href="logoutServlet" class="navbar-link" id="logoutText" >${sessionScope.user.getFirstName()} Logout</a></li>
								  	<%}%>
								</ul>  	
								<!-- </p> -->
							</div>
						</div>
					  </div><!-- /.container-fluid -->
					</nav>
				</div>
			<!-- /.col-md-12 -->
			</div>
			<!-- /.row-fluid -->
			
		    <section class="container content-section text-center" id="allElectives">
		        <div class="row">
		            <div class="col-lg-8 col-lg-offset-2">
		                <h2 id="allElectivesHeader">All Electives</h2>
						 <%
						 char startingLetter = ' ';
						 for(String elective_name:electiveNames){
							 if(elective_name.charAt(0) != startingLetter){
								 startingLetter = elective_name.charAt(0);
								 out.print("<h2>"+ startingLetter +"</h2>");
							 }
							 
							 elective_name.replace(" ", "_");
							 out.print("<a href='searchServlet?param1="+ elective_name +"'>"+ elective_name +"</a><br/>");
						 }
						 %>
		            </div>
		        </div>
		    </section>
		</div>
	<!-- /.container fluid -->
	</body>
	<script src="js/bootstrap.min.js"></script>
</html>
