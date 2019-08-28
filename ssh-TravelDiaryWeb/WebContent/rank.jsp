<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>旅游网|排行榜</title>
<link href="css/style1.css" rel="stylesheet" type="text/css">
<link href="css/base.css" rel="stylesheet">
<link href="css/index.css" rel="stylesheet">
<link href="css/m.css" rel="stylesheet">
<!--[if lt IE 9]>
<script src="js/modernizr.js"></script>
<![endif]-->
<script src="js/jquery.min.js" type="text/javascript"></script>
<script type="text/javascript" src="js/comm.js"></script>
<script src="js/spotUtil.js" type="text/javascript"></script>
<script src="js/scrollReveal.js"></script>
<script type="text/javascript">
	window.onload = function () {
		$("#phb").addClass("layui-this");
	}
</script>
<style>
html, body {
  height: 100%;
}


.tariffCards {
  position: absolute;
  top: 45%;
  left: 90%;
  margin: -180px 0 0 -140px;
  user-select: none;
  transform: translate3d(0, 0, 0);
  transform-style: preserve-3d;
}
.tariffCards:after {
  position: absolute;
  bottom: -27px;
  left: 5%;
  content: "";
  width: 65%;
  height: 10px;
  border-radius: 100%;
  background-image: radial-gradient(rgba(34, 50, 84, 0.04), rgba(34, 50, 84, 0));
}
.tariffCards > div {
  position: relative;
  width: 280px;
  height: 140px;
  border-radius: 12px;
  color: white;
  transform: rotateX(45deg) rotateY(-15deg) rotate(45deg);
  transition: all 0.4s ease;
  overflow: hidden;
  cursor: pointer;
}
.tariffCards > div:after {
  position: absolute;
  top: -70px;
  left: 0;
  content: "";
  width: 200%;
  height: 200%;
  background-image: linear-gradient(60deg, rgba(255, 255, 255, 0) 20%, rgba(255, 255, 255, 0.1), rgba(255, 255, 255, 0) 80%);
  transform: translateX(-100%);
}
.tariffCards > div img {
  margin-top: 15px;
  pointer-events: none;
}
.tariffCards > div h3 {
  position: absolute;
  bottom: 28px;
  left: 15px;
  font-size: 18px;
  font-weight: 800;
}
.tariffCards > div span {
  position: absolute;
  font-weight: 700;
  bottom: 15px;
  left: 15px;
  font-size: 12px;
  font-weight: 600;
  opacity: 0.8;
}
.tariffCards > div.economy {
  margin-top: 0;
  z-index: 3;
  background-color: #8063E1;
  background-image: linear-gradient(135deg, #BD7BE8, #8063E1);
  box-shadow: 20px 20px 60px rgba(34, 50, 84, 0.5), 1px 1px 0px 1px #8063E1;
}
.tariffCards > div.premiumeconomy {
  margin-top: -70px;
  z-index: 2;
  background-color: #3F58E3;
  background-image: linear-gradient(135deg, #7F94FC, #3F58E3);
  box-shadow: 20px 20px 60px rgba(34, 50, 84, 0.5), 1px 1px 0px 1px #3F58E3;
}
.tariffCards > div.business {
  margin-top: -70px;
  z-index: 1;
  background-color: #2C6FD1;
  background-image: linear-gradient(135deg, #21BBFE, #2C6FD1);
  box-shadow: 20px 20px 60px rgba(34, 50, 84, 0.5), 1px 1px 0px 1px #2C6FD1;
}
.tariffCards > div.first {
  margin-top: -70px;
  background-color: #352F64;
  background-image: linear-gradient(135deg, #415197, #352F64);
  box-shadow: 5px 5px 60px rgba(34, 50, 84, 0.1), 1px 1px 0px 1px #352F64;
}
.tariffCards > div:hover {
  transform: rotateX(30deg) rotateY(-15deg) rotate(30deg) translate(-25px, 50px);
}
.tariffCards > div:hover:after {
  transform: translateX(100%);
  transition: all 1.2s ease-in-out;
}


</style>
</head>
<body>
	<script>
		! spotRun();
    </script>
<br><br><br><br><br><br><br>
<header class="header-navigation" id="header">
		<%@ include file="head_top.jsp" %>
	</header>
<div class="ques-section clearfix" >
	<div class="ques-section-item">
		<h2 class="ques-item-title">旅游专家</h2>
		<div class="ques-section-card">
			<div class="ques-card-head ques-card-gul">
				<svg version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" width="323px" height="30px" xml:space="preserve">
					<defs>
						<pattern id="water" width=".25" height="1.1" patternContentUnits="objectBoundingBox">
							<path fill="#fff" d="M0.25,1H0c0,0,0-0.659,0-0.916c0.083-0.303,0.158,0.334,0.25,0C0.25,0.327,0.25,1,0.25,1z"></path>
						</pattern>
						<g id="eff">
							<rect fill="url(#water)" x="-119.461" y="0" width="1200" height="120" opacity="0.1">
								<animate attributeType="xml" attributeName="x" from="-300" to="0" repeatCount="indefinite" dur="10s"></animate>
							</rect>
							<rect fill="url(#water)" y="5" width="1600" height="125" opacity="0.1" x="-399.447">
								<animate attributeType="xml" attributeName="x" from="-400" to="0" repeatCount="indefinite" dur="13s"></animate>
							</rect>
						</g>
					</defs>
					<use xlink:href="#eff" opacity="1" style="mix-blend-mode:normal;"></use>
				</svg>
			</div>
			<div class="ques-card-title">NO.1</div>
			<!-- <div class="ques-card-text">在社区问问最专业的知识贡献用户</div> -->
			<a href="javascript:;" class="ques-card-num">
				<img src="${contribution.get(0).image }" alt="">
			</a>
			<div class="ques-card-name">${contribution.get(0).userName }</div>
			<div class="ques-card-major">${contribution.get(0).individualResume }</div>
			<div class="ques-card-field">贡献文章排行榜NO.1</div>
			<div class="ques-card-tag">
				<span>${text }榜</span>
			</div>
			<a href="findUserById?u_id=${contribution.get(0).id}" class="ques-card-help">查看主页</a>
			
		</div>
	</div>
	<div class="ques-section-item">
		<h2 class="ques-item-title">旅游达人</h2>
		<div class="ques-section-card">
			<div class="ques-card-head ques-card-org">
				<svg version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" width="323px" height="30px" xml:space="preserve">
					<defs>
						<pattern id="water" width=".25" height="1.1" patternContentUnits="objectBoundingBox">
							<path fill="#fff" d="M0.25,1H0c0,0,0-0.659,0-0.916c0.083-0.303,0.158,0.334,0.25,0C0.25,0.327,0.25,1,0.25,1z"></path>
						</pattern>
						<g id="eff">
							<rect fill="url(#water)" x="-119.461" y="0" width="1200" height="120" opacity="0.3">
								<animate attributeType="xml" attributeName="x" from="-300" to="0" repeatCount="indefinite" dur="10s"></animate>
							</rect>
							<rect fill="url(#water)" y="5" width="1600" height="125" opacity="0.3" x="-399.447">
								<animate attributeType="xml" attributeName="x" from="-400" to="0" repeatCount="indefinite" dur="13s"></animate>
							</rect>
						</g>
					</defs>
					<use xlink:href="#eff" opacity="1" style="mix-blend-mode:normal;"></use>
				</svg>
			</div>
			<div class="ques-card-title">NO.2</div>
			<!-- <div class="ques-card-text">问问官方直接领导的热心用户</div> -->
			<a href="javascript:;" class="ques-card-num">
				<img src="${contribution.get(1).image }" alt="">
			</a>
			<div class="ques-card-name">${contribution.get(1).userName }</div>
			<div class="ques-card-major">${contribution.get(1).individualResume }</div>
			<div class="ques-card-field">贡献文章排行榜NO.2</div>
			<div class="ques-card-tag">
				<span>${text }榜</span>
			</div>
			<a href="findUserById?u_id=${contribution.get(1).id}" class="ques-card-help">查看主页</a>
			
		</div>
	</div>
	<div class="ques-section-item">
		<h2 class="ques-item-title">其他排行</h2>
		<div class="ques-section-card">
			<div class="ques-card-head ques-card-bul">
				<svg version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" width="323px" height="30px" xml:space="preserve">
					<defs>
						<pattern id="water" width=".25" height="1.1" patternContentUnits="objectBoundingBox">
							<path fill="#fff" d="M0.25,1H0c0,0,0-0.659,0-0.916c0.083-0.303,0.158,0.334,0.25,0C0.25,0.327,0.25,1,0.25,1z"></path>
						</pattern>
						<g id="eff">
							<rect fill="url(#water)" x="-119.461" y="0" width="1200" height="120" opacity="0.3">
								<animate attributeType="xml" attributeName="x" from="-300" to="0" repeatCount="indefinite" dur="10s"></animate>
							</rect>
							<rect fill="url(#water)" y="5" width="1600" height="125" opacity="0.3" x="-399.447">
								<animate attributeType="xml" attributeName="x" from="-400" to="0" repeatCount="indefinite" dur="13s"></animate>
							</rect>
						</g>
					</defs>
					<use xlink:href="#eff" opacity="1" style="mix-blend-mode:normal;"></use>
				</svg>
			</div>
			<div class="ques-card-title ques-card-title-top">${text }排行榜</div>
			<ul class="ques-card-list">
				<c:forEach items="${contribution}" begin="2" end="6" var="item" varStatus="go">
					<li class="ques-card-list-noe" onclick="location.href='findUserById?u_id=${item.id}';">
						<div class="ques-list-box clearfix">
							<div class="ques-list-head">
								<div class="ques-list-image">
									<img src="${item.image }" alt="">
								</div>
							</div>
							<div class="ques-list-name">
								<div class="ques-list-name-head">  ${item.userName }</div>
							</div>
							<span class="ques-list-name-icon item-icon001" style="color: red">${go.count+2 }</span>
						</div>
					</li>
				</c:forEach>
				
				<%-- <li class="ques-card-list-two" onclick="location.href='findUserById?u_id=${contribution.get(3).id}';">
					<div class="ques-list-box clearfix">
						<div class="ques-list-head">
							<div class="ques-list-image">
								<img src="${contribution.get(3).image }" alt="">
							</div>
						</div>
						<div class="ques-list-name">
							<div class="ques-list-name-head">${contribution.get(3).userName }</div>
							
						</div>
						<span class="ques-list-name-icon item-icon002">4</span>
					</div>
				</li>
				<li class="ques-card-list-three" onclick="location.href='findUserById?u_id=${contribution.get(4).id}';">
					<div class="ques-list-box clearfix">
						<div class="ques-list-head">
							<div class="ques-list-image">
								<img src="${contribution.get(4).image }" alt="">
							</div>
						</div>
						<div class="ques-list-name">
							<div class="ques-list-name-head">${contribution.get(4).userName }</div>
							
						</div>
						<span class="ques-list-name-icon item-icon003">5</span>
					</div>
				</li>
				<li class="" onclick="location.href='findUserById?u_id=${contribution.get(5).id}';">
					<div class="ques-list-box clearfix">
						<div class="ques-list-head">
							<div class="ques-list-image">
								<img src="${contribution.get(5).image }" alt="">
							</div>
						</div>
						<div class="ques-list-name">
							<div class="ques-list-name-head">${contribution.get(5).userName }</div>
							
						</div>
						<span class="ques-list-name-icon item-icon004">6</span>
					</div>
				</li> --%>
				<%-- <li class="" onclick="location.href='findUserById?u_id=${contribution.get(6).id}';">
					<div class="ques-list-box clearfix">
						<div class="ques-list-head">
							<div class="ques-list-image">
								<img src="${contribution.get(6).image }" alt="">
							</div>
						</div>
						<div class="ques-list-name">
							<div class="ques-list-name-head">${contribution.get(6).userName }</div>
							
						</div>
						<span class="ques-list-name-icon item-icon005">7</span>
					</div>
				</li> --%>
			</ul>
		</div>
	</div>



<div class="tariffCards">

    <div class="economy"  onclick="location.href='diary_Contribution';" >
        <img src="img/tarcs.png" alt="Economy" height="74" >
        <h3 >贡献榜</h3>
        <span >贡献文章排行榜</span>
    </div>
    <div class="premiumeconomy"  onclick="location.href='comment_Contribution';">
        <img src="img/tarcs.png" alt="Premium Economy" height="74">
        <h3>热门榜</h3>
        <span>文章人气排行榜</span>
    </div>
    <div class="business"  onclick="location.href='userMessage_Contribution';">
        <img src="img/tarcs.png" alt="Business" height="74">
        <h3>人气榜</h3>
        <span>用户留言活跃榜</span>
    </div>
   
    </div>
</div>
</body>
</html>