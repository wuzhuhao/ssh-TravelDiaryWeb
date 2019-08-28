<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>Cropper</title>
        <link rel="stylesheet" type="text/css" href="http://cdn.bootcss.com/font-awesome/4.6.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="css/amazeui.min.css">
        <link rel="stylesheet" href="css/amazeui.cropper.css">
        <link rel="stylesheet" href="css/custom_up_img.css">
        <style type="text/css">
     		.up-img-cover {width: 100px;height: 100px;}
     		.up-img-cover img{width: 100%;}
        </style>
       
        
    </head>
    <body>
    	<%response.sendRedirect("fangKe"); %>
      
    </body>
</html>
