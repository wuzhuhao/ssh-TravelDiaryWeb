<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>

<head>
<meta charset="utf-8">
<!--<script type="text/javascript" src="js/Cooldog.js"></script>-->
<script src="js/jquery.min.js" type="text/javascript"></script>
<script src="js/spotUtil.js" type="text/javascript"></script>
<script src="js/checkUtil.js" type="text/javascript"></script>
<script src="js/indexPage.js" type="text/javascript"></script>
<link rel="stylesheet" href="css/Cooldog.css">
<link rel="stylesheet" href="css/iconfont.css">
<title>旅游网|首页</title>
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
        $(document).ready(function() {
            //鼠标移入显示左右箭头和关闭按钮
            var timer = '';
            $('.Cooldog_container').mouseover(function() {
                $('.btn_left').show('1000');
                $('.btn_right').show('1000');
                $('.btn_close').show('1000');
                clearInterval(timer);
            }).mouseleave(function() {
                $('.btn_left').hide('1000');
                $('.btn_right').hide('1000');
                $('.btn_close').hide('1000');
                timer = setInterval(btn_right, 4000);
            });

            //点击关闭隐藏轮播图
            $('.btn_close').on('click', function() {
                $('.Cooldog_container').hide('1000');
            });

            var arr = ['p1', 'p2', 'p3', 'p4', 'p5', 'p6', 'p7'];
            var index = 0;

            //上一张
            $('.btn_left').on('click', function() {
                btn_left();
            });

            //下一张
            $('.btn_right').on('click', function() {
                btn_right();
            });

            //图片自动轮播
            timer = setInterval(btn_right, 4000);

            //点击上一张的封装函数
            function btn_left() {
                arr.unshift(arr[6]);
                arr.pop();
                $('.Cooldog_content li').each(function(i, e) {
                    $(e).removeClass().addClass(arr[i]);
                })
                index--;
                if (index < 0) {
                    index = 6;
                }
                show();
            }

            //点击下一张的封装函数
            function btn_right() {
                arr.push(arr[0]);
                arr.shift();
                $('.Cooldog_content li').each(function(i, e) {
                    $(e).removeClass().addClass(arr[i]);
                })
                index++;
                if (index > 6) {
                    index = 0;
                }
                show();
            }

            //点击底部的按钮切换图片
            $('.buttons a').each(function() {
                $(this).on('click', function() {
                    var myindex = $(this).index();
                    var mindex = myindex - index;
                    if (mindex == 0) {
                        return;
                    } else if (mindex > 0) {
                        var newarr = arr.splice(0, mindex);
                        //$.merge() 函数用于合并两个数组内容到第一个数组
                        arr = $.merge(arr, newarr);
                        $('.Cooldog_content li').each(function(i, e) {
                            $(e).removeClass().addClass(arr[i]);
                        })
                        index = myindex;
                        show();
                    } else if (mindex < 0) {
                        //reverse() 方法用于颠倒数组中元素的顺序。
                        arr.reverse();
                        var oldarr = arr.splice(0, -mindex);
                        arr = $.merge(arr, oldarr);
                        arr.reverse();
                        $('.Cooldog_content li').each(function(i, e) {
                            $(e).removeClass().addClass(arr[i]);
                        })
                        index = myindex;
                        show();
                    }
                })
            })

            //底部按钮高亮
            function show() {
                $('.buttons a').eq(index).addClass('color').siblings().removeClass('color');
            }
        });

    </script>

<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
<link href="css/base.css" rel="stylesheet"/>
<link href="css/index.css" rel="stylesheet"/>
<link href="css/m.css" rel="stylesheet"/>
<script type="text/javascript" src="js/comm.js"></script>
<!--[if lt IE 9]>
<script src="js/modernizr.js"></script>
<![endif]-->
<script type="text/javascript">
window.onload = function () {
	$("#wzsy").addClass("layui-this");
	$('.btn_right').click();
}
</script>
</head>

<body>
	<script>
		! spotRun();
    </script>

	<!-- <header class="header-navigation" id="header"> 
		
	</header> -->
	<%@ include file="head_top.jsp" %>
	<article id="cleanArticle"></article>
	<div class="Cooldog_container">
		<div class="Cooldog_content">
			<ul>
				<li class="p1"><a href="#"> <img src="img/1.jpg" alt="">
				</a></li>
				<li class="p2"><a href="#"> <img src="img/2.jpg" alt="">
				</a></li>
				<li class="p3"><a href="#"> <img src="img/3.jpg" alt="">
				</a></li>
				<li class="p4"><a href="#"> <img src="img/4.jpg" alt="">
				</a></li>
				<li class="p5"><a href="#"> <img src="img/5.jpg" alt="">
				</a></li>
				<li class="p5"><a href="#"> <img src="img/6.jpg" alt="">
				</a></li>
				<li class="p5"><a href="#"> <img src="img/7.jpg" alt="">
				</a></li>
			</ul>
		</div>
		<a href="javascript:;" class="btn_left"> <i
			class="iconfont icon-zuoyoujiantou"></i>
		</a> <a href="javascript:;" class="btn_right"> <i
			class="iconfont icon-zuoyoujiantou-copy-copy"></i>
		</a>
		<div class="buttons clearfix">
			<a href="javascript:;" class="color"></a> <a href="javascript:;"></a>
			<a href="javascript:;"></a> <a href="javascript:;"></a> <a
				href="javascript:;"></a> <a href="javascript:;"></a> <a
				href="javascript:;"></a>
		</div>
	</div>
	<article id="indexArticle"> <aside class="l_box">
	<div class="search">
		<form action="seach" method="post" name="searchform" id="searchform">
			<input id="seachInput" name="seach" id="keyboard" class="input_text" value="请输入关键字词"
				style="color: rgb(153, 153, 153);"
				onfocus="if(value=='请输入关键字词'){this.style.color='#000';value=''}"
				onblur="if(value==''){this.style.color='#999';value='请输入关键字词'}"
				type="text"/> <input name="show" value="title" type="hidden"/>
			<input name="tempid" value="1" type="hidden"/> <input
				name="tbname" value="news" type="hidden"/> <input
				name="Submit" class="input_submit" value="搜索" type="button" onclick='seachSubmit()'/>
		</form>
	</div>
	<div class="wdxc">
		<h2>推荐目的地</h2>
		<ul>
			<c:forEach items="${citys}" end="5" var="diary" varStatus="loop">
				<li><a href="seachCityByCountryRegion?destinationName=${diary}">${diary}
				(${citys_counts[loop.count-1]})</a></li>

			</c:forEach>
		</ul>
	</div>

	<div class="fenlei">
		<h2>文章分类</h2>
		<ul>
			<li><a href="seachByFour?diary.classify=自驾游">自驾游（${zijiayou }）</a></li>
			<li><a href="seachByFour?diary.classify=海边游">海边游（${haibianyou }）</a></li>
			<li><a href="seachByFour?diary.classify=出境游">出境游（${chujingyou }）</a></li>
			<li><a href="seachByFour?diary.classify=跟团游">跟团游（${gentuanyou }）</a></li>
			<li><a href="seachByFour?diary.classify=自由行">自由行（${ziyouxing }）</a></li>
			<li><a href="seachByFour?diary.classify=穷游">穷游（${qiongyou}）</a></li>
		</ul>
	</div>
	<div class="tuijian">
		<h2>推荐游记</h2>
		<ul>
			<c:forEach items="${recommendedDiary}" var="diaryList">
				<li><a href="info?id=${diaryList.did}">${diaryList.title}</a></li>
			</c:forEach>
		</ul>
	</div>
	  <div class="guanzhu">
        <h2>关注作者</h2>
        <ul>
          <img src="img/erWeiMa.png">
        </ul>
      </div>

	</aside> <main class="r_box">
	<div id="List">
		<c:forEach items="${pageBean.list}" var="diary">
			<li><i><a href="info?id=${diary.did}"><img
						src="${diary.image}"></a></i>
				<h3>
					<a class="text-hide" href="info?id=${diary.did}">${diary.title}</a>
				</h3>
				<p class="text-hide">${diary.content}</p> <br> <!--<i style="background-size: 200px;"></i>-->
				<img src="images/dibiao.png" alt=""
				style="width: 20px; height: 20px; float: left; clear: right;">&nbsp;
			<a href="seachCityByCountryRegion?destinationName=${diary.city}">${diary.province}${diary.city}</a>&nbsp;&nbsp;by&nbsp;
				<a href="findUserById?u_id=${diary.user.id}">${diary.user.userName}</a></li>


		</c:forEach>
	</div>
	<div class="pagelist">
		
		<c:if test="${pageBean.totalPage != 0}">
			<c:if test="${pageBean.page != 1}">
			<span id="nextPage"><a style="cursor: default"
				onclick="findPage(1)">首页</a></span>
			<span id="nextPage"><a style="cursor: default"
				onclick="findPage(${pageBean.page-1})">上一页</a></span>
		</c:if>
		<span>第${pageBean.page}/${pageBean.totalPage}页 </span>
		<c:if test="${pageBean.page != pageBean.totalPage}">
			<span id="nextPage"><a style="cursor: default"
				onclick="findPage(${pageBean.page+1})">下一页</a></span>
		</c:if>
		</c:if>
		<c:if test="${pageBean.totalPage == 0}">
				<span>无结果</span>
			</c:if>
	</div>

	</main> </article>
	<a class="cd-top">Top</a>
</body>
<script>
    const oList = document.getElementById('List');

    [...oList.querySelectorAll('li')]
    .forEach((item, index) => {
        if (index === 0 || index === 1) {
            console.log(item.querySelectorAll('img'));
        }
    });

</script>
<script src="js/love.js" type="text/javascript"></script>

</html>
