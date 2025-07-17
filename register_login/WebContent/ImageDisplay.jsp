<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Adventure Images</title>
</head>
<body>
     <h2>Adventure Images</h2>
    <div id="image-container" style="display: flex; flex-wrap: wrap;"></div>
    
    <%
    // Get the 'id' from the query string
    String adventureId = request.getParameter("id");

    // Check if the id is present
    if (adventureId != null) {
        // You can now use the 'adventureId' for further processing, like fetching data from the database
     //   out.println("Adventure ID: " + adventureId);
    } else {
        out.println("No adventure ID provided.");
    } 
%>
    <script>

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

            console.log("Fetched Data:", data);

            // Clear previous images
            imageContainer.innerHTML = "";

            let images = data.trim().split("\n"); // Split URLs by line
            images.forEach(url => {
                let img = document.createElement("img");
                img.src = "images/" +  url.trim(); // Set image source
                img.alt = "Adventure Image";
                img.style.width = "200px"; // Adjust size
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


</script>
</body>
</html>
