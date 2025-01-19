<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>土木遺産紹介</title>
     <script src="http://maps.googleapis.com/maps/api/js?key=AIzaSyCrmbqbbbMEq7oJnSQ6a-FsjkbFLJ1tfvM"></script>
 <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.3/jquery.min.js">
 <script src="addressmaps.js"></script>

    <style>
        body {
            font-family: Arial, sans-serif;
        }
        #list {
            margin-bottom: 20px;
            background-color: #f4f4f4;
            padding: 10px;
            border-radius: 5px;
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
            border: 1px solid #ccc;
        }
    </style>
    <script>
        // 动态加载详情信息
        function loadDetails(name) {
            $.ajax({
                url: "",
                type: "GET",
                data: { name: name },
                success: function(response) {
                    try {
                        const data = JSON.parse(response);
                        // 更新详情部分
                        $("#details").html(`
                            <h2>${data.name}</h2>
                            <p><strong>"県名":</strong> ${data.prefecture}</p>
                            <p><strong>"所在地":</strong> ${data.location}</p>
                            <p><strong>"概要":</strong> ${data.description}</p>
                            <p><strong>"建設年":</strong> ${data.buildYear}</p>
                            <p><strong>"受賞年":</strong> ${data.awardYear}</p>
                        `);
                        // 地图标题更新
                        drawMap(name);
                    } catch (error) {
                        console.error("JSON 解析错误:", error);
                        alert("データ取得中にエラーが発生しました。");
                    }
                },
                error: function() {
                    alert("データ取得中にエラーが発生しました。");
                }
            });
        }

    </script>
</head>
<body>
    <h1>土木遺産紹介</h1>

    <!-- 土木遺産名称列表 -->
    <div id="list">
        <%
            // 数据库连接
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

                // 获取土木遗产名称列表
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

    <!-- 后端逻辑：根据名称返回 JSON 数据 -->
    <%
        String nameParam = request.getParameter("name");
        if (nameParam != null) {
            try {
            	 Class.forName("com.mysql.cj.jdbc.Driver");
                 String url="jdbc:mysql://localhost/mydb?characterEncoding=UTF-8";
                 
          	    String user="test";
          	    String password="password";
                 conn = DriverManager.getConnection(url,user, password);
                 stmt = conn.createStatement();

                // 根据名称查询土木遗产信息
                String sql = "SELECT *FROM message WHERE 名称 = ?";
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setString(1, "名称");
                rs = ps.executeQuery();

                if (rs.next()) {
                    String name = rs.getString("名称");
                    String prefecture = rs.getString("県名");
                    String location = rs.getString("所在地");
                    String description = rs.getString("概要");
                    String buildYear = rs.getString("建設年");
                    String awardYear = rs.getString("受賞年");

                    // 返回 JSON 数据
                    response.setContentType("application/json");
                    response.getWriter().write(String.format(
                        "{\"name\":\"%s\",\"prefecture\":\"%s\",\"location\":\"%s\",\"description\":\"%s\",\"buildYear\":\"%s\",\"awardYear\":\"%s\"}",
                        name, prefecture, location, description, buildYear, awardYear
                    ));
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
