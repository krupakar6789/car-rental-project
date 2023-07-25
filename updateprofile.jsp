<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.text.ParseException" %>

<%
    String userEmail = (String) session.getAttribute("email");
    
%>
<!DOCTYPE html>
<html>
<head>
    <title>Update Profile</title>
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
            String fname = request.getParameter("fname");
            String lname = request.getParameter("lname");
            String email = request.getParameter("email");
            String gender = request.getParameter("gender");
            String age = request.getParameter("age");
            String license=request.getParameter("license");
            String dateStr = request.getParameter("verificationDate");

// Convert date string to java.sql.Date object
java.sql.Date date = null;
try {
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    java.util.Date utilDate = sdf.parse(dateStr);
    date = new java.sql.Date(utilDate.getTime());
} catch (ParseException e) {
    e.printStackTrace();
    // Handle date parsing error
}

            // Update the car details in the database
            String updateQuery = "UPDATE USERS SET FNAME=?, LNAME=?, GENDER=?, AGE=?,LICENSE=?,EXPIRATION_DATE=? WHERE EMAIL=?";
            pstmt = conn.prepareStatement(updateQuery);
            pstmt.setString(1, fname);
            pstmt.setString(2, lname);
            pstmt.setString(3, gender);
            pstmt.setString(4, age);
            pstmt.setString(5, license);
            pstmt.setDate(6, date);
            pstmt.setString(7,email);
            
            
            int rowsAffected = pstmt.executeUpdate();
            
            if (rowsAffected > 0) {
                response.sendRedirect("validate.jsp");
            } else {
                out.println("<p>Failed to update car details.</p>");
            }
        }catch (Exception e) {
            out.println("<p>Error: " + e.getMessage() + "</p>");
            e.printStackTrace();
        }
        finally {
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
