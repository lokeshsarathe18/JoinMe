<!DOCTYPE html>
<%@page import="com.sjl.joinme.activity_images.ActivityImagesDTO"%>
<%@page import="com.sjl.joinme.activity_images.ActivityImagesDAO"%>
<%@page import="java.io.File"%>
<%@page import="org.apache.tomcat.util.http.fileupload.FileItem"%>
<%@page
	import="org.apache.tomcat.util.http.fileupload.disk.DiskFileItemFactory"%>
<%@page
	import="org.apache.tomcat.util.http.fileupload.servlet.ServletRequestContext"%>
<%@page import="java.util.List"%>
<%@page
	import="org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.sjl.joinme.contact.ContactDAO"%>
<%@page import="com.sjl.joinme.tags.TagsDTO"%>
<%@page import="com.sjl.joinme.event.EventDTO"%>
<%@page import="com.sjl.joinme.event.EventDAO"%>
<%@page import="com.sjl.joinme.notification.NotificationDAO"%>
<%@page import="com.sjl.joinme.notification.NotificationDTO"%>
<%@page import="com.sjl.joinme.activity_request.ActivityRequestDAO"%>
<%
	if (session.getAttribute("user_id") == null) {
		response.sendRedirect("index.jsp");
	} else {
%>
<%@page
	import="com.sjl.joinme.created_activity_list.CreatedActivityListDAO"%>
<%@page import="com.sjl.joinme.tags.TagsDAO"%>
<html lang="en">
<%
	if (request.getMethod().equalsIgnoreCase("post")) {
			if ("Create Activity".equals(request.getParameter("add_activity"))
					&& request.getMethod().equalsIgnoreCase("post")) {
%>
<jsp:useBean id="adto"
	class="com.sjl.joinme.created_activity_list.CreatedActivityListDTO"></jsp:useBean>
<jsp:setProperty property="*" name="adto" />
<jsp:useBean id="tdto" class="com.sjl.joinme.tags.TagsDTO"></jsp:useBean>
<jsp:setProperty property="*" name="tdto" />
<%
	//System.out.print(request.getParameter("tag"));
				int tag = Integer.parseInt(request.getParameter("tag"));
				adto.setTag_id(tag);
				new CreatedActivityListDAO().addCreatedActivityList(adto);

				int activity_id = new CreatedActivityListDAO().getActivityID(adto.getActivity_name());

				session.setAttribute("activity_id", activity_id);

				//Send notification to friends for new activity
				ArrayList<Integer> contacts = new ContactDAO()
						.getFriendList((int) session.getAttribute("user_id"));
				if (contacts != null)
					for (int user_id : contacts) {
						new NotificationDAO().addNotification(user_id, activity_id, "n",
								session.getAttribute("first_name") + " created new Activity. Check it!");
					}

				//Send notification if requested activity is created
				if (new ActivityRequestDAO().checkRequestedActivities(adto.getActivity_name())) {
					for (int user_id : new ActivityRequestDAO().getUserID(adto.getActivity_name())) {
						new NotificationDAO().addNotification(user_id, activity_id, "n",
								"Requested activity is avaliable now");
					}
				}

				//out.print("<script>alert('Activity Added. Now Select Images for activity')</script>");

			} else if (session.getAttribute("activity_id") != null) {
				int activity_id = (int) session.getAttribute("activity_id");
				session.removeAttribute("activity_id");
				int count = 0;
				try {
					ServletFileUpload sf = new ServletFileUpload(new DiskFileItemFactory());
					List<FileItem> files = sf.parseRequest(new ServletRequestContext(request));
					ActivityImagesDTO dto = new ActivityImagesDTO();
					dto.setActivity_id(activity_id);
					ActivityImagesDAO dao = new ActivityImagesDAO();
					
					for (FileItem file : files) {
						String dir = "/home/lokesh/A Projects/JoinMe/WebContent/frontend/f2/img/activity/";
						file.write(new File(dir + file.getName()));

						File file1 = new File(dir + file.getName());
						File newFile = new File(dir + activity_id + ".jpg");
						count++;
						file1.renameTo(newFile);

						dto.setImage(newFile.getName());
						dao.addActivityImages(dto);
					}
					//response.getWriter().print("<script>alert('Images uploaded to server')</script>");
					response.sendRedirect("my_activities.jsp");
				} catch (Exception e) {
					System.out.println("Exception :" + e);
				}
			}
		}
%>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>Add New Activity</title>
<link rel="stylesheet" href="css/w3.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"
	integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO"
	crossorigin="anonymous">
<style>
body {
	background: #ffffff00;
	color: #ffffff00;
}

#home-section {
	background: url("img/home.jpg") no-repeat;
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
	opacity: 0.8;
}

#home-section .fa {
	color: #008ed6;
	background: #ffffff00;
	padding: 4px;
	border-radius: 5px;
	font-size: 30px;
}

.navbar {
	border-bottom: #008ed6 3px solid;
	opacity: 0.8;
}
</style>

<!--css for get marker and lat,lug //////////////////////////////////////////////////////////////////// -->


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


<!-- //////////////////////////////////////////////////////////////////// -->
<script>
	function getTags() {
		ajaxEvent = new XMLHttpRequest();

		var events = document.getElementById("events").value;

		ajaxEvent.onreadystatechange = showTags;
		ajaxEvent.open("POST", "getTags.jsp?event=" + events, true);
		ajaxEvent.send(null);
	}

	function showTags() {
		if (ajaxEvent.readyState == 4) {
			var data = ajaxEvent.responseText;
			//console.log(data)
			document.getElementById("tag").innerHTML = data;
		}
	}
</script>
<!-- //////////////////////////////////////////////////////////////////// -->


<!--java  scripts for get marker and lat,lug //////////////////////////////////////////////////////////////////// -->
<script type="text/javascript">
	// In the following example, markers appear when the user clicks on the map.
	// The markers are stored in an array.
	// The user can then click an option to hide, show or delete the markers.
	var map;
	var markers = [];

	function initMap() {
		var haightAshbury = {
			lat : 23.2748308,
			lng : 77.4519248
		};

		map = new google.maps.Map(document.getElementById('map'), {
			zoom : 5, // Set the zoom level manually
			center : haightAshbury,
			mapTypeId : 'terrain'
		});

		// This event listener will call addMarker() when the map is clicked.
		map.addListener('click', function(event) {
			if (markers.length >= 1) {
				deleteMarkers();
			}

			addMarker(event.latLng);
			document.getElementById('lat').value = event.latLng.lat();
			document.getElementById('long').value = event.latLng.lng();
		});
	}

	// Adds a marker to the map and push to the array.
	function addMarker(location) {
		var marker = new google.maps.Marker({
			position : location,
			map : map
		});
		markers.push(marker);
		//alert(location);
	}

	// Sets the map on all markers in the array.
	function setMapOnAll(map) {
		for (var i = 0; i < markers.length; i++) {
			markers[i].setMap(map);
		}
	}

	// Removes the markers from the map, but keeps them in the array.
	function clearMarkers() {
		setMapOnAll(null);
	}

	// Deletes all markers in the array by removing references to them.
	function deleteMarkers() {
		clearMarkers();
		markers = [];
	}
</script>
<script async defer
	src="https://maps.googleapis.com/maps/api/js?key=AIzaSyACM8WnuDJGroEZCeYCKo16HN8-acMU8J8
&callback=initMap">
	
</script>
<!-- //////////////////////////////////////////////////////////////////// -->
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

	<!-- HOME SECTIONNN -->
	<header id="home-section">
		<div class="dark-overlay">
			<div class="home-inner">
				<div class="container">
					<div class="row">
						<div class="col-lg-6">
							<br> <br>
							<div class="card bg-primary text-center card-form">
								<div class="card-body">
									<%
										if (request.getParameter("add_activity") == null) {
									%>
									<form action="add_new_activity.jsp" method="post">
										<h3 style="color: white; font: 300%">Activity Details</h3>
										<p style="color: white; font: 190%">Please fill out this
											form to add activity</p>
										<div class="form-group">
											<br> <select name="events" id="events"
												class="form-control form-control-lg" onchange="getTags()">
												<option value="--------">--------- Select Event for
													Activity ---------</option>

												<%
													ArrayList<EventDTO> al = new EventDAO().getAllEvents();
															if (al != null)
																for (EventDTO dto : al) {
												%>
												<option value="<%=dto.getEvent_name()%>"><%=dto.getEvent_name()%></option>
												<%
													}
												%>
											</select> <br>
										</div>
										<div class="form-group">
											<select name="tag" id="tag"
												class="form-control form-control-lg">
												<option value="--------">--------- Select Tag for
													Activity ---------</option>
											</select> <br>
										</div>
										<div class="form-group">
											<input type="text" class="form-control form-control-lg"
												name="activity_name" placeholder="activity name">
										</div>
										<div class="form-group">
											<textarea class="form-control form-control-lg"
												name="activity_description"
												placeholder="activity Description"></textarea>
										</div>
										<div class="form-group">
											<input type="datetime-local"
												class="form-control form-control-lg" name="activity_date"
												placeholder="dateandtime">
										</div>
										<input type="text" name="lat"
											class="form-control form-control-lg" id="lat"
											placeholder="lat"> <input type="text" name="lng"
											class="form-control form-control-lg" id="long"
											placeholder="lng"> <input type="hidden"
											name="user_id"
											value=<%=(int) session.getAttribute("user_id")%>>
										<div class="form-group">
											<input type="text" class="form-control form-control-lg"
												name="cost" placeholder="cost">
										</div>
										<input type="submit" name="add_activity"
											value="Create Activity"
											class="btn btn-outline-light btn-block">
									</form>
									<br>
									<%
										}
									%>
									<%
										if ("Create Activity".equalsIgnoreCase(request.getParameter("add_activity"))) {
									%>
									<form method="POST" enctype="multipart/form-data"
										action="add_new_activity.jsp">
										<div class="p-4">
											<label style="color: white;">Upload Images for
												Activity: </label> <input class="form-control form-control-lg"
												type="file" name="image"> <br />
										</div>
										<div class="p-4">
											<input class="btn btn-outline-light btn-block" type="submit"
												value="Upload Images">
										</div>
									</form>
									<%
										}
									%>
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
					<br> <br> <br> <br> <br> <br> <br>
					<br> <br> <br> <br> <br>
				</div>
			</div>
		</div>
	</header>
</body>
</html>
<%
	}
%>