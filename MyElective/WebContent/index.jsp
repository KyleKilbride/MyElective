<%@page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.myelective.controllers.*, java.util.ArrayList, beans.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="language" value="${not empty param.language ? param.language : not empty language ? language : pageContext.request.locale}" scope="session" />
<fmt:setLocale value="${language}" />

<!DOCTYPE html>

<!-- PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd" -->
<%
	request.getSession(false);
	User user = (User)session.getAttribute("user");
	
	if(session.getAttribute("language") ==  "french"){
		%> <fmt:setBundle basename="com.myelective.resources.text_fr" /> <% 
	}else{
		%> <fmt:setBundle basename="com.myelective.resources.text" /> <%
	}
	
	ElectiveController electiveController = new ElectiveController();
	RatingController ratingController = new RatingController();
	
	ArrayList ratingArrLst = ratingController.getRecentRating(4);
	ArrayList<String> electiveNames = electiveController.getElectiveNames();		
	Elective featuredElective = (Elective)electiveController.getFeaturedElective();

	session.setAttribute("userName", null);
    session.setAttribute("userStatus", null);
	session.setAttribute("featuredElective", electiveController.getFeaturedElective());
	session.setAttribute("allElectives",ratingController.getElectiveNamesSearchBar());
//	session.setAttribute("recentRatingBean1", ratingArrLst.get(0));
//	session.setAttribute("recentRatingBean2", ratingArrLst.get(1));
//	session.setAttribute("recentRatingBean3", ratingArrLst.get(2));
//	session.setAttribute("recentRatingBean4", ratingArrLst.get(3));
	
	Rating rating1 = (Rating)ratingArrLst.get(0);
	Rating rating2 = (Rating)ratingArrLst.get(1);
	Rating rating3 = (Rating)ratingArrLst.get(2);
	Rating rating4 = (Rating)ratingArrLst.get(3);

//	session.setAttribute("recentRatingBean1",(Rating) ratingArrLst.get(1));

	if (user != null) {
		session.setAttribute("userName", user.getFirstName());
		session.setAttribute("userStatus", user.getStatus());
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
	<body id="page-top" data-spy="scroll" data-target=".navbar-fixed-top">
		<div class="container-fluid" id="fullHeader">
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
				</div><!-- /.col-md-12 -->
			</div><!-- /.row-fluid -->
		
		    <header class="intro" id="headerIntro">
		        <div class="intro-body">
		            <div class="container">
		                <div class="row">
		                    <div class="col-md-8 col-md-offset-2">
		                        <h1 class="brand-heading">MyElective</h1>
		                        <p class="intro-text"><fmt:message key="main.label.myelectivedescription" /></p>
		                        <a href="#featuredElective" class="btn btn-circle page-scroll">
		                            <i class="fa fa-angle-double-down animated"></i>
		                        </a>
		                    </div>
		                </div>
		            </div>
		        </div>
		    </header>			
			
			<!-- About Section -->
		    <section id="featuredElective" class="container content-section text-center">
		        <div class="row">
		            <div class="col-lg-8 col-lg-offset-2">
		                <h2><fmt:message key="main.label.featuredElective"/></h2>
		                <h3>${sessionScope.featuredElective.getName()} -- ${sessionScope.featuredElective.getCourseCode()}</h3>
		                <p>${sessionScope.featuredElective.getDescription()}</p>
		                <a class="btn btn-default" id="featuredViewButton" href="FullElective.jsp?ElectiveID=<%=featuredElective.getId()%>"><fmt:message key="main.button.view"/></a>
		            </div>
		        </div>
		    </section>

		    <section id="recentReviews" class="container content-section text-center">
		        <h1><fmt:message key="main.label.recentreview"/></h1>
		        <div class="row" id="recentReviewsRow">
		            <div class="col-lg-4">
			            <a href="FullElective.jsp?ElectiveID=<%=ratingController.getElective(rating1.getElectiveID()).getId()%>" id="recentLink">
			                <% out.write("<h2>" + ratingController.getElective(rating1.getElectiveID()).getName() + "</h2>"); %>
			                <p><fmt:message key="main.label.review"/>: <%=rating1.getComment() %></p>
			                <p><fmt:message key="main.label.rating"/>: <%=rating1.getRating()%></p>
			            </a>
		            </div>
		            <div class="col-lg-4">
			            <a href="FullElective.jsp?ElectiveID=<%=ratingController.getElective(rating2.getElectiveID()).getId()%>" id="recentLink">
			                <% out.write("<h2>" + ratingController.getElective(rating2.getElectiveID()).getName() + "</h2>"); %>
			                <p><fmt:message key="main.label.review"/>: <%=rating2.getComment() %></p>
			                <p><fmt:message key="main.label.rating"/>: <%=rating2.getRating()%></p>
			            </a>
		            </div>
		            <div class="col-lg-4">
			            <a href="FullElective.jsp?ElectiveID=<%=ratingController.getElective(rating3.getElectiveID()).getId()%>" id="recentLink">
			                <% out.write("<h2>" + ratingController.getElective(rating3.getElectiveID()).getName() + "</h2>"); %>
			                <p><fmt:message key="main.label.review"/>: <%=rating3.getComment() %></p>
			                <p><fmt:message key="main.label.rating"/>: <%=rating3.getRating()%></p>
			            </a>
		            </div>
		        </div>
		    </section>		    
		</div> <!-- /.container fluid -->
	</body>
	<script src="js/jquery.easing.min.js"></script>
	<script src="js/grayscale.js"></script>
	<script src="js/bootstrap.min.js"></script>
</html>
