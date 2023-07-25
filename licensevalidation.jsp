<%@ page import="java.io.InputStream" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>

<%
    String userEmail = "suresh@gmail.com";
    // Retrieve the uploaded image file
    Part filePart = request.getPart("licenseImage");
    InputStream inputStream = filePart.getInputStream();
    
    // Establish database connection
    Connection conn = null;
    PreparedStatement pstmt = null;
    
    try {
        // Your database connection code here
        // ...
        
        // Prepare the SQL statement
        String query = "UPDATE USERS SET LICENSE_IMAGE = ? WHERE EMAIL = ?";
        pstmt = conn.prepareStatement(query);
        
        // Set the parameter values
        pstmt.setBinaryStream(1, inputStream);
        pstmt.setString(2, userEmail);
        
        // Execute the update statement
        pstmt.executeUpdate();
        
        // ...
        
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        // Close database resources
        // ...
    }
%>
