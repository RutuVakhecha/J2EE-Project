<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="initial-scale=1,maximum-scale=1,user-scalable=no">
    <title>Mapbox Map</title>

    <!-- Mapbox CSS -->
    <link href="https://api.mapbox.com/mapbox-gl-js/v3.9.1/mapbox-gl.css" rel="stylesheet">
    
    <!-- Mapbox JS -->
    <script src="https://api.mapbox.com/mapbox-gl-js/v3.9.1/mapbox-gl.js"></script>

    <style>
        /* Ensure the map is visible */
        body, html {
            margin: 0;
            padding: 0;
            height: 100%;
        }
        #map {
            width: 100%;
            height: 500px; /* Adjust as needed */
        }
    </style>
</head>
<body>

    <div id="map"></div>

    <script>
        window.onload = function() { 
            // ✅ Use your own Mapbox API key here
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

            // ✅ Optional: Add a marker at the center location
            new mapboxgl.Marker()
                .setLngLat([72.5714, 23.0225]) 
                .setPopup(new mapboxgl.Popup().setText("Ahmedabad, Gujarat")) 
                .addTo(map);
        };
    </script>

</body>
</html>
