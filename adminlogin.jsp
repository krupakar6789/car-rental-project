<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login as Admin</title>
    <style>
        h2{color:rgb(17, 17, 17);}
        .book1{display:inline-block;}
        body{background-image: url("images/road.jpeg");background-size: cover;}
        .book2{color:rgb(2, 3, 3);font-size: 18px;}
        input, select {
        width: 100%;
        padding: 10px 10px;
        margin: 8px 0;
        display: inline-block;
        border: 1px solid #f8f4f4;
        border-radius: 5px;
        box-sizing: border-box;
        font-size:18px;
        }
        input[type=submit] {
        width: 50%;
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

div {
  border-radius: 5px;
  background-color:rgba(250, 253, 250, 0.5);
  padding: 20px;
}

    </style>
</head>
<body><br><br><br>

    <div class="book1">
        <% 
        // Check if an error message exists in the session
        String errorMessage = (String) session.getAttribute("adminErrorMessage");
        if (errorMessage != null) {
            %>
            <br><center>
            <span style="color: red;font-size: 20px;"><%= errorMessage %></span></center>
            <%
            // Remove the error message from the session after displaying it
            session.removeAttribute("adminErrorMessage");
        }
        %>
       <center> <h2>Login as Admin</h2><br></center>
    <form action="Admin.jsp" class="book2" style="text-align: left;" method="POST">
        <label for="email"><b>Enter your email:</b></label>
        <input type="email" id="email" name="email" required><br><br>
        <label for="password"><b>Password:</b></label>
        <input type="password" id="password" name="password"><br><br><center>
        <input type="submit" value="Login"></center>
       
      </form> 
      </div>
    
</body>
</html>