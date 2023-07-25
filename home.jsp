<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
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
        <a class="nav-link" href="home.jsp">Home <span class="sr-only">(current)</span></a>
      </li>
      <li class="nav-item active">
        <a class="nav-link" href="about.html">About <span class="sr-only">(current)</span></a>
      </li>
      <li class="nav-item dropdown active">
        <a class="nav-link dropdown-toggle" href="#" role="button" data-toggle="dropdown" aria-expanded="false">
          Cars <span class="sr-only">(current)</span>
        </a>
        <div class="dropdown-menu">
          <a class="dropdown-item" href="luxurycars.jsp">Luxury Cars</a>
          <a class="dropdown-item" href="tempocars.jsp">Tempo Traveller</a>
          <a class="dropdown-item" href="volvocars.jsp">Volvo Cars</a>
          <a class="dropdown-item" href="specialcars.jsp">Special Cars</a>
        </div>
      </li>
      <li class="nav-item dropdown active">
        <a class="nav-link dropdown-toggle" href="login.html" role="button" data-toggle="dropdown" aria-expanded="false">
          Login <span class="sr-only">(current)</span>
        </a>
        <div class="dropdown-menu">
          <a class="dropdown-item" href="adminlogin.jsp">Login as Admin</a>
          <a class="dropdown-item" href="user.jsp">Login as User</a>
        </div>
      </li>

    </ul>
    <form class="form-inline my-2 my-lg-0">
      <form action="" method="GET">
          <input class="form-control mr-sm-2" type="search" placeholder="Search" name="carName" aria-label="Search">
          <input class="btn btn-outline-success my-2 my-sm-0" type="submit"></button>
      </form>
    </form>
  </div>
  </nav>
  <%-- Display search results here --%>
        <%
            String carName = request.getParameter("carName");

            if (carName != null && !carName.isEmpty()) {
                // Declare variables
                Connection conn = null;
                PreparedStatement pstmt = null;
                ResultSet rs = null;
                try {
                  // Establish the database connection
                  Class.forName("oracle.jdbc.driver.OracleDriver");
                  String dbURL = "jdbc:oracle:thin:@localhost:1521:xe";
                  String dbusername = "system";
                  String password = "tiger";
                  conn = DriverManager.getConnection(dbURL, dbusername, password);

                  String selectQuery = "SELECT * FROM CARS WHERE UPPER(vname) LIKE ?";
                  pstmt = conn.prepareStatement(selectQuery);
                  pstmt.setString(1, "%" + carName.toUpperCase() + "%");

                  // Execute the query
                  rs = pstmt.executeQuery();
                  // Display the search results
                    while (rs.next()) {
                        String name = rs.getString("vname");
                        String model = rs.getString("vmodel");
                        String num = rs.getString("vnum");
                        String scapacity = rs.getString("scapacity");
                        String rent = rs.getString("rent");
                        String description = rs.getString("description");
                        String img = rs.getString("IMAGE_PATH");

                        out.println("<div class=\"card mb-3\">");
                        out.println("    <div class=\"row no-gutters\">");
                        out.println("        <div class=\"col-md-6\">");
                        out.println("            <img src=\"" + img + "\" alt=\"...\" width=\"300px\" height=\"200px\">");
                        out.println("        </div>");
                        out.println("        <div class=\"col-md-6\">");
                        out.println("            <div class=\"card-body\">");
                        out.println("                <h5 class=\"card-title\">" + name + "&nbsp;" + model + "</h5>");
                        out.println("                <p class=\"card-text\">" + num + "</p>");
                        out.println("                <p class=\"card-text\">Seating capacity: " + scapacity + "</p>");
                        out.println("                <p class=\"card-text\">Rent: " + rent + "</p>");
                        out.println("                <p class=\"card-text\">" + description + "</p>");
                        out.println("                <a href=\"rentacar.jsp?vnum=" + num + "&rent=" + rent + "\" class=\"btn btn-primary\">Rent car</a>");
                        out.println("            </div>");
                        out.println("        </div>");
                        out.println("    </div>");
                        out.println("</div>");
                    }
                } catch (ClassNotFoundException e) {
                    e.printStackTrace();
                    out.println("Failed to load the database driver.");
                } catch (SQLException e) {
                    e.printStackTrace();
                    out.println("An error occurred while executing the SQL statement: " + e.getMessage());
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
            }
        %>
  <img src="images/CAR.jpg" width="100%" height="100%"><br><br>


  <div class="container-fluid" style="overflow-x: hidden;"><br>
        <div class="row text-center">
            <div class="col-lg-3 col-sm-6 col-xs-12">
                <a href="luxurycars.jsp" target="_self"><img src="images/luxury.jpeg" alt="..." width="230px" height="200px"></a>
                <h4 style="text-align:center">Luxury Cars</h4>
            </div>
            <div class="col-lg-3 col-sm-6 col-xs-12">
                <a href="tempocars.jsp"><img src="images/tempo.jpg" alt="..." width="230px" height="200px"></a>
                <h4 style="text-align:center">Tempo Traveller</h4>
            </div>
            <div class="col-lg-3 col-sm-6 col-xs-12">
                <a href="volvocars.jsp"><img src="images/volvo.jpg" alt="..." width="230px" height="200px"></a>
                <h4 style="text-align:center">Volvo</h4>
            </div>
            <div class="col-lg-3 col-sm-6 col-xs-12">
              <a href="specialcars.jsp"><img src="images/ferrari.webp" alt="..." width="230px" height="200px"></a>
              <h4 style="text-align:center">Special Cars</h4>
          </div>
        </div>
      </div>
      <br><br>
     
  <div id="myCarousel" class="carousel slide" data-ride="carousel">
    <!-- Slides -->
    <div class="carousel-inner">
      <div class="carousel-item active">
        <div class="container">
          <div class="row">
            <div class="col-md-4">
              <div class="card">
                <img src="images/carousel1.png" class="card-img-top" alt="Image 1" height="500px">
                <div class="card-img-overlay">
                  <h2 class="card-title">Drive worry free with Rent-A-Car</h2>
                </div>
              </div>
            </div>
            <div class="col-md-4">
              <div class="card">
                <img src="images/carousel2.webp" class="card-img-top" alt="Image 2" height="500px">
                <div class="card-img-overlay">
                  <h2 class="card-title">Enjoy Unlimited Kilometers.</h2>
                </div>
              </div>
            </div>
            <div class="col-md-4">
              <div class="card">
                <img src="images/carousel3.jpeg" class="card-img-top" alt="Image 3" height="500px">
                <div class="card-img-overlay">
                  <h2 class="card-title">Rent, Ride, Explore!</h2>
                  
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>

      <div class="carousel-item">
        <div class="container">
          <div class="row">
            <div class="col-md-4">
              <div class="card">
                <img src="images/carousel4.jpeg" class="card-img-top" alt="Image 4" height="500px">
                <div class="card-img-overlay">
                  <h2 class="card-title">Keyless Access</h2>
                </div>
              </div>
            </div>
            <div class="col-md-4">
              <div class="card">
                <img src="images/carousel5.jpg" class="card-img-top" alt="Image 5" height="500px">
                <div class="card-img-overlay">
                  <h2 class="card-title">Never Stop Exploring!</h2>
                  
                </div>
              </div>
            </div>
            <div class="col-md-4">
              <div class="card">
                <img src="images/carousel6.jpeg" class="card-img-top" alt="Image 4" height="500px">
                <div class="card-img-overlay">
                  <h2 class="card-title">Discover the World, Your Way</h2>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- Add more carousel items here for additional slides -->

    </div>

    <!-- Controls -->
    <a class="carousel-control-prev" href="#myCarousel" role="button" data-slide="prev">
      <span class="carousel-control-prev-icon" aria-hidden="true"></span>
      <span class="sr-only">Previous</span>
    </a>
    <a class="carousel-control-next" href="#myCarousel" role="button" data-slide="next">
      <span class="carousel-control-next-icon" aria-hidden="true"></span>
      <span class="sr-only">Next</span>
    </a>
  </div>
      <br><br><br>
      <div class="container-fluid" style="overflow-x: hidden;">
        <div class="row" style="background-color: rgb(48, 47, 47);color:whitesmoke">
          <div class="col-1"></div>
          <div class="col-10"><br><br>
            <h4>About Rent-A-Car</h4>
<p>Rent-A-Car is India's largest marketplace for cars on rent. From short road trips to quick in-city drives for groceries, supply pick-up, food runs, we have the cheapest car rental options for all your needs!</p>
<p>With Rent-A-Car, you can experience the convenience of online booking. The cars listed on our platform come with all-India permits that include vehicle insurance. It is extremely easy to pick up the car from the host location. You can drive unlimited KMs, with 100% Free Cancellation up to 6 hours before the trip start, 0 Security Deposit, 0 Toll Charges, and 24/7 Roadside Assistance.From short road trips to quick in-city drives for groceries, supply pick-up, meeting friends and family, doctor visits, business trips, we have the cheapest car rental options for all your needs!</p><br>
<h4>Why Rent-A-Car?</h4>
<p>Unlimited KMs</p>
<p>You must never stop exploring! That's why you get unlimited KMs with every booking!</p>
<p>No Paperwork</p>
<p>Rent a car & start traveling with zero paperwork requirements! All you need in your driver's license, national ID & a live selfie!</p>
<p>Long-Duration</p>
<p>Don't put a limit to your travel plans - our long-duration bookings are here for you. Remember, the longer you book for, the more you save!</p>
<p>Keyless Access</p>
<p>Rent-A-Car gives you the freedom of self-drive! With budget car rental solutions, Zoomcar offers the best offers, the cheapest prices and a wide range of cars to choose from. Get unlimited KMs, Free Cancellation, 0 Security Deposit, 0 Toll Charges.</p>
<br>
          </div>
        </div>
        <div class="row" style="background-color: #c1c1c1;color:rgb(27, 26, 26)"><br>
          <div class="col-1"></div>
            <div class="col-3">
                <br><br>
                <p>Contact Us</p>
                <p>Ph No: 9381625676</p>
                <p>Tel No: 0856-743987</p>
                <p>Email Us: carrental@gmail.com</p>
                <br><br>
            </div>
            <div class="col-3">
                <br><br>
                <h6>Quick Links</h6>
                <a href="about.html" class="anchor">About Us</a><br>
                <a href="user.jsp" class="anchor">Login</a><br>
                <a href="register.html" class="anchor">Sign Up</a>
            </div>
                <div class="col-3">
                <br><br>
                <h4><i class="fa-solid fa-copyright"></i>&nbsp;Rent-A-Car</h4>
                <h5>Never Stop Exploring!!!</h5>
                <br><br>
                <br><br><br>
            </div>
            
        </div>
      </div>

</body>
</html>