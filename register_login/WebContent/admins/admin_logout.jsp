<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%
    // ✅ Session invalidate karna (logout)
    session.invalidate();

    // ✅ Redirect to login page
    response.sendRedirect("adminlogin.jsp");
%>
