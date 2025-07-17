<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Admin Login</title>
<style>
body {
    font-family: Arial, sans-serif;
    background-color: #f4f4f4;
    color: #333;
}
header {
    background: #1c202d;
    color: white;
    padding: 20px 0;
    text-align: center;
}
.auth-section {
    background: white;
    padding: 20px;
    margin: 20px auto;
    border-radius: 8px;
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
    width: 50%;
}
.container {
    width: 90%;
    max-width: 1200px;
    margin: auto;
    padding: 20px;
}
.form-group {
    margin-bottom: 15px;
}
label {
    display: block;
    margin-bottom: 5px;
    font-weight: bold;
}
input[type="email"], input[type="password"] {
    width: 100%;
    padding: 10px;
    border: 1px solid #ccc;
    border-radius: 4px;
}
button {
    background: #1c202d;
    color: white;
    padding: 10px 15px;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    font-size: 16px;
    width: 100%;
}
#error-message {
    color: red;
    font-size: 14px;
    margin-top: 10px;
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
* {
  box-sizing: border-box;
  margin: 0;
  padding: 0;
}
</style>
</head>
<body>
<header>
    <div class="container">
        <h1>Admin Login - Adventure Map</h1>
    </div>
</header>

<section class="auth-section">
    <div class="container" style="color:black">
        <h2>Login as Admin</h2>
        <form onSubmit="checkLogin(event)" method="post">
            <div class="form-group">
                <label for="email">Email</label>
                <input type="email" name="email" required>
            </div>
            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" name="password" required>
            </div>
            <button type="submit">Login</button>
        </form>
        <p id="error-message"></p>
    </div>
</section>

<footer>
    <div class="container">
        <p>&copy; 2025 Adventure Map. All Rights Reserved.</p>
    </div>
</footer>

<script>
async function checkLogin(event) {
    event.preventDefault();  // Prevent default form submission

    const errorMessageElement = document.getElementById('error-message');
    errorMessageElement.innerText = '';  // Clear previous error message

    const form = event.target;
    const data = {
        email: form.email.value,
        password: form.password.value
    };
    console.log('Sending Data:',data);

    try {
        const response = await fetch('http://localhost:8082/register_login/api1/adventures/adminLogin', {  // ✅ Ensure Correct API URL
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
            window.location.href = 'dashboard.jsp';  // This will trigger a redirection to map.jsp.
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
