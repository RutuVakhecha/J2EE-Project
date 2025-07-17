<%@ page import="java.sql.*" %>
<%! public Connection con; %>
<%

try {
    Class.forName("com.mysql.jdbc.Driver");
    con = DriverManager.getConnection("jdbc:mysql://localhost/emp_data", "root", "");
    System.out.println("Driver Connected..");
} catch (Exception e) {
    e.printStackTrace();  // Better error handling
}
%>
