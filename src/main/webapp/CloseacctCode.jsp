<%@ page import="java.sql.*" %>
<%
try
{
	int accountnumber=Integer.parseInt(request.getParameter("ano"));
	String name=request.getParameter("uname");
	String password=request.getParameter("psw");
	Class.forName("oracle.jdbc.driver.OracleDriver");
	Connection con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","kumar","kumar");
	PreparedStatement ps=con.prepareStatement("delete from jspbat where accountnumber=? and name=? and password=?");
	ps.setInt(1, accountnumber);
	ps.setString(2, name);
	ps.setString(3, password);
	int i=ps.executeUpdate();
	out.print(i+"Welcome"+" "+name+" "+"Your account no"+" "+accountnumber+" "+"has closed");
	con.close();
}
catch (Exception ex)
{
	out.print(ex);
}
%>