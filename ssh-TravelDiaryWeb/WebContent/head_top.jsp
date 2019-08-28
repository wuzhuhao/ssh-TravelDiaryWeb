<%@ page language="java" 
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<!-- contentType="text/html; charset=utf-8" -->
<html>
<head>
<meta charset="utf-8">
<title>top</title>
<meta name="renderer" content="webkit">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1">
<link rel="stylesheet" href="js/layui-v2.4.5/layui/css/layui.css"
	media="all">
</head>
<body>
<nav>
	
</nav>
	<!-- <nav> -->
	<%-- <div class="logo">

		<c:if test="${user==null||user.userName==null||user.userName.length()==0}">
			<a style="color: blue;cursor: pointer;" onclick="location='login.jsp'">请登陆</a>
		</c:if>
		<c:if test="${user!=null&&user.userName!=null&&user.userName.length()!=0}">
			<a style="color: blue; cursor: pointer;" onclick="displayOrHide1();">${session.user.userName}</a>
		</c:if>
		<ul id="cityList1">
			<div id="cityListBox">
				<li><a style="cursor: default" href="write.jsp">写游记</a></li>
				<li style="color: #000000"><a style="cursor: default"
					href="draftsList?page=1" style="color:#000000"><span
						style="color: #000000b3"> 草稿箱</span></a></li>
				<li><a href="findUserById?u_id=${user.id}">我的游记</a></li>
				<li><a href="users_userInfo">修改个人信息</a></li>
				<li><a href="gbook">留言</a></li>

			</div>
		</ul>
	</div>
	<h2 id="mnavh">
		<span class="navicon"></span>
	</h2>
	<div id="starlist ">
	<ul  style="color: #000000 ; ">
		<li style="float: left;display: block;
    padding: 0 0 0 40px;
    font-size: 16px;margin-left:30%"><a href="index2?page=1" style="color: #000000b3" id="wzsy">网站首页</a></li>
		<li style="float: left;display: block;
    padding: 0 0 0 40px;
    font-size: 16px"><a href="seachByFour"><span
				style="color: #000000b3" id="mdd">目的地</span></a></li>
		<li style="float: left;display: block;
    padding: 0 0 0 40px;
    font-size: 16px"><a href="index2?index=1&page=1" style="color: #f65a8a"><span
				style="color: #000000b3" id="tjyj">推荐游记</span> </a></li>
		<li style="float: left;display: block;
    padding: 0 0 0 40px;
    font-size: 16px">
			<a  style="color: #f65a8a">
				<span style="color: #000000b3;cursor: default" onclick="displayOrHide2()" id="ywgl">游玩攻略</span> 	
			</a>
		<div id="cityList2">
		<ul >
			
						<div id="cityListBox1">
							<li><a style="cursor: default" href="recommend_findRecommend?type_=1">怎么玩</a></li>
							<li><a style="cursor: default" href="recommend_findRecommend?type_=2">吃什么</a></li>
							<li><a style="cursor: default" href="recommend_findRecommend?type_=3">买什么</a></li>
							</div>	
		</ul>
		</div>			
				
		</li>	
		<c:if test="${user!=null&&user.id!=0}">
		   
			<li style="float: right;display: block;
    padding: 0 0 0 40px;
    font-size: 16px"><a href="exit">退出</a></li>
		</c:if>
		
	</ul>
	</div>	 --%>
	<!-- <h2 id="mnavh" class=""><span class="navicon"></span></h2> -->
	<ul class="layui-nav layui-bg-green header-navigation"
		style="text-align: center; opacity:1;position: fixed;">
		<!-- background-color: #5FB878; -->
		<c:if
			test="${user==null||user.userName==null||user.userName.length()==0}">
			<li class="layui-nav-item"><a onclick="location='login.jsp'">登录|注册</a></li>
		</c:if>
		<c:if
			test="${user!=null&&user.userName!=null&&user.userName.length()!=0}">
			<li class="layui-nav-item" lay-unselect=""><a
				href="javascript:;"><img src="//t.cn/RCzsdCq"
					class="layui-nav-img">${user.userName}<span
					class="layui-nav-more"></span></a>
				<dl class="layui-nav-child layui-anim layui-anim-upbit">
					<dd>
						<a href="write.jsp">写游记</a>
					</dd>
					<dd>
						<a href="draftsList?page=1">草稿箱</a>
					</dd>
					<dd>
						<a href="findUserById?u_id=${user.id}">个人主页</a>
					</dd>
					<dd>
						<a href="users_userInfo">修改信息</a>
					</dd>
					<dd>
						<a href="findComment">最近评论</a>
					</dd>
					<dd>
						<a href="exit">退出</a>
					</dd>
				</dl></li>
		</c:if>
		<li class="layui-nav-item" id="wzsy"><a href="index2?page=1">网站首页</a></li>
		<li class="layui-nav-item" id="mdd"><a href="seachCityByCountryRegion">目的地</a></li>
		<!-- <li class="layui-nav-item" id="tjyj"><a href="index2?index=1&page=1">推荐游记</a></li> -->
		<li class="layui-nav-item" id="jd"><a href="Recommendation_ListForward">景点</a></li>
		<li class="layui-nav-item" id="ywgl"><a href="seachByFour">游玩攻略</a></li>
		<li class="layui-nav-item" id="phb"><a href="diary_Contribution">排行榜</a></li>
		<!-- <li class="layui-nav-item"><a href="">排行榜</a></li> -->
		<li class="layui-nav-item" id="fksq"><a href="gbook">反馈社区</a></li>
	</ul>

	<!-- </nav> -->
	<style type="text/css">
.text-hide {
	text-overflow: ellipsis;
	height: 70px;
	overflow: hidden;
	width: 400px;
	text-overflow: ellipsis;
}
</style>

	<br>
	<script src="js/layui-v2.4.5/layui/layui.js" charset="utf-8"></script>
    <!-- 注意：如果你直接复制所有代码到本地，上述js路径需要改成你本地的 -->
    <script>
        layui.use('element', function() {
            var element = layui.element; //导航的hover效果、二级菜单等功能，需要依赖element模块

            //监听导航点击
            element.on('nav(demo)', function(elem) {
                //console.log(elem)
                layer.msg(elem.text());
            });
        });
    </script>
</body>
</html>