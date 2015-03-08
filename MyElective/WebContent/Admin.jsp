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
	
	String searchError = (String)session.getAttribute("searchError");
	if(searchError==null || searchError=="null"){
		searchError="";
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
						    			<li><a href="AllElectives.jsp">All Electives</a></li><li><a href="Admin.jsp">Admin</a></li>
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
												allElectives = searchScript.getAttribute("data-electives");
												allElectives = allElectives.substring(1);
												allElectives = allElectives.substring(0,allElectives.length - 1);
												var names = allElectives.split(", ");
												$("#search").autocomplete({source : names});
											});
										</script>
										<%if(searchError.equals("")){ %>
											<input type="text" class="form-control" placeholder="Search" id="search" name="search">
										<%}else{ %>
											<input type="text" class="form-control" placeholder="<%out.print(searchError); %>" id="search" name="search">
											<%session.setAttribute("searchError", null);%>
										<%} %>
										<input type="hidden" name="viewid" value="Admin.jsp">
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
			<br/><br/><br/><br/><br/>			
			<div>		
				<form action="adminServlet" method="post">
					<input type="submit" name="editElective" value="Edit Elective">
					<input type="submit" name="removeElective" value="Remove Elective">
					<input type="submit" name="addElective" value="Add Elective"><br/><br/>
				</form>
				<br/><br/>
				<% if(session.getAttribute("adminAction")=="editElective"){%>			
					<p><b>Select Elective to Edit</b></p>
					<form action="" method="POST">		
						<select name="editElectivesDrop">
							<option value=""></option>	
							<c:forEach items="${sessionScope.allElectives}" var="elective" >
								<option value="${elective}" >${elective}</option>
							</c:forEach>
						</select>
						<input type="submit" value="Select Elective"></input>			
					</form>
					<form action="adminServlet" method="post" id="editElectivesForm">	
						<%String editElectivesDropSelection[] = request.getParameterValues("editElectivesDrop");
						if(editElectivesDropSelection != null){ 
							String selectedElective="";
							for(int i=0; i<editElectivesDropSelection.length; i++){
								selectedElective += editElectivesDropSelection[i];
								//selectedElective = selectedElective.substring(1);
							}%>	
						<br/>
						<%Elective elective = ratingController.getElectiveByString(selectedElective);%>	
					</form>
					<form action="adminServlet" method="POST">		
						<b>Elective Name:</b> <%=elective.getName()%> <input type="text" name="editElectiveNewName" size="50" maxlength="200" placeholder="New Elective Name"/>
						<input type="submit" value="Submit New Name" />
						<input hidden="true" type="text" name="editElectiveCurrentName" value="<%=elective.getName()%>"/>
					</form>
					<br/><br/>
					<form action="adminServlet" method="POST">
						<b>Elective Course Code:</b> <%=elective.getCourseCode()%> <input type="text" name="editElectiveNewCode" maxlength="8" placeholder="New Elective Course Code"/>
						<input type="submit" value="Submit Course Code"></input>
						<input hidden="true" type="text" name="editElectiveCurrentCode" value="<%=elective.getCourseCode()%>"/>
					</form>
					<br/><br/>
					<form action="adminServlet" method="POST" id="editElectivesDescForm">	
						<b>Elective Description:</b><%=elective.getDescription()%> 
						<br/><br/>
						<textarea name="editElectiveNewDesc" placeholder="New Description" form="editElectivesDescForm" rows="5" cols="75" maxlength="5000"></textarea>
						<br/></br>
						<input type="submit" value="Submit New Description"></input>
						<input hidden="true" type="text" name="editElectiveCurrentDesc" value="<%=elective.getDescription()%>"/>
					</form>
						<%}%>			
					<%}%>
					<%if(session.getAttribute("adminAction")=="removeElective"){%>
						<p><b>Select Elective to Remove</b></p>
						<form action="" method="POST">		
							<select name="removeElectivesDrop">
								<option value=""></option>	
								<c:forEach items="${sessionScope.allElectives}" var="elective" >
									<option value="${elective}" >${elective}</option>
								</c:forEach>
							</select>
							<input type="submit" value="Select Elective"></input>			
						</form>
						<form action="adminServlet" method="post" id="removeElectivesForm">	
							<%String removeElectivesDropSelection[] = request.getParameterValues("removeElectivesDrop");
							if(removeElectivesDropSelection != null){ 
								String selectedElective="";
								for(int i=0; i<removeElectivesDropSelection.length; i++){
									selectedElective += removeElectivesDropSelection[i];
									//selectedElective = selectedElective.substring(1);
								}%>	
							<br/>
							<%Elective elective = ratingController.getElectiveByString(selectedElective);%>	
						</form>
						<form action="adminServlet" method="POST">	
							<b>Selected Elective:  </b><%=elective.getName()%>
							<br/>	
							<b>Enter CONFIRM to continue: </b><input type="text" maxlength="7" name="removeElectiveConfirm" placeholder="Are you sure?"/>
							<input type="submit" value="Confirm Remove" />
							<input hidden="true" type="text" name="removeElectiveName" value="<%=elective.getName()%>"/>
						</form>
							<%}%>
					<%}%>
					<%if(session.getAttribute("adminAction")=="addElective"){%>
						<p><b>Enter Elective Information</b></p>
						<form action="adminServlet" method="POST" id="addElectivesForm">
							<b>Elective Name: </b><input type="text" name="addElectiveName" maxlength="200" placeholder="Elective Name"/>
							<br/><br/>
							<b>Elective Code: </b><input type="text" name="addElectiveCode" maxlength="8" placeholder="Elective Code"/>
							<br/><br/>
							<b>Elective Description: </b><textarea name="addElectiveDesc" maxlength="5000" placeholder="Elective Description" form="addElectivesForm" rows="5" cols="75"></textarea>
							<br/><br/>
							<input type="submit" value="Add New Elective"></input>
						</form>
					<%}%>		
				</div>			
			</div><!-- /.container fluid -->
	</body>
	<script src="js/bootstrap.min.js"></script>
</html>
