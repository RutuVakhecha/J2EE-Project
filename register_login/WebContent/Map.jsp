<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Display a map on a webpage</title>
<meta name="viewport" content="initial-scale=1,maximum-scale=1,user-scalable=no">
<link href="https://api.mapbox.com/mapbox-gl-js/v3.9.1/mapbox-gl.css" rel="stylesheet">
<script src="https://api.mapbox.com/mapbox-gl-js/v3.9.1/mapbox-gl.js"></script>
<style>
body { margin: 0; padding: 0;font-family: 'Trebuchet MS','Lucida Sans Unicode','Lucida Grande','Lucida Sans',Arial,sans-serif;
   }
#map {
    position: relative;
    width: 100%;
    height: 100vh;
      margin-top: 65px;
}
#sidebar {
    position: absolute;
    top: 20px;
    right: 0;
    width: 300px;
    height: 40vh;
    background-color: rgb(28, 32, 49);
    padding: 43px;
    box-shadow: -2px 0 5px rgba(0, 0, 0, 0.2);
    display: none;
    overflow-y: auto;
    z-index: 10;
    color: white;
}

#filter-menu {
    position: absolute;
    bottom: 40px;
    left: 20px;
    background-color:#1c2031;
    color:white;
    padding: 10px;
    border-radius: 5px;
    display: none;
    width: 250px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
}
#filter-icon {
    position: absolute;
    top: 70px;
    left: 20px;
    background-color: #ff9300;
    color: white;
    padding: 10px;
    border-radius: 50%;
    cursor: pointer;
    z-index: 10;
    margin-top: 45px;
}
#description-label-container{
color:#ff9300;
font-family: 'Trebuchet MS','Lucida Sans Unicode','Lucida Grande','Lucida Sans',Arial,sans-serif;
  font-weight: bold;
}
#read-more-btn{
font-weight: bold;
  padding: 8px;
  border-radius: 9px;
  font-size: 12px;
}
input[type="checkbox"] {
    accent-color: orange;
    font-weight: bold; 
    }
</style>
</head>
<body>
<%@ include file="header.jsp" %>
<div id="map"></div>

<!-- Sidebar for Adventure Details -->
<div id="sidebar">
    <h2 id="adventure-name"></h2>
     <!-- Add a yellow line with DESCRIPTION text -->
    <div id="description-label-container">
        <span id="description-label">DESCRIPTION</span>
    </div>
    <p id="adventure-description"></p>
    <button id="read-more-btn">READ MORE</button>
</div>

<!-- Filter Menu -->
<div id="filter-menu">
    <h4 style='margin-left:28px'>Filter by Category</h4>
    <!-- Categories will be dynamically added here -->
    
</div>

<!-- Filter Icon -->
<div id="filter-icon"><img src="http://localhost:8082/register_login/images/Filter-512.jpg" width="30px" height="27px" alt="filter-icon"/><!-- Magnifying glass icon --></div>

<script>

mapboxgl.accessToken = 'pk.eyJ1Ijoid3dtY2NhcnRuZXkiLCJhIjoiY2xza2o4aG0yMDQ2ZTJrcjE0cHlodm16ayJ9.NLC8TAsgJ-hQN-v11poRmw';
    const map = new mapboxgl.Map({
        container: 'map', // container ID
        style: 'mapbox://styles/mapbox/streets-v11', // Map style
        center: [72.5714, 23.0225], // Ahmedabad, Gujarat coordinates [lng, lat]
        zoom: 10 // starting zoom level
    });
    
    // Add navigation controls (zoom and rotate)
    map.addControl(new mapboxgl.NavigationControl());

    // Empty array for GeoJSON data
    let geoJsonData = {
        type: 'FeatureCollection',
        features: []
    };
  
 // Extract adventure_id from URL
    const urlParams = new URLSearchParams(window.location.search);
    const adventure_id = urlParams.get('adventure_id');

    if (adventure_id) {
        loadAdventureLocation(adventure_id);
    } else {
        console.error("No adventure_id found in URL");
    }

    
    async function loadAdventureLocation(adventure_id) {
        try {
        	console.log("adventure id " +adventure_id);
            // Fetch categories from the API
            const response = await fetch('http://localhost:8082/register_login/api1/adventures/getAdventureLocation?adventure_id=' +adventure_id,{
                method: "GET",  // GET request
                headers: {
                    'Accept': 'application/json',
                    'Content-Type': 'application/json'
                }
            });

            const location = await response.json(); // Parse the JSON response
            console.log("adventure location",location);
            
            if (location && location["x"] !== undefined && location["y"] !== undefined) {
                addAdventureMarker(location["x"], location["y"]);
            } else {
                console.error("Invalid location data received:", location);
            }

        }catch (error) {
            console.error('Error fetching adventure location:', error);
        }
        }
    function addAdventureMarker(lng, lat, adventureName) {
        new mapboxgl.Marker({ color: "red" }) // Marker Color Red
            .setLngLat([parseFloat(lng), parseFloat(lat)])
            .setPopup(new mapboxgl.Popup().setHTML('<h3>' +adventureName+'</h3>')) // Popup with adventure name
            .addTo(map);

        // Map ko us location par zoom karein
        map.flyTo({
            center: [parseFloat(lng), parseFloat(lat)],
            zoom: 12
        });
    }

 // Category filter toggle
   async function loadCategories() {
    try {
        // Fetch categories from the API
        const response = await fetch('http://localhost:8082/register_login/api1/adventures/getCategories', {
            method: "GET",  // GET request
            headers: {
                'Accept': 'application/json',
                'Content-Type': 'application/json'
            }
        });

        const categories = await response.json(); // Parse the JSON response
        console.log(categories);

        const filterMenu = document.getElementById('filter-menu');
        filterMenu.innerHTML = '<h4>Filter by Category</h4>'; // Reset filter menu

        // Create a list element to hold the categories
        const categoryList = document.createElement('ul');
        document.body.appendChild(categoryList); // Append the list to the document

        categoryList.style.listStyle = 'none'; // Remove the list-style
        // Loop through categories and create list items
        categories.forEach(category => {
            const listItem = document.createElement('li'); // Create a list item for each category
           
            const checkbox = document.createElement('input');
            category
            checkbox.type = 'checkbox';
            checkbox.style.accentColor = "orange";
            checkbox.name = 'category'; // This groups all checkboxes under the same name
            checkbox.value = category; // Set the category name as the value of the checkbox

            // Check if the category is already in selectedCategories
            checkbox.checked = selectedCategories.includes(category);

            // Add the onchange event listener for category selection
            checkbox.addEventListener('change', function () {
                // If the checkbox is checked, add it to selectedCategories array, otherwise remove it
                if (checkbox.checked) {
                    selectedCategories.push(category);
                } else {
                    selectedCategories = selectedCategories.filter(item => item !== category);
                }

                console.log('Selected categories:', selectedCategories);

                // Call the function to filter GeoJSON data based on selected categories
                MapDetail(selectedCategories);
            });

            listItem.appendChild(checkbox); // Append checkbox first
            listItem.appendChild(document.createTextNode(category)); // Append category name as text

            categoryList.appendChild(listItem); // Append the list item to the list
        });

        // Append the category list to the filter menu
        filterMenu.appendChild(categoryList);

    } catch (error) {
        console.error('Error fetching categories:', error);
    }
}

   
   async function loadAdventureDetails(adventure_id) {
	    try {
	    	
	        // Fetch the adventure by ID
	        const response = await fetch('http://localhost:8082/register_login/api1/adventures/getAdventureById?adventure_id=' + adventure_id, {
	            method: "GET",
	            headers: {
	                'Accept': 'application/json',
	                'Content-Type': 'application/json'
	            }
	        });

	        if (!response.ok) {
	            console.error('Failed to fetch adventure:', response.statusText);
	            return;
	        }

	        // Parse the JSON response containing the adventure
	        const adventure = await response.json();
	        console.log('Adventure details:', adventure);

	        if (!adventure) {
	            console.error('Adventure not found');
	            return;
	        }

	        // Display the adventure details in the sidebar
	        document.getElementById('adventure-name').textContent = adventure.adventure_name;
	        document.getElementById('adventure-description').textContent = adventure.description;

	        // Toggle the "READ MORE" button based on description length
	        const readMoreBtn = document.getElementById('read-more-btn');
	        if (adventure.description.length > 150) {
	            readMoreBtn.style.display = "block";
	            readMoreBtn.addEventListener('click', () => {
	                // Redirect to the detailed adventure page
	                window.location.href = "Adventuredetails.jsp?id="+adventure.adventure_id; 
	            });
	        } else {
	            readMoreBtn.style.display = 'none'; // Hide "READ MORE" if description is short
	        }

	        // Show the sidebar with the adventure details
	        document.getElementById('sidebar').style.display = 'block';

	    } catch (error) {
	        console.error('Error fetching adventure details:', error);
	    }
	}


   
 // Store selected categories globally
    let selectedCategories = [];

    async function MapDetail() {
        try {
            // Construct the query string from selected categories
            const queryString = selectedCategories.length > 0 ? "?categories=" + selectedCategories.join(',') : '';
            console.log('Query String:', queryString);  // Log the query string for debugging

            // Fetch data from the backend with selected categories
            const response = await fetch("http://localhost:8082/register_login/api1/adventures/getAllAdventures" + queryString, {
                method: "GET",  // GET request
                headers: {
                    'Accept': 'application/json',
                    'Content-Type': 'application/json'
                }
            });

            if (!response.ok) {
                console.error('Failed to fetch data:', response.statusText);
                return;
            }

            // Parse the JSON response
            const result = await response.json();
            console.log('Received data:', result);

            // Clear previous features before adding new data
            geoJsonData.features = [];

            // Process and convert coordinates to float
            for (let i = 0; i < result.length; i++) {
                const feature = {
                    type: 'Feature',
                    geometry: {
                        type: 'Point',
                        coordinates: [
                            parseFloat(result[i].xcoordinate),  // Use xcoordinate and ycoordinate
                            parseFloat(result[i].ycoordinate)
                        ]
                    },
                    properties: {
                    	adventure_id: result[i].adventure_id,
                        adventure_name: result[i].adventure_name,
                        category: result[i].category,
                        description: result[i].description
                    }
                };
                geoJsonData.features.push(feature);
            }

            console.log('GeoJSON Data:', geoJsonData);

            // Check if the source exists and update it
            if (map.getSource('points')) {
                // Update the data of the map source
                map.getSource('points').setData(geoJsonData);
            } else {
                // Add the source if it doesn't exist
                map.addSource('points', {
                    type: 'geojson',
                    data: geoJsonData
                });
            }

        } catch (error) {
            console.error('Error fetching adventures:', error);
        }
    }

    map.on('load', () => {
        // Add a GeoJSON source
        map.addSource('points', {
            type: 'geojson',
            data: geoJsonData // Initially, empty data
        });

        // Add a layer to display the points
        map.loadImage('http://localhost:8082/register_login/images/backroad_adventure.jpg', function(error, image1) {
            if (error) throw error;
            map.addImage('backroad adventure', image1);
        });
        map.loadImage('http://localhost:8082/register_login/images/hicking_adventure.png', function(error, image2) {
            if (error) throw error;
            map.addImage('hicking', image2);
        });
        map.loadImage('http://localhost:8082/register_login/images/win.jpg', function(error, image3) {
            if (error) throw error;
            map.addImage('winter adventure', image3);
        });
        map.loadImage('http://localhost:8082/register_login/images/fishing1.png', function(error, image4) {
            if (error) throw error;
            map.addImage('fishing', image4);
        });

        // Add a symbol layer to display the points with icons
        map.addLayer({
            id: 'points-layer',
            type: 'symbol',
            source: 'points',
            layout: {
                'icon-image': [
                    'match',
                    ['get', 'category'],
                    'backroad adventure', 'backroad adventure',
                    'hicking', 'hicking',
                    'winter adventure', 'winter adventure',
                    'fishing', 'fishing',
                    'default'
                ],
                'icon-size': 0.1,
                'icon-allow-overlap': true,
                'icon-anchor': 'center'
            }
        });

        // Add popup on click
        map.on('click', 'points-layer', (e) => {
            const coordinates = e.features[0].geometry.coordinates.slice();
            const { adventure_name, category, adventure_id ,description} = e.features[0].properties;
            
            if (adventure_id) {
                loadAdventureDetails(adventure_id); // Pass adventure_id here
            } else {
                console.log("Adventure ID is missing.");
            }
              new mapboxgl.Popup()
                .setLngLat(coordinates)
                .setHTML('<h3>' + adventure_name + '</h3><p>' + category + '</p>')
                .addTo(map);
        });

        // Add cursor change on hover
        map.on('mouseenter', 'points-layer', () => {
            map.getCanvas().style.cursor = 'pointer';
        });

        map.on('mouseleave', 'points-layer', () => {
            map.getCanvas().style.cursor = '';
        });

        // Fetch adventure details
      MapDetail();
        // Load categories dynamically
        loadCategories();
    
    });

    // Toggle filter menu visibility
    document.getElementById('filter-icon').addEventListener('click', () => {
        const filterMenu = document.getElementById('filter-menu');
        filterMenu.style.display = filterMenu.style.display === 'none' || filterMenu.style.display === '' ? 'block' : 'none';
    });
</script>
</body>
</html>
