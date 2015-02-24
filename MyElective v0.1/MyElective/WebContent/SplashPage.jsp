<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html ng-app="ui.bootstrap.demo">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link href="css/bootstrap.min.css" rel="stylesheet" type="text/css">
	<link href="css/SplashPage.css" rel="stylesheet" type="text/css">
	<link rel="stylesheet" href="http://yui.yahooapis.com/pure/0.5.0/pure-min.css">
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>MyElective</title>
	<title>Insert title here</title>
</head>
	<body>
		<div class="container-fluid" id="loginSignupContainer">
			<div class="row-fluid" id="signinLoginRow">
				<div class="col-sm-12">
					<div class="loginCreateButtons">
						<div>
							<span class="logo"><a href="index.jsp">MyElective</a></span>
						</div>
						<div ng-controller="ModalDemoCtrl">
						    <script type="text/ng-template" id="loginModal.html">
        				<div class="modal-header">
        				    <h3 class="modal-title">Log In</h3>
        				</div>
        				<div class="modal-body">
        				    <form class="pure-form pure-form-aligned" action="loginServlet" method="post"> 
								<div class="pure-control-group">
									<label for="name">Username</label>
									<input id="name" type="text" class="input" name="user_name" placeholder="username">
								</div>
								<div class="pure-control-group">
									<label for="password">Password</label>
									<input type="password" class="input" name="user_pass" placeholder="password">
								</div>
								<div class="pure-controls">
									<input type="submit" class="pure-button" value="Log In" ng-click="ok()">
								</div>
							</form>
      				    </div>
   					 </script>
							<script type="text/ng-template" id="signupModal.html">
						<div class="modal-header">
        				    <h3 class="modal-title">Create Account</h3>
        				</div>
        				<div class="modal-body">
							<form class="pure-form pure-form-aligned" action="signupServlet" method="post"> 
								<div class="pure-control-group">
									<label for="name">Username</label>
									<input id="name" type="text" placeholder="username" name="user_name_signup">
								</div>
								<div class="pure-control-group">
									<label for="fName">First Name</label>
									<input id="fName" type="text" placeholder="first name" name="userFirstName">
								</div>
								<div class="pure-control-group">
									<label for="lName">Last Name</label>
									<input id="lName" type="text" placeholder="last name" name="userLastName">
								</div>
								<div class="pure-control-group">
									<label for="email">E-mail</label>
									<input id="email" type="text" placeholder="e-mail" name="email_signup">
								</div>
								<div class="pure-control-group">
									<label for="prog">Program of Study</label>
									<input id="prog" type="text" placeholder="program of study" name="prog_signup">
								</div>
								<div class="pure-control-group">
									<label for="password">Password</label>
									<input id="password" type="text" placeholder="Password" name="user_pass_signup">
								</div>
								<div class="pure-controls">
									<input type="submit" class="pure-button" value="Sign up" ng-click="ok()">
								</div>
							</form>       				    
      				    </div>					
					</script>
						    <button class="btn btn-default" ng-click="open('md', 1)" id="loginButton">Log In</button>
						    <button class="btn btn-default" ng-click="open('md', 2)" id="signupButton">Create Account</button>
					    </div> <!-- /modaldemocntrl -->
					</div><!-- / logincreatebuttons -->
				</div> <!-- / col-sm-12 -->
			</div><!-- / row fluid -->
		</div><!-- / container-fluid -->
	</body>
	<!-- <script class="cssdeck" src="//cdnjs.cloudflare.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
	<script class="cssdeck" src="//cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/2.3.1/js/bootstrap.min.js"></script> -->
	<script src="//ajax.googleapis.com/ajax/libs/angularjs/1.2.16/angular.js"></script>
    <script src="//angular-ui.github.io/bootstrap/ui-bootstrap-tpls-0.12.0.js"></script>
    <script src="js/main.js"></script>
</html>