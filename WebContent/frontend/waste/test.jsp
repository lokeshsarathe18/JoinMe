<%@page import="com.sjl.joinme.user.UserDTO"%>
<%@page import="com.sjl.joinme.user.UserDAO"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
    	
    
    
    
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>


<%
UserDAO dao= new UserDAO();
UserDTO dto = new UserDTO();

dto.setFirst_name(request.getParameter("first_name"));
dto.setLast_name(request.getParameter("last_name"));
dto.setMobile_number(request.getParameter("mobile_number").trim());
dto.setUnique_id(request.getParameter("unique_id"));
dto.setPassword(request.getParameter("password"));
dao.addUser(dto);
%>

</body>
</html>