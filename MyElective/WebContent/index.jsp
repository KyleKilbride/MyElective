<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:useBean id="user" class="beans.User" scope="session"></jsp:useBean>
<%
	String s = request.getParameter("newsession");
	if(s != null){
		try
        {
            response.setHeader("Cache-Control","no-cache"); //Forces caches to obtain a new copy of the page from the origin server
            response.setHeader("Cache-Control","no-store"); //Directs caches not to store the page under any circumstance
            response.setDateHeader("Expires", 0); //Causes the proxy cache to see the page as "stale"
            response.setHeader("Pragma","no-cache"); //HTTP 1.0 backward compatibility
            session.setAttribute("user",null);
            //session.invalidate(); //do not think this is necessary -- Kyle K
            response.sendRedirect("index.jsp");
        }
        catch(Exception e)
        {
            System.out.println(e.getMessage());
            System.out.println(e);
        }
	}
%>
<html>
	<head>
		<link href="css/bootstrap.min.css" rel="stylesheet" type="text/css">
		<link href="css/index.css" rel="stylesheet" type="text/css">
        <link rel="stylesheet" href="http://yui.yahooapis.com/pure/0.5.0/pure-min.css">
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>MyElective</title>
	</head>
	<body>
		<div class="container-fluid">
			<div class="row-fluid" id="navBarRow">
				<div class="col-md-12">
					<nav class="navbar navbar-inverse navbar-fixed-top">
					  <div class="container-fluid">
					    <div class="navbar-header">
					      <a class="navbar-brand" href="#">
					        MyElective
					      </a>
					    </div>
					    <ul class="nav navbar-nav">
					    	<li><a href="#">All Electives</a></li>
					    </ul>
					    <form class="navbar-form navbar-right" role="search">
						  <div class="form-group">
						    <input type="text" class="form-control" placeholder="Search">
						  </div>
						  <button type="submit" class="btn btn-default">Submit</button>
						</form>
					    <div id="loginSignupText" ng-app="" ng-controller="loginLogout">
						    <p class="navbar-text navbar-right">
						    	<%if(user.getUsername() == null){%>
							  	<a href="SplashPage.jsp" class="navbar-link" id="loginText">Log In/Sign Up</a>
							  	<%}else{%>${sessionScope.user} <a href="index.jsp" class="navbar-link" id="logoutText" >Logout</a><%}%>
							</p>
						</div>
					  </div>
					</nav>
				</div><!-- /.col-md-12 -->
			</div><!-- /.row-fluid -->
			<div class="row" id="featuredElectivesRow">
				<div class="col-sm-12" id="featuredElectives">
					<h2 id="featuredElectivesHeader">Featured Elective</h2>
                    <a class="btn btn-default" id="featuredViewButton" href="#">View</a>
				</div>
			</div><!-- /.row-fluid -->
			<div class="row" id="recentReviewsRow">
				<div class="row-fluid" id="recentReviewTitle">
					<h2>Recent Reviews</h2>
				</div>
				<div class="col-sm-6" id="recentReview">
					recent review
				</div>
				<div class="col-sm-6" id="recentReview">
					recent review
				</div>
			</div>
		</div> <!-- /.container fluid -->
	</body>
</html>
