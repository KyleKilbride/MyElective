<%@page import="javax.websocket.Session"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="com.myelective.servlets.LoginServlet" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="language" value="${not empty param.language ? param.language : not empty language ? language : pageContext.request.locale}" scope="session" />
<fmt:setLocale value="${language}" />
<fmt:setBundle basename="com.myelective.resources.text_fr" />

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<% 
	if(session.getAttribute("userStatus")!=null){
		response.sendRedirect("index.jsp");
	}

	if(session.getAttribute("language") ==  "french"){
		%> <fmt:setBundle basename="com.myelective.resources.text_fr" /> <% 
	}else{
		%> <fmt:setBundle basename="com.myelective.resources.text" /> <%
	}

	LoginServlet ls = new LoginServlet();
	
	String error = (String)session.getAttribute("error");
	if(error==null || error=="null"){
		error="";
	}

%>
<html ng-app="ui.bootstrap.demo" 
      xmlns:ui="http://java.sun.com/jsf/facelets"
      xmlns:h="http://java.sun.com/jsf/html"
      xmlns:p="http://primefaces.org/ui"
      xmlns:f="http://xmlns.jcp.org/jsf/core"
      xmlns:c="http://xmlns.jcp.org/jsp/jstl/core">
<head>
	<script type="text/javascript">
	function validate (){
		
		if(document.signupForm.user_pass_signup.value != document.signupForm.user_pass_conf_signup.value){
			document.getElementById("password_error").innerHTML = "<fmt:message key="loginsignup.label.passworderror" />";
			return false;
		}
	}
	</script>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link href="css/bootstrap.min.css" rel="stylesheet" type="text/css">
	<link href="css/grayscale.css" rel="stylesheet" type="text/css">
	<link href="http://fonts.googleapis.com/css?family=Lora:400,700,400italic,700italic" rel="stylesheet" type="text/css">
    <link href="http://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css">
	<link href="css/SplashPage.css" rel="stylesheet" type="text/css">
	<link rel="stylesheet" href="http://yui.yahooapis.com/pure/0.5.0/pure-min.css">
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>MyElective</title>
</head>
	<body>
				<script type="text/ng-template" id="loginModal.html">
        				<div class="modal-header">
        				    <h3 class="modal-title"><fmt:message key="loginsignup.button.login1" /></h3>
        				</div>
        				<div class="modal-body">
        				    <form class="pure-form pure-form-aligned" action="loginServlet" method="post"> 
								<div class="pure-control-group">
									<label for="name"><fmt:message key="loginsignup.label.username" /></label>
									<input id="name" type="text" class="input" name="user_name" placeholder="<fmt:message key="loginsignup.label.username1" />">
								</div>
								<div class="pure-control-group">
									<label for="password"><fmt:message key="loginsignup.label.password" /></label>
									<input type="password" class="input" name="user_pass" placeholder="<fmt:message key="loginsignup.label.password1" />">
								</div>
								<div class="pure-controls">
									<input type="submit" class="pure-button" value="<fmt:message key="loginsignup.button.login1" />" ng-click="ok()">
								</div>
							</form>
      				    </div>
   					 </script>
							<script type="text/ng-template" id="signupModal.html">
						<div class="modal-header">
        				    <h3 class="modal-title">Create Account</h3>
        				</div>
        				<div class="modal-body">
							<form class="pure-form pure-form-aligned" name="signupForm" action="signupServlet" method="post" onsubmit="return validate()"> 
								<div class="pure-control-group">
									<label for="name"><fmt:message key="loginsignup.label.username" /></label>
									<input id="name" type="text" placeholder="<fmt:message key="loginsignup.label.username1" />" name="user_name_signup" required>
								</div>
								<div class="pure-control-group">
									<label for="fName"><fmt:message key="loginsignup.label.fname" /></label>
									<input id="fName" type="text" placeholder="<fmt:message key="loginsignup.label.fname1" />" name="userFirstName" required>
								</div>
								<div class="pure-control-group">
									<label for="lName"><fmt:message key="loginsignup.label.lname" /></label>
									<input id="lName" type="text" placeholder="<fmt:message key="loginsignup.label.lname1" />" name="userLastName" required>
								</div>
								<div class="pure-control-group">
									<label for="email"><fmt:message key="loginsignup.label.email" /></label>
									<input id="email" type="text" placeholder="<fmt:message key="loginsignup.label.email1" />" name="email_signup" required>
								</div>
								<div class="pure-control-group">
									<label for="prog"><fmt:message key="loginsignup.label.pos" /></label>
									<input id="prog" type="text" placeholder="<fmt:message key="loginsignup.label.pos1" />" name="prog_signup" required>
								</div>
								<div class="pure-control-group">
									<label for="password"><fmt:message key="loginsignup.label.password" /></label>
									<input id="password" type="password" placeholder="<fmt:message key="loginsignup.label.password1" />" name="user_pass_signup" required>
								</div>
								<div class="pure-control-group">
									<label for="passwordConfirm"><fmt:message key="loginsignup.label.confirmp" /></label>
									<input id="passwordConfirm" type="password" placeholder="<fmt:message key="loginsignup.label.confirmp1" />" name="user_pass_conf_signup" required><label id="password_error" style="color: red;" />
								</div>
								<div class="pure-controls">
									<input type="submit" class="pure-button" value="<fmt:message key="loginsignup.button.signup" />" > <input type="cancel" class="pure-button" value="<fmt:message key="loginsignup.button.cancel" />" ng-click="ok()">
								</div>
							</form>       				    
      				    </div>					
					</script>
		<div class="container-fluid" id="loginSignupContainer">
			<div class="row-fluid" id="signinLoginRow">
				<div class="col-sm-12">
					<div class="loginCreateButtons">
						<div>
							<span class="logo"><a href="index.jsp">MyElective</a></span>
						</div>
						<div ng-controller="ModalDemoCtrl">
						    <button class="btn btn-default" ng-click="open('md', 1)" id="login"><fmt:message key="loginsignup.button.login" /></button>
						    <button class="btn btn-default" ng-click="open('md', 2)" id="createAccount"><fmt:message key="loginsignup.button.createaccount" /></button>
					    </div> <!-- /modaldemocntrl -->
					</div><!-- /logincreatebuttons -->
					<h2 style="color: red;"><%out.print(error); %></h2>
				</div> <!-- / col-sm-12 -->
			</div><!-- / row fluid -->
		</div><!-- / container-fluid -->
	</body>
	<!--  <script class="cssdeck" src="//cdnjs.cloudflare.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
	<script class="cssdeck" src="//cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/2.3.1/js/bootstrap.min.js"></script> -->
	<script src="//ajax.googleapis.com/ajax/libs/angularjs/1.2.16/angular.js"></script>
    <script src="//angular-ui.github.io/bootstrap/ui-bootstrap-tpls-0.12.0.js"></script>
    <script src="js/main.js"></script>
</html>