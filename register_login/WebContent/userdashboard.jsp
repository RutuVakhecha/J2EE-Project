<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <title>User Profile</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css" rel="stylesheet">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #1c1c1c;
            margin: 0;
            padding: 0;
        }
        .profile-container {
            width: 800px;
            margin: 50px auto;
            background: #f2f2f2;
            border-radius: 20px;
            padding: 20px;
            box-shadow: 0 11px 6px #00000029;
            display: flex;
        }
        .profile-sidebar {
            width: 250px;
            background: #ff9300;
            border-radius: 20px;
            padding: 27px;
            text-align: center;
        }
        .profile-sidebar img {
            width: 100%;
            border-radius: 50%;
            border: 4px solid white;
        }
        .profile-sidebar input {
            width: 90%;
            padding: 5px;
            margin-top: 4px;
            border: none;
        }
        .profile-content {
            flex-grow: 1;
            padding: 20px;
        }
        .input-field {
            margin-bottom: 15px;
        }
        label {
            font-weight: bold;
              float: left;
              color:#ff9300;
              margin-left:6px;
        }
        input, select, textarea {
            width: 90%;
            padding: 5px;
            border: none;
            border-radius: 5px;
        }
        .adventure-checkbox {
            display: flex;
            flex-wrap: wrap;
        }
        .adventure-checkbox label {
            width: 50%;
            margin-bottom: 5px;
        }
        .save-button {
            background: #ff9300;
            color: white;
            border: none;
            padding: 10px;
            width: 100px;
            cursor: pointer;
            border-radius: 5px;
        }
        .edit-img{
        font-size: 13px;
  text-align: center;
  margin-bottom: 20px;
  color: #fff;
  text-decoration: underline;
  cursor: pointer;
  padding-top:8px;
        }
    </style>
</head>
<body>
    <div class="profile-container">
        <div class="profile-sidebar">
            <img src="http://localhost:8082/register_login/images/default-avatar.jpg" alt="Profile Picture">
            
            <div class="edit-img">Change Profile Image</div>
            
            <div class="input-field">
                <label style="color:white">Username*</label>
                <input type="text" value="rutu vakhecha">
            </div>
            <div class="input-field">
                <label style="color:white">Bio</label>
                <textarea>Explorer</textarea>
            </div>
             <div class="input-field">
                <label style="color:white">Website</label>
                <input type="text" >
            </div>
             <div class="input-field">
                <label style="color:white">Company</label>
                <input type="text" >
            </div>
        </div>
        <div class="profile-content">
            <h2 style="color:rgb(112, 119, 127);">Private Information</h2>
            <div class="input-field">
                <label>First Name*</label>
                <input type="text" value="Rutu">
            </div>
            <div class="input-field">
                <label>Last Name*</label>
                <input type="text" value="Vakhecha">
            </div>
            <div class="input-field">
                <label>Email*</label>
                <input type="text" value="vakhechar347@gmail.com" disabled>
            </div>
            <div class="input-field">
                <label>City*</label>
                <input type="text" value="Shapur">
            </div>
            <div class="input-field">
                <label>Province*</label>
                <input type="text" value="Ontario">
            </div>
            <div class="input-field adventure-checkbox">
                <label>Adventures</label><br>
                <label><input type="checkbox" checked> Backroads</label>
                <label><input type="checkbox" checked> Fishing</label>
                <label><input type="checkbox" checked> Winter</label>
                <label><input type="checkbox" checked> Hicking</label>
            </div>
            <button class="save-button">SAVE</button>
        </div>
    </div>
</body>
</html>
