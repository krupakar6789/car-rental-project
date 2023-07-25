<!DOCTYPE html>
<html>
<head>
    <title>Login and Register</title>
    <style>
        /* Add some basic styling */
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 20px;
            background-image: url("images/back.jpeg");
            background-size: cover;
            background-color: rgba(245, 236, 236, 0.8);
        }

        h2 {
            margin-bottom: 20px;
        }

        .form-container {
            width: 300px;
            padding: 20px;
            background-color: #f2f2f2;
            border-radius: 5px;
            
        }

        .form-container h3 {
            text-align: center;
            margin-bottom: 20px;
        }

        .form-container input[type="text"],
        .form-container input[type="email"],
        .form-container input[type="password"],
        .form-container input[type="radio"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 3px;
            box-sizing: border-box;
        }

        .form-container button {
            width: 100%;
            padding: 10px;
            background-color: #4CAF50;
            color: #fff;
            border: none;
            border-radius: 3px;
            cursor: pointer;
        }

        .form-container p {
            text-align: center;
            margin-top: 10px;
        }

        .form-container p a {
            color: #333;
            text-decoration: none;
        }
        .form-container .gender-labels {
            display: flex;
            align-items: center;
            margin-bottom: 10px;
        }
        .form-container .gender-labels label {
            margin-right: 0px;
        }
        .overlay {
            position: absolute;
            background-color: rgba(0, 0, 0, 0.1); 
        }
        .content {
            position: relative;
            z-index: 2; 
            text-align: center;
            padding: 20px;
            color: #050505;
        }
        
        .content a {
            z-index: 3; 
            color: #080808;
            text-decoration: none;
        }
    </style>
</head>
<body>
    <center><br><br><br>
    <div class="form-container">
        <div class="overlay"></div>
        <form id="login-form" action="userlogin.jsp" class="content">
            <% 
            // Check if an error message exists in the session
            String Message = (String) session.getAttribute("registerMessage");
            if (Message != null) {
                %>
                <br><center>
                <span style="color: red;font-size: 15px;"><%= Message %></span></center>
                <%
                // Remove the error message from the session after displaying it
                session.removeAttribute("registerMessage");
            }
            %>
            <% 
            // Check if an error message exists in the session
            String errorMessage = (String) session.getAttribute("userErrorMessage");
            if (errorMessage != null) {
                %>
                <br><center>
                <span style="color: red;font-size: 15px;"><%= errorMessage %></span></center>
                <%
                // Remove the error message from the session after displaying it
                session.removeAttribute("userErrorMessage");
            }
            %>
		<h3>Login</h3>
            <input type="email" placeholder="Email" name="email" required>
            <input type="password" placeholder="Password" name="password" required>
            <button type="submit">Login</button>
            <p>Don't have an account? <a href="#" onclick="toggleForm()">Register</a></p>
        </form>

        
        <form id="register-form" style="display: none;" action="register.jsp" class="content">
		<h3>Register</h3>
            <input type="text" placeholder="First Name" name="fname" required>
            <input type="text" placeholder="Last Name" name="lname" required>
            <input type="email" placeholder="Email" name="email" required>
            <input type="password" placeholder="Password" name="password" required>
            <div class="gender-labels">
            <label for="gender">Gender:</label>
            <input type="radio" id="male" name="gender" value="male" required>
            <label for="male">Male</label>
            <input type="radio" id="female" name="gender" value="female" required>
            <label for="female">Female</label>
                </div>
            <input type="text" placeholder="Age" name="age" required>
            
            <button type="submit">Register</button>
            <p>Already have an account? <a href="#" onclick="toggleForm()">Login</a></p>
        </form>
    </div>
</center>
    <script>
        function toggleForm() {
            var loginForm = document.getElementById("login-form");
            var registerForm = document.getElementById("register-form");

            if (loginForm.style.display === "none") {
                loginForm.style.display = "block";
                registerForm.style.display = "none";
            } else {
                loginForm.style.display = "none";
                registerForm.style.display = "block";
            }
        }
    </script>
</body>
</html>
