<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="com.myelective.controllers.*, java.util.ArrayList, beans.*"%>
	<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<!-- PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd" -->
<!-- Authors: Kyle Usherwood, Kyle Kilbride -->
<%
	request.getSession(false);
	User user = (User) session.getAttribute("user");

	if(session.getAttribute("userStatus")== null || session.getAttribute("userStatus").equals("user")){
		response.sendRedirect("SplashPage.jsp");
	}

	ElectiveController electiveController = new ElectiveController();
	RatingController ratingController = new RatingController();
	ArrayList ratingArrLst = ratingController.getRecentRating(4);
		
	session.setAttribute("allElectives", electiveController.getElectiveNames());

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
								<form class="navbar-form navbar-right" role="search">
									<div class="form-group">
										<script src="//code.jquery.com/jquery-1.10.2.js"></script>
										<script src="//code.jquery.com/ui/1.11.3/jquery-ui.js"></script>
										<script type="text/javascript" id="searchScript" data-electives="${sessionScope.allElectives}">
											$(function() {			
												allElectives = searchScript.getAttribute("data-electives");
												allElectives = allElectives.substring(1);
												allElectives = allElectives.substring(0,allElectives.length - 4);
												var names = allElectives.split(",  ");
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
												System.out.println("gets in if " + session.getAttribute("userName"));
										%>
										<a href="SplashPage.jsp" class="navbar-link" id="loginText">Log In/Sign Up</a>
										<%
										} 
											else if (session.getAttribute("userName") != null) {
										  		System.out.println("gets in else " + session.getAttribute("userName"));
										%>
											${sessionScope.user.getFirstName()} <a href="index.jsp?newsession" class="navbar-link" id="logoutText">Logout</a>
										<%
										}
										%>
									</p>
								</div>
							</div>
						</div><!-- /.container-fluid -->
					</nav>
				</div><!-- /.col-md-12 -->
			</div><!-- /.row-fluid -->
			<br/><br/><br/><br/><br/>			
			<div>		
				<%if(session.getAttribute("adminAction")==null){ %>
					<form action="adminServlet" method="post">
						<input type="submit" name="editElective" value="Edit Elective">
						<input type="submit" name="removeElective" value="Remove Elective">
						<input type="submit" name="addElective" value="Add Elective"><br/><br/>
					</form>
				<%} 
				else if(session.getAttribute("adminAction")=="editElective"){%>			
					<p>Select Elective to Edit</p>
					<form action="" method="POST">		
						<select name="editElectivesDrop">
							<option value=""></option>	
							<c:forEach items="${sessionScope.allElectives}" var="elective" >
								<option value="${elective}" >${elective}</option>
							</c:forEach>
						</select>
						<input type="submit" value="Select Elective"></input>			
					</form>
					<form action="adminServlet" method="post">	
						<%String editElectivesDropSelection[] = request.getParameterValues("editElectivesDrop");
						if(editElectivesDropSelection != null){ 
							String selectedElective="";
							for(int i=0; i<editElectivesDropSelection.length; i++){
								selectedElective += editElectivesDropSelection[i];
						}%>	
						<br/>
						<%Elective elective = electiveController.getElective(selectedElective);%>			
						<b>Elective Name:</b> <%=selectedElective%> <input type="text" name="text" placeholder="New Elective Name	"/>
						<input type="submit" value="Submit New Name"></input>
						<br/><br/>
						<%=elective.getCourseCode() %>
						<br/>	
					</form>
							<%}%>			
						
						<%}%>	
				</div>			
			</div><!-- /.container fluid -->
	</body>
	<script src="js/bootstrap.min.js"></script>
</html>
