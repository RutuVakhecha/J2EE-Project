package register_login;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Arrays;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import javax.servlet.annotation.MultipartConfig;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import java.util.List;
import java.util.ArrayList;


import java.sql.*;

@MultipartConfig(
  fileSizeThreshold = 1024 * 1024 * 1, // 1 MB
  maxFileSize = 1024 * 1024 * 10,      // 10 MB
  maxRequestSize = 1024 * 1024 * 100  ) // 100 MB

//User POJO Class
class Users {
 private int id;
 private String name;
 private String password;
 private String email;
 private String city;

 // Constructor
 public Users(int id, String name, String password, String email, String city) {
     this.id = id;
     this.name = name;
     this.password = password;
     this.email = email;
     this.city = city;
 }

 // Getters
 public int getId() { return id; }
 public String getName() { return name; }
 public String getPassword() { return password; }
 public String getEmail() { return email; }
 public String getCity() { return city; }
}

class Adventure {
    private int adventure_id;  // Add an ID field
    private String adventure_name;
    private String category;
    private String xcoordinate;
    private String ycoordinate;
   private String description;
    
    public Adventure(int adventure_id,String adventure_name, String category, String xcoordinate, String ycoordinate, String description) {
        this.adventure_id = adventure_id;
    	this.adventure_name = adventure_name;
        this.category = category;
        this.xcoordinate = xcoordinate;
        this.ycoordinate = ycoordinate;
        this.description = description;
    }

    // Getters for the properties
    public int getAdventure_id() {
        return adventure_id;
    }
    public String getdescription() {
        return description;
    }
    public String getAdventure_name() {
        return adventure_name;
    }

    public String getCategory() {
        return category;
    }

    public String getXcoordinate() {
        return xcoordinate;
    }

    public String getYcoordinate() {
        return ycoordinate;
    }
    
}

public class AdventureServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

  protected void doPost(HttpServletRequest request, HttpServletResponse response)  throws ServletException, IOException
    {
    	String path = request.getPathInfo();
        if ("/register".equals(path)) {
            getRegister(response,request);
        } else if ("/login".equals(path)) {
           getLogin(response,request);
        }
        else if ("/imgupload".equals(path)) {
        	getUploadimg(request,response);
        }
        else if ("/insertImage".equals(path)) {
        	InsertImage(request,response);
        }
        else if ("/insertReview".equals(path)) {
        	InsertReview(request,response);
        }
        else if ("/adminLogin".equals(path)) {
        	adminLogin(request,response);
        }
        else if ("/addToWishlist".equals(path)) {
        	addToWishlist(request,response);
        }
        else if ("/updateUsersById".equals(path)) {
        	updateUsersById(request, response);
        }
        else if ("/updateAdventureById".equals(path)) {
        	updateAdventureById(request, response);
        }
        else if ("/InsertAdventure".equals(path)) {
        	InsertAdventure(request, response);
        }
        else {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST); // Bad Request if path is not correct
            response.getWriter().write("{\"success\": false, \"message\": \"Invalid request path\"}");
        }
    }

  private JsonObject CovertJson( HttpServletRequest request) throws ServletException, IOException
  {
  	  
      StringBuilder jsonBody = new StringBuilder();
      String line;
      try (BufferedReader reader = request.getReader() ) {//read request body data
          while ((line = reader.readLine()) != null) {
              jsonBody.append(line); //JSON data store in StringBuilder
          }
      }

      // Parse the JSON
      JsonObject jsonObject = JsonParser.parseString(jsonBody.toString()).getAsJsonObject();
      return jsonObject;
  }
  
  private void updateAdventureById(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    response.setContentType("application/json");
	    response.setCharacterEncoding("UTF-8");
	    System.out.println("Updating Adventure details by ID...");
	    
	    JsonObject body_json = this.CovertJson(request); // JSON data ko parse karna
	    int adventure_id = body_json.get("adventure_id").getAsInt(); // JSON se value nikalna
	    System.out.println("Adventure ID: " + adventure_id);

	    String adventure_name = body_json.get("adventure_name").getAsString();
	    String category = body_json.get("category").getAsString();
	    
	    double xcoordinate = body_json.get("x-coordinate").getAsDouble();
	    double ycoordinate = body_json.get("y-coordinate").getAsDouble();
	    String description = body_json.get("description").getAsString();


	    System.out.println("Adventure ID: " + adventure_id);
	    System.out.println("Category: " + category);
	    System.out.println("xcoordinate: " + xcoordinate);
	    System.out.println("ycoordinate: " + ycoordinate);
	    System.out.println("adventure_name" +adventure_name);


	    try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/emp_data", "root", "");
	         PreparedStatement ps = con.prepareStatement("UPDATE adventure SET adventure_name=?, category=? , `x-coordinate`=?, `y-coordinate`=?, description=? WHERE adventure_id=?")) {

	        ps.setString(1, adventure_name);
	        ps.setString(2, category);
	        ps.setDouble(3, xcoordinate);
	        ps.setDouble(4, ycoordinate);
	        ps.setString(5, description);
	        ps.setInt(6,adventure_id);

	        if (ps.executeUpdate() > 0) {
	            response.getWriter().write("{\"message\": \"Adventure updated successfully\"}");
	        } else {
	            response.setStatus(HttpServletResponse.SC_NOT_FOUND);
	            response.getWriter().write("{\"error\": \"Adventure not found\"}");
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	        response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
	        response.getWriter().write("{\"error\": \"Server error\"}");
	    }
	}

  
  private void updateUsersById(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    response.setContentType("application/json");
	    response.setCharacterEncoding("UTF-8");
	    System.out.println("Updating user details by ID...");

	    JsonObject body_json = this.CovertJson(request);
	    int userId = body_json.get("userId").getAsInt();
	    String username = body_json.get("username").getAsString();
	    
	    String email = body_json.get("email").getAsString();

	    System.out.println("User ID: " + userId);
	    System.out.println("Username: " + username);
	    System.out.println("Email: " + email);

	    try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/emp_data", "root", "");
	         PreparedStatement ps = con.prepareStatement("UPDATE registeruser SET name=?, email=? WHERE id=?")) {

	        ps.setString(1, username);
	        ps.setString(2, email);
	        ps.setInt(3, userId);

	        if (ps.executeUpdate() > 0) {
	            response.getWriter().write("{\"message\": \"User updated successfully\"}");
	        } else {
	            response.setStatus(HttpServletResponse.SC_NOT_FOUND);
	            response.getWriter().write("{\"error\": \"User not found\"}");
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	        response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
	        response.getWriter().write("{\"error\": \"Server error\"}");
	    }
	}
 
  private void addToWishlist(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	  response.setContentType("application/json");
      response.setCharacterEncoding("UTF-8");
      System.out.println("Insert Adventure to WishList");

      PrintWriter out = response.getWriter();

      try {
          JsonObject body_json = JsonParser.parseReader(request.getReader()).getAsJsonObject();
          int userId = body_json.get("userId").getAsInt();
          int adventureId = body_json.get("adventureId").getAsInt();

          System.out.println("User Id: " + userId);
          System.out.println("Adventure Id: " + adventureId);

          Class.forName("com.mysql.jdbc.Driver"); 
          Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/emp_data", "root", "");

          // ✅ Insert Query Without `id` (if auto-increment) & Use `NOW()` for Date
          String query = "INSERT INTO saved_places (id, adventure_id, saved_at) VALUES (?, ?, NOW())";
          PreparedStatement ps = con.prepareStatement(query);
          ps.setInt(1, userId);
          ps.setInt(2, adventureId);

          int rowsAffected = ps.executeUpdate();

          JsonObject jsonResponse = new JsonObject();
          if (rowsAffected > 0) {
              jsonResponse.addProperty("success", true);
              jsonResponse.addProperty("message", "Wishlist added successfully!");
          } else {
              jsonResponse.addProperty("success", false);
              jsonResponse.addProperty("message", " User not Login! .");
          }

          out.print(jsonResponse.toString());
          out.flush();

          // ✅ Close Resources
          ps.close();
          con.close();

      } catch (Exception e) {
          e.printStackTrace();
          out.print("{\"success\": false, \"message\": \"Please Login First  \"}");
      }
  }

  private void InsertAdventure(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    response.setContentType("application/json");
	    response.setCharacterEncoding("UTF-8");
	    System.out.println("Insert Adventure..");
	    
	     JsonObject body_json = this.CovertJson(request);
	        
	        String adventure_name = body_json.get("adventure_name").getAsString();
	        System.out.println("adventure name " +adventure_name);
	        
	        String category = body_json.get("category").getAsString();
	        System.out.println("adventure coordinate" +category);
	        
	        double xcoordinate = body_json.get("x-coordinate").getAsDouble();
	        System.out.println("adventure coordinate " +xcoordinate);
	        
	         double ycoordinate = body_json.get("y-coordinate").getAsDouble();
	        System.out.println("adventure coordinate " +ycoordinate);
	        
	        String description = body_json.get("description").getAsString();
	        System.out.println("adventure description " +adventure_name);
	        
	        try {
	        	
		        Class.forName("com.mysql.jdbc.Driver");
		        Connection con = DriverManager.getConnection("jdbc:mysql://localhost/emp_data", "root", "");
	        	    // SQL Query
	                String query = "INSERT INTO adventure (adventure_name,category,`x-coordinate`,`y-coordinate`,description) VALUES (?,?,?,?,?)";
	                try (PreparedStatement ps = con.prepareStatement(query)) {
	                	ps.setString(1,adventure_name);
	                	ps.setString(2,category);
	                	ps.setDouble(3,xcoordinate);
	                    ps.setDouble(4, ycoordinate);
	                    ps.setString(5, description);

	                    int rowsAffected = ps.executeUpdate();

	                    PrintWriter out = response.getWriter();
	                    if (rowsAffected > 0) {
	                        out.print("{\"success\": true, \"message\": \"Record Inserted successfully\"}");
	                    } else {
	                        out.print("{\"success\": false, \"message\": \"failed to insert record\"}");
	                    }
	                    out.flush();
	                }
	            } catch (Exception e) {
	                e.printStackTrace();
	                response.getWriter().print("{\"success\": false, \"message\": \"Error occurred during submission\"}");
	            }
}
  private void adminLogin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    response.setContentType("application/json");
	    response.setCharacterEncoding("UTF-8");

	    PrintWriter out = response.getWriter();  // ✅ Single instance of PrintWriter

	    try {
	        JsonObject body_json = this.CovertJson(request);
	        String email = body_json.get("email").getAsString();
	        String password = body_json.get("password").getAsString();

	        Class.forName("com.mysql.jdbc.Driver");
	        Connection con = DriverManager.getConnection("jdbc:mysql://localhost/emp_data", "root", "");

	        PreparedStatement ps = con.prepareStatement("SELECT * FROM admins WHERE email = ? AND password = ?");
	        ps.setString(1, email);
	        ps.setString(2, password);
	        ResultSet rs = ps.executeQuery();

	        // ✅ Check user exists or not
	        if (rs.next()) {
                // ✅ Username & User ID ko Session me Store karein
                HttpSession session = request.getSession();
                session.setAttribute("adminname", rs.getString("admin_name"));
             // ✅ Session me User ID store karna
                
                int adminId = rs.getInt("admin_id"); // ✅ User ka ID
                HttpSession session1 = request.getSession();
                session.setAttribute("adminId", adminId);
                System.out.println("Admin ID stored in session: " + session.getAttribute("adminId"));

                System.out.println("Stored AdminName in Session: " + session.getAttribute("adminname"));               
                out.print("{\"success\": true, \"message\": \"Login successful\"}");
	        } else {
	            out.print("{\"success\": false, \"message\": \"Invalid email or password\"}");
	        }

	        // ✅ Close resources
	        rs.close();
	        ps.close();
	        con.close();
	    } catch (SQLException e) {
	        e.printStackTrace();
	        out.print("{\"success\": false, \"message\": \"Database error: " + e.getMessage() + "\"}");
	    } catch (Exception e) {
	        e.printStackTrace();
	        out.print("{\"success\": false, \"message\": \"Error occurred during login: " + e.getMessage() + "\"}");
	    } finally {
	        out.flush();  // ✅ Ensure all data is sent before closing
	        out.close();  // ✅ Properly close PrintWriter
	    }
	}

  
  private void InsertReview(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    response.setContentType("application/json");
	    response.setCharacterEncoding("UTF-8");
	    System.out.println("Insert Adventure Review");
	    
	     JsonObject body_json = this.CovertJson(request);
	     int userId = body_json.get("userId").getAsInt(); 
	     System.out.println("User Id: " +userId);
	     
	     int adventure_id = body_json.get("adventureId").getAsInt(); // Adventure ID extract karein
	        System.out.println("adventure id " +adventure_id);
	        
	        String review_description = body_json.get("review_description").getAsString();
	        System.out.println("adventure review " +review_description);
	        try {
	        	
	        	Class.forName("com.mysql.jdbc.Driver");
	        		Connection con = DriverManager.getConnection("jdbc:mysql://localhost/emp_data", "root", "");
	        	    // SQL Query
	                String query = "INSERT INTO review (id,adventure_id,review_description) VALUES (?,?,?)";
	                try (PreparedStatement ps = con.prepareStatement(query)) {
	                	ps.setInt(1,userId);
	                	ps.setInt(2,adventure_id );
	                    ps.setString(3, review_description);

	                    int rowsAffected = ps.executeUpdate();

	                    PrintWriter out = response.getWriter();
	                    if (rowsAffected > 0) {
	                        out.print("{\"success\": true, \"message\": \"Review submitted successfully\"}");
	                    } else {
	                        out.print("{\"success\": false, \"message\": \"Review submission failed\"}");
	                    }
	                    out.flush();
	                }
	            } catch (Exception e) {
	                e.printStackTrace();
	                response.getWriter().print("{\"success\": false, \"message\": \"Error occurred during submission\"}");
	            }
  }
  
  private void InsertImage(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    response.setContentType("application/json");
	    response.setCharacterEncoding("UTF-8");
	    System.out.println("Insert Adventure Images");    
     JsonObject body_json = this.CovertJson(request);
     
     int userId = body_json.get("user_id").getAsInt(); 
     System.out.println("User Id: " +userId);
     int adventure_id = Integer.parseInt(body_json.get("adventure_id").getAsString());
     System.out.println(adventure_id);
     String filename = body_json.get("fileName").getAsString();
     System.out.println("FileName " +filename);
       	    
    try {    	
        	Class.forName("com.mysql.jdbc.Driver");
        		Connection con = DriverManager.getConnection("jdbc:mysql://localhost/emp_data", "root", "");
            String query = "INSERT INTO adventureimages (id,adventure_id, adventure_img) VALUES (?, ?, ?)";
            try (PreparedStatement ps = con.prepareStatement(query)) {
                
            	ps.setInt(1, userId);
            	ps.setInt(2, adventure_id);
                ps.setString(3, filename);
                
                int rowsAffected = ps.executeUpdate();
                PrintWriter out = response.getWriter();
                if (rowsAffected > 0) {
                    out.print("{\"success\": true, \"message\": \"Image Uploded Successfully\"}");
                } else {
                    out.print("{\"success\": false, \"message\": \"Image Uplodeded failed\"}");
                }
                out.flush();
            }   
  } catch (Exception e) {
      // Debug: Log error details
      System.out.println("Exception occurred during file Insert");
      e.printStackTrace();
  }     // Send error response
		    
  }
  private void getUploadimg(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    response.setContentType("application/json");
	    response.setCharacterEncoding("UTF-8");
	    System.out.println("Inside getUploadimg method");

	    try {
	        // Debug: Checking incoming request
	        System.out.println("Request received for file upload");

	        // Retrieve the file part from the request
	        Part filePart = request.getPart("file"); // Retrieve file part
	        System.out.println("File part retrieved: " + filePart);

	        // Get the original file name
	        String fileName = filePart.getSubmittedFileName(); // Get original file name
	        System.out.println("File name: " + fileName);

	        // Specify the directory where the file should be saved
	        String uploadDir = "D:/J2EE_WORKSPACE/register_login/WebContent/images/"; // Change this to your desired path
	        String filePath = uploadDir + fileName;
	        System.out.println("File will be saved at: " + filePath);

	        // Save the file to the specified directory
	        filePart.write(filePath);
	        System.out.println("File successfully saved at: " + filePath);

	        // Send success response
	        String successResponse = "{\"success\": true, \"message\": \"File uploaded successfully\", \"fileName\": \"" + fileName + "\"}";
	        System.out.println("Success response: " + successResponse);
	        response.getWriter().write(successResponse);
	    } catch (Exception e) {
	        // Debug: Log error details
	        System.out.println("Exception occurred during file upload");
	        e.printStackTrace();

	        // Send error response
	        String errorResponse = "{\"success\": false, \"message\": \"File upload failed\", \"error\": \"" + e.getMessage() + "\"}";
	        System.out.println("Error response: " + errorResponse);
	        response.getWriter().write(errorResponse);
	    }
	}

  

    private void getRegister(HttpServletResponse response, HttpServletRequest request) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
      JsonObject body_json = this.CovertJson(request);
        
        String name = body_json.get("name").getAsString();
        String password = body_json.get("password").getAsString();
        String email = body_json.get("email").getAsString();
        String city = body_json.get("city").getAsString();
        
       System.out.println(name);
       System.out.println(password);
       System.out.println(email);
       System.out.println(city);
        // Database connection
        try {
        	
        	Class.forName("com.mysql.jdbc.Driver");
        		Connection con = DriverManager.getConnection("jdbc:mysql://localhost/emp_data", "root", "");
            String query = "INSERT INTO registeruser (name, password, email, city) VALUES (?, ?, ?, ?)";
            try (PreparedStatement ps = con.prepareStatement(query)) {
              
            	ps.setString(1, name);
                ps.setString(2, password);
                ps.setString(3, email);
                ps.setString(4, city);
                int rowsAffected = ps.executeUpdate();
                
                // Send JSON response
                PrintWriter out = response.getWriter();
                if (rowsAffected > 0) {
                    // Registration successful
                    out.print("{\"success\": true, \"message\": \"Registration successful\"}");
                } else {
                    // Registration failed
                    out.print("{\"success\": false, \"message\": \"Registration failed\"}");
                }
                out.flush();
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().print("{\"success\": false, \"message\": \"Error occurred during registration\"}");
        }
    }
    

    private void getLogin(HttpServletResponse response, HttpServletRequest request) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        
        try {
            // Database connection parameters
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost/emp_data", "root", "");
            
            JsonObject json_body = this.CovertJson(request);
            String email = json_body.get("email").getAsString();
            String password = json_body.get("password").getAsString();

            PreparedStatement ps = con.prepareStatement("SELECT * FROM registeruser WHERE email = ? AND password = ?");
            ps.setString(1, email);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                // ✅ Username & User ID ko Session me Store karein
                HttpSession session = request.getSession();
                session.setAttribute("username", rs.getString("name"));
             // ✅ Session me User ID store karna
                
                int userId = rs.getInt("id"); // ✅ User ka ID
                HttpSession session1 = request.getSession();
                session.setAttribute("userId", userId);
                System.out.println("User ID stored in session: " + session.getAttribute("userId"));

                // ✅ Check karne ke liye session se values print karein
                System.out.println("Stored Username in Session: " + session.getAttribute("username"));

                // ✅ User ko response bhej rahe hain
                PrintWriter out = response.getWriter();
                out.print("{\"success\": true, \"message\": \"Login successful\", \"name\": \"" + rs.getString("name") + "\"}");
            } else {
                // User not found or incorrect credentials
                response.getWriter().print("{\"success\": false, \"message\": \"Invalid email or password\"}");
            }

            rs.close();
            con.close();
        } catch (SQLException e) {
            e.printStackTrace();  // Log database-related issues
            response.getWriter().print("{\"success\": false, \"message\": \"Database error: " + e.getMessage() + "\"}");
        } catch (Exception e) {
            e.printStackTrace();  // Log general errors
            response.getWriter().print("{\"success\": false, \"message\": \"Error occurred during login: " + e.getMessage() + "\"}");
        }
    }


  
    // API to get all adventures with optional category filtering
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getPathInfo();
        if ("/getAllAdventures".equals(path)) {
            getAllAdventures(response, request);
        } else if ("/getCategories".equals(path)) {
            getCategories(response);
        }else if ("/getAdventureById".equals(path)) {
            getAdventureById(response,request);
        }
        else if ("/getPhotoCount".equals(path)) {
       	 handleGetPhotoCount(request, response);
       } else if ("/getStoredImage".equals(path)) {
    	     getStoredImage(request, response);
         }
       else if ("/getReviewCount".equals(path)) {
    	   getReviewCount(request, response);
       }
       else if ("/getAdventureLocation".equals(path)) {
    	   getAdventureLocation(request, response);
       }
       else if ("/getAdventureReview".equals(path)) {
    	   getAdventureReview(request, response);
       }
       else if ("/getUsers".equals(path)) {
    	   getUsers(request, response);
       }
       else if ("/DeleteUsers".equals(path)) {
    	   DeleteUsers(request, response);
       }
       else if ("/DeleteAdventure".equals(path)) {
    	   DeleteAdventure(request, response);
       }
       else if ("/getUsersById".equals(path)) {
    	   getUsersById(request, response);
       }
     
                
    }

    
    private void DeleteAdventure(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
            System.out.println("Adventure Deleted...");
        int adventure_id;
        
        try {
        	adventure_id = Integer.parseInt(request.getParameter("adventure_id"));
        	System.out.println("adventure id" +adventure_id);
        } catch (NumberFormatException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"error\": \"Invalid adventure_id\"}");
            return;
        }

        try (
             Connection con = DriverManager.getConnection("jdbc:mysql://localhost/emp_data", "root", "");
             PreparedStatement stmt = con.prepareStatement("DELETE FROM adventure WHERE adventure_id = ?")) {
            
            stmt.setInt(1, adventure_id);
            int rowsAffected = stmt.executeUpdate();

            if (rowsAffected > 0) {
                response.getWriter().write("{\"message\": \"Adventure deleted\"}");
            } else {
                response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                response.getWriter().write("{\"error\": \"Adventure not found\"}");
            }
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"error\": \"Server error\"}");
        }
    }
    private void getUsersById(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        System.out.println("Fetching user details by ID...");

        int userId;
        try {
            userId = Integer.parseInt(request.getParameter("userId"));
        } catch (NumberFormatException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"error\": \"Invalid userId\"}");
            return;
        }

        Connection con = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            // ✅ Load MySQL JDBC Driver before connecting
            Class.forName("com.mysql.jdbc.Driver");

            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/emp_data", "root", "");
            stmt = con.prepareStatement("SELECT * FROM registeruser WHERE id = ?");
            stmt.setInt(1, userId);
            rs = stmt.executeQuery();

            if (rs.next()) {
                // Fetch user details
                int id = rs.getInt("id");
                String name = rs.getString("name");
                String email = rs.getString("email");
                String city = rs.getString("city");

                // ✅ Use StringBuilder for better performance
                StringBuilder jsonResponse = new StringBuilder();
                jsonResponse.append("{")
                            .append("\"id\":").append(id).append(",")
                            .append("\"name\":\"").append(name).append("\",")
                            .append("\"email\":\"").append(email).append("\",")
                            .append("\"city\":\"").append(city).append("\"")
                            .append("}");

                response.getWriter().write(jsonResponse.toString());
            } else {
                response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                response.getWriter().write("{\"error\": \"User not found\"}");
            }
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"error\": \"Server error\"}");
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (con != null) con.close();
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }
    }

    
    private void DeleteUsers(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        int userId;
        try {
            userId = Integer.parseInt(request.getParameter("userId"));
        } catch (NumberFormatException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"error\": \"Invalid userId\"}");
            return;
        }

        try (
             Connection con = DriverManager.getConnection("jdbc:mysql://localhost/emp_data", "root", "");
             PreparedStatement stmt = con.prepareStatement("DELETE FROM registeruser WHERE id = ?")) {
            
            stmt.setInt(1, userId);
            int rowsAffected = stmt.executeUpdate();

            if (rowsAffected > 0) {
                response.getWriter().write("{\"message\": \"User deleted\"}");
            } else {
                response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                response.getWriter().write("{\"error\": \"User not found\"}");
            }
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"error\": \"Server error\"}");
        }
    }

    private void getUsers(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        System.out.println("Fetching user details...");

        List<Users> userList = new ArrayList<>();

        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost/emp_data", "root", "");
            PreparedStatement preparedStatement = con.prepareStatement("SELECT * FROM registeruser");
            ResultSet resultSet = preparedStatement.executeQuery();

            // resultSet.next() moves the cursor to the next row in the result set from the database query.
            while (resultSet.next()) {
                int id = resultSet.getInt("id");
                String name = resultSet.getString("name");
                String password = resultSet.getString("password");
                String email = resultSet.getString("email");
                String city = resultSet.getString("city");

                // Add user to the list
                userList.add(new Users(id, name, password, email, city));
            }

            // Close connections
            resultSet.close();
            preparedStatement.close();
            con.close();
            
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"success\": false, \"message\": \"An error occurred while fetching users\"}");
            return;
        }

        // If no users found, return empty list
        if (userList.isEmpty()) {
            response.setStatus(HttpServletResponse.SC_NOT_FOUND);
            response.getWriter().write("{\"success\": false, \"message\": \"No users found\"}");
            return;
        }

        // Convert user list to JSON
        Gson gson = new Gson();
        String jsonResponse = gson.toJson(userList);

        // Send JSON response
        PrintWriter out = response.getWriter();
        out.print(jsonResponse);
        out.flush();
    }
    private void getAdventureReview(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        System.out.println("fetching adventure review from db...");
        String adventureIdParam = request.getParameter("adventure_id");
        System.out.println("adventure_id:" +adventureIdParam);
        if (adventureIdParam == null || adventureIdParam.isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("ERROR: Missing adventure_id parameter");
            return;
        }

        int adventureId;
        try {
            adventureId = Integer.parseInt(adventureIdParam);
        } catch (NumberFormatException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("ERROR: Invalid adventure_id parameter");
            return;
        }

        ArrayList<String> reviews = new ArrayList<>();
        
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost/emp_data", "root", "");
            PreparedStatement preparedStatement = con.prepareStatement("SELECT review_description FROM review WHERE adventure_id = ? LIMIT 5"
            );
            preparedStatement.setInt(1, adventureId);
            ResultSet rs = preparedStatement.executeQuery();    
            
            while (rs.next()) {
            	reviews.add(rs.getString("review_description"));
            }
        }catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("ERROR: An error occurred while fetching review");
        }
        Gson gson = new Gson();
        String jsonResponse = gson.toJson(reviews);

        // Send the response back to the client
        PrintWriter out = response.getWriter();
        out.print(jsonResponse);
        out.flush();
    }
    
    private void getAdventureLocation(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        System.out.println("fetching adventure location...");
        String adventureIdParam = request.getParameter("adventure_id");
        System.out.println("adventure_id:" +adventureIdParam);
        if (adventureIdParam == null || adventureIdParam.isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("ERROR: Missing adventure_id parameter");
            return;
        }

        int adventureId;
        try {
            adventureId = Integer.parseInt(adventureIdParam);
        } catch (NumberFormatException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("ERROR: Invalid adventure_id parameter");
            return;
        }

        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost/emp_data", "root", "");
            PreparedStatement preparedStatement = con.prepareStatement("SELECT `x-coordinate`, `y-coordinate` FROM adventure WHERE adventure_id= ?"
            );
            preparedStatement.setInt(1, adventureId);
            ResultSet rs = preparedStatement.executeQuery();
            if (rs.next()) {
                double xCoordinate = rs.getDouble("x-coordinate");
                double yCoordinate = rs.getDouble("y-coordinate");

                String jsonResponse = String.format("{\"x\": %.6f, \"y\": %.6f}", xCoordinate, yCoordinate);
                response.getWriter().write(jsonResponse);
            } else {
                response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                response.getWriter().write("{\"error\": \"No location found for given adventure_id\"}");
            }
        }catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("ERROR: An error occurred while fetching location");
        }
    }
    private void getStoredImage(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        System.out.println("fetching images from db");
        String adventureIdParam = request.getParameter("adventure_id");
        System.out.println(adventureIdParam);
        if (adventureIdParam == null || adventureIdParam.isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("ERROR: Missing adventure_id parameter");
            return;
        }

        int adventureId;
        try {
            adventureId = Integer.parseInt(adventureIdParam);
        } catch (NumberFormatException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("ERROR: Invalid adventure_id parameter");
            return;
        }

        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost/emp_data", "root", "");
            PreparedStatement preparedStatement = con.prepareStatement(
                "SELECT adventure_img FROM adventureimages WHERE adventure_id = ?"
            );
            preparedStatement.setInt(1, adventureId);
            ResultSet rs = preparedStatement.executeQuery();

            PrintWriter out = response.getWriter();
            boolean hasData = false;

            while (rs.next()) {
                hasData = true;
                String imageUrl = rs.getString("adventure_img");
                
                System.out.println("Fetched Image URL: " + imageUrl); // ✅ Debug Log
                out.println(imageUrl);
            }

            if (!hasData) {
                out.println("No images found"); // ✅ No data case
            }

            rs.close();
            preparedStatement.close();
            con.close();

        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("ERROR: An error occurred while fetching images");
        }
    }

    private void getReviewCount(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        System.out.println("Fetching review count...");

        // Request se adventure_id fetch karna
        String adventureIdParam = request.getParameter("adventure_id");

        if (adventureIdParam == null || adventureIdParam.isEmpty()) {
            System.out.println("Missing adventure_id parameter");
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"error\": \"Missing adventure_id parameter\"}");
            return;
        }

        int adventureId;
        try {
            adventureId = Integer.parseInt(adventureIdParam);
        } catch (NumberFormatException e) {
            System.out.println("Invalid adventure_id format");
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"error\": \"Invalid adventure_id format\"}");
            return;
        }

        try {
            // Database connection setup
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost/emp_data", "root", "");

            // SQL query to get the count of reviews
            String sql = "SELECT COUNT(*) AS count FROM review WHERE adventure_id = ?";
            PreparedStatement preparedStatement = con.prepareStatement(sql);
            preparedStatement.setInt(1, adventureId);

            ResultSet resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                int reviewCount = resultSet.getInt("count");

                // JSON Response
                String jsonResponse = "{\"count\": " + reviewCount + "}";
                response.getWriter().write(jsonResponse);
            } else {
                response.getWriter().write("{\"count\": 0}");
            }

            // Closing resources
            resultSet.close();
            preparedStatement.close();
            con.close();

        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"error\": \"An error occurred while fetching review count\"}");
        }
    }
    
    private void handleGetPhotoCount(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Set response content type and character encoding
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        System.out.println("Getting uploaded image count");

        // Get the adventure_id parameter from the request
        String adventureIdParam = request.getParameter("adventure_id");

        if (adventureIdParam == null || adventureIdParam.isEmpty()) {
            System.out.println("Missing adventure_id parameter");
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST); // Set 400 Bad Request
            response.getWriter().write("{\"error\": \"Missing adventure_id parameter\"}");
            return;
        }

        // Parse the adventure_id to an integer
        int adventureId;
        try {
            adventureId = Integer.parseInt(adventureIdParam);
        } catch (NumberFormatException e) {
            System.out.println("Invalid adventure_id format");
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST); // Set 400 Bad Request
            response.getWriter().write("{\"error\": \"Invalid adventure_id format\"}");
            return;
        }

        try {
            // Load the JDBC driver (not needed for newer versions of JDBC)
            Class.forName("com.mysql.jdbc.Driver");

            // Establish database connection
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost/emp_data", "root", "");

            // SQL query to get the count of images for the specified adventure_id
            String sql = "SELECT COUNT(*) AS count FROM adventureimages WHERE adventure_id = ?";
            PreparedStatement preparedStatement = con.prepareStatement(sql);
            preparedStatement.setInt(1, adventureId); // Set the adventure_id parameter

            // Execute the query and get the result
            ResultSet resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                int photoCount = resultSet.getInt("count");

                // Create a JSON response with the photo count
                String jsonResponse = "{\"count\": " + photoCount + "}";
                response.getWriter().write(jsonResponse);
            } else {
                // If no records found for the given adventure_id
                response.getWriter().write("{\"count\": 0}");
            }

            // Close resources
            resultSet.close();
            preparedStatement.close();
            con.close();

        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR); // Set 500 Internal Server Error
            response.getWriter().write("{\"error\": \"An error occurred while fetching photo count\"}");
        }
    }

    
    // Fetch all adventures with optional category filtering
    private void getAllAdventures(HttpServletResponse response, HttpServletRequest request) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        String selectedCategoriesString = request.getParameter("categories"); // "sports,music,movies"
        String[] selectedCategories = selectedCategoriesString != null ? selectedCategoriesString.split(",") : new String[0];
        System.out.println(Arrays.toString(selectedCategories));
     
        // Initialize the list to hold adventures
        ArrayList<Adventure> adventures = new ArrayList<>();

        try {
            // Load the JDBC driver
            Class.forName("com.mysql.jdbc.Driver");
            // Database connection
            Connection connection = DriverManager.getConnection("jdbc:mysql://localhost/emp_data", "root", "");

            // SQL query - if categories are selected, add them to the WHERE clause
            String query = "SELECT * FROM adventure";

            if (selectedCategories != null && selectedCategories.length > 0) {
                query += " WHERE category IN (";
                for (int i = 0; i < selectedCategories.length; i++) {
                    query += "'" + selectedCategories[i] + "'"; //SQL query mein string ke form mein hona zaroori hai, isliye single quotes (')
                    if (i < selectedCategories.length - 1) {
                        query += ",";
                    }
                }
                query += ")";
            }
        System.out.println(query);
            PreparedStatement preparedStatement = connection.prepareStatement(query);

            // Execute the query
            ResultSet resultSet = preparedStatement.executeQuery();

            // Iterate through the result set and populate the list
            while (resultSet.next()) {
                int adventure_id = resultSet.getInt("adventure_id");  // Get the adventure_id from the result set
                String adventure_name = resultSet.getString("adventure_name");
                String category = resultSet.getString("category");
                double xcoordinate = resultSet.getDouble("x-coordinate");
                double ycoordinate = resultSet.getDouble("y-coordinate");
                String description = resultSet.getString("description");
                // Format the coordinates
                String xCoordinateStrFormatted = String.format("%.2f", xcoordinate);
                String yCoordinateStrFormatted = String.format("%.2f", ycoordinate);

                // Add adventure details to list
                adventures.add(new Adventure(adventure_id,adventure_name, category, xCoordinateStrFormatted, yCoordinateStrFormatted, description));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        
        // Convert the list to JSON
        Gson gson = new Gson();
        String jsonResponse = gson.toJson(adventures);

        // Send the response
        PrintWriter out = response.getWriter();
        out.print(jsonResponse);
        out.flush();
    }


    // API to get all available categories
    private void getCategories(HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        ArrayList<String> categories = new ArrayList<>();
        
        try {
            // Load the JDBC driver
            Class.forName("com.mysql.jdbc.Driver");

            // Database connection
            Connection connection = DriverManager.getConnection("jdbc:mysql://localhost/emp_data", "root", "");

            // SQL query to get distinct categories
            String query = "SELECT DISTINCT category FROM adventure";
            PreparedStatement preparedStatement = connection.prepareStatement(query);

            // Execute the query
            ResultSet resultSet = preparedStatement.executeQuery();

           
            // Iterate through the result set and add categories to the list
            while (resultSet.next()) {
                categories.add(resultSet.getString("category"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        // Convert the list to JSON
        Gson gson = new Gson();
        String jsonResponse = gson.toJson(categories);

        // Send the response
        PrintWriter out = response.getWriter();
        out.print(jsonResponse);
        out.flush();
    }
    private void getAdventureById(HttpServletResponse response, HttpServletRequest request) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
      
        System.out.println("get Adventure by id...");
        // Get the adventure_id from the request
        String adventureIdParam = request.getParameter("adventure_id");
        int adventureId = Integer.parseInt(adventureIdParam); // Parse the ID to an integer
        System.out.println("adventure id: "+adventureId);

        if (adventureIdParam == null || adventureIdParam.isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"error\": \"Missing adventure_id parameter\"}");
            return;
        }

        int adventureId1 = Integer.parseInt(adventureIdParam); // Parse the ID to an integer

        Adventure adventure = null;

        try {
            // Load the JDBC driver
            Class.forName("com.mysql.jdbc.Driver");

            // Database connection
            Connection connection = DriverManager.getConnection("jdbc:mysql://localhost/emp_data", "root", "");

            // SQL query to fetch adventure by ID
            String query = "SELECT * FROM adventure WHERE adventure_id = ?";
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            preparedStatement.setInt(1, adventureId1); // Set the adventure_id parameter

            // Execute the query
            ResultSet resultSet = preparedStatement.executeQuery();

            // If a result is found, populate the Adventure object
            if (resultSet.next()) {
                int id = resultSet.getInt("adventure_id");
                String adventure_name = resultSet.getString("adventure_name");
                String category = resultSet.getString("category");
                double xcoordinate = resultSet.getDouble("x-coordinate");
                double ycoordinate = resultSet.getDouble("y-coordinate");
                String description = resultSet.getString("description");

                // Format the coordinates
                String xCoordinateStrFormatted = String.format("%.2f", xcoordinate);
                String yCoordinateStrFormatted = String.format("%.2f", ycoordinate);

                // Create the Adventure object with the data from the database
                adventure = new Adventure(id, adventure_name, category, xCoordinateStrFormatted, yCoordinateStrFormatted, description);
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"error\": \"An error occurred while fetching the adventure details\"}");
            return;
        }

        // If no adventure found, return an appropriate message
        if (adventure == null) {
            response.setStatus(HttpServletResponse.SC_NOT_FOUND);
            response.getWriter().write("{\"error\": \"Adventure not found\"}");
            return;
        }

        // Convert the Adventure object to JSON using Gson
        Gson gson = new Gson();
        String jsonResponse = gson.toJson(adventure);

        // Send the response back to the client
        PrintWriter out = response.getWriter();
        out.print(jsonResponse);
        out.flush();
    }

    }
 // Fetch adventure by ID (implement this method)


