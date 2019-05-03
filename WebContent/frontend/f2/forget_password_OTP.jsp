<%@page import="com.sjl.joinme.utility.OTP"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>Forget Password</title>
<link rel="stylesheet" href="css/form.css">
<style>
<%!
String message="";
%>
<%
if(request.getMethod().equalsIgnoreCase("post")){
	try
	{
		if("send".equals(request.getParameter("forget_password"))&&session.getAttribute("otp")==null)
		{
		   	session.setAttribute("mobile_number",request.getParameter("mobile_number"));
			session.setAttribute("otp",/*(OTP.MessageOTP(request.getParameter("mobile_number"), */OTP.RandomOTP()/*, ""))*/);
			System.out.println(session.getAttribute("otp"));
		}
	}catch(Exception e)
	{
		message="unable to send otp";
		System.out.println(message);
	}
	try{
		if("resend_otp".equals(request.getParameter("otp_form"))/*&&session.getAttribute("otp")==null*timer will make otp null*/)
		{
			session.setAttribute("otp",/*(OTP.MessageOTP(session.getAttribute("mobile_number").toString(), */OTP.RandomOTP()/*, ""))*/);
			System.out.println(session.getAttribute("otp"));
		}
	}catch(Exception e){
		
	}
	if("reenter_mobile_number".equals(request.getParameter("otp_form")))
	{
		session.setAttribute("mobile_number",null);
		session.setAttribute("otp",null);
	}
	try{
		if("confirm_otp".equals(request.getParameter("otp_form"))&&((session.getAttribute("otp")).toString()).equals(request.getParameter("input_otp")))
		{

			session.setAttribute("mobile_number", null);
			RequestDispatcher rd = request.getRequestDispatcher("change_password.jsp");
			rd.forward(request, response);
			
		}

	}catch(Exception e)
	{
		message="mismatch otp";
		System.out.println(message);
	}
}
%>
body {
	background: url('img/bg-01.jpg') no-repeat;
	background-size: cover;
}
</style>
</head>
<body>

<%=session.getAttribute("mobile_number") %><br>
<%=session.getAttribute("otp") %><br>
<%=session.getAttribute("user_id") %><br>
<%=session.getAttribute("first_name") %><br>


<%
if(session.getAttribute("OTP")==null&&session.getAttribute("mobile_number")==null){
%>

	<div class="login-wrap">
		<div class="login-html">
			<div class="login-form">
				<input id="tab-1" type="radio" name="tab" class="sign-in" checked>
				<label for="tab-1" class="tab">Forget Password</label>
				<form action="forget_password_OTP.jsp" method="post">
					<div class="group">
						<label for="user" class="label">Phone number</label> 
						<input id="user" name="mobile_number" type="text" class="input">
					</div>
					<div class="group">
						<input type="submit" name="forget_password" class="button" value="send">
					</div>
				</form>
			</div>
		</div>
	</div>

<%}else if(session.getAttribute("otp")!=null){
 %>


		<div class="login-wrap">
		<div class="login-html">
			<div class="login-form">
				<input id="tab-1" type="radio" name="tab" class="sign-in" checked>
				<label for="tab-1" class="tab">OTP</label>
				<form action="forget_password_OTP.jsp" method="post">
					<div class="group">
						<label for="user" class="label">OTP</label> 
						<input id="user" name="input_otp" type="text" class="input">
					</div>
					<div class="group">
					<input type="hidden" name="mobile_number" value=<%=session.getAttribute("mobile_number") %>>
						<input type="submit" name="otp_form" class="button" value="confirm_otp">
					</div>
					<div class="group">
						<input type="submit" name="otp_form" class="button" value="reenter_mobile_number">
					</div>
					<div class="group">
						<input type="submit" name="otp_form" class="button" value="resend_otp">
					</div>
				</form>
			</div>
		</div>
	</div>
<%}
else
{
	session.setAttribute("otp", null);
	session.setAttribute("mobile_number", null);
} %>

</body>
</html>