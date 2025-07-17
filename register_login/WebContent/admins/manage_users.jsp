<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>Manage Users</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            color: #333;
            margin: 0;
            padding: 0;
        }
* {
  box-sizing: border-box;
  margin: 0;
  padding: 0;

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

        h2 {
            text-align: center;
            color: #444;
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
/* Buttons Styling */
.edit-btn, .delete-btn {
    padding: 8px 12px;
    border: none;
    cursor: pointer;
    margin: 2px;
    border-radius: 5px;
    font-size: 14px;
}

.edit-btn {
    background-color: #4CAF50; /* Green */
    color: white;
}

.delete-btn {
    background-color: #f44336; /* Red */
    color: white;
}

.edit-btn:hover {
    background-color: #45a049;
}

.delete-btn:hover {
    background-color: #d32f2f;
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
    </style>
</head>
<body>

<header>
    <div class="container">
        <h1>Manage Users - Adventure Map</h1>
    </div>
</header>

<section class="admin-section">
    <div class="container">
        <h2>Users List</h2>
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>City</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody id="userTableBody">
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

    async function getUsersList() {
        try {
            const response = await fetch('http://localhost:8082/register_login/api1/adventures/getUsers', {
                method: "GET",
                headers: {
                    'Accept': 'application/json',
                    'Content-Type': 'application/json'
                }
            });

            // Get the JSON response
            const responseData = await response.json();
            console.log("Response Data:", responseData);

            // Check if responseData is an array
            if (Array.isArray(responseData) && responseData.length > 0) {
                populateTable(responseData);
            } else {
                alert("Failed to fetch users. No data received.");
            }
        } catch (error) {
            console.error("Error:", error);
            alert("There was an error with your request. Please try again.");
        }
    }

    getUsersList();

    function populateTable(users) {
        const tableBody = document.getElementById("userTableBody");
        tableBody.innerHTML = ""; // Clear previous data

        users.forEach(user => {
            var row = "<tr>" +
                      "<td>" + user.id + "</td>" +
                      "<td>" + user.name + "</td>" +
                      "<td>" + user.email + "</td>" +
                      "<td>" + user.city + "</td>" +
                      "<td>" +
                      "<button class='edit-btn' onclick='editUser(" + user.id + ")'>Edit</button> " +
                      "<button class='delete-btn' onclick='deleteUser(" + user.id + ")'>Delete</button>" +
                      "</td>" +
                      "</tr>";

            tableBody.innerHTML += row;
        });
    }
    async function editUser(userId) {
        alert("Edit user with ID: " + userId);
        // Implement edit functionality here
        window.location.href = "edit_users.jsp?userId=" +userId;
    }

    async function deleteUser(userId) {
        if (!confirm("Are you sure you want to delete this user?")) {
            return; // User ne cancel kar diya, toh function exit kar do
        }

        try {
            const response = await fetch('http://localhost:8082/register_login/api1/adventures/DeleteUsers?userId=' +userId, {
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
                alert("User with ID " + userId + " deleted successfully.");
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
