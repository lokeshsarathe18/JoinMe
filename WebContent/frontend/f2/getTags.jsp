<%@page import="java.util.Set"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.sjl.joinme.tags.TagsDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.sjl.joinme.tags.TagsDAO"%>
<%
	if (request.getMethod().equalsIgnoreCase("post")) {
		String event = request.getParameter("event");
		//System.out.println(event);
		HashMap<String, Integer> map = new TagsDAO().getTagsByEvent(event);
		//System.out.println(map);
		if (map != null) {
			Set keys = map.keySet();
			for (Object tag : keys) {
				out.println("<option id='tag' value=" + map.get(tag) + ">" + tag + "</option>");
				//System.out.println(tag);
			}
		}
	}
%>