<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"  import="java.net.InetAddress,java.util.*,java.text.SimpleDateFormat"%>
 <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
 <!DOCTYPE HTML>
<html>
<head>
<meta charset="utf-8">
<meta name="renderer" content="webkit|ie-comp|ie-stand">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<meta http-equiv="Cache-Control" content="no-siteapp" />
<!--[if lt IE 9]>
<script type="text/javascript" src="lib/html5shiv.js"></script>
<script type="text/javascript" src="lib/respond.min.js"></script>
<![endif]-->
<link rel="stylesheet" type="text/css" href="static/h-ui/css/H-ui.min.css" />
<link rel="stylesheet" type="text/css" href="static/h-ui.admin/css/H-ui.admin.css" />
<link rel="stylesheet" type="text/css" href="lib/Hui-iconfont/1.0.8/iconfont.css" />
<link rel="stylesheet" type="text/css" href="static/h-ui.admin/skin/default/skin.css" id="skin" />
<link rel="stylesheet" type="text/css" href="static/h-ui.admin/css/style.css" />
<!--[if IE 6]>
<script type="text/javascript" src="lib/DD_belatedPNG_0.0.8a-min.js" ></script>
<script>DD_belatedPNG.fix('*');</script>
<![endif]-->
<title>我的桌面</title>
</head>
<body>
<div class="page-container">

	<table class="table table-border table-bordered table-bg mt-20">
		<thead>
			<tr>
				<th colspan="2" scope="col">服务器信息</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<th width="30%">服务器计算机名</th>
				<td><%	InetAddress addr = InetAddress.getLocalHost(); out.println(addr.getHostName()); %></td>
			</tr>
			<tr>
				<td>服务器IP地址</td>
				<td><%out.println(addr.getHostAddress());%></td>
			</tr>
			<tr>
				<td>服务器端口 </td>
				<td> <% int serverPort=request.getServerPort();out.println(serverPort);%> </td>
			</tr>
			<tr>
				<td>本文件所在文件夹 </td>
				<td><% out.println(System.getProperty("user.dir"));%></td>
			</tr>
			<tr>
				<td>服务器操作系统 </td>
				<td><% out.println(System.getProperty("os.name")); %> </td>
			</tr>
			<tr>
				<td>系统所在文件夹 </td>
				<td><%out.println(System.getProperty("user.home")); %></td>
			</tr>
			<tr>
				<td>服务器的语言种类 </td>
				<td>Chinese (People's Republic of China)</td>
			</tr>
			<tr>
				<td>服务器当前时间 </td>
				<td>	<%
		Date d = new Date();
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String now = df.format(d);
		out.print(now);
	%>
	
	
			</tr>
			<tr>
				<td>当前系统用户名 </td>
				<td><% out.println(System.getProperty("user.name"));  %></td>
			</tr>
		</tbody>
	</table>
</div>
<footer class="footer mt-20">
	<div class="container">
		<p>感谢jQuery、layer、laypage、Validform、UEditor、My97DatePicker、iconfont、Datatables、WebUploaded、icheck、highcharts、bootstrap-Switch<br>
			Copyright &copy;2015-2017 H-ui.admin v3.1 All Rights Reserved.<br>
			本后台系统由<a href="http://www.h-ui.net/" target="_blank" title="H-ui前端框架">H-ui前端框架</a>提供前端技术支持</p>
			<p>More Templates <a href="http://www.cssmoban.com/" target="_blank" title="模板之家">模板之家</a> - Collect from <a href="http://www.cssmoban.com/" title="网页模板" target="_blank">网页模板</a></p>
	</div>
</footer>
<script type="text/javascript" src="lib/jquery/1.9.1/jquery.min.js"></script> 
<script type="text/javascript" src="static/h-ui/js/H-ui.min.js"></script> 

</body>
</html>