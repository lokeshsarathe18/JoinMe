<!DOCTYPE html>
<%@page import="java.util.ArrayList"%>
<%@page import="com.sjl.joinme.activity_message.ActivityMessageDAO"%>
<%@page import="com.sjl.joinme.activity_message.ActivityMessageDTO"%>
<%@page import="com.sjl.joinme.notification.NotificationDAO"%>

<%@page import="java.util.Random"%>
<%@page import="com.sjl.joinme.user.UserDAO"%>
<%@page
	import="com.sjl.joinme.selected_activity_list.SelectedActivityListDAO"%>
<%@page import="com.sjl.joinme.tags.TagsDAO"%>
<%@page
	import="com.sjl.joinme.created_activity_list.CreatedActivityListDAO"%>
<%@page
	import="com.sjl.joinme.created_activity_list.CreatedActivityListDTO"%>
<html lang="en">
<%
	if (session.getAttribute("user_id") == null && request.getParameter("activity_id") == null) {
%>
<jsp:forward page="warning.html"></jsp:forward>
<%
	}
%>
<%!String message = "";%>


<%
	if (request.getMethod().equalsIgnoreCase("post")) {
		if (request.getParameter("activity_details") != null) {
			if (request.getParameter("activity_details").equals("add_activity")) {
				if (!new SelectedActivityListDAO().userIDANDActivityIDExist(
						(int) session.getAttribute("user_id"),
						Integer.parseInt(request.getParameter("activity_id")))) {
					new SelectedActivityListDAO().addSelectedActivityList((int) session.getAttribute("user_id"),
							Integer.parseInt(request.getParameter("activity_id")),
							request.getParameter("feedback_message"));
					message = "activity added";
					NotificationDAO dao = new NotificationDAO();
					dao.addNotification(Integer.parseInt(request.getParameter("creator_id")),
							Integer.parseInt(request.getParameter("activity_id")), "n",
							"someone selected your activity");
				} else {
					message = "already exist";
				}
			}

			if (request.getParameter("activity_details").equals("add_comment")) {

				if (request.getParameter("comment").toString().length() != 0) {
					new ActivityMessageDAO().activityComment(
							Integer.parseInt(request.getParameter("activity_id")),
							Integer.parseInt(session.getAttribute("user_id").toString()),
							request.getParameter("comment"));
					System.out.print("comment added");
				}

			}
		}

		response.sendRedirect(
				"http://localhost:8080/JoinMe/frontend/f2/redirectToActivityDetails.jsp?activity_id="
						+ request.getParameter("activity_id"));
	}
%>

<%
	CreatedActivityListDTO adto = new CreatedActivityListDAO()
			.getCreatedActivityList(Integer.parseInt(request.getParameter("activity_id")));
	new CreatedActivityListDAO().incrementCount(adto.getActivity_id());
%>
<head>
<title>Activity Details</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>Document</title>
<link rel="stylesheet" href="css/w3.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"
	integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO"
	crossorigin="anonymous">
<style>
.containerm {
	border: 2px solid #dedede;
	background-color: #f1f1f1;
	border-radius: 5px;
	padding: 10px;
	margin: 10px 0;
}

.darker {
	border-color: #ccc;
	background-color: #ddd;
}

.containerm::after {
	content: "";
	clear: both;
	display: table;
}

.containerm img {
	float: left;
	max-width: 60px;
	width: 100%;
	margin-right: 20px;
	border-radius: 50%;
}

.containerm img.right {
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
	<style>
* {
	margin: 0;
	padding: 0;
}

body {
	background: #ffffff00;
	color: #ffffff00;
}

#home-section {
	background: url("img/activity.jpg") no-repeat;
	background-size: cover;
	background-attachment: fixed;
	min-height: 1080px;
}

#home-section .dark-overlay {
	background-color: rgba(0, 0, 0, 0);
	min-height: 1080px;
}

#home-section .home-inner {
	padding-top: 150px;
}

#home-section .card-form {
	opacity: 0.0;
}

#home-section .fa {
	color: #008ed6;
	background: #fff;
	padding: 4px;
	border-radius: 5px;
	font-size: 30px;
}

.navbar {
	border-bottom: #008ed6 3px solid;
	opacity: 0.8;
}

#authors img {
	width: 50%;
	margin-top: -130px;
}

#authors .fa {
	font-size: 25px;
}

#authors .card {
	background: #83899091;
	color: #fff;
}

#authors .card:hover .fa {
	color: #fff;
}
</style>

	<style>
/* Always set the map height explicitly to define the size of the div
       * element that contains the map. */
#map {
	height: 100%;
}
/* Optional: Makes the sample page fill the window. */
html, body {
	height: 100%;
	margin: 0;
	padding: 0;
}
</style>
</head>
<script>
	//(23.25023790227152, 77.47747421264648)

	function initMap() {
		var myLatLng = {
			lat :
<%=adto.getLat()%>
	,
			lng :
<%=adto.getLng()%>
	};
		var map = new google.maps.Map(document.getElementById('map'), {
			zoom : 15,
			center : myLatLng
		});

		var marker = new google.maps.Marker({
			position : myLatLng,
			map : map,
			title : 'Hello World!'
		});

	}
</script>

<script async defer
	src="https://maps.googleapis.com/maps/api/js?key= AIzaSyACM8WnuDJGroEZCeYCKo16HN8-acMU8J8
&callback=initMap">
	
</script>
<body>
	<nav class="navbar navbar-expand-sm bg-dark navbar-dark fixed-top">
		<div class="container">
			<button class="navbar-toggler" data-toggle="collapse"
				data-target="#navbarCollapse">
				<span class="navbar-toggler-icon"></span>
			</button>

			<a href="home.jsp" class="w3-bar-item w3-right navbar-brand"><img
				class="w3-circle" src="img/joinme.jpg"
				style="width: 50px; margin-right: 5px;">JOIN ME!</a>

		</div>
	</nav>

	<!-- HOme section -->

	<header id="home-section">
		<div class="dark-overlay">
			<div class="home-inner">
				<!-- HEADINGGG -->
				<h5 class="display-4 text-center" style="margin-bottom: 130px;">
					<strong> Activity !</strong>
				</h5>
				<!-- Authoree details -->

				<section id="authors" class="my-5 text-center">
					<div class="container">
						<div class="row">
							<!--  cost,count,status; -->
							<div class="col text-center">
								<div class="card">
									<div class="card-body">
										<div class="p-4">
											<img src="img/activity/<%=adto.getActivity_id()%>.jpg" alt=""
												class="img-fluid rounded-circle w-50 mb-3">
											<%
												if (adto.getStatus() == 'a') {
											%>

											<h3 style="color: yellow; font: 200%">Assured</h3>
											<%
												}
											%>
											<h1><%=adto.getActivity_name()%></h1>
											<%=message%>
										</div>


										<h5 class="text-muted"></h5>
										<p><%=adto.getActivity_description()%></p>
										<h4 class="text-sm-left">
											Created by :<a style="color: white;"
												href="user_details.jsp?show_details=details&friend_id=<%=adto.getUser_id()%>"><%=new UserDAO().getUniqueID(adto.getUser_id())%></a>
										</h4>
										<h4 class="text-sm-left">

											<form action="show_all_activities.jsp" method="post">
												In tag : <input type="hidden" name="show_activities"
													value="view"> <input type="hidden" name="id"
													value="<%=adto.getTag_id()%>"> <input type="submit"
													name="name"
													value="<%=new TagsDAO().getTagDTO(adto.getTag_id()).getTag()%>">
											</form>
										</h4>
										<h4 class="text-sm-left">
											Event date :
											<%=adto.getActivity_date()%></h4>
										<h4 class="text-sm-left">
											Cost :
											<%=adto.getCost()%></h4>




										<%
											if (!new SelectedActivityListDAO().userIDANDActivityIDExist((int) session.getAttribute("user_id"),
													Integer.parseInt(request.getParameter("activity_id")))) {
										%>
										<form action="activity_details.jsp" method="post">
											<div class="p-4">
												<input type="hidden" name="activity_id"
													value=<%=adto.getActivity_id()%>> <input
													type="hidden" name="creator_id"
													value="<%=adto.getUser_id()%>"> <input type="text"
													name="feedback_message"
													class="form-control form-control-lg"
													placeholder="Feedback plz"> <br> <input
													class="btn btn-dark" type="submit" name="activity_details"
													value="add_activity">
											</div>
										</form>
										<%
											}
										%>
										<form action="joined_activity_contact.jsp" method="post">
											<div class="d-flex flex-row justify-content-center">
												<div class="p-4">
													<input type="hidden" name="activity_id"
														value=<%=adto.getActivity_id()%>> <input
														type="hidden" name="name"
														value="<%=adto.getActivity_name()%>"> <input
														class="btn btn-dark" type="submit" name="user_list"
														value="Joined By">
												</div>
											</div>
										</form>




									</div>
								</div>
							</div>


							<div class="col-lg-6">
								<br> <br>
								<div id="map"></div>
								<br> <br> <br> <br> <br> <br> <br>
								<br> <br> <br>
							</div>

						</div>
						<br> <br> <br> <br>
						<form action="activity_details.jsp" method="post">
							<div class="p-4">
								<input type="hidden" name="activity_id"
									value=<%=adto.getActivity_id()%>>
								<!-- <input type="text" name="comment" class="form-control form-control-lg" placeholder="Feedback plz">  -->
								<textarea rows="5.5%" cols="95%"
									class="form-control form-control-lg" name="comment"
									placeholder="activity Description"></textarea>
								<br> <input class="btn btn-dark" type="submit"
									name="activity_details" value="add_comment">
							</div>
						</form>


						<br> <br> <br> <br>

						<%
							ArrayList<ActivityMessageDTO> activityMessageDTOList = new ArrayList<>();

							activityMessageDTOList = new ActivityMessageDAO().getActivityComment(adto.getActivity_id());
							if (activityMessageDTOList != null)
								for (ActivityMessageDTO amdto : activityMessageDTOList) {
						%>


						<div class="col text-center">
							<div class="card">
								<div class="card-body">
									<div class="container">

										<p><%=amdto.getMessage()%></p>
										<span class="time-right"><%=amdto.getUser_id()%></span>
									</div>
								</div>
							</div>
						</div>

						<%
							}
						%>


					</div>
				</section>
			</div>
		</div>
	</header>

</body>
</html>

<%
	//to cleat data of
	message = "";
%>