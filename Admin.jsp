<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Map" %>

<%
    // Define a map to store admin credentials
    Map<String, String> adminCredentials = new HashMap<>();
    adminCredentials.put("bindusha@gmail.com", "bindu");

    // Retrieve the submitted email and password from the form
    String email = request.getParameter("email");
    String password = request.getParameter("password");

    // Validate the email and password
    boolean isValid = false;
    if (adminCredentials.containsKey(email)) {
        String storedPassword = adminCredentials.get(email);
        if (storedPassword.equals(password)) {
            isValid = true;
        }
    }

    // Perform further actions based on validation result
    if (isValid) {
        // Admin credentials are valid, redirect to admin dashboard or perform other operations
        session.setAttribute("adminEmail", email);
        response.sendRedirect("admindashboard.jsp");
    } else {
        // Admin credentials are invalid, set an error message in the session and redirect back to the login page
        session.setAttribute("adminErrorMessage", "Invalid email or password. Please try again.");
        response.sendRedirect("adminlogin.jsp");
    }
%>
