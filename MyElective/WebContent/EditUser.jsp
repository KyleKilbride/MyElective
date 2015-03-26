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
						    			<li><a href="AllElectives.jsp"><fmt:message key="nav.label.allelectives" /></a></li>
						    			<li><a href="Admin.jsp"><fmt:message key="nav.label.admin" /></a></li>
						    		</ul>
						    	<%}
						    	else{%>
						    		<ul class="nav navbar-nav">
						    			<li><a href="AllElectives.jsp"><fmt:message key="nav.label.allelectives" /></a></li>
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
										<input type="hidden" name="viewid" value="EditUser.jsp">
										<button type="submit" class="btn btn-default"><fmt:message key="nav.button.submit" /></button>	
									</div>
								</form>
								<div id="loginSignupText">
									<p class="navbar-text navbar-right">
											<a href="EditUser.jsp">${sessionScope.user.getUsername()}</a>
											<a href="logoutServlet" class="navbar-link" id="logoutText" ><fmt:message key="nav.label.logout" /></a>							
									</p>
								</div>
								<div id="language">
							    	<ul class="nav navbar-nav navbar-right">
								  		<li><a href="languageServlet" class="navbar-link" id="loginText"><fmt:message key="nav.label.language" /></a></li>
									</ul>  	
								</div>
							</div>
						</div><!-- /.container-fluid -->
					</nav>
				</div><!-- /.col-md-12 -->
			</div><!-- /.row-fluid -->
		</div><!-- /.container fluid -->
		<br/>
		<br/>
		<b><fmt:message key="edituser.label.edituser" /></b>
		<br/>
		<br/>
		<form action="editUserServlet" method="POST" id="editUserForm">
			<b><fmt:message key="edituser.label.currfn" />:</b> <%=user.getFirstName()%> <input type="text" maxlength="100" size="100" name="editUserFirstName" placeholder="<fmt:message key="edituser.label.newfn" />"/>			
			<br/><br/>
			<b><fmt:message key="edituser.label.currln" />:</b> <%=user.getLastName()%> <input type="text" maxlength="100" size="100" name="editUserLastName" placeholder="<fmt:message key="edituser.label.newln" />"/>
			<br/><br/>
			<b><fmt:message key="edituser.label.currprog" />:</b> <%=user.getProgram()%> <input type="text" name="editUserProgram" maxlength="200" size="100" placeholder="<fmt:message key="edituser.label.newprog" />"/>
			<br/><br/>			
			<b><fmt:message key="edituser.label.enternewpass" />:</b> <input type="password" name="editUserPassword" maxlength="100" size="25" placeholder="<fmt:message key="edituser.label.newpass" />"/>
			<br/><br/>
			<b><fmt:message key="edituser.label.enterconfpass" />:</b> <input type="password" name="editUserConfirmPassword" maxlength="100" size="25" placeholder="<fmt:message key="edituser.label.confpass" />"/> 
			<br/><br/>
			<h2 style="color: red;"><%out.print(error); %></h2>
			<%session.setAttribute("error", null);%>
			<input type="submit" value="<fmt:message key="edituser.button.submit" />"></input>
			<input hidden="true" type="text" name="editUserEmail" value="<%=user.getEmailAddress()%>"/>
			
		</form>
	</body>
	<script src="js/bootstrap.min.js"></script>
</html>