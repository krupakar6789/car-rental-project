<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%
    String userEmail = (String) session.getAttribute("email");
    
%>
<%

// Retrieve the vehicle number from the previous page
String vehicleNum = request.getParameter("vnum");
String rent=request.getParameter("rent");
// Get the current date and time
LocalDateTime currentDateTime = LocalDateTime.now();

// Format the date and time
DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");


%>

<!DOCTYPE html>
<html>
<head>
    <title>Booking Page</title>
    <style>
         .custom-card {
            max-width: 1000px;
            border-radius: 15px !important;
            overflow: hidden;
        }

        .custom-card .card-img {
            width: 100%;
            height: 550px;
        }
        label {
            font-size: 20px;
        }

        .form-group {
            margin-bottom: 20px;
           float:left;
           width:270px;
            align-items: center;
        }

        .form-group label {
            margin-right: 10px;
        }
    </style>
</head>

<body>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-Fy6S3B9q64WdZWQUiU+q4/2Lc9npb8tCaSX9FK7E8HnRr0Jz8D6OP9dO5Vg3Q9ct" crossorigin="anonymous"></script>
              <center><br>
                  <div class="card mb-3 custom-card">
                      <div class="row no-gutters">
                          <div class="col-md-5">
                              <img class="card-img" src="images/book.jpeg" alt="..." >
                          </div>
                          <div class="col-md-7">
                              <div class="card-body" style="text-align: left;">
                                  <form action="booking.jsp" method="post">
                                      <!-- Your form content -->
                                      <% 
                                      // Check if an error message exists in the session
                                      String Message = (String) session.getAttribute("bookingMessage");
                                      if (Message != null) {
                                          %>
                                          <br><center>
                                          <span style="color: red;font-size: 15px;"><%= Message %></span></center>
                                          <%
                                          // Remove the error message from the session after displaying it
                                          session.removeAttribute("bookingMessage");
                                      }
                                      %><br>
                                      <center><h3>Rent A Car!</h3></center><br>
                                      <div class="form-group">
                                          <label for="vehicleNum">Vehicle Number:</label><br>
                                          <input type="text" id="vehicleNum" name="vehicleNum" value="<%= vehicleNum %>" readonly>
                                      </div>
                                      <div class="form-group">
                                          <label for="email">Email Address:</label><br>
                                          <input type="email" id="email" name="email" value="<%= userEmail %>" readonly>
                                      </div><br>
                                      <div class="form-group">
                                          <label for="checkInDateTime">Check-in Date and Time:</label><br>
                                          <input type="datetime-local" id="checkInDateTime" name="checkInDateTime" required>
                                      </div>
                                      <div class="form-group">
                                          <label for="checkOutDateTime">Check-out Date and Time:</label><br>
                                          <input type="datetime-local" id="checkOutDateTime" name="checkOutDateTime" required>
                                      </div><br>
                                      <div class="form-group">
                                          <label for="rentPerHour">Rent per Hour:</label><br>
                                          <input type="number" id="rentPerHour" name="rentPerHour" value="<%= rent %>" readonly>
                                      </div>
                                      <div class="form-group">
                                          <label for="totalRent">Total Rent:</label><br>
                                          <input type="number" id="totalRent" name="totalRent" readonly>
                                      </div><br>
                                      <div class="form-group">
                                          <input type="hidden" id="rentAmount" name="rentAmount">
                                          <input type="button" value="Calculate Rent" onclick="calculateRent()" class="btn btn-primary"><br><br>
                                          <input type="submit" value="Book Now" class="btn btn-primary">
                                      </div>
                                  </form>
                              </div>
                          </div>
                      </div>
                  </div>
              </center>
          
    
    <script>
        function calculateRent() {
            var checkInDateTime = new Date(document.getElementById("checkInDateTime").value);
            var checkOutDateTime = new Date(document.getElementById("checkOutDateTime").value);
            var rentPerHour = document.getElementById("rentPerHour").value;
            
            var timeDiff = checkOutDateTime.getTime() - checkInDateTime.getTime();
            var hours = Math.ceil(timeDiff / (1000 * 60 * 60));
            var totalRent = hours * rentPerHour;
            
            document.getElementById("totalRent").value = totalRent;
        }
    </script>
</body>
</html>
