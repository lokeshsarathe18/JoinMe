<%@page import="com.sjl.joinme.user.UserDAO"%>
<%@page import="com.sjl.joinme.utility.OTP"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<jsp:useBean id="udto" class="com.sjl.joinme.user.UserDTO"></jsp:useBean>
<jsp:setProperty property="*" name="udto" />
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>Forget Password</title>
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
<%=message%><br>
<%!
	String message="";
%>
<%if((session.getAttribute("mobile_number")==null))
{
	%>
	<jsp:forward page="index.jsp?sign_up_checked=checked"></jsp:forward>
	<%
}
if(request.getMethod().equalsIgnoreCase("post"))
{
	if("sign_up".equals(request.getParameter("submit"))&&session.getAttribute("otp")==null)
	{

		session.setAttribute("otp",(OTP.MessageOTP((String)session.getAttribute("mobile_number"),OTP.RandomOTP(), "")));
		System.out.print(session.getAttribute("otp"));
	}
	
	try
	{
		if("confirm_otp".equals(request.getParameter("otp_form"))&&((session.getAttribute("otp")).toString()).equals(request.getParameter("input_otp")))
		{

		UserDAO dao =new UserDAO();
		dao.addUser(udto);
		session.setAttribute("user_id",dao.getUserID(request.getParameter("unique_id")) );
		session.setAttribute("first_name", udto.getFirst_name());
		session.setAttribute("mobile_number", null);
		session.setAttribute("otp", null);
		%>
		<jsp:forward page="home.jsp"></jsp:forward>
		<%
		}
		else
		{
			message="otp mismatch";
		}
		try{
			if("resend_otp".equals(request.getParameter("otp_form"))/*&&session.getAttribute("otp")==null*timer will make otp null*/)
			{
				RequestDispatcher rd = request.getRequestDispatcher("sign_up_OTP.jsp");
				session.setAttribute("otp",(OTP.MessageOTP(session.getAttribute("mobile_number").toString(), OTP.RandomOTP(), "")));
				message="new otp sended";
				System.out.print(message+""+session.getAttribute("otp"));
			}
		}
		catch(Exception e)
		{	
			System.out.println("+++Exception in sign_up_OTP: " +e);
		}
	}
	catch(Exception e)
	{
		session.setAttribute("mobile_number", null);
	}
}
%>

</style>
</head>
<body>
		<div class="login-wrap">
		<div class="login-html">
			<div class="login-form">
				<input id="tab-1" type="radio" name="tab" class="sign-in" checked>
				<label for="tab-1" class="tab">OTP</label>
				<form action="sign_up_OTP.jsp" method="post">
					<div class="group">
						<label for="user" class="label">OTP</label> 
						<input id="user" name="input_otp" type="text" class="input">
					</div>
					<div class="group">
					<input type="hidden" name="first_name" value=<%=request.getParameter("first_name") %>>
					<input type="hidden" name="last_name" value=<%=request.getParameter("last_name") %>>
					<input type="hidden" name="mobile_number" value=<%=request.getParameter("mobile_number") %>>
					<input type="hidden" name="password" value=<%=request.getParameter("password") %>>
					<input type="hidden" name="unique_id" value=<%=request.getParameter("unique_id") %>>
						
						<input type="submit" name="otp_form" class="button" value="confirm_otp">
					</div>
					<div class="group">
						<input type="submit" name="otp_form" class="button" value="resend_otp"><br>
						<a href="index.jsp?sign_up_checked=checked">create new account</a>
					</div>
				</form>
			</div>
		</div>
	</div>
</body>
</html>