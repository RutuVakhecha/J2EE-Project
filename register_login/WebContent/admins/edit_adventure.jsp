<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Edit Adventure</title>
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
            margin-bottom: 10px;
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
<script>
var adminId = <%= session.getAttribute("adminId") %>;
console.log("Admin ID from session:", adminId);


if (!adminId) {
    alert(" Admin not logged in. Please log in first.");
    window.location.href = "adminlogin.jsp"; 
}

//Get userId from URL parameter
const urlParams = new URLSearchParams(window.location.search);
const adventure_id = urlParams.get('adventure_id');
console.log(adventure_id);


if (!adventure_id) {
    alert("No Adventure ID provided. Redirecting to Manage Adventures.");
    window.location.href = "manage_adventures.jsp";
}
    

 async function getAdventureDetails() {
        try {
            const response = await fetch('http://localhost:8082/register_login/api1/adventures/getAdventureById?adventure_id=' + adventure_id,{
                method: "GET",
                headers: {
                    'Accept': 'application/json',
                    'Content-Type': 'application/json'
                }
            });

            if (!response.ok) {
                throw new Error("Failed to fetch user details");
            }

            const adventure = await response.json();
            console.log("Fetched Adventure Data:", adventure);

            // Populate form fields
            document.getElementById("adventure-name").value = adventure.adventure_name;
            document.getElementById("category").value = adventure.category;
            document.getElementById("x-coordinate").value = adventure["xcoordinate"];
            document.getElementById("y-coordinate").value = adventure["ycoordinate"];
            document.getElementById("description").value = adventure["description"];
 


        } catch (error) {
            console.error("Error fetching Adventure details:", error);
            alert("Error fetching Adventure details.");
        }
    }
getAdventureDetails();

async function updateAdventure(event) {
    const urlParams = new URLSearchParams(window.location.search);
    const adventure_id = urlParams.get("adventure_id");

    event.preventDefault(); // Prevent form submission

    const updatedUser = {
        adventure_id: adventure_id,
        "adventure_name": document.getElementById("adventure-name").value, // Use quotes
        "category": document.getElementById("category").value,
        "x-coordinate": document.getElementById("x-coordinate").value, // Use quotes
        "y-coordinate": document.getElementById("y-coordinate").value, // Use quotes
        "description": document.getElementById("description").value
    };

    try {
        const response = await fetch('http://localhost:8082/register_login/api1/adventures/updateAdventureById?adventure_id=' +adventure_id, {
            method: "POST",
            headers: { // Fixed: headers object should be inside the request object
                'Accept': 'application/json',
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(updatedUser)
        });

        const responseData = await response.json();
        console.log("Response Data:", responseData);

        if (response.ok) {
            alert("Adventure updated successfully!");
            window.location.href = "manage_adventures.jsp"; // Redirect to user list
        } else {
            alert("Error: " + responseData.error);
        }
    } catch (error) {
        console.error("Error:", error);
        alert("There was an error updating the Adventure.");
    }
}

</script>
<body>
<div class="container">
        <h1>Edit Adventure</h1>

        <form method="POST" onSubmit="updateAdventure(event)">
            <div class="form-group">
                <label for="adventure-name">Adventure Name:</label>
                <input type="text" name="adventure_name" id="adventure-name" required>
            </div>

            <div class="form-group">
                <label for="category">Category</label>
                <input type="text" name="category" id="category"  required>
                
                <label for="x-coordinate">X Coordinate</label>
                <input type="text" name="x-coordinate" id="x-coordinate" required>
                
                 <label for="y-coordinate">Y Coordinate</label>
                <input type="text" name="y-coordinate"  id="y-coordinate" required>
                
                 <label for="description">Description</label>
                <input type="text" name="description"  id="description" required>
            </div>

            <button type="submit" class="button">Update Adventure</button>
        </form>
    </div>
</body>
</html>