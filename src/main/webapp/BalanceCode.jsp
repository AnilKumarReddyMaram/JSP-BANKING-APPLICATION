<%@ page import="java.sql.*"%>
<%
try
{
	int accountnumber=Integer.parseInt(request.getParameter("ano"));
	String name=request.getParameter("uname");
	String password=request.getParameter("psw");
	Class.forName("oracle.jdbc.driver.OracleDriver");
	Connection con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","kumar","kumar");
	PreparedStatement ps=con.prepareStatement("select accountnumber,name,amount,address,mobileno from jspbat where accountnumber=? and name=? and password=?");
	ps.setInt(1, accountnumber);
	ps.setString(2, name);
	ps.setString(3, password);
	ResultSet rs=ps.executeQuery();
	ResultSetMetaData rsmd=rs.getMetaData();
	out.print("<table border='1'>");
	int n=rsmd.getColumnCount();
	for (int i=1; i<=n; i++)
		out.print("<td><fontcolor=blue size=3>"+"<br>"+rsmd.getColumnName(i));
	out.print("<tr>");
	while (rs.next())
	{
		for (int i=1; i<=n;i++)
			out.print("<td><br>"+rs.getString(i));
		out.print("<tr>");
	}
	con.close();	
}
catch (Exception ex)
{
	out.print(ex);
}
%>