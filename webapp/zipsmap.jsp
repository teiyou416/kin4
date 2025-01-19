<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
   String paramq=request.getParameter("q");
%>
<!DOCTYPE html>
<html>
 <head>
  <meta charset="UTF-8">
  <style type="text/css">
  html,body{height:100%;}
  td{font-size:smaller;}
  </style>
 <script src="http://maps.googleapis.com/maps/api/js?key=AIzaSyDLZlbD4bI6eDbdLDS753-6IjbGdXnuNAY"></script>
 <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.3/jquery.min.js"></script>
 <script src="addressmaps.js"></script>
 <script>
   $(document).ready(function(){
	   var address=$(".address:first").text();
	   drawMap(address);
   });
 </script>
<title>郵便番号検索フォームとGoogle Maps APIのマッシュアップ</title>
</head>
<body>
 <form action="" method="get">
  <p>
   <input type="text" name="q" value='<%=paramq%>'/>
   <input type="submit" value="search"/>
   </p>
 </form>
 <div id="
" style="float:right;width:50%;height:90%;"></div>
 <jsp:include page="zips.jsp"/>
</body>
</html>