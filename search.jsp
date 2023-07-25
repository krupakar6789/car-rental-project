<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Car Search Results</title>
</head>
<body>
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
      String username = "system";
      String password = "tiger";
      conn = DriverManager.getConnection(dbURL, username, password);

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
        String img=rs.getString("IMAGE_PATH");
%>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-Fy6S3B9q64WdZWQUiU+q4/2Lc9npb8tCaSX9FK7E8HnRr0Jz8D6OP9dO5Vg3Q9ct" crossorigin="anonymous"></script>
<center>
<div class="card mb-3" style="max-width: 750px;">
    <div class="row no-gutters">
      <div class="col-md-6">
        <img src="<%= img %>" alt="..." width="300px" height="200px">
      </div>
      <div class="col-md-6" style="text-align: left;">
        <div class="card-body">
          <h5 class="card-title"><%= name %>&nbsp;<%= model %></h5>
          <p class="card-text"><%= num %></p>
          <p class="card-text">Seating capacity : <%= scapacity %></p>
          <p class="card-text">Rent : <%= rent %></p>
          <p class="card-text"><%= description %></p>
          <a href="rentacar.jsp?vnum=<%= num %>&rent=<%= rent %>" class="btn btn-primary">Rent car</a>
        </div>
      </div>
    </div>
  </div></center>
<%
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
</body>
</html>
