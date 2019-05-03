<!DOCTYPE html>
<%@page import="com.sjl.joinme.contact.ContactDAO"%>
<%@page import="com.sjl.joinme.notification.NotificationDAO"%>
<%@page
	import="com.sjl.joinme.selected_activity_list.SelectedActivityListDAO"%>
<%@page
	import="com.sjl.joinme.created_activity_list.CreatedActivityListDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page
	import="com.sjl.joinme.created_activity_list.CreatedActivityListDTO"%>
<%
	if (session.getAttribute("user_id") == null) {
%>
<jsp:forward page="index.jsp"></jsp:forward>
<%
	}
	if (request.getMethod().equalsIgnoreCase("post")) {
		if (request.getParameter("delete") != null) {
			new CreatedActivityListDAO().deleteActivity(Integer.parseInt(request.getParameter("activity_id")));
		} else if (request.getParameter("share") != null) {
			int activity_id = Integer.parseInt(request.getParameter("activity_id"));
			ArrayList<Integer> contacts = new ContactDAO()
					.getContactList((int) session.getAttribute("user_id"));
			if (contacts != null) {
				for (int user_id : contacts) {
					new NotificationDAO().addNotification(user_id, activity_id, "n",
							session.getAttribute("first_name") + " shared this Activity. Check it!");
				}
				out.print("<script>alert('Activity Shared with Friends')</script>");
			}
		}
	}
%>
<html>
<title>my_activities</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="css/w3.css">

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link href="https://fonts.googleapis.com/css?family=Acme"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"
	integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO"
	crossorigin="anonymous">
<style>
html, body, h1, h2, h3, h4, h5 {
	font-family: 'Acme', sans-serif;
}

#authors img {
	margin-top: -50px;
}

#authors .fa {
	font-size: 25px;
}

#authors .card:hover {
	background: #3292a6;
	color: #fff;
}

#authors .card:hover .fa {
	color: #fff;
}
</style>
<body class="w3-light-grey">

	<!-- Top container -->
	<div class="w3-bar w3-top w3-black w3-large bg-dark" style="z-index: 4">
		<button
			class="w3-bar-item w3-button w3-hide-large w3-hover-none w3-hover-text-light-grey"
			onclick="w3_open();">
			<i class="fa fa-bars"></i> Menu
		</button>
		<span class="w3-bar-item w3-right"><a href="home.jsp"
			style="color: white"><img class="w3-circle" src="img/joinme.jpg"
				style="width: 50px;"> JOIN ME!</a></span>
		<%
			int count = new NotificationDAO().getNotificationCount((int) session.getAttribute("user_id"));
			if (count > 0) {
		%>
		<span class="w3-bar-item w3-right"><a href="notification.jsp"><img
				class="w3-circle" src="img/noti.png" style="width: 50px;"></a><%=count%></span>
		<%
			} else {
		%>
		<span class="w3-bar-item w3-right"><a href="notification.jsp"><img
				class="w3-circle" src="img/notification.png" style="width: 50px;"></a></span>
		<%
			}
		%>
	</div>

	<!-- Sidebar/menu -->
	<nav
		class="bg-dark text-light w3-sidebar w3-collapse w3-white w3-animate-left"
		style="z-index: 3; width: 300px;" id="mySidebar">
		<br>
		<div class="w3-container w3-row">
			<a href="user_profile.jsp" style="color: white">
				<div class="w3-col s4">
					<img
						src="img/users/1 (<%=(int) session.getAttribute("user_id") % 82%>).jpg"
						class="w3-circle w3-margin-right" style="width: 55px">
				</div>
				<div class="w3-col s8 w3-bar">
					<span>Welcome,<br> <%=session.getAttribute("first_name")%></span><br>
				</div>
			</a>
		</div>
		<hr>

		<div class="w3-bar-block ">
			<a href="#"
				class="w3-bar-item w3-button w3-padding-16 w3-hide-large w3-dark-grey w3-hover-black"
				onclick="w3_close()" title="close menu"><i
				class="fas fa-user-alt"></i>Close Menu</a> <a href="home.jsp"
				class="w3-bar-item w3-button w3-padding"><i
				class="fa fa-users fa-fw"></i>Home</a> <a href="my_activities.jsp"
				class="w3-bar-item w3-button w3-padding w3-blue"><i
				class="fa fa-user fa-fw"></i> My Activities</a> <a
				href="selected_activities.jsp"
				class="w3-bar-item w3-button w3-padding  "><i
				class="fa fa-eye fa-fw"></i>Selected Activities</a> <a href="event.jsp"
				class="w3-bar-item w3-button w3-padding"><i
				class="fa fa-search fa-fw"></i>Explore Event</a> <a href="contacts.jsp"
				class="w3-bar-item w3-button w3-padding"><i
				class="fa fa-users fa-fw"></i>My Contacts</a> <a
				href="activity_request.jsp" class="w3-bar-item w3-button w3-padding"><i
				class="fa fa-users fa-fw"></i>Request Activity</a> <a href="logout.jsp"
				class="w3-bar-item w3-button w3-padding"><i
				class="fa fa-users fa-fw"></i>Logout</a>
		</div>
	</nav>


	<!-- Overlay effect when opening sidebar on small screens -->
	<div class="w3-overlay w3-hide-large w3-animate-opacity"
		onclick="w3_close()" style="cursor: pointer" title="close side menu"
		id="myOverlay"></div>

	<!-- !PAGE CONTENT! -->
	<div class="w3-main" style="margin-left: 300px; margin-top: 60px;">

		<!-- Header -->
		<section id="authors" class="my-5 text-center">
			<div class="container">
				<div class="row">
					<div class="col">

						<div class="info-header mb-5">
							<!-- <br> <br> <img src="img/subscribe.jpg">-->
							<h1 class="text-primary mt-5 pb-3">My Activities</h1>
							<p class="lead pb-3">Here goes the list of activities created
								by you.....</p>
						</div>

						<!-- ADD ACTIVITY BUTTONS -->
						<div class="text-center">
							<a class="btn btn-primary btn-lg text-light"
								href="add_new_activity.jsp" role="button">Add New Activity</a>
						</div>
						<!-- ADD ACTIVITY BUTTONS ENDS-->
						<br> <br> <br>
					</div>
				</div>
				<div class="row">

					<%
						ArrayList<CreatedActivityListDTO> alADTO = new ArrayList<>();
						alADTO = new CreatedActivityListDAO()
								.getAllCreatedActivityListWithuserID((int) session.getAttribute("user_id"));
						if (alADTO != null) {
							SelectedActivityListDAO adao = new SelectedActivityListDAO();
							for (CreatedActivityListDTO adto : alADTO) {
					%>

					<div class="col-lg-3 col-md-6">
						<div class="card">
							<div class="card-body">
								<form action="activity_details.jsp" method="post">
									<img src="img/activity/<%=adto.getActivity_id()%>.jpg" alt=""
										class="img-fluid rounded-circle w-50 mb-3">
									<%
										if (adto.getStatus() == 'a') {
									%>
									Assured
									<%
										}
									%>

									<h3><%=adto.getActivity_name()%></h3>
									<h6>
										Joined By :
										<%=adao.getAllSelectedActivityListCountWithActivityID(adto.getActivity_id())%></h6>
									<div class="d-flex flex-row justify-content-center">
										<div class="p-4">
											<input type="hidden" name="activity_id"
												value=<%=adto.getActivity_id()%>> <input
												class="btn btn-dark" type="submit" name="show_details"
												value="details">
										</div>
									</div>
								</form>

								<form action="selected_activities.jsp" method="post">
									<div class="d-flex flex-row justify-content-center">
										<div class="p-4">
											<input type="hidden" name="activity_id"
												value=<%=adto.getActivity_id()%>><input
												class="btn btn-dark" type="submit" name="share"
												value="Share with friends">
										</div>
									</div>
								</form>

								<form action="my_activities.jsp" method="post">
									<div class="d-flex flex-row justify-content-center">
										<div class="p-4">
											<input type="hidden" name="activity_id"
												value=<%=adto.getActivity_id()%>> <input
												type="hidden" name="name"
												value="<%=adto.getActivity_name()%>"> <input
												class="btn btn-dark" type="submit" name="delete"
												value="delete">
										</div>
									</div>
								</form>
							</div>
						</div>
					</div>
					<%
						}
						} else {
							out.print("No activity is created by you.....");
						}
					%>

				</div>
			</div>
		</section>


		<!-- Footer -->
		<footer class="w3-container w3-padding-16 w3-light-grey">
			<h4></h4>

		</footer>

		<!-- End page content -->
	</div>

	<script>
		// Get the Sidebar
		var mySidebar = document.getElementById("mySidebar");

		// Get the DIV with overlay effect
		var overlayBg = document.getElementById("myOverlay");

		// Toggle between showing and hiding the sidebar, and add overlay effect
		function w3_open() {
			if (mySidebar.style.display === 'block') {
				mySidebar.style.display = 'none';
				overlayBg.style.display = "none";
			} else {
				mySidebar.style.display = 'block';
				overlayBg.style.display = "block";
			}
		}

		// Close the sidebar with the close button
		function w3_close() {
			mySidebar.style.display = "none";
			overlayBg.style.display = "none";
		}
	</script>
	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
		integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
		crossorigin="anonymous"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"
		integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49"
		crossorigin="anonymous"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"
		integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy"
		crossorigin="anonymous"></script>
</body>
</html>