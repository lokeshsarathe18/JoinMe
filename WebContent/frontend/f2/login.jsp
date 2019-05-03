<%@page import="com.sjl.joinme.user.UserDAO"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%!String message = "", checked = " ";%>
<%
	if ("checked".equals(request.getParameter("sign_up_checked"))) {
		checked = "checked";
	}
	if (session.getAttribute("user_id") != null) {
%>
<jsp:forward page="home.jsp"></jsp:forward>
<%
	}
	if ("sign_in".equals(request.getParameter("submit")) && request.getMethod().equalsIgnoreCase("post")) {
		if (new UserDAO().checkUserPassword(request.getParameter("unique_id"),
				request.getParameter("password"))) {
			message = "welcome.jsp";
			System.out.print(message);
			session.setAttribute("user_id", new UserDAO().getUserID(request.getParameter("unique_id")));
			String first_name = (new UserDAO().getUser((int) session.getAttribute("user_id"))).getFirst_name();
			session.setAttribute("first_name", first_name);
%>
<jsp:forward page="home.jsp"></jsp:forward>
<%
	} else {
			message = "user name or password is incorrect";
			out.print("<script>alert('username or password is incorrect')</script>");
		}
	}
	if ("sign_up".equals(request.getParameter("submit")) && request.getMethod().equalsIgnoreCase("post")) {

		UserDAO dao = new UserDAO();
		if (!dao.uniqueIDExist(request.getParameter("unique_id"))
				&& !dao.moblieNumberExist(request.getParameter("mobile_number"))) {
			message = "mobile number and user id is not exist";
			System.out.print(message);
			try {
				if (((String) session.getAttribute("mobile_number"))
						.equals(request.getParameter("mobile_number"))) {
					message = "otp set to null for new number";
					session.setAttribute("otp", null);
				}
			} catch (Exception e) {

			}
			session.setAttribute("mobile_number", request.getParameter("mobile_number"));
			RequestDispatcher rd = request.getRequestDispatcher("sign_up_OTP.jsp");
			rd.forward(request, response);

		} else {
			checked = "checked";
			if (dao.uniqueIDExist(request.getParameter("unique_id"))) {
				message = "username already exist";
			} else if (dao.moblieNumberExist(request.getParameter("mobile_number"))) {
				message = "mobile number already exist";
			}
		}
	}
%>


<%=session.getAttribute("mobile_number")%><br>
<%=session.getAttribute("otp")%><br>
<%=session.getAttribute("user_id")%><br>
<%=session.getAttribute("first_name")%><br>
<%=message%><br>



<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Log-in</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-C	ompatible" content="ie=edge">
<link rel="stylesheet" href="css/form.css">
<style>
body {
	background: url('img/bg-01.jpg') no-repeat;
	background-size: cover;
}
</style>
</head>
<body>
	<div class="login-wrap">
		<div class="login-html">
			<input id="tab-1" type="radio" name="tab" class="sign-in" checked>
			<label for="tab-1" class="tab">Sign In</label> <input id="tab-2"
				type="radio" name="tab" class="sign-up" <%=checked%>> <label
				for="tab-2" class="tab">Sign Up</label>
			<div class="login-form">
				<form action="login.jsp" method="post">
					<div class="sign-in-htm">
						<div class="group">
							<label for="user" class="label"><br>Username</label> <input
								id="user" type="text" name="unique_id" class="input">
						</div>
						<div class="group">
							<label for="pass" class="label">Password</label> <input id="pass"
								type="password" name="password" class="input"
								data-type="password">
						</div>
						<!-- 
						<div class="group">
							<input id="check" type="checkbox" class="check" checked>
							<label for="check"><span class="icon"></span> Keep me
								Signed in</label>
						</div>
						-->
						<br>
						<div class="group">
							<input type="submit" name="submit" class="button" value="sign_in">
						</div>
						<div class="hr"></div>
						<div class="foot-lnk">
							<a href="forget_password_OTP.jsp">Forgot Password?</a>
						</div>
					</div>
				</form>





				<form action="login.jsp" method="post">
					<div class="sign-up-htm">
						<div class="group">
							<label for="user" class="label"><br>First Name</label> <input
								id="user" name="first_name" type="text" class="input" required>
						</div>
						<div class="group">
							<label for="user" class="label">Last Name</label> <input
								id="user" name="last_name" type="text" class="input" required>
						</div>
						<div class="group">
							<label for="user" class="label">Phone Number</label> <input
								id="user" type="text" name="mobile_number" class="input"
								required pattern="[789][0-9]{9}">
						</div>
						<div class="group">
							<label for="pass" class="label">Password</label> <input id="pass"
								type="password" name="password" class="input"
								data-type="password" required pattern="(?=.*\d).{8,}"
								title="Must contain at least one number and at least 8 or more characters">
						</div>

						<div class="group">
							<label for="user" class="label">User Name</label> <input
								id="user" type="text" name="unique_id" class="input" required>
						</div>

						<div class="group">
							<input type="submit" name="submit" class="button" value="sign_up">
						</div>
						<div class="foot-lnk">
							<label for="tab-1">Already a Member?</label>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
</body>
</html>