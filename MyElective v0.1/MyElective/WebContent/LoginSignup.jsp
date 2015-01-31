<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<link href="css/bootstrap.min.css" rel="stylesheet" type="text/css">
		<link href="css/custom.css" rel="stylesheet" type="text/css">
		<link rel="stylesheet" href="http://yui.yahooapis.com/pure/0.5.0/pure-min.css">
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>MyElective</title>
	</head>
	<body>
		<div class="container-fluid" id="loginSignupContainer">
			<div class="row-fluid" id="signinLoginRow">
				<div class="col-xs-6" id="loginSplit">
				<h2 id="loginHeader">Login</h2>	
					<div class="block">						
						<form class="pure-form pure-form-aligned" action="loginServlet" method="post"> <!-- Login form -->
							<div class="pure-control-group">
								<label for="name">Username</label>
								<input id="name" type="text" class="input" name="user_name" placeholder="username">
							</div>
							<div class="pure-control-group">
								<label for="password">Password</label>
								<input type="password" class="input" name="user_pass" placeholder="password">
							</div>
							<div class="pure-controls">
								<input type="submit" class="pure-button" value="Log In">
							</div>
						</form> <!-- / Login form -->
					</div>
				</div>
				<div class="col-xs-6" id="signUpSplit">
				<h2 id="signUpHeader">Sign Up</h2>
				<div class="block">						
					<form class="pure-form pure-form-aligned" action="signupServlet" method="post"> <!-- Sign up form -->
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
							<input type="submit" class="pure-button" value="Sign up">
						</div>
					</form> <!-- / Sign up form -->
				</div>
				</div>
			</div>
		</div>
	</body>
</html>
