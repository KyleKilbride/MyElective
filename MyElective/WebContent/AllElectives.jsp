<%@page import="com.myelective.controllers.RatingController"%>
<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="com.myelective.controllers.*, java.util.ArrayList, beans.*"%>

<!DOCTYPE html>

<!-- PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd" -->
<!-- Authors: Kyle Usherwood, Kyle Kilbride -->
<%

	request.getSession(false);
	//User user = (User) session.getAttribute("user");

	ElectiveController electiveController = new ElectiveController();
	RatingController ratingController = new RatingController();
	//ArrayList ratingArrLst = ratingController.getRecentRating(4);

	session.setAttribute("allElectives", electiveController.getElectiveNames());
	//session.setAttribute("featuredElective", electiveController.getFeaturedElective());
	//session.setAttribute("recentRatingBean1", (Rating) ratingArrLst.get(1));

//	if (user != null) {
//		session.setAttribute("userName", user.getFirstName());
//	}
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
							    <!-- <p class="navbar-text navbar-right"> -->
							    <ul class="nav navbar-nav navbar-right">
							    	<%if(session.getAttribute("userName") == null){
							    		System.out.println("gets in if "+ session.getAttribute("userName"));%>
								  		<li><a href="SplashPage.jsp" class="navbar-link" id="loginText">Log In/Sign Up</a></li>
								  	<%}else if(session.getAttribute("userName") != null){ 
								  		System.out.println("gets in else " + session.getAttribute("userName"));%>
								  		<li><a href="EditUser.jsp">${sessionScope.user.getUsername()}</a></li><li><a href="logoutServlet" class="navbar-link" id="logoutText" >Logout</a></li>
								  	<%}%>
								</ul>  	
								<!-- </p> -->
							</div>
						</div>
					  </div><!-- /.container-fluid -->
					</nav>
				</div>
			<!-- /.col-md-12 -->
			</div>
			<!-- /.row-fluid -->	
		    <section class="container content-section text-center" id="allElectives">
		        <div class="row">
		            <div class="col-lg-8 col-lg-offset-2">
		                <h2 id="allElectivesHeader">All Electives</h2>
		                <script type="text/javascript" id="tableScript" data-electives="${sessionScope.allElectives}">
							allElectives = tableScript.getAttribute("data-electives");
							allElectives = allElectives.substring(1);
							allElectives = allElectives.substring(0,allElectives.length - 4);
							var letters = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"];
							var names = allElectives.split(", ");
							var n = 0;
							var x = 0;
							for(var i = 0; i < letters.length; i++){
								var letter = letters[n];
								if(names[x].charAt(0) === letter){
									document.write("<h1>" + letter + "</h1>");
									while(names[x].charAt(0) === letter){
										document.write("<span>"+names[x++]+"</span><br/>");
									}
								}
								n++;
							}
						 </script> 
		            </div>
		        </div>
		    </section>
		</div>
	<!-- /.container fluid -->
	</body>
	<script src="js/bootstrap.min.js"></script>
</html>
