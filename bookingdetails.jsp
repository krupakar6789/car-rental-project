<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Booking details</title>
</head>
<body>
    <h2>Bookings</h2>
    <table border=2px solid black cellpadding="5">
        <tr>
            <th>Email Id</th>
            <th>Vehicle Number</th>
            <th>Check In</th>
            <th>Check Out</th>
            <th>Rent</th>
            <th>Total Rent</th>
            
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
                String selectQuery = "SELECT * FROM BOOKINGS";
                stmt = conn.createStatement();
                rs = stmt.executeQuery(selectQuery);

                // Iterate over the ResultSet and display the data
                while (rs.next()) {
                    String email = rs.getString("USER_EMAIL");
                    String vnum = rs.getString("VEHICLE_NUMBER");
                    String checkin = rs.getString("CHECK_IN");
                    String checkout = rs.getString("CHECK_OUT");
                    String rent = rs.getString("RENT_PER_HOUR");
                    String totalrent = rs.getString("TOTAL_RENT");
                    
                    // Display the data row in the HTML table
                    
                    out.println("<tr>");
                    out.println("<td>" + email + "</td>");
                    out.println("<td>" + vnum + "</td>");
                    out.println("<td>" + checkin + "</td>");
                    out.println("<td>" + checkout + "</td>");
                    out.println("<td>" + rent + "</td>");
                    out.println("<td>" + totalrent + "</td>");
                    
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
