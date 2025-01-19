<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<!doctype html>
  <head>
    <meta charset="UTF-8" />
    <title>土木遺産詳細情報</title>
    <link rel="stylesheet" href="map.css" />
    <script src ="jav.js"></script>
    <script src="http://maps.google.com/maps/api/js?key=AIzaSyAo3d2dA0xoSHudzDhC0fNIfl6q0o-kACY&language=ja"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.3/jquery.min.js"></script>
  </head>
  <body>
    <div class="container">
    
       <div class="details">
        <div id="map"></div>
        <script type="text/javascript" src="map.js"></script>
        <h2>" + name + "</h2>
        <p><strong>所在地：</strong>" + address + "</p>
        <p><strong>紹介：</strong>" + contents1 + "</p>
        <p><strong>建設年度：</strong>" + contents2 + "</p>
        <p><strong>竣工年度：</strong>" + contents3 + "</p>
      </div>
      <div id="map_canvas"></div>
    </div>
  </body>
</html>
