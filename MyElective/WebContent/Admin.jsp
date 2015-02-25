<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="com.myelective.controllers.*, java.util.ArrayList, beans.*"%>

<!DOCTYPE html>

<!-- PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd" -->
<!-- Authors: Kyle Usherwood, Kyle Kilbride -->
<%
	String s = request.getParameter("newsession");

	if(session.getAttribute("userStatus")!= null || session.getAttribute("userStatus").equals("user")){
		response.sendRedirect("index.jsp");
	}

	if (s != null) {
		try {
			response.setHeader("Cache-Control", "no-cache"); //Forces caches to obtain a new copy of the page from the origin server
			response.setHeader("Cache-Control", "no-store"); //Directs caches not to store the page under any circumstance
			response.setDateHeader("Expires", 0); //Causes the proxy cache to see the page as "stale"
			response.setHeader("Pragma", "no-cache"); //HTTP 1.0 backward compatibility
			session.setAttribute("userName", null);
			session.setAttribute("userStatus", null);
			System.out.println("I got in here s!=null");
			//request.getSession().invalidate(); //session.invalidate(); //do not think this is necessary -- Kyle K
		} catch (Exception e) {
			System.out.println(e.getMessage());
			System.out.println(e);
		}
	} else {
		System.out.println("Here tooooooo");
		request.getSession(false);
		User user = (User) session.getAttribute("user");

		ElectiveController electiveController = new ElectiveController();
		session.setAttribute("allElectives", electiveController.getElectiveNames());

		if (user != null) {
			session.setAttribute("userName", user.getFirstName());
			session.setAttribute("userStatus", user.getStatus());
		}
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
												var names = allElectives.split(", ~, ");
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
		</div><!-- /.container fluid -->
	</body>
	<script src="js/bootstrap.min.js"></script>
</html>
