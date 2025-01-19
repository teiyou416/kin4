<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
   String q=request.getParameter("q");
   if(q!=null){
	   String url="jdbc:mysql://localhost/mydb?characterEncoding=UTF-8";
	   Connection conn=DriverManager.getConnection(url,"test","password");
	   PreparedStatement stmt=conn.prepareStatement(
			   "SELECT*FROM zip WHERE code LIKE?ORDER BY code");
	   stmt.setString(1,q+"%");
	   stmt.setMaxRows(20);
	   ResultSet rs =stmt.executeQuery();
	   out.println("<table>");
	   
	   while(rs.next()){
		   String code =rs.getString("code");
		   String address=rs.getString("address1")
		        +rs.getString("address2")
		        +rs.getString("address3");
		   out.println("<tr>"
				   +"<td>"+code+"</td>"
				   +"<td class='address'>"+address+"</td>"
				   +"</tr>");
	   }
	   out.println("</table>");
	   rs.close();
	   stmt.close();
	   conn.close();
   }
   %>
