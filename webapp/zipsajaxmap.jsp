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
 <script src="http://maps.googleapis.com/maps/api/js?key=AIzaSyCrmbqbbbMEq7oJnSQ6a-FsjkbFLJ1tfvM"></script>
 <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.3/jquery.min.js"></script>
 <script src="addressmaps.js"></script>
 <script type="text/javascript">
   $(document).ready(function(){
	   $("#q").keyup(function(){
		   var url="zips.jsp?q="+$("#q").val();
		   $("#result").load(url,function(){
			   var address=$(".address:first").text();
			   drawMap(address);
		   }); 
		   });
	   });
 </script>
 <title>リアルタイム郵便番号検索</title>
 </head>
   <body>
    <form action="" method="get">
     <p>
      <input id="q" type="text" name="q" value='<%=paramq %>'/>
      <input type="submit" value="search"/>
      </p>
    </form>
    <div id="map_canvas" style="float:right;width:50%;height:90%;"></div>
    <div id="result"><jsp:include page="zips.jsp"/></div>
   </body>

	   
	  