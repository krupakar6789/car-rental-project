<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%
    String userEmail = (String) session.getAttribute("email");
    
%>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Profile</title>
    <script src="https://kit.fontawesome.com/15d438045a.js" crossorigin="anonymous"></script>
    <style>
       input {
        width:300px;
        padding: 10px 10px;
        margin: 8px 0;
        display: inline-block;
        border: 1px solid #f8f4f4;
        border-radius: 5px;
        box-sizing: border-box;
        font-size:18px;
        
        }
        input[type=submit] {
        width: 55%;
        background-color: #4CAF50;
        color: white;
        padding: 10px 14px;
        margin: 8px 0;
        border: none;
        border-radius: 4px;
        cursor: pointer;
        }
        input[type=submit]:hover {
        background-color: #45a049;
        }

.update {
  border-radius: 15px;
  padding: 20px;
  width:700px;
  background-color: rgb(243, 242, 242);
}
.update{
    display:inline-block;
}
label{
    font-size: 20px;
    margin-left: -200px;
}
.left{
    float:left;
    width:350px;
}
    </style>
</head>
<body>
    <% 
            Connection conn = null;
            Statement stmt = null;
            ResultSet rs = null;
            
            try {
                // Establish database connection
                Class.forName("oracle.jdbc.driver.OracleDriver");
                conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE","system","tiger");

                // Execute SELECT query
                String selectQuery = "SELECT * FROM USERS WHERE EMAIL=?";
                PreparedStatement pstmt = conn.prepareStatement(selectQuery);
                pstmt.setString(1, userEmail);
                rs = pstmt.executeQuery();

                // Iterate over the ResultSet and display the data
                while (rs.next()) {
                    String fname = rs.getString("FNAME");
                    String lname = rs.getString("LNAME");
                    String email = rs.getString("EMAIL");
                    String gender = rs.getString("GENDER");
                    String age = rs.getString("AGE");
                    String license = rs.getString("LICENSE");
                    java.util.Date date = rs.getDate("EXPIRATION_DATE");
    %>
    <br><br>
    <center>
    <div class="update">
    <form action="updateprofile.jsp" method="post">
        <div class="left">
        <label for="fname" style="margin-left: -200px;">First Name:</label><br>
        <input type="text" id="fname" name="fname" value="<%= fname %>"><br></div>
        <div class="left">
        <label for="lname" style="margin-left: -200px;">Last Name:</label><br>
        <input type="text" id="lname" name="lname" value="<%= lname %>"><br></div><br>
        <div class="left">
        <label for="email" style="margin-left: -230px;">Email:</label><bR>
        <input type="text" id="email" name="email" value="<%= userEmail %>" readonly><br></div>
        <div class="left">
        <label for="gender" style="margin-left: -230px;">Gender:</label><br>
        <input type="text" id="gender" name="gender" value="<%= gender %>"><br></div><br>
        <div class="left">
        <label for="age" style="margin-left: -250px;">Age:</label><br>
        <input type="text" id="age" name="age" value="<%= age %>"><br></div>
        <div class="left">
        <label for="license" style="margin-left: -90px;">Driving License Number:</label><br>
        <input type="text" id="license" name="license" value="<%= license %>"><br></div>
        <div class="left">
        <label for="verificationDate" style="margin-left:-150px;">Expiration Date:</label><br>
        <input type="date" id="verificationDate" name="verificationDate" value="<%= date %>"></div>
            
        <input type="submit" value="Update">
    </form>
</div></center>
<%
}
}catch (Exception e) {
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
</body>
</html>
