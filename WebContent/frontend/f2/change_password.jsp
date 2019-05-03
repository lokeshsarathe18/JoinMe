<%@page import="com.sjl.joinme.user.UserDAO"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<%
if(session.getAttribute("otp")==null)
{
	%>
	<jsp:forward page="forget_password_OTP.jsp"></jsp:forward>
	<%
}
if("change_password".equals(request.getParameter("change_password"))&&request.getMethod().equalsIgnoreCase("post"))
{
	try
	{
		session.setAttribute("otp", null);
		new UserDAO().changePassword(request.getParameter("mobile_number"), request.getParameter("new_password"));
		%>
		<jsp:forward page="index.jsp"></jsp:forward>
		<%
	}
	catch(Exception e)
	{
		System.out.println(request.getParameter("mobile_number"));
		System.out.println(request.getParameter("new_password"));
	}
}
%>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>Change password</title>
<link rel="stylesheet" href="css/form.css">
<style>
body {
	background: url('img/bg-01.jpg') no-repeat;
	background-size: cover;
}
<%=session.getAttribute("mobile_number") %><br>
<%=session.getAttribute("otp") %><br>
<%=session.getAttribute("user_id") %><br>
<%=session.getAttribute("first_name") %><br>


</style>
</head>
	<body>
		<div class="login-wrap">
			<div class="login-html">
				<div class="login-form">
					<input id="tab-1" type="radio" name="tab" class="sign-in" checked><label
						for="tab-1" class="tab">Forget Password</label>
					<form action="change_password.jsp" method="post">
						<div class="group">
							<label for="user" class="label">new password</label> 
							<input id="user" type="text" name="new_password" value="" class="input">
						</div>
						<div class="group">
							<label for="user" class="label">confirm password</label> 
							<input type="hidden" name="mobile_number" value=<%=request.getParameter("mobile_number") %>>
							<input id="user" type="text" name="confirm_password" value="" class="input">
						</div>
						<div class="group">
							<input type="submit" class="button" name="change_password" value="change_password">
						</div>
					</form>
				</div>
			</div>
		</div>
	</body>
</html>