<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Manage Adventure</title>
</head>
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
.admin-section {
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
     table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 20px;
    background: white;
    border-radius: 8px;
    overflow: hidden;
}

/* Header Styling */
thead {
    background: #333;
    color: white;
}

/* Table Cells */
th, td {
    padding: 12px;
    text-align: left;
    border-bottom: 1px solid #ddd;
    border-right: 1px solid #ddd; /* Add vertical lines */
}

/* Remove the last column's border */
th:last-child, td:last-child {
    border-right: none;
}

/* Alternate Row Colors */
tbody tr:nth-child(even) {
    background: #f9f9f9;
}

/* Hover Effect */
tbody tr:hover {
    background: #f1f1f1;
    transition: 0.3s;
}
.edit-btn {
  background-color: #28a745;
  color: white;
  padding: 8px 16px;
  text-decoration: none;
  border-radius: 4px;
  transition: background-color 0.3s ;border:none;
}
.delete-btn{
background-color: #dc3545;
color: white;
  padding: 8px 16px;
  text-decoration: none;
  border-radius: 4px;
  transition: background-color 0.3s; border:none;}
</style>
<body>
<header>
<div class="container">
<h1>Manage Adventures - Adventure Map</h1>
</div>
</header>
<section class="admin-section">
    <div class="container">
        <h2>Adventure List</h2>
         <a href="add_adventure.jsp" class="button">Add New Adventure</a>
        <table>
            <thead>
                <tr>    
                    <th>Adventure ID </th>             
                    <th>Adventure Name</th>
                    <th>Category</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody id="adventureTableBody">
                <!-- Data will be inserted here -->
            </tbody>
        </table>
    </div>
</section>
 <footer>
        <div class="container">
            <p>&copy; 2025 Adventure Map. All Rights Reserved.</p>
        </div>
    </footer>
    <script>
    var adminId = <%= session.getAttribute("adminId") %>;
    console.log("Admin ID from session:", adminId);


    if (!adminId) {
        alert(" Admin not logged in. Please log in first.");
        window.location.href = "adminlogin.jsp"; 
    }
    
    async function loadAdventure() {
        try {
            const response = await fetch('http://localhost:8082/register_login/api1/adventures/getAllAdventures',{
                method: "GET",  // GET request
                headers: {
                    'Accept': 'application/json',
                    'Content-Type': 'application/json'
                }
            });

            const adventures = await response.json(); // Parse the JSON response
            console.log("adventure detail",adventures);
            
            const tableBody = document.getElementById("adventureTableBody");
            tableBody.innerHTML = ""; // Clear previous data
            
            adventures.forEach(adventure => {
            	const row =  "<tr>" +
                "<td>" + adventure.adventure_id + "</td>" +
                "<td>" + adventure.adventure_name + "</td>" +
                "<td>" + adventure.category + "</td>" +
                "<td>" +
                "<button class='edit-btn' onclick='editAdventure(" + adventure.adventure_id + ")'>Edit</button> " +
                "<button class='delete-btn' onclick='deleteAdventure(" + adventure.adventure_id + ")'>Delete</button>" +
                "</td>" +
                "</tr>";

      tableBody.innerHTML += row;
            });
        }catch (error) {
            console.error("Error:", error);
            alert("There was an error with your request. Please try again.");
        }
    }
    loadAdventure();
    
    async function editAdventure(adventure_id)
    {
    	alert("Edit Adventure with ID: " + adventure_id);
        // Implement edit functionality here
        window.location.href = "edit_adventure.jsp?adventure_id=" +adventure_id;
    }
    
    async function deleteAdventure(adventure_id)
    {
    	 if (!confirm("Are you sure you want to delete this Adventure?")) {
             return; // User ne cancel kar diya, toh function exit kar do
         }
    	 
    	  try {
              const response = await fetch('http://localhost:8082/register_login/api1/adventures/DeleteAdventure?adventure_id=' +adventure_id, {
                  method: "GET", // GET method use kar rahe hain
                  headers: {
                      'Accept': 'application/json',
                      'Content-Type': 'application/json'
                  }
              });

              // JSON response read karo
              const responseData = await response.json();
              console.log("Response Data:", responseData);

              if (response.ok) {
                  alert("Adventure with ID " + adventure_id + " deleted successfully.");
              } else {
                  alert("Error: " + responseData.error);
              }
          } catch (error) {
              console.error("Error:", error);
              alert("There was an error with your request. Please try again.");
          }

    }
    </script>
</body>
</html>