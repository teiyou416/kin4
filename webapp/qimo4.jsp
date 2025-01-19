<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*" %>
<%
    // 数据库连接信息
    String dbUrl = "jdbc:mysql://localhost/mydb?characterEncoding=UTF-8"; // 修改为你的数据库连接
    String dbUser = "root"; // 数据库用户名
    String dbPassword = "password"; // 数据库密码

    // 查询数据
    List<Map<String, String>> heritageList = new ArrayList<>();
    try {
        Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
        Statement stmt = conn.createStatement();
        String sql = "SELECT * FROM kaitou"; // 假设表名为 `kaitou`
        ResultSet rs = stmt.executeQuery(sql);

        while (rs.next()) {
            Map<String, String> heritage = new HashMap<>();
            heritage.put("id", rs.getString("id"));
            heritage.put("name", rs.getString("name"));
            heritage.put("address", rs.getString("address"));
            heritage.put("description", rs.getString("contents1"));
            heritage.put("buildYear", rs.getString("contents2"));
            heritage.put("repairYear", rs.getString("contents3"));
            heritageList.add(heritage);
        }

        rs.close();
        stmt.close();
        conn.close();
    } catch (SQLException e) {
        out.println("数据库连接错误：" + e.getMessage());
    }
%>
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>土木遗产介绍</title>
    <!-- Google Maps API 密钥 -->
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCrmbqbbbMEq7oJnSQ6a-FsjkbFLJ1tfvM"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="addressmaps.js"></script> <!-- 引用您提供的 addressmaps.js 文件 -->
    <style>
        body {
            display: flex;
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
        }
        #heritageList {
            width: 30%;
            max-height: 100vh;
            overflow-y: auto;
            padding: 20px;
            border-right: 1px solid #ccc;
            background-color: #f9f9f9;
            list-style: none;
        }
        #heritageList li {
            margin: 10px 0;
            cursor: pointer;
        }
        #heritageList li:hover {
            text-decoration: underline;
            color: blue;
        }
        #content {
            flex-grow: 1;
            display: flex;
            flex-direction: column;
            padding: 20px;
        }
        #heritageDetail {
            flex-grow: 1;
        }
        #map_canvas {
            width: 100%;
            height: 400px;
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <!-- 左侧列表 -->
    <ul id="heritageList">
        <% for (Map<String, String> heritage : heritageList) { %>
            <li class="heritage-item" data-id="<%= heritage.get("id") %>">
                <%= heritage.get("name") %>
            </li>
        <% } %>
    </ul>

    <!-- 右侧内容区 -->
    <div id="content">
        <div id="heritageDetail">
            <!-- 遗产详情区 -->
            <h2>请选择一个遗产进行查看</h2>
        </div>
        <div id="map_canvas">
            <!-- 地图区 -->
        </div>
    </div>

    <script>
        // 初始化遗产数据
        const heritageData = <%= heritageList.toString().replace("=", ":") %>;

        $(document).ready(function () {
            // 点击列表项时更新详情和地图
            $(".heritage-item").on("click", function () {
                const id = $(this).data("id");
                const heritage = heritageData.find(item => item.id == id);
                if (heritage) {
                    // 更新详情
                    $("#heritageDetail").html(`
                        <h2>${heritage.name}</h2>
                        <p><b>地址：</b>${heritage.address}</p>
                        <p><b>描述：</b>${heritage.description}</p>
                        <p><b>建造年份：</b>${heritage.buildYear}</p>
                        <p><b>修复年份：</b>${heritage.repairYear}</p>
                    `);
                    // 更新地图
                    drawMap(heritage.address); // 调用 addressmaps.js 中的 drawMap 函数
                }
            });

            // 默认加载第一个遗产
            if (heritageData.length > 0) {
                $(".heritage-item:first").click();
            }
        });
    </script>
</body>
</html>