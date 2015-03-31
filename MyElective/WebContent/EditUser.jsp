<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="com.myelective.controllers.*, java.util.ArrayList, beans.*"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="language" value="${not empty param.language ? param.language : not empty language ? language : pageContext.request.locale}" scope="session" />
<fmt:setLocale value="${language}" />
<fmt:setBundle basename="com.myelective.resources.text_fr" />

<!DOCTYPE html>
<!-- PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd" -->
<!-- Authors: Kyle Usherwood, Kyle Kilbride -->
<%
	request.getSession(false);
	User user = (User) session.getAttribute("user");
	
	if(session.getAttribute("language") ==  "french"){
		%> <fmt:setBundle basename="com.myelective.resources.text_fr" /> <% 
	}else{
		%> <fmt:setBundle basename="com.myelective.resources.text" /> <%
	}
	
	if(session.getAttribute("user")== null){
		response.sendRedirect("SplashPage.jsp");
	}

	ElectiveController electiveController = new ElectiveController();
	RatingController ratingController = new RatingController();
	ArrayList ratingArrLst = ratingController.getRecentRating(4);
		
	session.setAttribute("allElectives",ratingController.getElectiveNamesSearchBar());
	//session.setAttribute("userName", user.getFirstName());
	
	String error = (String)session.getAttribute("error");
	if(error==null || error=="null"){
		error="";
	}
	
	String searchError = (String)session.getAttribute("searchError");
	if(searchError==null || searchError=="null"){
		searchError="";
	}
%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<link href="font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
		<link href="css/bootstrap.min.css" rel="stylesheet" type="text/css">
		<link href="css/index.css" rel="stylesheet" type="text/css">
		<link href="css/grayscale.css" rel="stylesheet" type="text/css">
		<link rel="stylesheet" href="//code.jquery.com/ui/1.11.3/themes/smoothness/jquery-ui.css">
        <link rel="stylesheet" href="http://yui.yahooapis.com/pure/0.5.0/pure-min.css">
		<link href="http://fonts.googleapis.com/css?family=Lora:400,700,400italic,700italic" rel="stylesheet" type="text/css">
    	<link href="http://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css">
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
					   		<a class="navbar-brand" href="index.jsp">MyElective</a>
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
						    		<li><a href="AllElectives.jsp"><fmt:message key="nav.label.allelectives" /></a></li>
						    		<li><a href="Admin.jsp"><fmt:message key="nav.label.admin" /></a></li>
						    	</ul>
						   	<%}
						   	else{%>
						   		<ul class="nav navbar-nav">
						   			<li><a href="AllElectives.jsp"><fmt:message key="nav.label.allelectives" /></a></li>
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
											allElectives = allElectives.substring(2);
											allElectives = allElectives.substring(0,allElectives.length - 1);
											var names = allElectives.split(", ~, ");
											$("#search").autocomplete({source : names});
										});
									</script>
							    		<%if(searchError.equals("")){ %>
											<input type="text" class="form-control" placeholder="<fmt:message key="nav.label.search" />" id="search" name="search">
										<%}else{ %>
											<input type="text" class="form-control" placeholder="<%out.print(searchError); %>" id="search" name="search">
											<%session.setAttribute("searchError", null);%>
										<%} %>
										<input type="hidden" name="viewid" value="index.jsp">
							    	<button type="submit" class="btn btn-default"><fmt:message key="nav.button.submit" /></button>							    
							  	</div>
							</form>
						    <div id="loginSignupText">
							    <ul class="nav navbar-nav navbar-right">
							   		<%if(session.getAttribute("userName") == null){%>
								  		<li><a href="SplashPage.jsp" class="navbar-link" id="loginText"><fmt:message key="nav.label.loginsignup" /></a></li>
								  	<%}else if(session.getAttribute("userName") != null){%>
							  			<li><a href="EditUser.jsp">${sessionScope.user.getUsername()}</a></li>
							  			<li><a href="logoutServlet" class="navbar-link" id="logoutText" ><fmt:message key="nav.label.logout" /></a></li>
								  	<%}%>
								</ul>  	
							</div>
							<div id="language">
							    <ul class="nav navbar-nav navbar-right">
								  	<li><a href="languageServlet" class="navbar-link" id="loginText"><fmt:message key="nav.label.language" /></a></li>
								</ul>  	
							</div>
						</div>
					  </div><!-- /.container-fluid -->
					</nav>
				</div>
			</div><!-- /.row-fluid -->
		</div><!-- /.container fluid -->
		<form action="editUserServlet" class="form-horizontal" method="POST" id="editUserForm">
			<h1><b><fmt:message key="edituser.label.edituser" /></b></h1>
			<div class="form-group">
				<label class="col-md-4 control-label" for="editUserFirstName"><b><fmt:message key="edituser.label.currfn" />:</b> <%=user.getFirstName()%></label>
				<div class="col-md-6">
					<input type="text" class="form-control" maxlength="100" size="100" name="editUserFirstName" placeholder="<fmt:message key="edituser.label.newfn" />"/>			
				</div>
			</div>
			
			 <div class="form-group">
				<label class="col-md-4 control-label" for="editUserLastName"><b><fmt:message key="edituser.label.currln" />:</b> <%=user.getLastName()%></label>
				<div class="col-md-6">
					<input type="text" class="form-control" maxlength="100" size="100" name="editUserLastName" placeholder="<fmt:message key="edituser.label.newln" />"/>			
				</div>
			</div>
			
			<div class="form-group">
				<label class="col-md-4 control-label" for="editUserProgram"><b><fmt:message key="edituser.label.currprog" />:</b> <%=user.getProgram()%></label>
				<div class="col-md-6">
					<input type="text" class="form-control" name="editUserProgram" maxlength="200" size="100" placeholder="<fmt:message key="edituser.label.newprog" />"/>			
				</div>
			</div>
			 
			<div class="form-group">
				<label class="col-md-4 control-label" for="editUserPassword"><b><fmt:message key="edituser.label.enternewpass" />:</b></label>
				<div class="col-md-6">
					<input type="password" class="form-control" name="editUserPassword" maxlength="100" size="25" placeholder="<fmt:message key="edituser.label.newpass" />"/>
				</div>
			</div>
			 
			<div class="form-group">
				<label class="col-md-4 control-label" for="editUserProgram"><b><fmt:message key="edituser.label.enterconfpass" />:</b></label>
				<div class="col-md-6">
					<input type="password" class="form-control" name="editUserConfirmPassword" maxlength="100" size="25" placeholder="<fmt:message key="edituser.label.confpass" />"/> 
				</div>
			</div>	
			 			 
			<div class="form-group">
				<div class="col-md-6 col-md-offset-4">
					<input type="submit" class="btn btn-default" value="<fmt:message key="edituser.button.submit" />"></input>
				</div>
			</div>
			
			<h2 style="color: red;"><%out.print(error); %></h2>
			<%session.setAttribute("error", null);%>
			<input hidden="true" type="text" name="editUserEmail" value="<%=user.getEmailAddress()%>"/>
			
		</form>
	</body>
	<script src="js/bootstrap.min.js"></script>
</html>