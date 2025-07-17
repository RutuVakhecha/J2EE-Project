<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login Form</title>
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
 background-image: linear-gradient(135deg, #0643eb, #FF9300);        }

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
            color: #4d04d1;
            text-decoration: none;
        }

        p a:hover {
            text-decoration: underline;
        }

        #error-message {
            color: red;
            font-size: 14px;
            margin-top: 10px;
        }
    </style>
</head>
<body>

    <div class="container">
        <h2>Login Form</h2>
        <form onSubmit="checklogin(event)" method="post">
            <div class="form-group">
                <label for="email">Email Id:</label>
                <input type="email" name="email" required id="email" placeholder="Enter your email" />
            </div>
            <div class="form-group">
                <label for="password">Password:</label>
                <input type="password" name="password" required id="password" placeholder="Enter your password" />
            </div>
            <div class="form-group">
                <input type="submit" value="Login" />
            </div>
        </form>
        <p id="error-message"></p> <!-- Error message will be displayed here -->
        <p>Don't have an account? <a href="register.jsp">Register here</a>.</p>
    </div>

    <script>
    async function checklogin(e) {
        e.preventDefault();  // Prevent form submission

        
        // Clear previous error message
        const errorMessageElement = document.getElementById('error-message');
        errorMessageElement.innerText = '';  // Clear previous error message

        const form = e.target;
        const data = {
            email: form.email.value,
            password: form.password.value,
        };

        // Validate the form data
        if (!data.password || !data.email) {
            errorMessageElement.innerText = "All fields are required!";
            errorMessageElement.style.color = 'red';
            return;
        }

        try {
            const response = await fetch('http://localhost:8082/register_login/api1/adventures/login', {
                method: "POST",
                headers: {
                    'Accept': 'application/json',
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(data)
            });

            const responseData = await response.json();

            // Handle the response
            if (responseData.success) {
                alert("Login successful!");

                // Redirect to map.jsp
                window.location.href = 'Map.jsp';  // This will trigger a redirection to map.jsp.
            } else {
                errorMessageElement.innerText = responseData.message;
                errorMessageElement.style.color = 'red';
            }
        } catch (error) {
            console.log("Error:", error);
            alert("There was an error with your request. Please try again.");
        }

        // Clear form fields after submission
        form.reset();
    }

    </script>

</body>
</html>
