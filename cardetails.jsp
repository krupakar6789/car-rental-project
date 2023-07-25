<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Car List</title>
</head>
<body>
    <h2>Cars</h2>
    <table border=2px solid black cellpadding="5">
        <tr>
            <th>Brand</th>
            <th>Model</th>
            <th>Car Number</th>
            <th>Seating Capacity</th>
            <th>Rent</th>
            <th>Description</th>
            <th>Category</th>
            <th>Image</th>
            <th></th>
        </tr>
        <% 
            Connection conn = null;
            Statement stmt = null;
            ResultSet rs = null;
            
            try {
                // Establish database connection
                Class.forName("oracle.jdbc.driver.OracleDriver");
                conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE","system","tiger");

                // Execute SELECT query
                String selectQuery = "SELECT * FROM CARS";
                stmt = conn.createStatement();
                rs = stmt.executeQuery(selectQuery);

                // Iterate over the ResultSet and display the data
                while (rs.next()) {
                    String brand = rs.getString("vname");
                    String model = rs.getString("vmodel");
                    String carNumber = rs.getString("vnum");
                    int seatingCapacity = rs.getInt("scapacity");
                    String rent = rs.getString("rent");
                    String description = rs.getString("description");
                    String category = rs.getString("category");
                    String img=rs.getString("IMAGE_PATH");
                    // Display the data row in the HTML table
                    
                    out.println("<tr>");
                    out.println("<td>" + brand + "</td>");
                    out.println("<td>" + model + "</td>");
                    out.println("<td>" + carNumber + "</td>");
                    out.println("<td>" + seatingCapacity + "</td>");
                    out.println("<td>" + rent + "</td>");
                    out.println("<td>" + description + "</td>");
                    out.println("<td>" + category + "</td>");
                    out.println("<td>" + img + "</td>");
                    out.println("<td><a href='editcar.jsp?carNumber=" + carNumber + "&vname=" + brand + "&vmodel=" + model + "&scapacity=" + seatingCapacity + "&rent=" + rent + "&description=" + description + "&category=" + category + "&image_path=" + img + "'>edit</a></td>");


                    out.println("</tr>");
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                // Close database resources
                if (rs != null) {
                    try {
                        rs.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
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
    </table>
</body>
</html>
