<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Update Car</title>
</head>
<body>
    
    <% 
        Connection conn = null;
        PreparedStatement pstmt = null;
        
        try {
            // Establish database connection
            Class.forName("oracle.jdbc.driver.OracleDriver");
            conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE","system","tiger");

            // Get the form data
            String carNumber = request.getParameter("carNumber");
            String brand = request.getParameter("brand");
            String model = request.getParameter("model");
            int seatingCapacity = Integer.parseInt(request.getParameter("seatingCapacity"));
            String rent = request.getParameter("rent");
            String category = request.getParameter("cars");
            String description = request.getParameter("description");
            String img=request.getParameter("img");

            // Update the car details in the database
            String updateQuery = "UPDATE CARS SET vname=?, vmodel=?, scapacity=?, rent=?, description=?,category=?,IMAGE_PATH=? WHERE vnum=?";
            pstmt = conn.prepareStatement(updateQuery);
            pstmt.setString(1, brand);
            pstmt.setString(2, model);
            pstmt.setInt(3, seatingCapacity);
            pstmt.setString(4, rent);
            pstmt.setString(5, description);
            pstmt.setString(6,category);
            pstmt.setString(7,img);
            pstmt.setString(8, carNumber);
            
            int rowsAffected = pstmt.executeUpdate();
            
            if (rowsAffected > 0) {
                out.println("<p>Car details updated successfully.</p>");
                out.println("<p><a href='cardetails.jsp'>Go back to Car List</a></p>");
            } else {
                out.println("<p>Failed to update car details.</p>");
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // Close database resources
            if (pstmt != null) {
                try {
                    pstmt.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    %>
</body>
</html>
