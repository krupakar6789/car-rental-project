<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.ParseException" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<!DOCTYPE html>
<html>
<head>
    <title>Booking Confirmation</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
        }

        .confirmation-container {
            max-width: 500px;
            margin: 50px auto;
            background-color: #fff;
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }.confirmation-container h1 {
            font-size: 24px;
            color: #333;
            margin-bottom: 10px;
        }

        .confirmation-container p {
            color: #555;
            margin-bottom: 10px;
        }

        .confirmation-container .highlight {
            font-weight: bold;
            color: #333;
        }.confirmation-container .success-message {
            color: #008000;
            font-weight: bold;
            margin-top: 20px;
        }

        .confirmation-container .error-message {
            color: #ff0000;
            font-weight: bold;
            margin-top: 20px;
        }
    </style>
</head>
<body>
<%
String userEmail = request.getParameter("email");
String vehicleNumber = request.getParameter("vehicleNum");
String rentPerHour = request.getParameter("rentPerHour");
String totalRent = request.getParameter("totalRent");

// Retrieve the form data from the request
String checkInDateTimeStr = request.getParameter("checkInDateTime");
String checkOutDateTimeStr = request.getParameter("checkOutDateTime");

// Declare variables
Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;
boolean isVerified = false;

try {
    // Parse the timestamp strings to LocalDateTime objects
    LocalDateTime checkInDateTime = LocalDateTime.parse(checkInDateTimeStr);
    LocalDateTime checkOutDateTime = LocalDateTime.parse(checkOutDateTimeStr);

    // Format the parsed date and time values
    DateTimeFormatter outputFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
    String formattedCheckInDateTime = checkInDateTime.format(outputFormatter);
    String formattedCheckOutDateTime = checkOutDateTime.format(outputFormatter);

    // Establish the database connection
    Class.forName("oracle.jdbc.driver.OracleDriver");
    String dbURL = "jdbc:oracle:thin:@localhost:1521:xe";
    String username = "system";
    String password = "tiger";
    conn = DriverManager.getConnection(dbURL, username, password);

    String selectQuery = "SELECT VERIFIED FROM USERS WHERE EMAIL = ?";
    pstmt = conn.prepareStatement(selectQuery);
    pstmt.setString(1, userEmail);
    
    // Execute the query
    rs = pstmt.executeQuery();
    
    // Retrieve the data from the result set
    if (rs.next()) {
        String verifiedStatus = rs.getString("VERIFIED");
        
        // Check if user is verified
        if (verifiedStatus != null && verifiedStatus.equalsIgnoreCase("Yes")) {
            isVerified = true;
        }
    }
    
    if (isVerified) {

        String insertQuery = "INSERT INTO BOOKINGS (USER_EMAIL, VEHICLE_NUMBER, CHECK_IN, CHECK_OUT, RENT_PER_HOUR, TOTAL_RENT) VALUES (?, ?, TO_TIMESTAMP(?, 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP(?, 'YYYY-MM-DD HH24:MI:SS'), ?, ?)";
        pstmt = conn.prepareStatement(insertQuery);
        pstmt.setString(1, userEmail);
        pstmt.setString(2, vehicleNumber);
        pstmt.setString(3, formattedCheckInDateTime);
        pstmt.setString(4, formattedCheckOutDateTime);
        pstmt.setString(5, rentPerHour);
        pstmt.setString(6, totalRent);

        // Execute the SQL statement to insert the data
        int rowsInserted = pstmt.executeUpdate();

        %>
        <div class="confirmation-container">
            <h1>Booking Confirmation</h1>
        
            <p>Thank you for your booking. Below are the details:</p>
            <p>User Email: <span class="highlight"><%= userEmail %></span></p>
            <p>Vehicle Number: <span class="highlight"><%= vehicleNumber %></span></p>
            <p>Check-in DateTime: <span class="highlight"><%= formattedCheckInDateTime %></span></p>
            <p>Check-out DateTime: <span class="highlight"><%= formattedCheckOutDateTime %></span></p>
            <p>Rent Per Hour: <span class="highlight"><%= rentPerHour %></span></p>
            <p>Rent Amount: <span class="highlight"><%= totalRent %></span></p>
            <p>Please note down these details for future reference.</p>
            <p>Enjoy your trip!</p>
            <p class="success-message">Your booking has been confirmed.</p>
            <p><a href="userhomepage.jsp" style="color:black;text-decoration: none;"><span class="highlight">Click here</span>
            </a>to go to home page.</p>
        
        <%

        if (rowsInserted > 0) {
            // Successful booking
        } else {
            // Display an error message
            out.println("Failed to insert data into the database.");
        }
    } else {
        
        session.setAttribute("bookingMessage", "User verification failed. Please verify your account before booking.");
        response.sendRedirect("rentacar.jsp");
    }
} catch (ClassNotFoundException e) {
    // Print the stack trace for debugging purposes
    e.printStackTrace();

    // Display an error message
    out.println("Failed to load the database driver.");
} catch (SQLException e) {
    // Print the stack trace for debugging purposes
    e.printStackTrace();

    // Display an error message with the specific SQL error
    out.println("An error occurred while executing the SQL statement: " + e.getMessage());
} catch (Exception e) {
    // Print the stack trace for debugging purposes
    e.printStackTrace();

    // Display a generic error message
    out.println("An error occurred while processing your request."+ e.getMessage());
} finally {
    // Close the connection, statement, and result set
    try {
        if (rs != null) {
            rs.close();
        }
        if (pstmt != null) {
            pstmt.close();
        }
        if (conn != null) {
            conn.close();
        }
    } catch (SQLException ex) {
        ex.printStackTrace();
    }
}
%>
</body>
</html>
