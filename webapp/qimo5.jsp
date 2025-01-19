<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*" %>
<%
    // データベース接続情報
    String dbUrl = "jdbc:mysql://localhost/mydb?characterEncoding=UTF-8"; // データベース接続URL
    String dbUser = "test"; // データベースユーザー名
    String dbPassword = "password"; // データベースパスワード

    // データをクエリするためのリスト
    List<Map<String, String>> heritageList = new ArrayList<>();
    StringBuilder json = new StringBuilder();
    json.append("[");

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

            // JSON文字列を手動で構築
            json.append("{");
            json.append("\"id\":\"").append(rs.getInt("id")).append("\",");
            json.append("\"name\":\"").append(rs.getString("name").replace("\"", "\\\"")).append("\",");
            json.append("\"address\":\"").append(rs.getString("address").replace("\"", "\\\"")).append("\",");
            json.append("\"description\":\"").append(rs.getString("contents1").replace("\"", "\\\"")).append("\",");
            json.append("\"buildYear\":\"").append(rs.getString("contents2").replace("\"", "\\\"")).append("\",");
            json.append("\"repairYear\":\"").append(rs.getString("contents3").replace("\"", "\\\"")).append("\"");
            json.append("},");
        }

        // 最後のカンマを削除してJSON配列を閉じる
        if (heritageList.size() > 0) {
            json.setLength(json.length() - 1); // 最後のカンマを削除
        }
        json.append("]");

        // リソースを閉じる
        rs.close();
        stmt.close();
        conn.close();
    } catch (Exception e) {
        out.println("データベース接続エラー：" + e.getMessage());
    }
%>
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>土木遺産紹介</title>
    <!-- Google Maps API キー -->
    <script src="http://maps.googleapis.com/maps/api/js?key=AIzaSyDLZlbD4bI6eDbdLDS753-6IjbGdXnuNAY"></script>
    <!-- jQueryライブラリ -->
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/2.2.3/jquery.min.js"></script>
    <!-- 外部JavaScriptファイル（addressmaps.js） -->
    <script src="addressmaps.js"></script>
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
    <!-- 左側リスト -->
    <ul id="heritageList">
        <% for (Map<String, String> heritage : heritageList) { %>
            <li class="heritage-item" data-id="<%= heritage.get("id") %>">
                <%= heritage.get("name") %>
            </li>
        <% } %>
    </ul>

    <!-- 右側コンテンツエリア -->
    <div id="content">
        <div id="heritageDetail">
            <!-- 遺産詳細エリア -->
            <h2>遺産を選択してください</h2>
        </div>
        <div id="map_canvas">
            <!-- 地図エリア -->
        </div>
    </div>

    <script>
        // 初期遺産データをJSONとして埋め込む
        const heritageData = <%= json.toString() %>;

        $(document).ready(function () {
            // リスト項目をクリックしたときに詳細と地図を更新
            $(".heritage-item").on("click", function () {
                const id = $(this).data("id");
                const heritage = heritageData.find(item => item.id === id.toString());
                if (heritage) {
                    // 詳細を更新
                    $("#heritageDetail").html(`
                        <h2>${heritage.name}</h2>
                        <p><b>住所：</b>${heritage.address}</p>
                        <p><b>説明：</b>${heritage.description}</p>
                        <p><b>建造年：</b>${heritage.buildYear}</p>
                        <p><b>重賞年：</b>${heritage.repairYear}</p>
                    `);
                    // 地図を更新（'name'フィールドを使用）
                    drawMap(heritage.name); // addressmaps.js の drawMap 関数を呼び出す
                }
            });

            // デフォルトで最初の遺産をロード
            if (heritageData.length > 0) {
                $(".heritage-item:first").click();
            }
        });
    </script>
</body>
</html>
