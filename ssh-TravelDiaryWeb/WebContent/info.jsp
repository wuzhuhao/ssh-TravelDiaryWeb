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
<title>${info.content }</title>
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
<script type="text/javascript" src="js/checkUtil.js"></script>
<script src="js/spotUtil.js" type="text/javascript"></script>
<script type="text/javascript">
		function reply_submit(id) {
		    var ul = $("ul[data-id=" + id + "]")
		    var form = ul.find('div.replyDiv').find('form');
		    var data1 = form.serializeArray();
		    var da={};
		    $.each(data1, function() {
		        da[this.name] = this.value;
		      });
		    $.ajax({
		        url: "comment_reply",
		        async: false,
		        type: "POST",
		        data: data1,
		        dataType: "json",
		        success: function (data) {
		        	if (data == true) {
				        alert('回复成功');
				        ul.html('<p class="zzhf"><font color="#FF0000">作者回复:</font>' + da['comment.reply'] + '</p>');
				    } else {
				        alert('回复失败');
				    }
		        }
		    });
		}
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
                        likea += '<a onclick = likenum('+data.d_id+','+data.u_id+') style="cursor:pointer;"> 很赞哦！ </a>';
                    }
                    var num = data.num;
                    var tip = data.tip;
                    if(tip != "" && tip != null && tip != undefined){
                    	alert(tip);
                    }
                    $('#num').html(num);
                    $('#likea').html(likea);
                }
            });

        }
        function delDiray(id) {
        	if (confirm("是否确认删除")) {
                window.location.href = "delete?id=" + id;
            }
        }

    </script>
<script type="text/javascript">
		function checkLogin(){
			var userName = '${user.userName}';
			if(isEmpty(userName)){
				return true;
			}
			return false;
		}
		
        function Comment() {
        	
        	/* var name = document.getElementById('name').value;
        	
        	if(name.length<1){
        		alert("暂未登陆，无法评论文章")
        		return;
        	} */
        	if(checkLogin()){
        		alert("暂未登陆，无法评论文章");
        		return;
        	}
            var data1 = $("#comment").serialize();
            $.ajax({
                url: "comment",
                async: false,
                type: "POST",
                data: data1,
                dataType: "json",
                success: function(data) {
                    if (data == 0) {
                    	alert("不能评论自己的文章")
                    }
                    else if(data==true){
                    	alert("发表评论成功")
                        window.location.href = "info?id=${info.did }";
                    }
                    else{
                    	alert("发表评论失败,请检查登陆状态")
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
		! spotRun();
    </script>

	<!-- <header class="header-navigation" id="header">
		
	</header> -->
	<%@ include file="head_top.jsp"%>
	<article>
		<aside class="l_box">
			<div class="tuijian">
				<h2>
					相关目的地：<a href="seachCityByCountryRegion?destinationName=${info.province }"
						style="color: coral">${session.info.province }</a> <a
						href="seachCityByCountryRegion?destinationName=${info.city }" style="color: coral">${session.info.city }</a>
				</h2>
			</div>
			<div class="tuijian">
				<h2>猜你喜欢</h2>
				<ul>
					<c:forEach items="${guessLikeList}" var="diary3">
						<li><a href="info?id=${diary3.did}">${diary3.title}</a></li>
					</c:forEach>
				</ul>
			</div>
			<div class="tuijian">
				<h2>相关游记</h2>
				<ul>
					<c:forEach items="${relevantDiary}" var="diary3">
						<li><a href="info?id=${diary3.did}">${diary3.title}</a></li>
					</c:forEach>
				</ul>
			</div>
			<div class="cloud">
				<h2>标签云</h2>
				<div class="tagcloud">
					<a href="seachByFour?diary.classify=自驾游"
						style=" padding:${zijiayou2}px">自驾游</a> <a
						href="seachByFour?diary.classify=海边游"
						style=" padding:${haibianyou2}px">海边游</a> <a
						href="seachByFour?diary.classify=出境游"
						style=" padding:${chujingyou2}px">出境游</a> <a
						href="seachByFour?diary.classify=跟团游"
						style=" padding:${gentuanyou2}px">跟团游</a> <a
						href="seachByFour?diary.classify=自由行"
						style=" padding:${ziyouxing2}px">自由行</a> <a
						href="seachByFour?diary.classify=穷游"
						style=" padding:${qiongyou2}px">穷游</a> <a
						href="seachByFour?diary.classify=自驾游"
						style=" padding:${zijiayou2}px">自驾游</a> <a
						href="seachByFour?diary.classify=海边游"
						style=" padding:${haibianyou2}px">海边游</a> <a
						href="seachByFour?diary.classify=出境游"
						style=" padding:${chujingyou2}px">出境游</a> <a
						href="seachByFour?diary.classify=跟团游"
						style=" padding:${gentuanyou2}px">跟团游</a> <a
						href="seachByFour?diary.classify=自由行"
						style=" padding:${ziyouxing2}px">自由行</a> <a
						href="seachByFour?diary.classify=穷游"
						style=" padding:${qiongyou2}px">穷游</a>
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
		</aside>
		<main>
		<div class="infosbox">
			<div class="newsview">
				<h3 class="news_title">${info.title }</h3>
				<div class="bloginfo">
					<ul>
						<li class="author">作者：<a
							href="findUserById?u_id=${info.user.id }">${session.info.user.userName }</a></li>
						<li class="lmname">${info.keyLandscape }</li>
						<li class="timer">${info.dTime }</li>

					</ul>
				</div>
				<div class="tags">
					<a target="_blank">游记</a> &nbsp; <a target="_blank">${info.classify }</a>
				</div>
				<div class="news_about">
					<strong>作者简介:${info.user.individualResume }</strong><br> <br>&nbsp;&nbsp;${info.content }<br>
					<br>
					<c:forEach items="${photoList}" var="photo">
						<div class="jq22-container">

							<div class="content">
								<div class="baguetteBoxFive gallery">
									<a href="${photo.image }"> <img src="${photo.image }"
										alt="A caption in the alt attribute">
									</a>
								</div>
								<br>
							</div>
						</div>
					</c:forEach>
					<br> &nbsp;
				</div>
			</div>
			<c:if test="${user != null}">
				<c:if test="${user.id == info.user.id}">
					<div class="share">
						<p class="diggit">
							<a onclick="delDiray(${info.did})" style="cursor:pointer;"> 删除日记 </a>
						</p>
					</div>
				</c:if>
			</c:if>
			<div class="share">
				<p class="diggit">
					<span id="likea"> <c:if test="${flag != 1}">
							<a onclick="likenum(${info.did},${user.id})" style="cursor:pointer;"> 很赞哦！ </a>
						</c:if> <c:if test="${flag == 1}">
							已赞！
						</c:if>
					</span>(<b id="diggnum"> <script type="text/javascript"
							src="/e/public/ViewClick/?classid=2&id=20&down=5"></script><span
						id="num">${info.likenum}</span></b>)
				</p>
			</div>

			<div class="nextinfo">
				<p>
					<a href="index2">返回列表</a>
				</p>
			</div>
			<div class="news_pl">
				<h2>文章评论</h2>
				<c:forEach items="${commentList}" var="comment">
					<div class="gbko">

						<script src="/e/pl/more/?classid=77&amp;id=106&amp;num=20"></script>
						<div class="fb">
							<ul>
								<p class="fbtime">
									<span style="width: auto">${comment.time}</span>${comment.user.userName}</p>
								<p class="fbinfo">${comment.content}</p>
							</ul>
						</div>
					</div>


					<c:choose>
						<c:when test="${empty comment.reply && !empty user.id&&user.id==info.user.id}">
							<div class="hf">
								<ul data-id="${comment.id }">
									<div class="replyDiv">
										<form action="comment_reply" method="post" id="comment_reply">
											<p class="zzhf">
												<font color="#FF0000">回复:</font> &nbsp;&nbsp; 
												<input id="reply" name="comment.reply">&nbsp; <input
													type="hidden" name="id" value="${comment.id }">
													<input type="hidden" name="diaryId" value="${info.did }"> <input
													type="button" value="发送"
													onclick="reply_submit(${comment.id})">
											</p>
										</form>
									</div>
								</ul>
							</div>
						</c:when>
						<c:when test="${!empty comment.reply }">
							<div class="hf">
								<ul data-id="${comment.id }">
									<p class="zzhf">
										<font color="#FF0000">作者回复:</font>${comment.reply }</p>
								</ul>
							</div>
						</c:when>
					</c:choose>




				</c:forEach>


				<script>
                    function CheckPl(obj) {
                        if (obj.saytext.value == "") {
                            alert("您没什么话要说吗？");
                            obj.saytext.focus();
                            return false;
                        }
                        return true;
                    }

                </script>
				<form id="comment" method="post">

					<div id="plpost">
						<p class="saying">
							<span><a>共有<script type="text/javascript"
										src="/e/public/ViewClick/?classid=77&amp;id=106&amp;down=2"></script>${fn:length(commentList)}条评论</a></span>来说两句吧...
						</p>
						<input name="nomember" type="hidden" id="nomember" value="1"
							checked="checked">
						<textarea name="comment.content" rows="6" id="saytext"></textarea>
						<input type="hidden" name="diaryId" value="${info.did}"> <input
							type="hidden" name="ecmsfrom"
							value="/joke/talk/2018-07-23/106.html">
					</div>
				</form>
				<div id="plpost">
					<input name="imageField" type="submit" onclick="Comment()"
						value="提交">
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

</html>
