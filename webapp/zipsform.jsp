<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
   String paramq =request.getParameter("q");
%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
 "http://www.w3.org/TR/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type"content="text/html; 
charset="UTF-8"/>
<title>郵便番号検索フォーム</title>
</head>
<body>
<form action=""method="get">
<p>
   <input type="text" name="q"value='<%=paramq %>'/>
   <input type="submit"value="search"/>
</p>

</form>
<jsp:include page="zips.jsp"/>
</body>
</html>