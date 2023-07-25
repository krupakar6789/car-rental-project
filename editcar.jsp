<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Car</title>
    <script src="https://kit.fontawesome.com/15d438045a.js" crossorigin="anonymous"></script>
    <style>
        body{
            margin-top: 0px;
        }
        input{
    font-size: 20px;
    border: 2px solid black;
    border-radius: 5px;
}
textarea{
    font-size: 20px;
    border: 2px solid black;
    border-radius: 5px;
}
.form{
    margin-top: 20px;
    margin-left: 50px;
    color: rgb(4, 4, 4);
    border: 3px solid rgb(241, 229, 229);
    padding-left: 30px;
    padding-right: 30px;
    padding-top: 5px;
    padding-bottom: 15px;
    background-color: rgb(241, 229, 229);
}
.form:hover{
    box-shadow: 5px 5px 5px 5px rgb(192, 176, 176);
}
.row{
    display: flex;
    justify-content: center;
}
label{
  text-align: left;
  float: left;
  clear: left;
  font-size:20px;
}
select{
    font-size: 20px;
    border: 2px solid black;
    border-radius: 5px;
   
}

    </style>
</head>
<body>
    
    <div class="row row1">
        <div class="col-6 img">
        <img src="images/logo.png" class="img1">
    </div>
    <center>
    <div class="col-6 form">
    <i class="fa-solid fa-car signup" style="font-size: 30px;" ></i>
        <h1 class="signup1">Edit Car</h1>
    <form action="updatecar.jsp" method="post">
        <input type="hidden" name="carNumber" value="<%= request.getParameter("carNumber") %>">
        <label for="brand">Brand:</label>
        <input type="text" id="brand" name="brand" value="<%= request.getParameter("vname") %>"><br><br>
        <label for="model">Model:</label>
        <input type="text" id="model" name="model" value="<%= request.getParameter("vmodel") %>"><br><br>
        <label for="carNumber">Car Number:</label>
        <input type="text" id="carNumber" name="carNumber" value="<%= request.getParameter("carNumber") %>" readonly><br><br>
        <label for="seatingCapacity">Seating Capacity:</label>
        <input type="text" id="seatingCapacity" name="seatingCapacity" value="<%= request.getParameter("scapacity") %>"><br><br>
        <label for="rent">Rent:</label>
        <input type="text" id="rent" name="rent" value="<%= request.getParameter("rent") %>"><br><br>
        <label for="description">Description:</label>
        <textarea id="description" name="description" value="<%= request.getParameter("description") %>"></textarea><br><br>
        <select name="cars" id="cars" value="<%= request.getParameter("category") %></select>">
            <option value="luxury">Luxury Cars</option>
            <option value="volvo">Volvo</option>
            <option value="tempo">Tempo Traveller</option>
            <option value="special">Special Cars</option>
          </select><br><br>
          <label for="img">Image Path:</label>
        <input type="text" id="img" name="img" value="<%= request.getParameter("image_path") %>"><br><br>
        <input type="submit" value="Update">
    </form>
</div>
</center>
</div>

</body>
</html>
