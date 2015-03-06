<%@page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.myelective.controllers.*, java.util.ArrayList, beans.*"%>
	<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	
<!DOCTYPE html>

<!-- PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd" -->

<%
	User loggedUser = (User)session.getAttribute("user");
	ElectiveController electiveController = new ElectiveController();
	RatingController ratingController = new RatingController();
	UserController userController = new UserController();

	int electiveID = Integer.parseInt(request.getParameter("ElectiveID"));

	Elective elective = ratingController.getElective(electiveID);
	
	if (loggedUser != null) {
		session.setAttribute("userName", loggedUser.getFirstName());
		session.setAttribute("userStatus", loggedUser.getStatus());
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
											var names = allElectives.split(",  ");
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
								  		${sessionScope.user.getFirstName()} <a href="logoutServlet" class="navbar-link" id="logoutText" >Logout</a>
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
			
			<!-- MAIN CONTENT -->
		    <section id="featuredElective" class="container content-section text-center">
		        <div class="row">
		            <div class="col-lg-8 col-lg-offset-2">
		      			<h1><%=elective.getName()%> - <%=elective.getCourseCode()%></h1>
						<p>Description: <%=elective.getDescription()%></p>
						<p>Rating: <%=elective.getRating()%></p>
						<%for(Rating rating: elective.getComments()){
							User user = ratingController.getUser(rating.getUserID());
							//out.print("<p><b>" + user.getUsername() + "</b>   " + rating.getDate().toString() + "</p>");
							out.print("<p><b>" + user.getUsername() + "</b>");
							out.print("<p>" + rating.getRating() + "    " + rating.getHoursPerWeek() + " hours per week </p>");
							out.print("<p>\"" + rating.getComment() + "\"</p>");
							out.print("<hr />");
						}%>
						<c:if test="${sessionScope.userName != null}">
							<form action="" method="POST" id="reviewForm">
								<textarea form="reviewForm" placeholder="Review" rows="5" cols="75"></textarea>
							</form>
						</c:if>
		      		</div>
		        </div>
		    </section>

		</div> <!-- /.container fluid -->
	</body>
	<script src="js/jquery-1.11.2.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
</html>