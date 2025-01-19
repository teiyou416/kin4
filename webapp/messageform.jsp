<%@page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<% 
  request.setCharacterEncoding("UTF-8");
  String username=request.getParameter("username");
  String message=request.getParameter("message");
  
  if(message!=null){
	  //Class.forName("com.mysql.jdbc.Driver").newInstance();
	  String url="jdbc:mysql://localhost/mydb?characterEncoding=UTF-8";
	  Connection conn = DriverManager.getConnection(url,"test","password");
	  PreparedStatement pstmt=conn.prepareStatement(
			  "INSERT INTO message (name,body) VALUES(?,?)");
	  pstmt.setString(1, username);
	  pstmt.setString(2, message);
	  
      pstmt.executeUpdate();
      pstmt.close();
      conn.close();
  }
  %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
   "http://www.w3.org/TR/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type"content="text/html;charset=UTF-8"/>
<title>メッセージ登録フォーム</title>
</head>
<body>
<h1>メッセージ登録フォーム</h1>
<form action=""method="post">
<dl>
  <dt>名前</dt><dd><input type="text"name="username"/></dd>
  <dt>メッセージ</dt><dd><textarea name="message"rows="3"cols="30"></textarea></dd>
  </dl>
  <p><input type="submit"value="送信"/></p>  
</form>
</body>
</html>