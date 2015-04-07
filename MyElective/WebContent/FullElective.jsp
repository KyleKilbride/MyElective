<%@page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.myelective.controllers.*, java.util.ArrayList, beans.*"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="language" value="${not empty param.language ? param.language : not empty language ? language : pageContext.request.locale}" scope="session" />
<fmt:setLocale value="${language}" />
<fmt:setBundle basename="com.myelective.resources.text_fr" />
	
<!DOCTYPE html>

<!-- PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd" -->

<%
	if(session.getAttribute("language") ==  "french"){
		%> <fmt:setBundle basename="com.myelective.resources.text_fr" /> <% 
	}else{
		%> <fmt:setBundle basename="com.myelective.resources.text" /> <%
	}

	User loggedUser = (User)session.getAttribute("user");
	ElectiveController electiveController = new ElectiveController();
	RatingController ratingController = new RatingController();
	UserController userController = new UserController();
	session.setAttribute("allElectives",ratingController.getElectiveNamesSearchBar());
	int electiveID = Integer.parseInt(request.getParameter("ElectiveID"));
	session.setAttribute("ElectiveID", electiveID);
	
	Elective elective = ratingController.getElective(electiveID);
	
	if (loggedUser != null) {
		session.setAttribute("userName", loggedUser.getFirstName());
		session.setAttribute("userStatus", loggedUser.getStatus());
	}
	
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
        <link rel="stylesheet" href="http://yui.yahooapis.com/pure/0.5.0/pure-min.css">
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
		
			<!-- CONTENT HEADER -->
			<!-- featuredElectives row -->
			
			<!-- MAIN CONTENT -->
		    <section id="fullElective" class="container content-section text-center">
		        <div class="row">
		            <div class="col-lg-8 col-lg-offset-2">
		      			<h1><%=elective.getName()%> - <%=elective.getCourseCode()%></h1>
						<p><fmt:message key="fullelective.label.description" />: <%=elective.getDescription()%></p>
						<p><fmt:message key="fullelective.label.rating" />: <%=elective.getRating()%></p>
						<%for(Rating rating: elective.getComments()){
							User user = ratingController.getUser(rating.getUserID());
							String date = new java.text.SimpleDateFormat("MM/dd/yyyy HH:mm:ss").format(new java.util.Date (rating.getDate()*1000L));
							out.print("<p><b>" + user.getUsername() + "</b>");
							out.print("<p>\"" + rating.getComment() + "\"</p>");
							out.print("<p>\"" + date + "\"</p>");
							out.print("<p> Rating: " + rating.getRating() + "/10<br/>" + "Hours required per week: " + rating.getHoursPerWeek() + "<fmt:message key=\"fullelective.label.hpw\" />" + " </p>"); //not outprinting fmt properly
							out.print("<hr />");
						}%>
						<c:if test="${sessionScope.userName != null}">
							<form action="commentServlet" method="POST" id="reviewForm" class="form-horizontal">
								<div class="form-group">
									<label for="reviewRating" style="color: #ffffff"><fmt:message key="fullelective.label.rating" />: </label>
									<input name="reviewRating" class="form-control" maxlength="2" size="2"/><span style="color:#ffffff">/10</span>
								</div>
								<div class="form-group">
									<label for="reviewText" style="color: #ffffff">Review</label>
									<textarea form="reviewForm" class="form-control" name="reviewText" placeholder="<fmt:message key="fullelective.label.review" />" rows="5" cols="75"></textarea>
								</div>
								<div class="form-group">
									<label for="hoursAWeek" style="color: #ffffff">Hours a Week: </label>
									<input name="hoursAWeek" maxlength="4" size="4" class="form-control"/>
								</div>
								<div class="form-group">
									<input type="submit" class="form-control btn-default submitRatingButton" value="<fmt:message key="fullelective.button.submit" />"/>
								</div>
							</form>
						</c:if>
		      		</div>
		        </div>
		    </section>
		</div> <!-- /.container fluid -->
	</body>
	<script src="js/bootstrap.min.js"></script>
</html>
