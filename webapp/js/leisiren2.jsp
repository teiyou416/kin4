<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <title>土木遺産詳細情報</title>
    <link rel="stylesheet" href="map.css" />
    <script src ="jav.js"></script>
    <script src="http://maps.google.com/maps/api/js?key=AIzaSyAo3d2dA0xoSHudzDhC0fNIfl6q0o-kACY&language=ja"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.3/jquery.min.js"></script>
 // <script>
 //        $(document).ready(function(){
 //            // 地図を描画するための処理(nameを基づいて検索)
 //            var name = $(".name").text();
 //            if(name){
 //                drawMap(name);
 //            } else {
 //                alert("地図情報が見つかりません。");
 //            }
 //        });
 //    </script>
</head>
<body>
    <div class="container">
        <%
            int id = Integer.parseInt(request.getParameter("id"));
            Connection conn = DriverManager.getConnection(
                "jdbc:mysql://localhost/mydb?characterEncoding=UTF-8",
                "test",
                "password"
            );
            String sql = "SELECT * FROM kaido WHERE id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                String name = rs.getString("name");
                String address = rs.getString("address");
                String contents1 = rs.getString("contents1");
                String contents2 = rs.getString("contents2");
                String contents3 = rs.getString("contents3");

                out.println("<div class='details'>");
                out.println("<h2>" + name + "</h2>");
                out.println("<p><strong>所在地：</strong>" + address + "</p >");
                out.println("<p><strong>紹介：</strong>" + contents1 + "</p >");
                out.println("<p><strong>建設年度：</strong>" + contents2 + "</p >");
                out.println("<p><strong>竣工年度：</strong>" + contents3 + "</p >");
                out.println("</div>");
                out.println("<div id='map_canvas'></div>");
            } else {
                out.println("<p>指定されたIDの土木遺産が見つかりません。</p >");
            }
            rs.close();
            stmt.close();
            conn.close();
        %>
        <div id="map"></div>
        <script type="text/javascript" src="map.js"></script>
    </div>
</body>
</html>
