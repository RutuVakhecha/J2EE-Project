<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<!-- Include FontAwesome for icons -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css" rel="stylesheet">

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Adventure Details</title>
<!-- Include Mapbox CSS -->
<link href="https://api.mapbox.com/mapbox-gl-js/v3.9.1/mapbox-gl.css" rel="stylesheet">
<style>
 body {
font-family: TofinoPersonal-Regular,sans-serif;
  font-size: 16px;
  line-height: 23px;    }
    .adventure-detail {
      margin-left: 70px;
      margin-right: 70px;
      background: url(../register_login/images/contour_full-grey.png) no-repeat;
      background-position: -300px -800px;
    }
    #map {
    }
    #adventure-name {
      font-family: TofinoPersonal-Semibold;
      font-size: 40px;
      color: #1a1a1a;
      padding-top: 115px;
    }
    #description-label {
      font-weight: bold; /* Make the text bold */
      margin-top: 20px;
      font-family: TofinoPersonal-Regular, sans-serif;
      font-size: 19px;
      padding-top: 30px;
    }
    #description-label-container {
      padding-top: 50px;
    }
    #submit {
      background-color: #1a1a1a;
      color: #fff;
      padding: 4px 7px;
      border: none;
      border-radius: 5px;
      font-size: 12px;
      cursor: pointer;
    }
   #previewContainer {
    position: fixed;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    background-color: #fff;
    border-radius: 12px;
    padding: 15px;
    width: 470px;
    border: 3px solid #000000bd;
    z-index: 999;
    display: none; /* Hidden by default */
    text-align: center;
    box-shadow: 0px 10px 20px rgba(0, 0, 0, 0.3);
}
#previewOverlay {
    position: fixed;
    top: 0;
    left: 0;
    width: 100vw;
    height: 100vh;
    background: rgba(0, 0, 0, 0.6);
    backdrop-filter: blur(2px);
    z-index: 998;
    display: none; /* Hidden by default */
}
    #closeButton {
      float: right;
      vertical-align: middle;
      margin-top: 5px;
    width: 80px;
  padding: 6px 22px;
      border-radius: 19px;
      border: none;
      background-color: #424242;
      color: white;
      cursor: pointer;
      position: absolute;
      right: 6px;
      bottom: 10px;
    }
    #imagePreview {
      max-width: 100%;
      max-height: 60vh;
      border-radius: 10px;
      margin-bottom: 39px;
  
    }
    #addPhotoButton {
      background-color: #1a1a1a;
      color: #fff;
      padding: 4px 7px;
      border: none;
      border-radius: 5px;
      font-size: 13px;
      cursor: pointer;
      margin-left: 5px;
    }
    #uploadButton {
    padding: 6px 10px;  
  font-size: 13px;
  background: #dfdfdf;
  border-radius: 17px;
  position: absolute;
  right: 98px;
  bottom: 10px;
  border: none;
    }
    .fas {
  display: inline-block;
    font-size: 14px;
  font-size: inherit;
  color:white;
  }
  .sec_928 {
  display:inline;
}
.sec_928 .sub_sec_01 {
  background-color: #ff9300;
  display: inline-block;
  margin-right: 20px;
  padding: 20px;
  border-radius: 10px;
  min-height: 53px;
  vertical-align: middle;
  display: inline;
  }
  sec_928 .sub_sec_01 .partial_container {
  margin-right: 7px;
  font-size: 14px;
  }
.add-review{
   display: inline-block;

}
  .partial_container{
   display: inline-block;
   margin-bottom: 45px;
   margin-top: 25px;
  }
  .review{background-color: #1a1a1a;
  color: #fff;
  padding: 4px 7px;
  border: none;
  border-radius: 5px;
  font-size: 13px;
  cursor: pointer;margin-left: 5px;
  }
   .star-icons i {
    margin-left: 5px;
  }
  .partial_container a {
    pointer-events: auto;
    display: inline-block;
}
/* Modal Styling */
.modal {
  display: none; /* Hidden by default */
  position: fixed;
  z-index: 1000;
  left: 50%;
  top: 50%;
  transform: translate(-50%, -50%);
  background: white;
  padding: 45px;
  border-radius: 10px;
  box-shadow: 0 0 10px rgba(0,0,0,0.2);
  width: 400px;
  text-align: center;
}

/* Close Button */
.close {
  position: absolute;
  top: 10px;
  right: 15px;
  font-size: 20px;
  cursor: pointer;
}

textarea {
  width: 100%;
  height: 100px;
  margin-top: 10px;
  padding: 8px;
  border-radius: 19px;
  border: 1px solid rgb(120, 120, 120);
}

.modal-buttons {
  margin-top: 10px;
}

button {
  padding: 10px;
  margin: 5px;
  cursor: pointer;
}
#closeModal{
background: #787878 0 0 no-repeat padding-box;
  min-width: 20px;
  width: 170px;
  min-height: 20px;
  height: 35px;
  border-radius: 15px;
  font-size: 14px;
  color: #fff;
  border: transparent;
}
 #publishReview{
 background: #f6911e 0 0 no-repeat padding-box;
  min-width: 20px;
  width: 170px;
  min-height: 20px;
  height: 35px;
  margin-left: 10px;
  border-radius: 15px;
  font-size: 14px;
  color: #fff;
  border: transparent;
  padding: 5px 15px 5px 15px;
  letter-spacing: 1.02px;
  outline: 0;
 } 
 /* Overlay for Background Blur */
.modal-overlay {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: rgba(0, 0, 0, 0.5); /* Dark Overlay */
    backdrop-filter: blur(2px); /* Blur Effect */
    z-index: 998;
    display: none;
}
.map-control-btn-custom {
  background-color: #1d2231;
  padding: 12px;
  color: #f1f1f1;
  }
  .map-control-btn-custom .section09 {
  display: inline-block;
  margin-right: 10px;
  border-right: 1px solid #ff9300;
  padding-right: 15px;
  font-size: 13px;
  cursor: pointer;
}
.map-control-btn-custom .section09 span {
  color: #ff9300;
  margin-right: 5px;
  font-size: 22px;
  vertical-align: middle;
}
#review-description{
width:40%;
  display: inline-block;
    vertical-align: top;}
#user-review{
padding-top:50px;}
#review-description {
    background: #ffffff;
    padding: 20px;
    border-radius: 12px;
    box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
    max-width: 800px;
      border: 1px solid #d45d07;
}
#review-description p {
    font-size: 16px;
    color: #555;
    line-height: 1.6;
}
 #image-container {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 5px;
            max-width: 600px;
            margin: auto;
            
        }
        #image-container img {
            width: 100%;
            height: 200px; /* Fixed Height */
            object-fit: cover; /* Image ko crop karke fit karega */
            border-radius: 10px;
        }
        .img-display
        {
       display: inline-block;
    vertical-align: top;
    margin-left:105px;
        }
       #wishlist-container {
            osition: relative;
  display: inline-block;
  background-color: #ff7f22;
  padding: 8px 20px;
  border-radius: 17px;
  width: 160px;
  margin-top:40px;
        }

        #wishlist-button {
            display: flex;
            align-items: center;
            background-color: #eee;
            padding: 6px 20px;
            border-radius: 20px;
            border: none;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            position: relative;
            padding-left: 50px;
        }

        #wishlist-button i {
            position: absolute;
            left: -8px;
            top: 50%;
            transform: translateY(-50%);
            background: black;
            color: white;
            width: 40px;
            height: 40px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 18px;
        }
        #wishlist-button i:hover{
        color:red;
        } 
</style>
</head>
<body>
<script src='https://kit.fontawesome.com/a076d05399.js' crossorigin='anonymous'></script>
<%@ include file="header.jsp" %>

<div class="adventure-detail">
<h1 id="adventure-name">Loading adventure details...</h1> <!-- Placeholder for adventure name -->
<h2 id="adventure-category">category</h2>

<form onSubmit="handleAdventureReview(event, adventureId)" method="post">
  <!-- Review Modal (Hidden by Default) -->
<div id="reviewModal" class="modal">
  <div class="modal-content">
    <span class="close">&times;</span>
    <h3>Describe Your Adventure</h3>
    <textarea id="reviewText" placeholder="Write your review here..." name="review_description"></textarea>
    <div class="modal-buttons">
      <button id="closeModal">CLOSE</button>
      <input type="submit" value="PUBLISH REVIEW" id="publishReview"/>
    </div>
  </div>
</div>
</form>

<form method="post" onsubmit="handleImageUpload(event)" enctype="multipart/form-data" id="imageUploadForm">

  <div class="sec_928">
  <div class="sub_sec_01">
  <div class="partial_container">
   <span class="star-icons">
    <i class="fas fa-star"></i>
    <i class="fas fa-star"></i>
    <i class="fas fa-star"></i>
    <i class="fas fa-star"></i>
  <i class="fas fa-star"></i>
  </span>
<div class="partial_container unl" style="cursor: pointer; margin-left:7px;" id="review-count">
  0 Reviews
</div>

<!-- Background Overlay -->
<div id="modalOverlay" class="modal-overlay"></div>

<div class="add-review">
<button class="review">ADD REVIEW</button></div></div>
  </div>
 

   <div class="sub_sec_01">
  <!-- Add Photo Button -->
<div class="partial_container unl2" style="cursor: pointer;">
  <i class="fas fa-camera-retro"></i>
<a href="http://localhost:8082/register_login/ImageDisplay.jsp"> <span style="margin-left:4px;" id="photo-link"> 0 Photos</span></a>
  
</div>

    <!-- Hidden file input -->
  <input type="file" name="file" id="fileInput" accept="image/*" style="display: none;" />
  <button type="button" id="addPhotoButton">ADD PHOTO</button>
  </div>
  </div>
  <!-- Image Preview and Buttons -->
  <div id="previewOverlay"></div>
  <div id="previewContainer" style="display: none; margin-bottom: 40px;">
    <img id="imagePreview" src="#" alt="Image Preview" />
    <div>
   
      <button type="submit" id="uploadButton">
        <i class="fas fa-cloud-upload-alt"></i> Upload
      </button>
        <button type="button" id="closeButton">Close</button>
    </div>
    </div>
</form>

<div id="map" style="height: 500px;"></div> <!-- Make sure the map container has a defined height -->
<div class="map-control-btn-custom">
<div class="section09" id="mapRedirect"><span><i class="fa fa-map" aria-hidden="true"></i></span>OPEN WEB MAP</div>
 </div>
  <div id="description-label-container">
          <span id="description-label">DESCRIPTION</span>
  </div>
<p id="description">DESCRIPTION</p>

<div id="wishlist-container">
        <button id="wishlist-button">
        <div id="heart-icon">
            <i class="fas fa-heart"></i>
            </div>
            Wishlist
        </button>
    </div>
    
<div class="container">
<h2 id="user-review">Users Reviews</h2>
<div id="review-description" >
</div>
<div class="img-display">
<h3>Adventure Photos</h3>
 <div id="image-container"></div> 
    </div>
    </div>
</div>


<%
    //  Query String se adventure ID lena
    String adventureId = request.getParameter("id");

    if (adventureId != null) {
        //  Adventure ID mil gaya
        // out.println("Adventure ID: " + adventureId);  // Debug ke liye
    } else {
        out.println("<p style='color:red;'>❌ No adventure ID provided.</p>");
    }

%>


<script src="https://api.mapbox.com/mapbox-gl-js/v3.9.1/mapbox-gl.js"></script> <!-- Include Mapbox JS -->

<script>
    // Your Mapbox API access token
mapboxgl.accessToken = 'pk.eyJ1Ijoid3dtY2NhcnRuZXkiLCJhIjoiY2xza2o4aG0yMDQ2ZTJrcjE0cHlodm16ayJ9.NLC8TAsgJ-hQN-v11poRmw';

    // Initialize the map
    const map = new mapboxgl.Map({
        container: 'map', // The ID of the HTML element where the map will be displayed
        style: 'mapbox://styles/mapbox/streets-v11', // Map style
        center: [72.5714, 23.0225], // Coordinates for Ahmedabad, Gujarat [longitude, latitude]
        zoom: 10 // Initial zoom level
    });

    // Add zoom and rotation controls
    map.addControl(new mapboxgl.NavigationControl());
    
 

    document.getElementById("mapRedirect").addEventListener("click", function() {
        window.location.href = "Map.jsp?adventure_id=" +adventureId; // Redirect to Map.jsp
    });
    
    
 // Get modal elements
    var modal = document.getElementById("reviewModal");
    var overlay = document.getElementById("modalOverlay");
    var btn = document.querySelector(".review"); // "ADD REVIEW" Button
    var closeBtn = document.querySelector(".close");
    var closeModalBtn = document.getElementById("closeModal");

 // Show modal on button click
    btn.onclick = function() {
      modal.style.display = "block";
      overlay.style.display = "block";
      document.body.classList.add("modal-open"); // Stop background scrolling
    }
 // Hide modal on close button click
    closeBtn.onclick = function() {
      modal.style.display = "none";
      overlay.style.display = "none";
      document.body.classList.remove("modal-open");
    }
    // Hide modal if user clicks outside of it
    window.onclick = function(event) {
      if (event.target == modal) {
        modal.style.display = "none";
        overlay.style.display = "none";
        document.body.classList.remove("modal-open");
      }
    }
    closeModalBtn.onclick = function() {
        modal.style.display = "none";
        overlay.style.display = "none";
      //  document.body.classList.remove("modal-open");
      }
    
    const fileInput = document.getElementById('fileInput');
    const addPhotoButton = document.getElementById('addPhotoButton');
    const previewContainer = document.getElementById('previewContainer');
    const imagePreview = document.getElementById('imagePreview');
    const cancelButton = document.getElementById('closeButton');
    const imageUploadForm = document.getElementById('imageUploadForm');
    const previewOverlay = document.getElementById('previewOverlay');


    // Add click event to "ADD PHOTO" button
    addPhotoButton.addEventListener('click', () => {
        fileInput.click(); // Trigger file input click
    });

    // Display preview when a file is selected
    fileInput.addEventListener('change', (event) => {
        const file = event.target.files[0];
        if (file) {
            const reader = new FileReader();

            reader.onload = function (e) {
                imagePreview.src = e.target.result; // Set preview image source
                previewContainer.style.display = 'flex'; // Show the preview container
                previewOverlay.style.display = 'block';
                addPhotoButton.style.display = 'none'; // Hide the "ADD PHOTO" button
            };

            reader.readAsDataURL(file); // Read the file as a data URL
        }
    });

    // Cancel button functionality
    cancelButton.addEventListener('click', () => {
        fileInput.value = ''; // Clear the file input
        imagePreview.src = ''; // Clear the image preview
        previewContainer.style.display = 'none'; // Hide the preview container
        previewOverlay.style.display = 'none'; // Hide blur overlay

        addPhotoButton.style.display = 'inline-block'; // Show the "ADD PHOTO" button
    });
 

    window.onload = function() {
        const adventureId2 = new URLSearchParams(window.location.search).get('id');
        const photoLinkElement = document.getElementById('photo-link');
        if (adventureId) {
            photoLinkElement.innerHTML = '<a href="http://localhost:8082/register_login/ImageDisplay.jsp?id=' + adventureId2 + '<span style="margin-left:10px">0 Photos</span></a>';
        }
    }
 let photoCount = 0;
 
//Function to update the photo count display
function updatePhotoCount() {
	  const urlParams = new URLSearchParams(window.location.search); // Ensure urlParams is defined here
	    const adventureId2 = urlParams.get('id');

	 const photoCountElement = document.querySelector('.sub_sec_01 .partial_container.unl2');

	    if (adventureId2) {
	    	 photoCountElement.innerHTML = 
	             '<i class="fas fa-camera-retro"></i>' +
	             '<a href="http://localhost:8082/register_login/ImageDisplay.jsp?id=' + adventureId2 + '">' +
	             '<span style="margin-left:10px">' + photoCount + ' Photos</span>' +
	             '</a>';
	    }
}

    async function handleImageUpload(event) {
        event.preventDefault(); // Prevent default form submission

        const fileInput = event.target.querySelector('input[type="file"]');
        const file = fileInput.files[0];

        if (!file) {
         //   alert("Please select a file to upload.");
            return;
        }

        // Validate file type and size (example: max 2MB and only image files)
        const allowedTypes = ["image/jpeg", "image/png", "image/gif"];
        const maxSize = 2 * 1024 * 1024; // 2MB

        if (!allowedTypes.includes(file.type)) {
            alert("Only JPEG, PNG, and GIF files are allowed.");
            return;
        }

        if (file.size > maxSize) {
            alert("File size must not exceed 2MB.");
            return;
        }

        // Create a FormData object and append the file
        const formData = new FormData();
        formData.append("file", file);
     
     
        try {
            // Send the file to the server
            const response = await fetch('http://localhost:8082/register_login/api1/adventures/imgupload', {
                method: "POST",
                body: formData, // Send FormData as the request body
            });
            
           
            
            if (response.ok) {
                const result = await response.json();

                if (result.success) {
                    console.log(result);
                    const filename = result.fileName;
                    console.log(filename);

                    const urlParams = new URLSearchParams(window.location.search);
                    const adventureId = urlParams.get('id'); // Adventure ID from URL
                    
                    var userId = <%= session.getAttribute("userId") %>;
                    console.log("User ID from session:", userId);

                    if (!userId) {
                        alert(" User not logged in. Please log in first.");
                        window.location.href = "loginform.jsp"; 
                        return;
                    }
                    

                    // ✅ Include userId in payload
                    const payload = { fileName: filename, adventure_id: adventureId,  user_id: userId };

                    const secondResponse = await fetch("http://localhost:8082/register_login/api1/adventures/insertImage", {
                        method: "POST",
                        headers: {
                            "Content-Type": "application/json",
                        },
                        body: JSON.stringify(payload),
                    });

                    const secondResult = await secondResponse.json();
                    if (secondResult.success) {
                        alert("Image uploaded successfully");

                        // Increment photo count and update display
                        photoCount++;
                        updatePhotoCount();

                        // Reset the form and hide the preview
                        fileInput.value = ''; // Clear file input
                        document.getElementById('previewContainer').style.display = 'none';
                        document.getElementById('addPhotoButton').style.display = 'inline-block';

                        console.log("Image inserted successfully into the database.");
                    } else {
                        alert("Failed to insert image into the database: " + secondResult.message);
                    }
                   
                } else {
                    alert("File upload failed: " + result.message);
                }
            } else {
                alert("Server error: " + response.statusText);
            }
        } catch (error) {
            console.error("Error during file upload:", error);
            alert("An error occurred while uploading the file. Please try again.");
        }
    }

 // Fetch photo count from the server
    async function fetchPhotoCount() {
        const urlParams = new URLSearchParams(window.location.search);
        const adventureId = urlParams.get('id');

        if (adventureId) {
            try {
                const response = await fetch('http://localhost:8082/register_login/api1/adventures/getPhotoCount?adventure_id=' + adventureId, {
                    method: "GET",
                    headers: {
                        'Accept': 'application/json',
                        'Content-Type': 'application/json'
                    }
                });
                console.log(response);
                if (response.ok) {
                    const result = await response.json();
                    photoCount = result.count || 0; // Update the photo count
                    updatePhotoCount();
                } else {
                    console.error("Failed to fetch photo count:", response.statusText);
                }
            } catch (error) {
                console.error("Error fetching photo count:", error);
            }
        }
    }

    // Call fetchPhotoCount when the page loads
    fetchPhotoCount();

    // Get the adventure ID from the URL query string
    const adventureId = new URLSearchParams(window.location.search).get('id');
  
    // Fetch adventure details and update the UI
    async function getAdventureDetails() {
        if (adventureId) {
            try {
                // Fetch the adventure details using the adventureId in the query string
                const response = await fetch('http://localhost:8082/register_login/api1/adventures/getAdventureById?adventure_id=' + adventureId, {
                    method: "GET",
                    headers: {
                        'Accept': 'application/json',
                        'Content-Type': 'application/json'
                    }
                });

                // Check if the response is successful
                if (!response.ok) {
                    console.error('Failed to fetch adventure details:', response.statusText);
                    return;
                }

                // Parse the JSON response containing the adventure details
                const adventure = await response.json();

                document.getElementById('adventure-name').textContent = adventure.adventure_name;
                document.getElementById('adventure-category').textContent = adventure.category;

                // Update the map location based on adventure's coordinates
                map.setCenter([parseFloat(adventure.xcoordinate), parseFloat(adventure.ycoordinate)]);
                map.setZoom(12); // Adjust zoom level as needed

                // Add a marker at the adventure's coordinates
                new mapboxgl.Marker()
                    .setLngLat([parseFloat(adventure.xcoordinate), parseFloat(adventure.ycoordinate)])
                    .addTo(map);

              document.getElementById('description').textContent = adventure.description;

            } catch (error) {
                console.error('Error fetching adventure details:', error);
            }
        }
    }

    // Call the function to fetch adventure details when the page loads
    getAdventureDetails();
 
    var userId = <%= session.getAttribute("userId") %>;
    console.log("User ID from session:", userId);
    
    async function handleAdventureReview(event, adventureId) {
        event.preventDefault(); // Prevent default form submission


        if (!userId) {
            alert(" User not logged in. Please log in first.");
            window.location.href = "loginform.jsp"; 

            return;
        }
        
        const form = event.target;
        const data = {
            review_description: form.review_description.value.trim(),
            adventureId: adventureId, // Pass the adventure_id
            userId: userId 
        };

        console.log("Review Data:", data);
        
        if (!data.review_description) {
            alert("Please write a review before submitting!");
            return;
        }

        try {
            const response = await fetch('http://localhost:8082/register_login/api1/adventures/insertReview', {
                method: "POST",
                headers: {
                    'Accept': 'application/json',
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(data)
            });

            const responseData = await response.json();

            if (responseData.success) {
                alert("Review submitted successfully!");
                form.review_description.value = "";  // Clear the textarea after success
            } else {
                alert("Submission failed: " + responseData.message);
            }
        } catch (error) {
            console.error("Error:", error);
            alert("There was an error with your request. Please try again.");
        }
    }
    let reviewCount = 0;

 // Function to fetch review count from the server
 async function fetchReviewCount() {
     const urlParams = new URLSearchParams(window.location.search);
     const adventureId3 = urlParams.get('id'); // Ensure correct parameter name
     console.log("adventure id.." +adventureId3);

     if (adventureId3) {
         try {
             const response = await fetch('http://localhost:8082/register_login/api1/adventures/getReviewCount?adventure_id=' + adventureId3, {
                 method: "GET",
                 headers: {
                     'Accept': 'application/json',
                     'Content-Type': 'application/json'
                 }
             });

             if (response.ok) {
                 const result = await response.json();
                 console.log("Review Count API Response:", result);

                 reviewCount = result.count || 0; // Default to 0 if no reviews
                 updateReviewCount(); // Call function to update UI
             } else {
                 console.error("Failed to fetch review count:", response.statusText);
             }
         } catch (error) {
             console.error("Error fetching review count:", error);
         }
     }
 }

 // Function to update review count in UI
 function updateReviewCount() {
     const reviewCountElement = document.getElementById("review-count"); // Ensure correct ID

     if (reviewCountElement) {
         reviewCountElement.innerHTML = '<span style="margin-left:10px">' + reviewCount + ' Reviews</span>';
     } else {
         console.error("Review count element not found!");
     }
 }

 // Call fetchReviewCount when the page loads
 fetchReviewCount();
 
 var userId = <%= session.getAttribute("userId") %>;
 console.log("User ID from session:", userId);
 
 async function fetchAdventureReview() {
     const urlParams = new URLSearchParams(window.location.search);
     const adventureId = urlParams.get('id'); // URL se adventure_id fetch kar raha hai
     console.log("Adventure ID:", adventureId);

     if (!adventureId) {
         document.getElementById("review-description").innerHTML = "<p style='color:red;'>Adventure ID is missing in the URL.</p>";
         return;
     }

     try {
         const response = await fetch('http://localhost:8082/register_login/api1/adventures/getAdventureReview?adventure_id=' + adventureId, {
             method: "GET",
             headers: {
                 'Accept': 'application/json',
                 'Content-Type': 'application/json'
             }
         });

         if (response.ok) {
             const result = await response.json();
             console.log("Review fetch API Response:", result);

             let reviewHtml = "";
             if (result.length > 0) {
                 result.forEach(review => {
                     reviewHtml += '<i class="fas fa-user-alt" style="color:#ff9300;"><i class="far fa-comment"></i><p>' +review+ '</p></i><hr/>';  // Review ko display kar raha hai
                 });
             } else {
                 reviewHtml = "<p>No reviews found.</p>";
             }

             document.getElementById("review-description").innerHTML = reviewHtml;

         } else {
             document.getElementById("review-description").innerHTML = "<p style='color:red;'>Failed to fetch reviews.</p><hr> ";
             console.error("Failed to fetch review:", response.statusText);
         }

     } catch (error) {
         document.getElementById("review-description").innerHTML = "<p style='color:red;'>Error fetching reviews.</p>";
         console.error("Error fetching review:", error);
     }
 }

 fetchAdventureReview();
 
 async function fetchImages() {
     const urlParams = new URLSearchParams(window.location.search);
     const adventureId = urlParams.get('id');  // Correct parameter
     const imageContainer = document.getElementById("image-container");

     if (!adventureId) {
         console.error("Adventure ID is missing from URL");
         imageContainer.innerHTML = "<p style='color:red;'>Adventure ID is required.</p>";
         return;
     }

     try {
         const response = await fetch('http://localhost:8082/register_login/api1/adventures/getStoredImage?adventure_id=' + adventureId);

         if (!response.ok) {
             throw new Error("Failed to fetch images");
         }

         const data = await response.text();  // Change to text() if servlet returns plain text

         //console.log("Fetched Data:", data);

         // Clear previous images
         //imageContainer.innerHTML = "";

         let images = data.trim().split("\n"); // Split URLs by line
         images.forEach(url => {
             let img = document.createElement("img");
             img.src = "images/" +  url.trim(); // Set image source
             img.alt = "Adventure Image";
             img.style.width = "300px"; // Adjust size
             img.style.height = "320px";
             img.style.margin = "10px";
             imageContainer.appendChild(img);
         });

     } catch (error) {
         console.error("Error fetching adventure images:", error);
         imageContainer.innerHTML = "<p style='color:red;'>Error loading images.</p>";
     }
 }

 // Call function
 fetchImages();
 
 
 async function Insertwishlist() {
	    document.getElementById("wishlist-button").addEventListener("click", async function() {
	        let heartIcon = document.getElementById("heart-icon");
	        let wishlistText = this;
	        heartIcon.style.color="red";	  
	        
	        if (heartIcon.style.color === "red") {
	            heartIcon.style.color = ""; // ❌ Reset to default
	        } else {
	            heartIcon.style.color = "red"; // ✅ Change to red
	        }
	        
	        wishlistText.classList.toggle("active");
	        
	        var userId = <%= session.getAttribute("userId") %>;
	        console.log("User ID:", userId);

	        const urlParams = new URLSearchParams(window.location.search);
	        const adventureId = urlParams.get('id'); // URL se adventure_id fetch kar raha hai
	        console.log("Adventure ID:", adventureId);

	        const data = {
	            adventureId: adventureId,
	            userId: userId
	        };

	        try {
	            const response = await fetch("http://localhost:8082/register_login/api1/adventures/addToWishlist", {
	                method: "POST",
	                headers: {
	                    'Accept': 'application/json',
	                    'Content-Type': 'application/json'
	                },
	                body: JSON.stringify(data)
	            });

	            const responseData = await response.json();

	            if (responseData.success) {
	                alert("Wishlist added successfully!");
	            } else {
	                alert("Failed to add to wishlist. " + responseData.message);
	                window.location.href = "loginform.jsp"; 

	            }
	        } catch (error) {
	            console.error("Error:", error);
	            alert("There was an error with your request. Please try again.");
	        }
	    });
	}

	// ✅ Call function
	Insertwishlist();

 Insertwishlist();
</script>

</body>
</html>
