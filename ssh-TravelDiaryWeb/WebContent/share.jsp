<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!doctype html>
<html>
<head>
<meta charset="gbk">
<title>旅游网|推荐</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="css/base.css" rel="stylesheet">
<link href="css/index.css" rel="stylesheet">
<link href="css/m.css" rel="stylesheet">
<!--[if lt IE 9]>
<script src="js/modernizr.js"></script>
<![endif]-->
<script src="js/jquery.min.js" type="text/javascript"></script>
<script type="text/javascript" src="js/comm.js"></script>
<script src="js/scrollReveal.js"></script>
<style type="text/css">
ul {
	list-style-type: none;
}

#cityListBox {
	margin: 1px;
	padding: 15px;
	background: #edebe8;
	-webkit-box-shadow: 11px 10px 20px -3px rgba(0, 0, 0, 0.7);
	-moz-box-shadow: 11px 10px 20px -3px rgba(0, 0, 0, 0.7);
	box-shadow: 11px 10px 20px -3px rgba(0, 0, 0, 0.7);
}
#cityListBox1 {
	margin: 1px;
	padding: 15px;
	background: #edebe8;
	-webkit-box-shadow: 11px 10px 20px -3px rgba(0, 0, 0, 0.7);
	-moz-box-shadow: 11px 10px 20px -3px rgba(0, 0, 0, 0.7);
	box-shadow: 11px 10px 20px -3px rgba(0, 0, 0, 0.7);
}

#cityList1 {
	display: none;
}

#cityList2 {
	display: none;
}

#cityList3 {
	display: none;
}

#cityList4 {
	display: none;
}
</style>
<style type="text/css">
.text-hide {
	text-overflow: ellipsis;
	-webkit-line-clamp: 10;
	overflow: hidden;
	width: 400px;
	text-overflow: ellipsis;
}
</style>

</head>
<body>
<script type="text/javascript">
window.onload = function () {
	$("#ywgl").css("color","#f65a8a");
}
</script>
	<script> 
    
!function(){function n(n,e,t){return n.getAttribute(e)||t}function e(n){return document.getElementsByTagName(n)}function t(){var t=e("script"),o=t.length,i=t[o-1];return{l:o,z:n(i,"zIndex",-1),o:n(i,"opacity",.5),c:n(i,"color","0,0,0"),n:n(i,"count",99)}}function o(){a=m.width=window.innerWidth||document.documentElement.clientWidth||document.body.clientWidth,c=m.height=window.innerHeight||document.documentElement.clientHeight||document.body.clientHeight}function i(){r.clearRect(0,0,a,c);var n,e,t,o,m,l;s.forEach(function(i,x){for(i.x+=i.xa,i.y+=i.ya,i.xa*=i.x>a||i.x<0?-1:1,i.ya*=i.y>c||i.y<0?-1:1,r.fillRect(i.x-.5,i.y-.5,1,1),e=x+1;e<u.length;e++)n=u[e],null!==n.x&&null!==n.y&&(o=i.x-n.x,m=i.y-n.y,l=o*o+m*m,l<n.max&&(n===y&&l>=n.max/2&&(i.x-=.03*o,i.y-=.03*m),t=(n.max-l)/n.max,r.beginPath(),r.lineWidth=t/2,r.strokeStyle="rgba("+d.c+","+(t+.2)+")",r.moveTo(i.x,i.y),r.lineTo(n.x,n.y),r.stroke()))}),x(i)}var a,c,u,m=document.createElement("canvas"),d=t(),l="c_n"+d.l,r=m.getContext("2d"),x=window.requestAnimationFrame||window.webkitRequestAnimationFrame||window.mozRequestAnimationFrame||window.oRequestAnimationFrame||window.msRequestAnimationFrame||function(n){window.setTimeout(n,1e3/45)},w=Math.random,y={x:null,y:null,max:2e4};m.id=l,m.style.cssText="position:fixed;top:0;left:0;z-index:"+d.z+";opacity:"+d.o,e("body")[0].appendChild(m),o(),window.onresize=o,window.onmousemove=function(n){n=n||window.event,y.x=n.clientX,y.y=n.clientY},window.onmouseout=function(){y.x=null,y.y=null};for(var s=[],f=0;d.n>f;f++){var h=w()*a,g=w()*c,v=2*w()-1,p=2*w()-1;s.push({x:h,y:g,xa:v,ya:p,max:6e3})}u=s.concat([y]),setTimeout(function(){i()},100)}();  


</script>
	<header class="header-navigation" id="header">
		<%@ include file="head_top.jsp" %>
	</header>
	<article>

		<div class="picbox">
			<ul >
				<c:forEach items="${pageBean.list}" end="1" var="recommend">
					<li data-scroll-reveal="enter bottom over 1s"><a
						href="recommend_findById?id_=${recommend.id}"><i><img
								src="${recommend.image }"></i>
							<div class="picinfo">
								<h3>${recommend.name }</h3></a></li>
				</c:forEach>
			</ul>
			<ul>
				<c:forEach items="${pageBean.list}" begin="2" end="3" var="recommend">
					<li data-scroll-reveal="enter bottom over 1s"><a
						href="recommend_findById?id_=${recommend.id}"><i><img
								src="${recommend.image }"></i>
							<div class="picinfo">
								<h3>${recommend.name }</h3></a></li>
				</c:forEach>
			</ul>
			<ul>
				<c:forEach items="${pageBean.list}" begin="4" end="5" var="recommend">
					<li data-scroll-reveal="enter bottom over 1s"><a
						href="recommend_findById?id_=${recommend.id}"><i><img
								src="${recommend.image }"></i>
							<div class="picinfo">
								<h3>${recommend.name }</h3></a></li>
				</c:forEach>
			</ul>
			<ul>
				<c:forEach items="${pageBean.list}" begin="6" end="7" var="recommend">
					<li data-scroll-reveal="enter bottom over 1s"><a
						href="recommend_findById?id_=${recommend.id}"><i><img
								src="${recommend.image }"></i>
							<div class="picinfo">
								<h3>${recommend.name }</h3></a></li>
				</c:forEach>
			</ul>



		</div>
		<div class="pagelist">
			<c:if test="${pageBean.totalPage != 0}">
				<c:if test="${pageBean.page != 1}">
				<span id="nextPage"><a style="cursor: default"
				href="recommend_findRecommend?type_=${pageBean.params.type_}&page=1">首页</a></span>
				<span id="nextPage"><a style="cursor: default"
					href="recommend_findRecommend?type_=${pageBean.params.type_}&page=${pageBean.page-1}">上一页</a></span>
			</c:if>
			<span>第${pageBean.page}/${pageBean.totalPage}页 </span>
			<c:if test="${pageBean.page != pageBean.totalPage}">
				<span id="nextPage"><a style="cursor: default"
					href="recommend_findRecommend?type_=${pageBean.params.type_}&page=${pageBean.page+1}">下一页</a></span>
			</c:if>
			</c:if>
			<c:if test="${pageBean.totalPage == 0}">
				<span>暂时无推荐，请敬请期待</span>
			</c:if>
			
		</div>
		<script>
	if (!(/msie [6|7|8|9]/i.test(navigator.userAgent))){
		(function(){
			window.scrollReveal = new scrollReveal({reset: true});
		})();
	};
</script>
</body>
<script src="js/love.js" type="text/javascript"></script>
</html>
