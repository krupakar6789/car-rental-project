<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>User List</title>
</head>
<body>
    <h2>Users</h2>
    <table border=2px solid black cellpadding="5">
        <tr>
            <th>First Name</th>
            <th>Last Name</th>
            <th>Email Id</th>
            <th>Gender</th>
            <th>Age</th>
            <th>Driving License Number</th>
            <th>Expiration Date</th>
            <th>Verified</th>
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
                String selectQuery = "SELECT * FROM USERS";
                stmt = conn.createStatement();
                rs = stmt.executeQuery(selectQuery);

                // Iterate over the ResultSet and display the data
                while (rs.next()) {
                    String fname = rs.getString("FNAME");
                    String lname = rs.getString("LNAME");
                    String email = rs.getString("EMAIL");
                    String gender = rs.getString("GENDER");
                    String age = rs.getString("AGE");
                    String license=rs.getString("LICENSE");
                    java.util.Date date = rs.getDate("EXPIRATION_DATE");
                    String verified=rs.getString("VERIFIED");
                    
                    // Display the data row in the HTML table
                    
                    out.println("<tr>");
                    out.println("<td>" + fname + "</td>");
                    out.println("<td>" + lname + "</td>");
                    out.println("<td>" + email + "</td>");
                    out.println("<td>" + gender + "</td>");
                    out.println("<td>" + age + "</td>");
                    out.println("<td>"+ license +"</td>");
                    out.println("<td>" + date + "</td>");
                    out.println("<td>" + verified + "</td>");
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
