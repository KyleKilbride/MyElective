<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<link href="css/bootstrap.min.css" rel="stylesheet" type="text/css">
		<link href="css/index.css" rel="stylesheet" type="text/css">
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>MyElective</title>
	</head>
	<body>
		<div class="container-fluid">
			<div class="row-fluid">
				<div class="col-md-12">
					<nav class="navbar navbar-inverse navbar-fixed-top">
					  <div class="container-fluid">
					    <div class="navbar-header">
					      <a class="navbar-brand" href="#">
					        MyElective
					      </a>
					    </div>
					    <div id="loginSignupText" ng-app="" ng-controller="loginLogout">
						    <p class="navbar-text navbar-right">
							  	<a href="SplashPage.jsp" class="navbar-link" ng-show="$scope.loggedOut">Log In/Sign Up</a>
							  	<a href="index.jsp" class="navbar-link" ng-show="!$scope.loggedOut">Logout</a>
							</p>
						</div>
					  </div>
					</nav>
				</div><!-- /.col-md-12 -->
			</div><!-- /.row-fluid -->
			<div class="row-fluid" id="sidebarDashboardRow">
				<div class="col-sm-2">
					this
				</div>
				<div class="col-sm-10">
					that
				</div>
			</div><!-- /.row-fluid -->
		</div> <!-- /.container fluid -->
	</body>
</html>
