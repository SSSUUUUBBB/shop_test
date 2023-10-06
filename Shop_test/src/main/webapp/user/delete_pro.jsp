<%@page import="shop.dto.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="userDAO" class="shop.dao.UserRepository" />

<%
	User user = new User();
	
	String id = request.getParameter("id");
	
	user.setId(id);
	
	int result = userDAO.delete(id);
	
	if(result > 0){
		session.invalidate();
		response.sendRedirect("complete.jsp?msg=3");
	}else{
		response.sendRedirect("update.jsp");		
	}
%>
