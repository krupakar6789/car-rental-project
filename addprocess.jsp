<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<% 
    String brand = request.getParameter("name");
    String model = request.getParameter("model");
    String carNumber = request.getParameter("number");
    int seatingCapacity = Integer.parseInt(request.getParameter("seating"));
    String rent = request.getParameter("rent");
    String description = request.getParameter("description");
    String category = request.getParameter("cars");
    String img=request.getParameter("img");
    Connection conn = null;
    PreparedStatement stmt = null;
    
    try {
        // Establish database connection
        Class.forName("oracle.jdbc.driver.OracleDriver");
        conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE","system","tiger");

        // Insert car details into the "cars" table
        String insertQuery = "INSERT INTO CARS (vname, vmodel, vnum, scapacity, rent, description,category,IMAGE_PATH) VALUES (?, ?, ?, ?, ?, ?,?,?)";
        stmt = conn.prepareStatement(insertQuery);
        stmt.setString(1, brand);
        stmt.setString(2, model);
        stmt.setString(3, carNumber);
        stmt.setInt(4, seatingCapacity);
        stmt.setString(5, rent);
        stmt.setString(6, description);
        stmt.setString(7,category);
        stmt.setString(8,img);
        int rowsInserted = stmt.executeUpdate();
        
        if (rowsInserted > 0) {
            response.sendRedirect("cardetails.jsp");
        } else {
            throw new SQLException("Failed to insert car details.");
        }
    } 
    catch (Exception e) {
        e.printStackTrace();
    } finally {
        // Close database resources
        if (stmt != null) {
            try {
                stmt.close();
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
