<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Edit Users</title>
 <style>
        /* admin.css */

        .container {
            max-width: 800px;
            margin: 130px auto;
            padding: 20px;
            background-color: #f9f9f9;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
        }

        form {
            margin-top: 20px;
        }

        .form-group {
            margin-bottom: 15px;
        }

        label {
            display: block;
            font-weight: bold;
            margin-bottom: 5px;
        }

        input[type="text"],
        input[type="email"] {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 16px;
        }

        button {
            padding: 10px 20px;
            background-color: #28a745;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        button:hover {
            background-color: #218838;
        }

        .success-message,
        .error-message {
            padding: 10px;
            margin-bottom: 20px;
            border-radius: 4px;
            font-size: 16px;
        }

        .success-message {
            background-color: #d4edda;
            color: #155724;
        }

        .error-message {
            background-color: #f8d7da;
            color: #721c24;
        }
    </style>
</head>
<body>
<script> 
var adminId = <%= session.getAttribute("adminId") %>;
console.log("Admin ID from session:", adminId);


if (!adminId) {
    alert(" Admin not logged in. Please log in first.");
    window.location.href = "adminlogin.jsp"; 
}

//Get userId from URL parameter
const urlParams = new URLSearchParams(window.location.search);
const userId = urlParams.get('userId');
console.log(userId);


if (!userId) {
    alert("No User ID provided. Redirecting to Manage Users.");
    window.location.href = "manage_users.jsp";
}

async function getUserDetails() {
    try {
        const response = await fetch('http://localhost:8082/register_login/api1/adventures/getUsersById?userId=' + userId, {
            method: "GET",
            headers: {
                'Accept': 'application/json',
                'Content-Type': 'application/json'
            }
        });

        if (!response.ok) {
            throw new Error("Failed to fetch user details");
        }

        const user = await response.json();
        console.log("Fetched User Data:", user);

        // Populate form fields
        document.getElementById("username").value = user.name;
        document.getElementById("email").value = user.email;

    } catch (error) {
        console.error("Error fetching user details:", error);
        alert("Error fetching user details.");
    }
}
getUserDetails();



async function updateUser(event)
{
	const urlParams = new URLSearchParams(window.location.search);
	const userId = urlParams.get("userId");
	
    event.preventDefault(); // Prevent form submission
    
    
    const updatedUser = {
    		userId: userId,
            username: document.getElementById("username").value,
            email: document.getElementById("email").value
        };

    try {
        const response = await fetch('http://localhost:8082/register_login/api1/adventures/updateUsersById?userId=' + userId, {
            method: "POST",
            headers: {
                'Accept': 'application/json',
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(updatedUser)
        });

        const responseData = await response.json();
        console.log("Response Data:", responseData);

        if (response.ok) {
            alert("User updated successfully!");
            window.location.href = "manage_users.jsp"; // Redirect to user list
        } else {
            alert("Error: " + responseData.error);
        }
    } catch (error) {
        console.error("Error:", error);
        alert("There was an error updating the user.");
    }
}

	
</script>
 <div class="container">
        <h1>Edit User</h1>

        <form method="POST" onSubmit="updateUser(event)">
            <div class="form-group">
                <label for="username">Username:</label>
                <input type="text" name="username" id="username" required>
            </div>

            <div class="form-group">
                <label for="email">Email:</label>
                <input type="email" name="email" id="email"  required>
            </div>

            <button type="submit" class="button">Update User</button>
        </form>
    </div>
</body>
</html>