<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <meta name="viewport" content="initial-scale=1,maximum-scale=1,user-scalable=no">
    <title>Add Adventure</title>

    <!-- Mapbox CSS -->
    <link href="https://api.mapbox.com/mapbox-gl-js/v3.9.1/mapbox-gl.css" rel="stylesheet">
    <!-- Mapbox JS -->
    <script src="https://api.mapbox.com/mapbox-gl-js/v3.9.1/mapbox-gl.js"></script>

    <style>
        .container {
            max-width: 800px;
            margin: 130px auto;
            padding: 20px;
            background-color: #f9f9f9;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
        }
        #map {
            width: 90%;
            margin-left:70px;
            height: 500px;
        }
        #info {
            padding: 10px;
            background: white;
            position: absolute;
            top: 10px;
            left: 10px;
            border-radius: 5px;
            box-shadow: 0px 0px 5px rgba(0,0,0,0.3);
            font-size: 16px;
        }
        form {
        }
        .form-group {
            margin-bottom: 15px;
        }
        label {
            display: block;
            font-weight: bold;
            margin-bottom: 10px;
        }
        input[type="text"] {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 16px;
        }
        button {
            padding: 10px 20px;
            background-color: #1c202d;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        button:hover {
            background-color: #333;
        }
    </style>
</head>
<body>

    <div id="info"></div>
    <div id="map"></div>

    <div class="container">
        <h1>Add Adventure</h1>
        <form method="POST" onSubmit="addAdventure(event)">
            <div class="form-group">
                <label for="adventure-name">Adventure Name:</label>
                <input type="text" name="adventure_name" id="adventure-name" required>
            </div>

            <div class="form-group">
                <label for="category">Category</label>
                <input type="text" name="category" id="category" required>

                <label for="x-coordinate">Longitude</label>
                <input type="text" name="x-coordinate" id="x-coordinate" required readonly>

                <label for="y-coordinate">Latitude</label>
                <input type="text" name="y-coordinate" id="y-coordinate" required readonly>

                <label for="description">Description</label>
                <input type="text" name="description" id="description" required>
            </div>

            <button type="submit" class="button">Add Adventure</button>
        </form>
    </div>

    <script>
        window.onload = function() {
            // ✅ Use your own Mapbox API key
            mapboxgl.accessToken = 'pk.eyJ1Ijoid3dtY2NhcnRuZXkiLCJhIjoiY2xza2o4aG0yMDQ2ZTJrcjE0cHlodm16ayJ9.NLC8TAsgJ-hQN-v11poRmw';

            // ✅ Initialize Mapbox
            const map = new mapboxgl.Map({
                container: 'map',
                style: 'mapbox://styles/mapbox/streets-v11',
                center: [72.5714, 23.0225], // Ahmedabad, Gujarat
                zoom: 10
            });

            // ✅ Add zoom and rotation controls
            map.addControl(new mapboxgl.NavigationControl());

            document.getElementById('x-coordinate').value = "";
            document.getElementById('y-coordinate').value = "";
            
            // ✅ Display longitude & latitude on click and populate fields
            map.on('click', function(e) {
                const lngLat = e.lngLat; // Get clicked coordinates
                document.getElementById('info').innerHTML = 'Longitude: ${lngLat.lng}, Latitude: ${lngLat.lat}';
                document.getElementById('x-coordinate').value = lngLat.lng;
                document.getElementById('y-coordinate').value = lngLat.lat;
            });
        };

        async function addAdventure(event) {
            event.preventDefault(); // Prevent form submission

            const adventure = {
                adventure_name: document.getElementById("adventure-name").value,
                category: document.getElementById("category").value,
                x_coordinate: document.getElementById("x-coordinate").value,
                y_coordinate: document.getElementById("y-coordinate").value,
                description: document.getElementById("description").value
            };

            try {
                const response = await fetch('http://localhost:8082/register_login/api1/adventures/InsertAdventure', {
                    method: "POST",
                    headers: {
                        'Accept': 'application/json',
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify(adventure)
                });

                const responseData = await response.json();
                console.log("Response Data:", responseData);

                if (response.ok) {
                    alert("Adventure Inserted successfully!");
                    window.location.href = "manage_adventures.jsp";
                } else {
                    alert("Error: " + responseData.error);
                }
            } catch (error) {
                console.error("Error:", error);
                alert("There was an error inserting the adventure.");
            }
        }
    </script>

</body>
</html>
