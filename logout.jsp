<%
  // Perform logout actions
  session.invalidate(); // Invalidate the session
  response.sendRedirect("home.jsp"); // Redirect to the login page
%>
