<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.Date" %>
<%
    String userEmail = (String) session.getAttribute("email");

    // Retrieve license and date from the database
    Connection conn = null;
    Statement stmt = null;
    ResultSet rs = null;
    String license = null;
    java.util.Date date = null;
    boolean isVerified = false;
    
    try {
        // Establish database connection
        Class.forName("oracle.jdbc.driver.OracleDriver");
        conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE","system","tiger");
        stmt = conn.createStatement();
        
        // Execute the query
        String selectQuery = "SELECT AGE,LICENSE, EXPIRATION_DATE FROM USERS WHERE EMAIL='" + userEmail + "'";
        rs = stmt.executeQuery(selectQuery);
        
        // Retrieve the data from the result set
        if (rs.next()) {
            String ageStr=rs.getString("AGE");
            license = rs.getString("LICENSE");
            date = rs.getDate("EXPIRATION_DATE");
            int age=0;
            age = Integer.parseInt(ageStr);
            // Check if verification date is greater than today's date
            Date currentDate = new Date();
            if (date.compareTo(currentDate) > 0&& age>=18) {
                isVerified = true;
            }
        }
        
        // Update the verification status in the database
        if (isVerified) {
            String updateQuery = "UPDATE USERS SET VERIFIED='Yes' WHERE EMAIL='" + userEmail + "'";
            stmt.executeUpdate(updateQuery);
        }else{
            String updateQuery = "UPDATE USERS SET VERIFIED='No' WHERE EMAIL='" + userEmail + "'";
            stmt.executeUpdate(updateQuery);
        }
        response.sendRedirect("profile.jsp");
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
