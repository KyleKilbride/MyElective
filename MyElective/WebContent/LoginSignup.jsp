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
		<div class="container-fluid" id="loginSignupContainer">
			<div class="row-fluid" id="signinLoginRow">
				<div class="col-md-6" id="loginSplit">
				<h2 id="loginHeader">Login</h2>	
					<div class="block">						
						<form action="loginServlet" method="post"> <!-- Login form -->
							<span class="formText">Username or Email</span><input type="text" class="input" name="user_name" autocomplete="off"></br>
							<span class="formText">Password</span><input type="password" class="input" name="user_pass" autocomplete="off"></br>
							<input type="submit" class="button" value="Log In">
						</form> <!-- / Login form -->
					</div>
				</div>
				<div class="col-md-6" id="signUpSplit">
				<h2 id="signUpHeader">Sign Up</h2>
				<div class="block">						
					<form action="signupServlet" method="post"> <!-- Sign up form -->
						<span class="formText">Username</span><input type="text" class="input" name="user_name_signup" autocomplete="off"></br>
						<span class="formText">First Name</span><input type="text" class="input" name="userFirstName" autocomplete="off"></br>
						<span class="formText">Last Name</span><input type="text" class="input" name="userLastName" autocomplete="off"></br>
						<span class="formText">E-mail</span><input type="text" class="input" name="email_signup" autocomplete="off"></br>
						<span class="formText">Program of Study</span><input type="text" class="input" name="prog_signup" autocomplete="off"></br>
						<span class="formText">Password</span><input type="password" class="input" name="user_pass_signup" autocomplete="off"></br>
						<input type="submit" class="button" value="Sign up">
					</form> <!-- / Sign up form -->
				</div>
				</div>
			</div>
		</div>
	</body>
</html>
