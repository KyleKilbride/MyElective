<%@page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.myelective.controllers.*, java.util.ArrayList, beans.*"%>

<!DOCTYPE html>

<!-- PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd" -->

<%
	request.getSession(false);
	ElectiveController electiveController = new ElectiveController();
	RatingController ratingController = new RatingController();
	UserController userController = new UserController();
	session.setAttribute("allElectives",electiveController.getElectiveNames());
	
	if(session.getAttribute("searchElective") != null){
		Elective elective = (Elective) session.getAttribute("searchElective");
		int electiveID = elective.getId();
	}

		int electiveID = Integer.parseInt(request.getParameter("ElectiveID"));
		Elective elective = ratingController.getElective(electiveID);	
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
						    <form class="navbar-form navbar-right" role="search" action="searchServlet" method="post">
							  <div class="form-group">
							  		<script src="//code.jquery.com/jquery-1.10.2.js"></script>
									<script src="//code.jquery.com/ui/1.11.3/jquery-ui.js"></script>
								  	<script type="text/javascript" id="searchScript" data-electives="${sessionScope.allElectives}">
										$(function() {
											var electives = document.getElementById("mainDiv"), allElectives;
											allElectives = mainDiv.getAttribute("data-electives");
											allElectives = allElectives.substring(1);
											allElectives = allElectives.substring(0,allElectives.length - 1);
											var names = allElectives.split(",  ");
											$("#search").autocomplete({source : names});
										});
								</script>
							    <input type="text" class="form-control" placeholder="Search" id="search" name="search">
							    <button type="submit" class="btn btn-default">Submit</button>							    
							  </div>
							</form>
						    <div id="loginSignupText">
							    <ul class="nav navbar-nav navbar-right">
							    	<%if(session.getAttribute("userName") == null){%>
								  		<li><a href="SplashPage.jsp" class="navbar-link" id="loginText">Log In/Sign Up</a></li>
								  	<%}else if(session.getAttribute("userName") != null){%>
								  			<li><a href="EditUser.jsp">${sessionScope.user.getUsername()}</a></li><li><a href="logoutServlet" class="navbar-link" id="logoutText" >Logout</a></li>
								  	<%}%>
								</ul>
							</div>
						</div>
					  </div><!-- /.container-fluid -->
					</nav>
				</div><!-- /.col-md-12 -->
			</div><!-- /.row-fluid -->
		
			<!-- CONTENT HEADER -->
			<!-- featuredElectives row -->
			
			
			<!-- MAIN CONTENT -->
			<p>Name: <%=elective.getName()%></p>
			<p>Course Code: <%=elective.getCourseCode()%>
			<p>Description: <%=elective.getDescription()%></p>
			<p>Rating: <%=elective.getRating()%>
			
			<%for(Rating rating: elective.getComments()){
				User user = ratingController.getUser(rating.getUserID());
				//out.print("<p><b>" + user.getUsername() + "</b>   " + rating.getDate().toString() + "</p>");
				out.print("<p><b>" + user.getUsername() + "</b>");
				out.print("<p>Rating: " + rating.getRating() + "    " + rating.getHoursPerWeek() + " hours per week </p>");
				out.print("<p>" + rating.getComment() + "</p>");
				out.print("<hr />");
			}%>

		</div> <!-- /.container fluid -->
	</body>
	<script src="js/jquery-1.11.2.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
</html>