<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*"%>
<%
    // データベース接続情報
    String dbUrl = "jdbc:mysql://localhost/mydb?characterEncoding=UTF-8";
    String dbUser = "test";
    String dbPassword = "password";

    List<Map<String, String>> heritageList = new ArrayList<>();

    try {
        // MySQL JDBCドライバーをロード
        Class.forName("com.mysql.cj.jdbc.Driver");

        // データベースに接続
        Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);

        // SQLクエリを準備
        String sql = "SELECT * FROM kaido";
        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery(sql);

        // 結果をリストに格納
        while (rs.next()) {
            Map<String, String> heritage = new HashMap<>();
            heritage.put("id", String.valueOf(rs.getInt("id")));
            heritage.put("name", rs.getString("name"));
            heritage.put("address", rs.getString("address"));
            heritage.put("description", rs.getString("contents1"));
            heritage.put("buildYear", rs.getString("contents2"));
            heritage.put("repairYear", rs.getString("contents3"));
            heritageList.add(heritage);
        }

        // リソースを閉じる
        rs.close();
        stmt.close();
        conn.close();
    } catch (Exception e) {
        out.println("データベースエラー：" + e.getMessage());
    }
%>
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <title>土木遺産紹介</title>
    <style>
        body {
            display: flex;
            margin: 0;
            font-family: Arial, sans-serif;
        }
        #heritageList {
            width: 30%;
            padding: 20px;
            overflow-y: auto;
            border-right: 1px solid #ccc;
            background-color: #f9f9f9;
        }
        #heritageList li {
            margin: 10px 0;
            cursor: pointer;
        }
        #heritageList li:hover {
            color: blue;
            text-decoration: underline;
        }
        #mapContainer {
            flex-grow: 1;
            padding: 20px;
        }
        #map_canvas {
            width: 100%;
            height: 100%;
        }
    </style>
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDLZlbD4bI6eDbdLDS753-6IjbGdXnuNAY"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.3/jquery.min.js"></script>
    <script src="addressmaps.js"></script>
    <script>
    

        $(document).ready(function () {
            $(".heritage-item").on("click", function () {
                const id = $(this).data("id");
                const heritage = heritageData.find(item => item.id === id.toString());
                if (heritage) {
                    drawMap(heritage.address);
                }
            });

            // 初期表示：最初の遺産を地図に表示
            if (heritageData.length > 0) {
                $(".heritage-item:first").click();
            }
        });
    </script>
</head>
<body>
    <ul id="heritageList">
        <% for (Map<String, String> heritage : heritageList) { %>
            <li class="heritage-item" data-id="<%= heritage.get("id") %>">
                <strong><%= heritage.get("name") %></strong><br>
                <small><%= heritage.get("address") %></small>
            </li>
        <% } %>
    </ul>
    <div id="mapContainer">
        <div id="map_canvas"></div>
    </div>
</body>
</html>