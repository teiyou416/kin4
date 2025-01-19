<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>土木遺産ガイド</title>
    <style>
        .container {width: 80%; margin: 20px auto;}
        .details {margin-bottom: 20px;}
        .details h2 {margin-bottom: 10px;}
        #map_canvas { width: 100%;height: 400px;border: 1px solid #ddd;}
        table { width: 80%; border-collapse: collapse; margin: 20px auto;}
        th, td {border: 1px solid #ddd; padding: 8px;}
        th {background-color: #f2f2f2; text-align: center;}
        td {text-align: center;}
        h1 {text-align: center;}
    </style>
    <script src="http://maps.googleapis.com/maps/api/js?key=AIzaSyDLZlbD4bI6eDbdLDS753-6IjbGdXnuNAY"></script>
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/2.2.3/jquery.min.js"></script>
    <script src="addressmapss.js"></script>
    <script>
        $(document).ready(function(){
            // 地図を描画するための処理
            var name = $(".name").text();
            if(name && name.trim() !== ""){
                drawMap(name);
            } else {
                alert("名称情報が見つかりません。");
            }
        });
    </script>
</head>
<body>
    <h1>日本西部の土木遺産ガイド</h1>
    <div class="container">
    <%
        String idParam = request.getParameter("id");
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        // データベース接続設定
        String url = "jdbc:mysql://localhost/mydb?characterEncoding=UTF-8";
        String user = "test";
        String password = "password";

        conn = DriverManager.getConnection(url, user, password);

        if (idParam == null) {
            // 土木遺産リストを取得
            String sql = "SELECT id, name, address FROM kaido ORDER BY id";
            stmt = conn.prepareStatement(sql);
            rs = stmt.executeQuery();

            out.println("<table>");
            out.println("<tr><th>ID</th><th>名称</th><th>住所</th></tr>");
            while (rs.next()) {
                int id = rs.getInt("id");
                String name = rs.getString("name");
                String address = rs.getString("address");
                out.println("<tr>");
                out.println("<td>" + id + "</td>");
                out.println("<td><a href=' " + id + "'>" + name + "</a ></td>");
                out.println("<td>" + address + "</td>");
                out.println("</tr>");
            }
            out.println("</table>");
        } else {
            // 指定されたIDの詳細情報を取得
            int id = Integer.parseInt(idParam);
            String sql = "SELECT * FROM kaido WHERE id = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, id);
            rs = stmt.executeQuery();

            if (rs.next()) {
                String name = rs.getString("name");
                String address = rs.getString("address");
                String contents1 = rs.getString("contents1");
                String contents2 = rs.getString("contents2");
                String contents3 = rs.getString("contents3");

                out.println("<div class='details'>");
                out.println("<h2>" + name + "</h2>");
                out.println("<p><strong>名称：</strong><span class='name'>" + name + "</span></p >");
                out.println("<p><strong>所在地：</strong>" + address + "</p >");
                out.println("<p><strong>紹介：</strong>" + contents1 + "</p >");
                out.println("<p><strong>竣工年：</strong>" + contents2 + "</p >");
                out.println("<p><strong>備考：</strong>" + contents3 + "</p >");
                out.println("</div>");
                out.println("<div id='map_canvas'></div>");
            } else {
                out.println("<p>指定されたIDの土木遺産が見つかりません。</p >");
            }
        }

        rs.close();
        stmt.close();
        conn.close();
    %>
    </div>
</body>
</html>
l>