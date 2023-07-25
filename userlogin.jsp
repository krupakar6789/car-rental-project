<%@ page import="java.sql.*" %>

<%
    // Retrieve the email and password entered by the user
    String email = request.getParameter("email");
    String password = request.getParameter("password");
    
    // Establish a connection to the Oracle database
    String jdbcURL = "jdbc:oracle:thin:@localhost:1521:xe";
    String dbUser = "system";
    String dbPassword = "tiger";
    Connection connection = null;
    PreparedStatement statement = null;
    ResultSet resultSet = null;
    
    try {
        Class.forName("oracle.jdbc.driver.OracleDriver");
        connection = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);
        
        // Prepare the SQL query
        String sqlQuery = "SELECT * FROM users WHERE email = ? AND password = ?";
        statement = connection.prepareStatement(sqlQuery);
        statement.setString(1, email);
        statement.setString(2, password);
        
        // Execute the query
        resultSet = statement.executeQuery();
        
        // Check if the login details are correct
        if (resultSet.next()) {
            // Login successful, redirect to userhomepage.jsp
            String fname = resultSet.getString("FNAME");
            String lname = resultSet.getString("LNAME");
            String gender = resultSet.getString("GENDER");
            String age = resultSet.getString("AGE");
            // Set the retrieved values as session attributes
            session.setAttribute("fname", fname);
            session.setAttribute("lname", lname);
            session.setAttribute("email", email);
            session.setAttribute("age", age);
            session.setAttribute("gender", gender);
            response.sendRedirect("userhomepage.jsp");
        } else {
            // Login failed, display an error message
            session.setAttribute("userErrorMessage", "Invalid email or password. Please try again.");
            response.sendRedirect("user.jsp");
        }
    } catch (ClassNotFoundException e) {
        e.printStackTrace();
    } catch (SQLException e) {
        e.printStackTrace();
    } finally {
        // Close the database resources
        if (resultSet != null) {
            try {
                resultSet.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        if (statement != null) {
            try {
                statement.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        if (connection != null) {
            try {
                connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
%>
