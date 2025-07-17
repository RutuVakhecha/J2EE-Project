<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>header</title>
</head>
<style>
#nav-bar {
    position: fixed;
    top: 0;
    width: 97%;
    background-color: #1c202d;
    color: white;
    padding: 10px 20px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    z-index: 20; /* Ensure the nav bar is above the map */
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
}
#nav-bar h1 {
    margin: 0;
    font-size: 24px;
}
#nav-bar .menu {
    display: flex;
    gap: 15px;
}
#nav-bar .menu a {
    color: white;
    text-decoration: none;
    font-size: 16px;
    font-weight: bold;
    padding: 11px 10px;
    border-radius: 5px;
    transition: background-color 0.3s;
}
#nav-bar .menu a:hover {
    color: #ff7f22;
}
#uname {
    margin-top: 10px;
}
#uname a:hover {
    color: #ff7f22; /* Hover effect for username */
}
#logout-link:hover {
    color: #ff7f22; /* Hover effect for logout link */
}
</style>
<body>
<div id="nav-bar">
    <h1>Adventure Map</h1>
    <div class="menu">
        <a href="loginform.jsp">Login</a>
        <a href="register.jsp">Register</a>
        <h4 id="uname">
            Welcome, 
            <% 
                // Get the username from the session
                String username = (String) session.getAttribute("username");
                if (username != null) { 
            %>
               <a href="userdashboard.jsp" 
   style="color:white; text-decoration:none; font-weight: bold;"
   onmouseover="this.style.color='#ff7f22';"
   onmouseout="this.style.color='white';"> 
                    <%= username %>
                </a>
            <% 
                } else { 
                    out.print("Guest"); // Display "Guest" if username is not found
                } 
            %>
            
            <% if (username != null) { %>
             <a href="Logout.jsp" id="logout-link" 
   style="color:white; text-decoration:none; font-weight: bold; margin-left: 10px;"
   onmouseover="this.style.color='#ff7f22';"
   onmouseout="this.style.color='white';">
   Logout
</a>

            <% } %>
        </h4>
    </div>
</div>
</body>
</html>
