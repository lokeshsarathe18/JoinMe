<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

</body>
</html>
<%
response.sendRedirect("http://localhost:8080/JoinMe/frontend/f2/activity_details.jsp?activity_id="+request.getParameter("activity_id"));

%>