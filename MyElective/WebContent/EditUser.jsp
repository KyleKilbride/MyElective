<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="com.myelective.controllers.*, java.util.ArrayList, beans.*"%>
	<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<!-- PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd" -->
<!-- Authors: Kyle Usherwood, Kyle Kilbride -->
<%
	request.getSession(false);
	User user = (User) session.getAttribute("user");
	
	if(session.getAttribute("userStatus")== null){
		response.sendRedirect("SplashPage.jsp");
	}

	ElectiveController electiveController = new ElectiveController();
	RatingController ratingController = new RatingController();
	ArrayList ratingArrLst = ratingController.getRecentRating(4);
		
	session.setAttribute("allElectives", electiveController.getElectiveNames());
	//session.setAttribute("userName", user.getFirstName());
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
								<a class="navbar-brand" href="index.jsp"> MyElective </a>
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
								<form class="navbar-form navbar-right" role="search"  action="searchServlet" method="post">
									<div class="form-group">
										<script src="//code.jquery.com/jquery-1.10.2.js"></script>
										<script src="//code.jquery.com/ui/1.11.3/jquery-ui.js"></script>
										<script type="text/javascript" id="searchScript" data-electives="${sessionScope.allElectives}">
											$(function() {			
												allElectives = searchScript.getAttribute("data-electives");
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
									<p class="navbar-text navbar-right">
											<a href="EditUser.jsp">${sessionScope.user.getUsername()}</a>
											<a href="logoutServlet" class="navbar-link" id="logoutText" >Logout</a>							
									</p>
								</div>
							</div>
						</div><!-- /.container-fluid -->
					</nav>
				</div><!-- /.col-md-12 -->
			</div><!-- /.row-fluid -->
		</div><!-- /.container fluid -->
		<br/>
		<br/>
		<b>Edit User</b>
		<br/>
		<br/>
		<form action="editUserServlet" method="POST" id="editUserForm">
			<b>Current First Name:</b> <%=user.getFirstName()%> <input type="text" maxlength="100" name="editUserFirstName" placeholder="New User First Name"/>			
			<br/><br/>
			<b>Current Last Name:</b> <%=user.getLastName()%> <input type="text" maxlength="100" name="editUserLastName" placeholder="New User Last Name"/>
			<br/><br/>
			<b>Current Program:</b> <%=user.getProgram()%> <input type="text" name="editUserProgram" maxlength="200" size="100" placeholder="New User Program"/>
			<br/><br/>			
			<b>Enter New Password:</b> <input type="password" name="editUserPassword" maxlength="100" placeholder="New User Password"/>
			<br/><br/>
			<b>Confirm New Password:</b> <input type="password" name="editUserConfirmPassword" maxlength="100" placeholder="Confirm New User Password"/>
			<br/><br/>
			<script type="text/javascript">
				$(function() {			
					if(document.getElementById("editUserPassword")){
						

					}
				});							
			</script>
			<input type="submit" value="Submit"></input>
			<input hidden="true" type="text" name="editUserEmail" value="<%=user.getEmailAddress()%>"/>
			
		</form>
	</body>
	<script src="js/bootstrap.min.js"></script>
</html>