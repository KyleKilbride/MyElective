<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<link href="css/bootstrap.min.css" rel="stylesheet" type="text/css">
		<link href="css/custom.css" rel="stylesheet" type="text/css">
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>MyElective</title>
	</head>
	<body>
		<div class="container-fluid">
			<div class="row-fluid" id="signinLoginRow">
				<div class="col-md-6" id="loginSplit">
					<div>
						<h3 id="loginHeader">Login</h3>
						<form action="loginServlet" method="post">	
							<input type="text" class="input" id="user_name" autocomplete="off" placeholder="Username / Email"></br>
							<input type="text" class="input" id="user_pass" autocomplete="off" placeholder="Password"></br>
							<input type="submit" class="button" value="Log In">
						</form>
					</div>
				</div>
				<div class="col-md-6" id="signUpSplit">
					<div>
						<h3 id="signUpHeader">Sign Up</h3>
						<input type="text" class="input" id="username" autocomplete="off" placeholder="Username"></br>
						<input type="text" class="input" id="first_name" autocomplete="off" placeholder="First Name"></br>
						<input type="text" class="input" id="last_name" autocomplete="off" placeholder="Last Name"></br>
						<input type="text" class="input" id="email_address" autocomplete="off" placeholder="Email"></br>
						<input type="text" class="input" id="program" autocomplete="off" placeholder="Program of Study"></br>
						<input type="text" class="input" id="password" autocomplete="off" placeholder="Password"></br>
						<input type="submit" class="button" value="Sign up">
					</div>
				</div>
			</div>
		</div>
	</body>
</html>