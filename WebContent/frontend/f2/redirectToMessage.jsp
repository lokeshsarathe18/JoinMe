<%@page import="java.net.HttpURLConnection"%>
<%@page import="java.net.URL"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head><%
System.out.println("redirectToMessage.jsp "+request.getParameter("friend_id"));
System.out.println("redirectToMessage.jsp "+request.getMethod());
response.sendRedirect("http://localhost:8080/JoinMe/frontend/f2/message.jsp?friend_id="+request.getParameter("friend_id"));
%>
 
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

</body>
</html>