<%@ page import="java.sql.*" %>
<%
try
{
	int accountnumber=Integer.parseInt(request.getParameter("ano"));
	String name=request.getParameter("uname");
	String password=request.getParameter("psw");
	String cpassword=request.getParameter("cpsw");
	double amount=Double.parseDouble(request.getParameter("amt"));
	String address=request.getParameter("addr");
	long mobileno=Long.parseLong(request.getParameter("mno"));
	Class.forName("oracle.jdbc.driver.OracleDriver");
	Connection con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","kumar","kumar");
	PreparedStatement ps=con.prepareStatement("insert into jspbat values(?,?,?,?,?,?)");
	ps.setInt(1, accountnumber);
	ps.setString(2, name);
	ps.setString(3, password);
	ps.setDouble(4, amount);
	ps.setString(5, address);
	ps.setLong(6, mobileno);
	int i=ps.executeUpdate();
	out.print(i+"New Record successfully Inserted");
	con.close();
}
catch (Exception ex)
{
	out.print(ex);
}
%>