<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registration Form</title>
    <style>
        /* General Styles */
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
            color: #333;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background-image: linear-gradient(135deg, #0643eb, #FF9300);
          }

        .container {
            background-color: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 400px;
            text-align: center;
        }

        .container h2 {
            color: #3f00b2;
            margin-bottom: 20px;
        }

        .form-group {
            margin-bottom: 15px;
            text-align: left;
        }

        .form-group label {
            font-size: 14px;
            color: #555;
            margin-bottom: 5px;
            display: block;
        }

        .form-group input {
            width: 100%;
            padding: 10px;
            font-size: 14px;
            border: 1px solid #ccc;
            border-radius: 5px;
            outline: none;
            transition: border-color 0.3s ease;
        }

        .form-group input:focus {
            border-color: #6f42c1;
        }

        .form-group input[type="submit"] {
            background-color: #1b217e;
            color: white;
            font-size: 16px;
            border: none;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .form-group input[type="submit"]:hover {
            background-color: #5a36a1;
        }

        .form-group input[type="submit"]:active {
            background-color: #4a2a83;
        }

        p {
            margin-top: 20px;
            font-size: 14px;
        }

        p a {
            color: #4500c3;
            text-decoration: none;
        }

        p a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>

    <div class="container">
        <h2>Registration Form</h2>
        <form onSubmit="checkRegister(event)" method="post">
            <div class="form-group">
                <label for="name">Name:</label>
                <input type="text" name="name" required id="name" placeholder="Enter your name" />
            </div>
            <div class="form-group">
                <label for="password">Password:</label>
                <input type="password" name="password" required id="password" placeholder="Enter your password" />
            </div>
            <div class="form-group">
                <label for="email">Email Id:</label>
                <input type="email" name="email" required id="email" placeholder="Enter your email" />
            </div>
            <div class="form-group">
                <label for="city">City:</label>
                <input type="text" name="city" required id="city" placeholder="Enter your city" />
            </div>
            <div class="form-group">
                <input type="submit" value="Register" />
            </div>
        </form>
        <p>Already have an account? <a href="loginform.jsp">Login here</a>.</p>
    </div>

    <script>
        async function checkRegister(e) {
            e.preventDefault();  // Prevent normal form submission

            // Get form values
            const form = e.target;
            const data = {
                name: form.name.value,
                password: form.password.value,
                email: form.email.value,
                city: form.city.value
            };
            console.log(data);

            // Validate the form data (optional)
            if (!data.name || !data.password || !data.email || !data.city) {
                alert("All fields are required!");
                return;
            }

            try {
                // Send data via Fetch API to the backend
                const response = await fetch('http://localhost:8082/register_login/api1/adventures/register', {
                    method: "POST",  // Specify HTTP method
                    headers: {
                        'Accept': 'application/json',
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify(data)  // Convert data object to JSON string
                });

                const responseData = await response.json();  // Parse the response as JSON

                if (responseData.success) {
                	// ✅ User ID ko session storage me store karein
                    sessionStorage.setItem("userId", responseData.userId);
                    console.log("Stored User ID:", sessionStorage.getItem("userId"));
                	
                    alert("Registration successful!");
                    window.location.href = "loginform.jsp";  // Redirect after success
                } else {
                    alert("Registration failed: " + responseData.message);  // Show error message
                }
            } catch (error) {
                console.log("Error:", error);
                alert("There was an error with your request. Please try again.");
            }
        }
    </script>

</body>
</html>
