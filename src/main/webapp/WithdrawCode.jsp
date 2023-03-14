<%@ page import="java.sql.*"%>
<%
try
{
	int accountnumber=Integer.parseInt(request.getParameter("ano"));
	String name=request.getParameter("uname");
	String password=request.getParameter("psw");
	double withdraw=Double.parseDouble(request.getParameter("amt"));
	double amount=0.0;
	Class.forName("oracle.jdbc.driver.OracleDriver");
	Connection con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","kumar","kumar");
	PreparedStatement ps=con.prepareStatement("select amount from jspbat where accountnumber=? and name=? and password=?");
	ps.setInt(1, accountnumber);
	ps.setString(2, name);
	ps.setString(3, password);
	ResultSet rs=ps.executeQuery();
	if (rs.next())
	{
		if(withdraw<rs.getDouble(1))
		{
			amount=rs.getDouble(1)-withdraw;
			out.print("<h3> Amount debited is: "+withdraw+"</h3>");
			out.print("<h3> Available balance is :"+amount+"</h3>");
		}
		else 
		{
			out.print("<h3> sufficient amount is not avavilble in account</h3>");
		}
	}
	else
	{
		out.print("invalid useraccount and password");
	}
	PreparedStatement ps1=con.prepareStatement("update jspbat set amount=? where accountnumber=? and name=? and password=?");
	ps1.setDouble(1, amount);
	ps1.setInt(2, accountnumber);
	ps1.setString(3, name);
	ps1.setString(4, password);
	ps1.executeUpdate();
	con.close();
}
catch (Exception ex)
{
	out.print(ex);
}
%>