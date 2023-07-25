<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%
    String userEmail = (String) session.getAttribute("email");
    String username = "";
if (userEmail != null) {
    username = userEmail.substring(0, userEmail.indexOf("@"));
}
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-Fy6S3B9q64WdZWQUiU+q4/2Lc9npb8tCaSX9FK7E8HnRr0Jz8D6OP9dO5Vg3Q9ct" crossorigin="anonymous"></script>
    <script src="https://kit.fontawesome.com/ea4f812ebc.js" crossorigin="anonymous"></script>
    <title>Rent-A-Car</title>
    <style>
       .anchor{
            color:black;
            text-decoration: none;
        }
        .card-img-overlay {
      background-color: rgba(0, 0, 0, 0.3);
      color: white;
      padding: 20px;
    }
   
    </style>
</head>
<body>

    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <a class="navbar-brand" href="#">RentACar</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
      
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav mr-auto">
                <li class="nav-item active">
                    <a class="nav-link" href="userhomepage.jsp">Home <span class="sr-only">(current)</span></a>
                </li>
                <li class="nav-item active">
                    <a class="nav-link" href="profile.jsp">My Profile <span class="sr-only">(current)</span></a>
                </li>
                <li class="nav-item active">
                    <a class="nav-link" href="userbookings.jsp">My Bookings <span class="sr-only">(current)</span></a>
                </li>
                
                
            </ul>
            <ul class="navbar-nav ml-auto">
              <li class="nav-item dropdown active">
                <a class="nav-link dropdown-toggle" href="#" role="button" data-toggle="dropdown" aria-expanded="false">
                    Welcome,<%= username %>! <span class="sr-only">(current)</span>
                </a>
                <div class="dropdown-menu">
                    <a class="dropdown-item" href="logout.jsp">Logout</a>
                   
                  </div>
            </li>
            </ul>
        </div>
    </nav><br><br><center><h2>My Bookings</h2></center>
    
    <% 
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        
        try {
            // Establish database connection
            Class.forName("oracle.jdbc.driver.OracleDriver");
            conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE","system","tiger");

            // Execute SELECT query
            String selectQuery = "SELECT * FROM BOOKINGS,CARS WHERE CARS.vnum=BOOKINGS.vehicle_number AND BOOKINGS.USER_EMAIL=?";
            PreparedStatement pstmt = conn.prepareStatement(selectQuery);
            pstmt.setString(1, userEmail);
            rs = pstmt.executeQuery();

            // Iterate over the ResultSet and display the data
            while (rs.next()) {
                String email = rs.getString("USER_EMAIL");
                String vnum = rs.getString("VEHICLE_NUMBER");
                String name = rs.getString("vname");
                String model = rs.getString("vmodel");
                String img = rs.getString("image_path");
                String checkin = rs.getString("CHECK_IN");
                String checkout = rs.getString("CHECK_OUT");
                String rent = rs.getString("RENT_PER_HOUR");
                String totalrent = rs.getString("TOTAL_RENT");
    %>
    <center>
       
        <div class="container">
        
    <div class="card mb-3" style="max-width: 750px;">
        
        <div class="row no-gutters">
            <div class="col-md-6">
                <img src="<%= img %>" alt="..." width="300px" height="200px">
            </div>
            <div class="col-md-6" style="text-align: left;">
                <div class="card-body">
                    <h5 class="card-title"><%= name %>&nbsp;<%= model %></h5>
                    <p class="card-text"><%= vnum %></p>
                    <p class="card-text">Check In : <%= checkin %></p>
                    <p class="card-text">Check Out : <%= checkout %></p>
                    <p class="card-text">Rent : <%= rent %></p>
                    <p class="card-text">Total Rent : <%= totalrent %></p>
                   
                </div>
            </div>
        </div>
    </div>
    </div>
    </center>
    <%
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
</body>
</html>
