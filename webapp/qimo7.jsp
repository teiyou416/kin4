<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
    // データベース接続情報
    String dbUrl = "jdbc:mysql://localhost/mydb?characterEncoding=UTF-8";
    String dbUser = "test";
    String dbPassword = "password";
    Connection conn=null;
    PreparedStatement stmt =null;
    ResultSet rs=null;
    try {
        conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
        stmt = conn.prepareStatement("SELECT* FROM kaido");
        rs = stmt.executeQuery();
    }catch (Exception e) {
    	e.printStackTrace();
        }
%>
   
<html>
<head>
    <title>土木遺産紹介</title>
  
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDLZlbD4bI6eDbdLDS753-6IjbGdXnuNAY"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.3/jquery.min.js"></script>
    <script src="addressmaps.js"></script>
    <script>
    let locations=[];
    function geocodeAddress(geocoder,map,address,callback){
    	geocoder.geocode({address:address},(results,status)=>{
    		if (status ==="OK"){
    			callback(results[0].geometry.location);
    		}else{
    			console.error("Geocode was not successful for the following reason:"+status);
    			}
    		});
    	}
    

       function initMap(){
    	   const geocoder=new google.maps.Geocoder();
    	   
    	   location.forEach(location)=>{
    		   geocodeAddress(geocoder,null,location,address,(latLng)=>{
    			   const mapElement=document.getElementById(location.id);
    			   if (mapElement){
    				   const map=new google.maps.Map(mapElement,{
    					   zoom:15,
    				        center:latLng,
    				        });
    			   }
    		   });
    	   });
    	   }
     </script>
</head>
 <body>
 <h1>土木遺産</h1>
 <% try{
	 conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
     stmt = conn.prepareStatement("SELECT* FROM kaido");
     rs = stmt.executeQuery();
     while(rs.next()){
    	 String name=rs.getString("土木遺産名称");
    	 String postalCode=rs.getString("郵便番号");%>
    	 <h2><%= name %></h2>
    	 <p><strong>郵便番号:</strong><%= postalCode %></p>
    	  <p><strong>選奨年度:</strong><%= rs.getString("選奨年度") %></p>
    	   <p><strong>	nendo:</strong><%= rs.getString("年度")%></p>
    	   <div id="map_<%= name,replace(" ","_") %>" style="width:100%;height:300px;margin-bottom:20px;"></div>
    	   <script>
    	   locations.push({
    		   id:"map_<%=name.replace(" ","_")%>",
    		   name:"<%=name%>",
    		   address:"<%= postalCode %>"
    	   });
    	   </script>
    	   <%
     }
 }catch(Exception e){
	 e.printStackTrace();
 }
 %>
</body>
</html>