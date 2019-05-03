<!DOCTYPE html>

<%@page import="java.io.File"%>
<%@page import="java.util.List"%>
<%@page
	import="org.apache.tomcat.util.http.fileupload.servlet.ServletRequestContext"%>
<%@page
	import="org.apache.tomcat.util.http.fileupload.disk.DiskFileItemFactory"%>
<%@page
	import="org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload"%>
<%@page import="org.apache.tomcat.util.http.fileupload.FileItem"%>
<%@page import="com.sjl.joinme.user.UserDAO"%>
<%@page import="com.sjl.joinme.user.UserDTO"%>
<html lang="en">
<%
	if (session.getAttribute("user_id") == null) {
%>
<jsp:forward page="login.jsp"></jsp:forward>

<%
	}
%>
<%
	UserDTO udto = new UserDTO();
	UserDAO udao = new UserDAO();
	udto = udao.getUser((int) session.getAttribute("user_id"));
%>

<%
	if (request.getMethod().equalsIgnoreCase("post")) {
		try {
			ServletFileUpload sf = new ServletFileUpload(new DiskFileItemFactory());
			List<FileItem> files = sf.parseRequest(new ServletRequestContext(request));

			for (FileItem file : files) {

				String dir = "/home/lokesh/A Projects/JoinMe/WebContent/frontend/f2/img/users/";
				//Remane file to upload
				file.write(new File(dir + file.getName()));
				
				File file1 = new File(dir + file.getName());
		        File newFile = new File(dir + "1 ("+session.getAttribute("user_id")+").jpg");
		        file1.renameTo(newFile);
			}
			//response.getWriter().print("<script>alert('Images uploaded to server')</script>");
		} catch (Exception e) {
			System.out.println("Exception :" + e);
		}
	}
%>

<head>


<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>Edit User Details</title>
<link rel="stylesheet" href="css/w3.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"
	integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO"
	crossorigin="anonymous">
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
	background: url("img/user.jpg") no-repeat;
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


							<div class="col text-center">
								<div class="card">
									<div class="card-body">
										<img src="img/users/1 (<%=udto.getUser_id() %>).jpg"
											alt="img/users/0.jpg" class="img-fluid rounded-circle  mb-3">

										<form action="user_profile.jsp" method="post">
											<input type="text" hidden="" name="user_id"
												value="<%=udto.getUser_id()%>"> <input type="text"
												hidden="" name="mobile_number"
												value="<%=udto.getMobile_number()%>"> <input
												type="text" hidden="" name="coins"
												value="<%=udto.getCoins()%>"> <input type="text"
												hidden="" name="unique_id" value="<%=udto.getUnique_id()%>">

											<input type="text" hidden="" name="password"
												value="<%=udto.getPassword()%>"> <input type="text"
												hidden="" name="created_datetime"
												value="<%=udto.getCreated_datetime()%>"> <input
												type="text" name="lat" class="form-control form-control-lg"
												hidden="" id="lat" placeholder="lat"> <input
												type="text" name="lng" class="form-control form-control-lg"
												id="lng" hidden="" placeholder="lng">


											<div class="p-4">
												<P>
													<font size="6.5"> Rating : <%=udto.getRating()%>
													</font>
												</p>
												<h4 class="text-sm-left">
													first name : <input type="text"
														placeholder="<%=udto.getFirst_name()%>" name="first_name"
														value="<%=udto.getFirst_name()%>"> <br> <br>last
													name : <input type="text"
														placeholder="<%=udto.getLast_name()%>" name="last_name"
														value="<%=udto.getLast_name()%>">
													<div class="form-group">
														<br>date of birth<input type="date"
															class="form-control form-control-lg" name="date_of_birth"
															placeholder="<%=udto.getDate_of_birth()%>"
															value="<%=udto.getDate_of_birth()%>">
													</div>
												</h4>
												<h4 class="text-sm-left">
													<br> Email : <input type="email"
														placeholder="<%=udto.getEmail()%>" name="email"
														value="<%=udto.getEmail()%>">
												</h4>
												<h4 class="text-sm-left">
													<br> Gender :<br> <input type="radio"
														name="gender" <%if (udto.getGender() == 'm') {%>
														checked="checked" <%}%> value="m">Male <input
														type="radio" name="gender"
														<%if (udto.getGender() == 'f') {%> checked="checked" <%}%>
														value="f">Female <input type="radio" name="gender"
														<%if (udto.getGender() == 'o') {%> checked="checked" <%}%>
														value="o">Other
												</h4>
												<br>
												<h4 class="text-sm-left">
													<br>Unique_id :
													<%=udto.getUnique_id()%></h4>
												<h4 class="text-sm-left">
													Mobile_number :
													<%=udto.getMobile_number()%></h4>
												<br>
												<h4 class="text-sm-left">
													About :<br> <input type="text"
														placeholder="<%=udto.getAbout()%>" name="about"
														value="<%=udto.getAbout()%>">
												</h4>
												<br>
												<div class="p-4">
													<input class="btn btn-dark" type="submit"
														name="Submit changes" value="Submit_changes">
												</div>
											</div>
										</form>

										<form method="POST" enctype="multipart/form-data"
											action="user_details_edit.jsp">
											<div class="p-4">
												<label>Select Profile Image: </label> <input type="file"
													name="image"><br />
											</div>
											<div class="p-4">
												<input class="btn btn-dark" type="submit"
													value="Change Image">
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
						<br> <br> <br> <br> <br> <br> <br>
						<br> <br> <br> <br> <br> -->

					</div>
			</div>

			</section>

		</div>
		</div>
	</header>

</body>


<!--set marker/////////////////////////////////////////////////////////////////////////////////////////////-->


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
			zoom : 4, // Set the zoom level manually
			center : haightAshbury,
			mapTypeId : 'terrain'
		});

		// This event listener will call addMarker() when the map is clicked.
		map.addListener('click', function(event) {
			if (markers.length >= 1) {
				deleteMarkers();
			}

			addMarker(event.latLng);
			if (event.latLng.lat() != null && event.latLng.lng() != null) {
				document.getElementById('lat').value =
<%=udto.getLat()%>
	;
				document.getElementById('lng').value =
<%=udto.getLng()%>
	;
			} else {
				document.getElementById('lat').value = event.latLng.lat();
				document.getElementById('lng').value = event.latLng.lng();
			}
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

	function getTags() {
		ajaxReq = new XMLHttpRequest();
		ajaxBranch = new XMLHttpRequest();

		var course = document.getElementById("event").value;

		ajaxBranch.onreadystatechange = showTags;
		ajaxBranch.open("POST", "GetData.jsp?course=" + event, true);
		ajaxBranch.send(null);
	}

	function showTags() {
		if (ajaxBranch.readyState == 4) {
			var data = ajaxBranch.responseText;
			document.getElementById("tag").innerHTML = data;
		}
	}
</script>
<script async defer
	src="https://maps.googleapis.com/maps/api/js?key=AIzaSyACM8WnuDJGroEZCeYCKo16HN8-acMU8J8
&callback=initMap">
	
</script>

<!--/////////////////////////////////////////////////////////////////////////////////////////////-->


</html>

