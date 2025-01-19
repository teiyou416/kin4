<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>土木遺産紹介</title>
    <script src="http://maps.googleapis.com/maps/api/js?key=AIzaSyCrmbqbbbMEq7oJnSQ6a-FsjkbFLJ1tfvM"></script>
 <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.3/jquery.min.js"></script>
 <script src="addressmaps.js"></script>
    <style>
        body {
            font-family: Arial, sans-serif;
        }
        #list {
            margin-bottom: 20px;
        }
        #list a {
            margin-right: 15px;
            text-decoration: none;
            color: blue;
        }
        #list a:hover {
            text-decoration: underline;
        }
        #content {
            display: flex;
            justify-content: space-between;
        }
        .details {
            width: 45%;
        }
        #map {
            width: 50%;
            height: 500px;
        }
    </style>
    <script>
        function loadDetails(name) {
            // 通过 AJAX 动态获取数据
            $.ajax({
                url: "",
                type: "GET",
                data: { name: name },
                success: function(response) {
                    // 解析返回的 JSON 数据并更新页面内容
                    const data = JSON.parse(response);
                    $("#details").html(`
                        <h2>${data.name}</h2>
                        <p><strong>県名:</strong> ${data.prefecture}</p>
                        <p><strong>所在地:</strong> ${data.location}</p>
                        <p><strong>概要:</strong> ${data.description}</p>
                        <p><strong>建設年:</strong> ${data.buildYear}</p>
                        <p><strong>受賞年:</strong> ${data.awardYear}</p>
                    `);
                    drawMap(data.latitude, data.longitude);
                }
            });
        }

        function drawMap(lat, lng) {
            var location = {lat: parseFloat(lat), lng: parseFloat(lng)};
            var map = new google.maps.Map(document.getElementById('map'), {
                zoom: 14,
                center: location
            });
            new google.maps.Marker({
                position: location,
                map: map
            });
        }
    </script>
</head>
<body>
    <h1>土木遺産紹介</h1>

    <!-- 土木遺産列表 -->
    <div id="list">
        <%
            Connection conn = null;
            Statement stmt = null;
            ResultSet rs = null;

            try {
                // 数据库连接
               Class.forName("com.mysql.cj.jdbc.Driver");
                String url="jdbc:mysql://localhost/mydb?characterEncoding=UTF-8";
                
         	    String user="test";
         	    String password="password";
                conn = DriverManager.getConnection(url,user, password);
                stmt = conn.createStatement();
                // 查询土木遗产列表
                String sql = "SELECT 名称 FROM message";
                rs = stmt.executeQuery(sql);

                while (rs.next()) {
                    String name = rs.getString("名称");
        %>
                    <a href="javascript:void(0);" onclick="loadDetails('<%= name %>')"><%= name %></a>
        <%
                }
            } catch (Exception e) {
                out.println("エラー: " + e.getMessage());
            } finally {
                if (rs != null) try { rs.close(); } catch (SQLException e) {}
                if (stmt != null) try { stmt.close(); } catch (SQLException e) {}
                if (conn != null) try { conn.close(); } catch (SQLException e) {}
            }
        %>
    </div>

    <!-- 内容展示区域 -->
    <div id="content">
        <div class="details" id="details">
            <h2>土木遺産を選択してください</h2>
            <p>リストから遺産を選択して、詳細情報を表示します。</p>
        </div>
        <div id="map"></div>
    </div>

    <%
        // 当页面被 AJAX 请求时，返回 JSON 数据
        String nameParam = request.getParameter("name");
        if (nameParam != null) {
            try {
                // 数据库连接
              Class.forName("com.mysql.cj.jdbc.Driver");
                String url="jdbc:mysql://localhost/mydb?characterEncoding=UTF-8";
                
         	    String user="test";
         	    String password="password";
                conn = DriverManager.getConnection(url,user, password);
                stmt = conn.createStatement();

                
             // 在查询结果前输出调试信息
                String sql = "SELECT 名称, 県名, 所在地, 概要, 建設年, 受賞年 FROM message WHERE 名称 = '" + nameParam + "'";
                out.println("Debug SQL: " + sql); // 输出 SQL 查询语句，便于调试
                rs = stmt.executeQuery(sql);
                
                if (rs.next()) {
                    String name = rs.getString("名称");
                    String prefecture = rs.getString("県名");
                    String location = rs.getString("所在地");
                    String description = rs.getString("概要");
                    String buildYear = rs.getString("建設年");
                    String awardYear = rs.getString("受賞年");

                    // 返回 JSON 格式的数据
                    response.setContentType("application/json");
                    response.getWriter().write("{\"名称\":\"" + name + "\",\"県名\":\"" + prefecture + "\",\"所在地\":\"" + location + "\",\"概要\":\"" + description + "\",\"建設年\":\"" + buildYear + "\",\"受賞年\":\"" + awardYear + "\",\"latitude\":\"35.6895\",\"longitude\":\"139.6917\"}");
                }
            } catch (Exception e) {
                response.getWriter().write("{\"error\":\"" + e.getMessage() + "\"}");
            } finally {
                if (rs != null) try { rs.close(); } catch (SQLException e) {}
                if (stmt != null) try { stmt.close(); } catch (SQLException e) {}
                if (conn != null) try { conn.close(); } catch (SQLException e) {}
            }
        }
    %>
</body>
</html>