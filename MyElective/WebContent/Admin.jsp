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

	if(session.getAttribute("userStatus")== null || session.getAttribute("userStatus").equals("user")){
		response.sendRedirect("SplashPage.jsp");
	}

	ElectiveController electiveController = new ElectiveController();
	RatingController ratingController = new RatingController();
	ArrayList ratingArrLst = ratingController.getRecentRating(4);
		
	session.setAttribute("allElectives",ratingController.getElectiveNamesSearchBar());
	
	String searchError = (String)session.getAttribute("searchError");
	if(searchError==null || searchError=="null"){
		searchError="";
	}
%>
<html>
	<head>
		<link href="font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
		<link href="css/bootstrap.min.css" rel="stylesheet" type="text/css">
		<!-- <link href="css/index.css" rel="stylesheet" type="text/css"> -->
		<link href="css/grayscale.css" rel="stylesheet" type="text/css">
		<link rel="stylesheet" href="//code.jquery.com/ui/1.11.3/themes/smoothness/jquery-ui.css">
       
		<link href="http://fonts.googleapis.com/css?family=Lora:400,700,400italic,700italic" rel="stylesheet" type="text/css">
    	<link href="http://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css">
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
											//allElectives = allElectives.substring(2);
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
								<input type="hidden" name="viewid" value="FullElective.jsp">
							    <button type="submit" class="btn btn-default"><fmt:message key="nav.button.submit" /></button>							    
							  </div>
							</form>
						    <div id="loginSignupText">
							    <ul class="nav navbar-nav navbar-right">
							    	<%if(session.getAttribute("userName") == null){%>
								  		<li><a href="SplashPage.jsp" class="navbar-link" id="loginText"><fmt:message key="nav.label.loginsignup" /></a></li>
								  	<%}else if(session.getAttribute("userName") != null){%>
								  		<li><a href="EditUser.jsp">${sessionScope.user.getUsername()}</a></li><li><a href="logoutServlet" class="navbar-link" id="logoutText" ><fmt:message key="nav.label.logout" /></a></li>
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
				</div><!-- /.col-md-12 -->
			</div><!-- /.row-fluid -->
			<br/><br/><br/><br/><br/>			
			<div class="container">		
				<form action="adminServlet" method="post" class="form-horizontal">
					<div class="form-group">
						<input type="submit" name="editElective" class="form-control btn-default" value="<fmt:message key="admin.button.editelective" />">
					</div>
					<div class="form-group">
						<input type="submit" name="removeElective" class="form-control btn-default" value="<fmt:message key="admin.button.removeelective" />">
					</div>
					<div class="form-group">
						<input type="submit" name="addElective" class="form-control btn-default" value="<fmt:message key="admin.button.addelective" />">
					</div>
				</form>
				<br/><br/>
				<% if(session.getAttribute("adminAction")=="editElective"){%>			
					<p><b><fmt:message key="admin.label.selectedelectiveedit" /></b></p>
					<form action="" method="POST" class="form-horizontal" style="display: flex">		
						<select name="editElectivesDrop" class="form-control" style="width: 20%">
							<option value=""></option>
							<%int z=0;%>	
							<c:forEach items="${sessionScope.allElectives}" var="elective" >
							<%if(z%2 == 1){ %>
								<option value="${elective}" >${elective}</option>			
								<%}z++; %>
							</c:forEach>
						</select>
						<div class="form-group">
							<input type="submit" class="form-control btn-default" value="<fmt:message key="admin.label.selectelective" />" style="margin-left: 30px"></input>
						</div>
									
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
						<b><fmt:message key="admin.label.electivename" />:</b> <%=elective.getName()%> <input type="text" name="editElectiveNewName" size="50" maxlength="200" placeholder="<fmt:message key="admin.label.newelectivename" />"/>
						<input type="submit" class="btn-default" value="<fmt:message key="admin.button.submitnewname" />" />
						<input hidden="true" type="text" name="editElectiveCurrentName" value="<%=elective.getName()%>"/>
					</form>
					<br/><br/>
					<form action="adminServlet" method="POST">
						<b><fmt:message key="admin.label.electivecode" />:</b> <%=elective.getCourseCode()%> <input type="text" name="editElectiveNewCode" maxlength="8" placeholder="<fmt:message key="admin.label.newelectivecode" />"/>
						<input type="submit" class="btn-default" value="<fmt:message key="admin.button.submitcoursecode" />"></input>
						<input hidden="true" type="text" name="editElectiveCurrentCode" value="<%=elective.getCourseCode()%>"/>
					</form>
					<br/><br/>
					<form action="adminServlet" method="POST" id="editElectivesDescForm">	
						<b><fmt:message key="admin.label.electivedescription" />:</b><%=elective.getDescription()%> 
						<br/><br/>
						<textarea name="editElectiveNewDesc" placeholder="<fmt:message key="admin.label.newelectivedescription" />" form="editElectivesDescForm" rows="5" cols="75" maxlength="5000"></textarea>
						<br/></br>
						<input type="submit" class="btn-default" value="<fmt:message key="admin.button.submitnewdescription" />"></input>
						<input hidden="true" type="text" name="editElectiveCurrentDesc" value="<%=elective.getDescription()%>"/>
					</form>
						<%}%>			
					<%}%>
					<%if(session.getAttribute("adminAction")=="removeElective"){%>
						<p><b><fmt:message key="admin.label.newelectivedescription" /></b></p>
						<form action="" method="POST">		
							<select name="removeElectivesDrop" class="selectpicker">
								<option value=""></option>
								<%int y=0;%>	
								<c:forEach items="${sessionScope.allElectives}" var="elective" >
								<%if(y%2 == 1){ %>
									<option value="${elective}" >${elective}</option>
								<%}y++; %>
								</c:forEach>
							</select>
							<input type="submit" class="btn-default" value="<fmt:message key="admin.label.selectelectiveremove" />"></input>			
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
							<b><fmt:message key="admin.label.selectedelective" />:  </b><%=elective.getName()%>
							<br/>	
							<b><fmt:message key="admin.label.confirmremove" />: </b><input type="text" maxlength="7" name="removeElectiveConfirm" placeholder="<fmt:message key="admin.label.sure" />"/>
							<input type="submit" class="btn-default" value="<fmt:message key="admin.label.confirmremove" />" />
							<input hidden="true" type="text" name="removeElectiveName" value="<%=elective.getName()%>"/>
						</form>
							<%}%>
					<%}%>
					<%if(session.getAttribute("adminAction")=="addElective"){%>
						<p><b><fmt:message key="admin.label.enterelectiveinfo" /></b></p>
						<form action="adminServlet" method="POST" id="addElectivesForm">
							<b><fmt:message key="admin.label.electivename" />: </b><input type="text" name="addElectiveName" maxlength="200" placeholder="<fmt:message key="admin.label.electivename" />"/>
							<br/><br/>
							<b><fmt:message key="admin.label.electivecode" />: </b><input type="text" name="addElectiveCode" maxlength="8" placeholder="<fmt:message key="admin.label.electivecode" />"/>
							<br/><br/>
							<b><fmt:message key="admin.label.electivedescription" />: </b><textarea name="addElectiveDesc" maxlength="5000" placeholder="<fmt:message key="admin.label.electivedescription" />" form="addElectivesForm" rows="5" cols="75"></textarea>
							<br/><br/>
							<input type="submit" class="btn-default" value="<fmt:message key="admin.button.addnewelective" />"></input>
						</form>
					<%}%>		
				</div>			
			</div><!-- /.container fluid -->
	</body>
	<script src="js/bootstrap.min.js"></script>
</html>
