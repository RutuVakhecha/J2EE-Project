package register_login;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import java.sql.*;

 //Adventure POJO
 class User {
    private String name;
    private String password;
    private String email;
    private String city;

    // Getters and Setters
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }
}


public class API extends HttpServlet {
	    private static final long serialVersionUID = 1L;

	    @Override
	    protected void doPost(HttpServletRequest request, HttpServletResponse response)  throws ServletException, IOException
	    {
	    	String path = request.getPathInfo();
	        if ("/register".equals(path)) {
	            getRegister(response,request);
	        } else if ("/login".equals(path)) {
	           getLogin(response,request);
	        }else {
	            response.setStatus(HttpServletResponse.SC_BAD_REQUEST); // Bad Request if path is not correct
	            response.getWriter().write("{\"success\": false, \"message\": \"Invalid request path\"}");
	        }
	    }
	    private JsonObject CovertJson( HttpServletRequest request) throws ServletException, IOException
	    {
	    	  
	        StringBuilder jsonBody = new StringBuilder();
	        String line;
	        try (BufferedReader reader = request.getReader()) {
	            while ((line = reader.readLine()) != null) {
	                jsonBody.append(line);
	            }
	        }

	        // Parse the JSON
	        JsonObject jsonObject = JsonParser.parseString(jsonBody.toString()).getAsJsonObject();
	        return jsonObject;
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

	    private void getLogin(HttpServletResponse response, HttpServletRequest request)  throws ServletException, IOException {
	        response.setContentType("application/json");
	        response.setCharacterEncoding("UTF-8");

	        // Database connection parameters
	        try {
	            Class.forName("com.mysql.jdbc.Driver");
	            Connection con = DriverManager.getConnection("jdbc:mysql://localhost/emp_data", "root", "");

	            JsonObject json_body = this.CovertJson(request);
	            String email = json_body.get("email").getAsString();
	            String password = json_body.get("password").getAsString();

	            System.out.println("Email: " + email);
	            System.out.println("Password: " + password);

	            // Prepare SQL query to check if the user exists with the given credentials
	            PreparedStatement ps = con.prepareStatement("SELECT * FROM registeruser WHERE email = ? AND password = ?");
	            ps.setString(1, email);
	            ps.setString(2, password);

	            PrintWriter out = response.getWriter();
	            ResultSet rs = ps.executeQuery();

	            if (rs.next()) {
	                // User found
	                out.print("{\"success\": true, \"message\": \"Login successful\"}");
	            } else {
	                // User not found or credentials are incorrect
	                out.print("{\"success\": false, \"message\": \"Invalid Email or Password\"}");
	            }

	            rs.close();
	            con.close();
	        } catch (Exception e) {
	            e.printStackTrace();
	            response.getWriter().print("{\"success\": false, \"message\": \"Error occurred during login\"}");
	        }
	    

	        // Convert the list to JSON
	        Gson gson = new Gson();
	    //    String jsonResponse = gson.toJson(adventures);

	        // Send the response
	        PrintWriter out = response.getWriter();
	    //    out.print(jsonResponse);
	        out.flush();
	    }
}
