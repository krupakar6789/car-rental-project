<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*"%>

<%
        response.setContentType("text/html");
		String fn = request.getParameter("fname");
		String ln = request.getParameter("lname");
		String mail = request.getParameter("email");
		String pwd = request.getParameter("password");
		String gender = request.getParameter("gender");
		String age = request.getParameter("age");
		try
		{
			Class.forName("oracle.jdbc.driver.OracleDriver");
			Connection con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE","system","tiger");
			String qry = "insert into USERS(FNAME,LNAME,EMAIL,PASSWORD,GENDER,AGE) values(?,?,?,?,?,?)";
			PreparedStatement pst=con.prepareStatement(qry);
			pst.setString(1,fn);
			pst.setString(2,ln);
			pst.setString(3,mail);
			pst.setString(4,pwd);
			pst.setString(5,gender);
			pst.setString(6,age);
			int i = pst.executeUpdate();
			if(i>0)
			{
				session.setAttribute("registerMessage", "Account created successfully!");
               response.sendRedirect("user.jsp");
            }
            
        }
        catch(Exception e)
        {
            out.println(e);
        }
%>
      