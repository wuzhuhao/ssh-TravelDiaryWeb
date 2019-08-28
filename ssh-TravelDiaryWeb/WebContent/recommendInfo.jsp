<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!doctype html>
<html>

<head>

<meta charset="utf-8">
<title>${recommend.name }</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
<link href="css/base.css" rel="stylesheet">
<link href="css/index.css" rel="stylesheet">
<link href="css/info.css" rel="stylesheet">
<link href="css/m.css" rel="stylesheet">
<link rel="stylesheet" href="css/baguetteBox.css">
<script src="js//jquery.min.js" type="text/javascript"></script>
<script type="text/javascript" src="js/comm.js"></script>
<script type="text/javascript" src="js/tagcloud.js"></script>

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

<script type="text/javascript">
        function likenum(d_id,u_id) {
            $.ajax({
                url: "DiaryLike_addLike",
                async: false,
                type: "POST",
                data: {
                    "diary_id": d_id,
                    "user_id":u_id
                },
                dataType: "json",
                success: function(data) {
                	var likea = "";
                    if (data.rs == true) {
                    	likea += " 已赞!  ";
                    } else {
                        likea += "<a onclick=\"likenum("+data.d_id+","+data.u_id+")\"> 很赞哦！ </a>";
                    }
                    var num = data.num;
                    $('#num').html(num);
                    $('#likea').html(likea);
                }
            });

        }
    </script>
<script type="text/javascript">
        function Comment() {
            var data1 = $("#comment").serialize();
            $.ajax({
                url: "comment",
                async: false,
                type: "POST",
                data: data1,
                dataType: "json",
                success: function(data) {
                    if (data == true) {
                    	alert("暂未登陆，无法评论文章")
                    	 window.location.href = "info?id=${info.did }";
                    } else {

                        window.location.href = "info?id=${info.did }";

                    }
                }

            });

        }
    </script>


<!--[if lt IE 9]>
<script src="js/modernizr.js"></script>
<![endif]-->
<style type="text/css">
h1, h2, h3, footer, .gallery {
	text-align: center;
}

pre {
	width: 340px;
	margin: 0 auto;
	border: dashed 1px #aaa;
	margin-bottom: 10px;
}

@media ( max-width : 480px) {
	pre {
		max-width: 98%;
	}
}

header, footer {
	display: block;
	padding: .2em 0;
	background-color: #555;
	box-shadow: 0 0 8px #222;
}

footer {
	margin-top: 1.5em;
}

.content {
	max-width: 1160px;
	margin: 0 auto;
}

.gallery:after {
	content: '';
	display: block;
	height: 2px;
	margin: .5em 0 1.4em;
	background-image: -webkit-linear-gradient(left, rgba(0, 0, 0, 0) 0%,
		rgba(77, 77, 77, 1) 50%, rgba(0, 0, 0, 0) 100%);
	background-image: linear-gradient(to right, rgba(0, 0, 0, 0) 0%,
		rgba(77, 77, 77, 1) 50%, rgba(0, 0, 0, 0) 100%);
}

.gallery img {
	height: 100%;
}

.gallery a {
	width: 240px;
	height: 180px;
	display: inline-block;
	overflow: hidden;
	margin: 4px 6px;
	box-shadow: 0 0 4px -1px #000;
}

.ribbon>img {
	position: absolute;
	top: 0;
	right: 0;
	border: 0;
}

@media ( max-width : 768px) {
	.sm-hidden {
		display: none;
	}
}
/* Highlight.js Tomorrow Night style */
.hljs-comment, .hljs-quote {
	color: #969896
}

.hljs-deletion, .hljs-name, .hljs-regexp, .hljs-selector-class,
	.hljs-selector-id, .hljs-tag, .hljs-template-variable, .hljs-variable {
	color: #c66
}

.hljs-tag {
	color: #f8f8f2
}

.hljs-built_in, .hljs-builtin-name, .hljs-link, .hljs-literal,
	.hljs-meta, .hljs-number, .hljs-params, .hljs-type {
	color: #de935f
}

.hljs-attr {
	color: #f0c674
}

.hljs-addition, .hljs-bullet, .hljs-string, .hljs-symbol {
	color: #b5bd68
}

.hljs-section, .hljs-title {
	color: #81a2be
}

.hljs-keyword, .hljs-selector-tag {
	color: #b294bb
}

.hljs {
	display: block;
	overflow-x: auto;
	background: #1d1f21;
	color: #c5c8c6;
	padding: .8em
}

.hljs-emphasis {
	font-style: italic
}

.hljs-strong {
	font-weight: 700
}
</style>
</head>

<body>
	<script>
        ! function() {
            function n(n, e, t) {
                return n.getAttribute(e) || t
            }

            function e(n) {
                return document.getElementsByTagName(n)
            }

            function t() {
                var t = e("script"),
                    o = t.length,
                    i = t[o - 1];
                return {
                    l: o,
                    z: n(i, "zIndex", -1),
                    o: n(i, "opacity", .5),
                    c: n(i, "color", "0,0,0"),
                    n: n(i, "count", 99)
                }
            }

            function o() {
                a = m.width = window.innerWidth || document.documentElement.clientWidth || document.body.clientWidth, c = m.height = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight
            }

            function i() {
                r.clearRect(0, 0, a, c);
                var n, e, t, o, m, l;
                s.forEach(function(i, x) {
                    for (i.x += i.xa, i.y += i.ya, i.xa *= i.x > a || i.x < 0 ? -1 : 1, i.ya *= i.y > c || i.y < 0 ? -1 : 1, r.fillRect(i.x - .5, i.y - .5, 1, 1), e = x + 1; e < u.length; e++) n = u[e], null !== n.x && null !== n.y && (o = i.x - n.x, m = i.y - n.y, l = o * o + m * m, l < n.max && (n === y && l >= n.max / 2 && (i.x -= .03 * o, i.y -= .03 * m), t = (n.max - l) / n.max, r.beginPath(), r.lineWidth = t / 2, r.strokeStyle = "rgba(" + d.c + "," + (t + .2) + ")", r.moveTo(i.x, i.y), r.lineTo(n.x, n.y), r.stroke()))
                }), x(i)
            }
            var a, c, u, m = document.createElement("canvas"),
                d = t(),
                l = "c_n" + d.l,
                r = m.getContext("2d"),
                x = window.requestAnimationFrame || window.webkitRequestAnimationFrame || window.mozRequestAnimationFrame || window.oRequestAnimationFrame || window.msRequestAnimationFrame || function(n) {
                    window.setTimeout(n, 1e3 / 45)
                },
                w = Math.random,
                y = {
                    x: null,
                    y: null,
                    max: 2e4
                };
            m.id = l, m.style.cssText = "position:fixed;top:0;left:0;z-index:" + d.z + ";opacity:" + d.o, e("body")[0].appendChild(m), o(), window.onresize = o, window.onmousemove = function(n) {
                n = n || window.event, y.x = n.clientX, y.y = n.clientY
            }, window.onmouseout = function() {
                y.x = null, y.y = null
            };
            for (var s = [], f = 0; d.n > f; f++) {
                var h = w() * a,
                    g = w() * c,
                    v = 2 * w() - 1,
                    p = 2 * w() - 1;
                s.push({
                    x: h,
                    y: g,
                    xa: v,
                    ya: p,
                    max: 6e3
                })
            }
            u = s.concat([y]), setTimeout(function() {
                i()
            }, 100)
        }();

    </script>
	
	<header class="header-navigation" id="header">
		<%@ include file="head_top.jsp" %>
	</header>
	<article>
		<aside class="l_box">
			<div class="search">
				<form action="seach" method="post" name="searchform" id="searchform">
					<input name="seach" id="keyboard" class="input_text"
						value="请输入关键字词" style="color: rgb(153, 153, 153);"
						onfocus="if(value=='请输入关键字词'){this.style.color='#000';value=''}"
						onblur="if(value==''){this.style.color='#999';value='请输入关键字词'}"
						type="text"> <input name="show" value="title"
						type="hidden"> <input name="tempid" value="1"
						type="hidden"> <input name="tbname" value="news"
						type="hidden"> <input name="Submit" class="input_submit"
						value="搜索" type="submit">
				</form>
			</div>
			<div class="fenlei">
		<h2>文章分类</h2>
		<ul>
			<li><a href="list4?seach=zijiayou">自驾游（${zijiayou }）</a></li>
			<li><a href="list4?seach=haibianyou">海边游（${haibianyou }）</a></li>
			<li><a href="list4?seach=chujingyou">出境游（${chujingyou }）</a></li>
			<li><a href="list4?seach=gentuanyou">跟团游（${gentuanyou }）</a></li>
			<li><a href="list4?seach=ziyouxing">自由行（${ziyouxing }）</a></li>
			<li><a href="list4?seach=qiongyou">穷游（${qiongyou}）</a></li>
		</ul>
	</div>
			
			
			<div class="tuijian">
				<h2>推荐游记</h2>
				<ul>
					<c:forEach items="${recommendedDiary}" var="diary3">
						<li><a href="info?id=${diary3.did}">${diary3.title}</a></li>
					</c:forEach>
				</ul>
			</div>
			<div class="cloud">
				<h2>标签云</h2>
					<div class="tagcloud">

					<a href="list4?seach=zijiayou" style=" padding:${zijiayou2}px";>自驾游</a>
					<a href="list4?seach=haibianyou" style=" padding:${haibianyou2}px";>海边游</a> <a
						href="list4?seach=chujingyou" style=" padding:${chujingyou2}px";>出境游</a>
					<a href="list4?seach=gentuanyou" style=" padding:${gentuanyou2}px";>跟团游</a>
					<a href="list4?seach=ziyouxing" style=" padding:${ziyouxing2}px";>自由行</a>
					<a href="list4?seach=qiongyou" style=" padding:${qiongyou2}px";>穷游</a>
					<a href="list4?seach=zijiayou" style=" padding:${zijiayou2}px";>自驾游</a>
					<a href="list4?seach=haibianyou" style=" padding:${haibianyou2}px";>海边游</a> <a
						href="list4?seach=chujingyou" style=" padding:${chujingyou2}px";>出境游</a>
					<a href="list4?seach=gentuanyou" style=" padding:${gentuanyou2}px";>跟团游</a>
					<a href="list4?seach=ziyouxing" style=" padding:${ziyouxing2}px";>自由行</a>
					<a href="list4?seach=qiongyou" style=" padding:${qiongyou2}px";>穷游</a>
				</div>
			</div>
			<script type="text/javascript">
                /*3D标签云*/

                tagcloud({
                    selector: ".tagcloud", //元素选择器
                    fontsize: 17, //基本字体大小, 单位px
                    radius: 100, //滚动半径, 单位px
                    mspeed: "slow", //滚动最大速度, 取值: slow, normal(默认), fast
                    ispeed: "slow", //滚动初速度, 取值: slow, normal(默认), fast
                    direction: 135, //初始滚动方向, 取值角度(顺时针360): 0对应top, 90对应left, 135对应right-bottom(默认)...
                    keep: false //鼠标移出组件后是否继续随鼠标滚动, 取值: false, true(默认) 对应 减速至初速度滚动, 随鼠标滚动
                });

            </script>
			<!--<div class="guanzhu">
    <h2>联系作者</h2>
    <ul>
        <img src="images/2019.jpg">
    </ul>
</div>-->
		</aside>
		<main>
		<div class="infosbox">
			<div class="newsview">
				<h3 class="news_title">${recommend.name }</h3>
				<div class="bloginfo">
					<ul>
						<li class="author">地点：<a href="/">${recommend.local }</a></li>
					</ul>
				</div>
				<div class="tags">
					<c:if test="${recommend.type_ == 1}">
						<a target="_blank">玩</a>
					</c:if>
					<c:if test="${recommend.type_ == 2}">
						<a target="_blank">吃</a>
					</c:if>
					<c:if test="${recommend.type_ == 3}">
						<a target="_blank">买</a>
					</c:if>
				</div>
				<div class="news_about">
					<%-- <strong>个人简介:${user.individualResume }</strong> --%><br> <br>&nbsp;&nbsp;${recommend.content }<br>
					<br>
					<div class="content">
								<div class="baguetteBoxFive gallery">
									<a href="${recommend.image }"> <img src="${recommend.image }"
										alt="A caption in the alt attribute">
									</a>
								</div>
								<br>
							</div>
					<br> &nbsp;
				</div>
			</div>
		</div>
		</div>
		</div>
		</main>
	</article>

</body>
<script src="js/love.js" type="text/javascript"></script>
<script>
    window.onload = function() {
        baguetteBox.run('.baguetteBoxOne');
        baguetteBox.run('.baguetteBoxTwo');
        baguetteBox.run('.baguetteBoxThree', {
            animation: 'fadeIn',
            noScrollbars: true
        });
        baguetteBox.run('.baguetteBoxFour', {
            buttons: false
        });
        baguetteBox.run('.baguetteBoxFive', {
            captions: function(element) {
                return element.getElementsByTagName('img')[0].alt;
            }
        });

        if (typeof oldIE === 'undefined' && Object.keys) {
            hljs.initHighlighting();
        }
    };

</script>
<script type="text/javascript">
window.onload = function () {
	$("#ywgl").css("color","#f65a8a");
}
</script>
</html>
