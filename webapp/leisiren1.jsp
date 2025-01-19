<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <title>土木遺産ガイド</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            line-height: 1.6;
            background-color: #f9f9f9;
            color: #333;
            margin: 0;
            padding: 0;
        }

        .container {
            max-width: 800px;
            margin: 20px auto;
            background: #fff;
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th, td {
            text-align: left;
            padding: 8px;
            border-bottom: 1px solid #ddd;
        }

        th {
            background-color: #007BFF;
            color: #fff;
        }

        tr:hover {
            background-color: #f1f1f1;
        }

        a {
            color: #007BFF;
            text-decoration: none;
        }

        a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>日本西部の土木遺産ガイド</h1>
        <%
            Connection conn = DriverManager.getConnection(
                "jdbc:mysql://localhost/mydb?characterEncoding=UTF-8",
                "test",
                "password"
            );
            String sql = "SELECT id, name FROM kaido ORDER BY id";
            PreparedStatement stmt = conn.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
            out.println("<table>");
            out.println("<tr><th>名称</th></tr>");
            while (rs.next()) {
                String name = rs.getString("name");
                out.println("<tr>");
                out.println("<td><a href='leisiren2.jsp?id=" + rs.getInt("id") + "'>" + name + "</a ></td>");
                out.println("</tr>");
            }
            out.println("</table>");
            rs.close();
            stmt.close();
            conn.close();
        %>
    </div>
</body>
</html>