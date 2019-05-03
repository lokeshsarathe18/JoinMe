

<%
	if (session.getAttribute("user_id") == null || request.getParameter("friend_id") == null) {
%>
<jsp:forward page="warning.html"></jsp:forward>
<%
	}
%>


<!DOCTYPE html>
<%@page import="com.sjl.joinme.user_message.UserMessageDAO"%>
<%@page import="com.sjl.joinme.user_message.UserMessageDTO"%>
<%@page import="java.util.ArrayList"%>
<html>
<head>

<meta name="viewport" content="width=device-width, initial-scale=1">
<style>
body {
	background-image: url('img/messageBackground.jpeg');
	margin: 0 auto;
	max-width: 800px;
	padding: 0 20px;
}

.container {
	border: 2px solid #dedede;
	background-color: #ab9ce6ad;
	border-radius: 5px;
	padding: 10px;
	margin: 10px 0;
}

.darker {
	border-color: #ccc;
	background-color: #3f365fcf;
}

.container::after {
	content: "";
	clear: both;
	display: table;
}

.container img {
	float: left;
	max-width: 60px;
	width: 100%;
	margin-right: 20px;
	border-radius: 50%;
}

.container img.right {
	float: right;
	margin-left: 20px;
	margin-right: 0;
}

.time-right {
	float: right;
	color: #aaa;
}

.time-left {
	float: left;
	color: #999;
}
</style>
</head>



<body>

	<nav class="navbar navbar-expand-sm bg-dark navbar-dark fixed-top">
		<div class="container">
			<button class="navbar-toggler" data-toggle="collapse"
				data-target="#navbarCollapse">
				<span class="navbar-toggler-icon"></span>
			</button>

			<a href="home.jsp" class="w3-bar-item w3-right navbar-brand" style="color: white"><img
				class="w3-circle" src="img/joinme.jpg"
				style="width: 50px; margin-right: 5px;">JOIN ME!</a>

		</div>
	</nav>

	<h1 style="color: white;"><%=request.getParameter("friend_id")%></h1>



	<%
		int user_id = (int) Integer.parseInt(session.getAttribute("user_id").toString());
		String friend_id = request.getParameter("friend_id");
		UserMessageDAO udao = new UserMessageDAO();
		System.out.println("Message.jsp " + request.getParameter("friend_id"));
		System.out.println("Message.jsp " + request.getMethod());
		if (request.getMethod().equalsIgnoreCase("post")
				&& (request.getParameter("message_data").toString().length() != 0)) {
			udao.sendUserMessage(user_id, friend_id, request.getParameter("message_data"));
			response.sendRedirect("http://localhost:8080/JoinMe/frontend/f2/redirectToMessage.jsp?friend_id="
					+ request.getParameter("friend_id"));
		}
	%>



	<%
		ArrayList<UserMessageDTO> message = new ArrayList<UserMessageDTO>();
		message = udao.getUserMessageByUniqueID(user_id, friend_id);
		if (message != null)
			for (UserMessageDTO msg : message) {
				if (msg.getSender_id() == user_id) {
	%>
	<div class="container darker">
		<img src="img/users/1 (<%=msg.getSender_id() % 82%>).jpg" alt="Avatar"
			class="right" style="width: 100%;">
		<p>
			<font size="4" color="white"><%=msg.getMessage()%></font>
		</p>
		<span class="time-left" style="color: white"><%=msg.getCreated_datetime()%></span>
	</div>
	<%
		} else {
	%>
	<div class="container">
		<img src="img/users/1 (<%=msg.getSender_id() % 82%>).jpg" alt="Avatar"
			style="width: 100%;">
		<p>
			<font size="4" color="white"><%=msg.getMessage()%></font>
		</p>
		<span class="time-right" style="color: white"><%=msg.getCreated_datetime()%></span>
	</div>


	<%
		}
	%>


	<%
		}
	%>
	<form action="message.jsp" method="post">

		<div class="container">

			<div class="form-group">
				<textarea rows="5.5%" cols="95%"
					class="form-control form-control-lg" name="message_data"
					placeholder="activity Description"></textarea>
			</div>
			<input type="text" name="friend_id" value="<%=friend_id%>" hidden="">
			<input type="submit" name="send_msg" value="send_msg"
				style="float: right">
		</div>


	</form>


</body>
</html>