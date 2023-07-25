<%
    // Retrieve the admin email from the session attribute
    String adminEmail = (String) session.getAttribute("adminEmail");
    String adminUsername = adminEmail.substring(0, adminEmail.indexOf("@"));
%>

<!DOCTYPE html>
<html>
<head>
    <title>Admin Home</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-Fy6S3B9q64WdZWQUiU+q4/2Lc9npb8tCaSX9FK7E8HnRr0Jz8D6OP9dO5Vg3Q9ct" crossorigin="anonymous"></script>
    <style>
      ul li a{text-decoration: none;margin-top:15px;color:white;}
      ul li{list-style: none;display:inline-flex;width:170px;}
    .row{background-color:rgb(1, 1, 71);}
    .my-link:hover {
  color: white; }
.my-link:visited {
  color:white; 
}

    </style>
</head>
<body>
<div class="container-fluid">
  <nav class="navbar navbar-light bg-light">
    <span class="navbar-brand mb-0 h1">Welcome, <%= adminUsername %>!</span>
    <a href="home.jsp" style="color:black;">Logout</a>
  </nav>
   <div class="row">
  <ul>

    <li><a href="#" onclick="loadContent('addcar.html')" class="my-link">Add Car</a></li>
    <li><a href="#" onclick="loadContent('userdetails.jsp')" class="my-link">User Details</a></li>
    <li><a href="#" onclick="loadContent('bookingdetails.jsp')" class="my-link">Booking Details</a></li>
    <li><a href="#" onclick="loadContent('cardetails.jsp')" class="my-link">Car Details</a></li>
</ul>
</div><br><br>
<iframe id="contentFrame" src="" width="100%" height="600px" frameborder="0"></iframe>
</div>
<script>
    function loadContent(page) {
        document.getElementById('contentFrame').src = page;
    }
</script>
</body>
</html>



