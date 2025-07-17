<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    <link rel="stylesheet" href="../assets/css/style.css">
  <style>
  body {
  font-family: Arial, sans-serif;
  background-color: #f4f4f4;
  color: #333;
}
* {
  box-sizing: border-box;
  margin: 0;
  padding: 0;
}
header {
  background: #1c202d;
  color: white;
  padding: 20px 0;
  text-align: center;
}
.container {
  width: 90%;
  max-width: 1200px;
  margin: auto;
  padding: 20px;
}
.auth-section, .admin-section {
  background: white;
  padding: 20px;
  margin: 20px 0;
  border-radius: 8px;
  box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
}
footer {
  text-align: center;
  padding: 10px;
  background: #1c202d;
  color: white;
  position: relative;
  bottom: 0;
  width: 100%;
}
.admin-section h2 {
    color: #1c202d;
    font-size: 24px;
    margin-bottom: 20px;
}

.admin-section ul {
    list-style: none;
    padding: 0;
}

.admin-section ul li {
    margin: 10px 0;
}

.admin-section ul li a {
    display: inline-block;
    padding: 10px 15px;
    width: 200px;
    text-align: center;
    background: #1c202d;
    color: white;
    text-decoration: none;
    font-size: 16px;
    border-radius: 5px;
    transition: 0.3s;
}

.admin-section ul li a:hover {
    background: #ff9300;
}
  </style>
</head>
<body>
    <header>
        <div class="container">
            <h1>Admin Dashboard - Adventure Map</h1>
        </div>
    </header>

    <section class="admin-section">
        <div class="container">
            <h2>Welcome, <span id="adminNamePlaceholder"></span> !</h2>
            <ul>
                <li><a href="manage_adventures.jsp">Manage Adventures</a></li>
                <li><a href="manage_users.jsp">Manage Users</a></li>
                <li><a href="admin_logout.jsp">Logout</a></li>
            </ul>
        </div>
    </section>

    <footer>
        <div class="container">
            <p>&copy; 2025 Adventure Map. All Rights Reserved.</p>
        </div>
    </footer>
 <script>
    var adminId = "<%= session.getAttribute("adminId") != null ? session.getAttribute("adminId") : "" %>";
    console.log("Admin ID from session:", adminId);
    
    var adminName = "<%= session.getAttribute("adminname") != null ? session.getAttribute("adminname") : "" %>";
    document.getElementById("adminNamePlaceholder").innerText = adminName;
    console.log("Admin Name from session:", adminName);
    
    if (!adminId || adminId.trim() === "") {
        window.location.href = 'admins/adminlogin.jsp';
    }

</script>

</body>
</html>