<%@ page import="java.sql.*"%>
<%
try
{
	int accno=Integer.parseInt(request.getParameter("ano"));
    String name=request.getParameter("uname");
    String password=request.getParameter("psw");
	int taccno=Integer.parseInt(request.getParameter("tano"));
	double transferamt=Double.parseDouble(request.getParameter("amt"));
	double amount=0;
	double ttamount=0;
	double actual=0;
	double tactual=0;
	Class.forName("oracle.jdbc.driver.OracleDriver");
	Connection con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","kumar","kumar");
	PreparedStatement ps= con.prepareStatement("select amount from jspbat  where  accountnumber=? and name=? and password=?");
	ps.setInt(1, accno);
	ps.setString(2, name);
	ps.setString(3, password);
	ResultSet rs= ps.executeQuery();
	
	if(rs.next())
	{
	 	actual=rs.getDouble(1);
	}
		PreparedStatement ps1=con.prepareStatement("select amount from jspbat where accountnumber=?");
		ps1.setInt(1,taccno);
		ResultSet rs1=ps1.executeQuery();
	if(rs1.next())
	{
	 	tactual=rs1.getDouble(1);
	}
	if(true)
	{
		if(transferamt<actual)
		{
			amount=actual-transferamt;
			PreparedStatement ps2=con.prepareStatement("update jspbat set amount=? where accountnumber=?");	
			ps2.setDouble(1,amount);
			ps2.setInt(2,accno);
			ps2.executeUpdate();
			
			ttamount=tactual+transferamt;
			PreparedStatement ps3=con.prepareStatement("update jspbat set amount=? where accountnumber=?");
			ps3.setDouble(1,ttamount);
			ps3.setInt(2, taccno);
			ps3.executeUpdate();
			
			out.print("<h3>amount transfer is:</h3>"+transferamt);
			out.print("<h3>available balance:</h3>"+amount);
		}
		else
		{
			out.print("<h3>Sufficient amount is not available in account</h3>");
		}
	}
	else
	{
		out.print("invalid useraccount and password");
	}
con.close();
}
catch(Exception e)
{
	out.println(e);
}
%>