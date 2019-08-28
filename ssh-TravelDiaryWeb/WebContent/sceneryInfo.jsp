<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
 <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!doctype html>
<html>
<head>
<meta charset="gbk">
<title>旅游网|景点详情</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="css/base.css" rel="stylesheet">
<link href="css/index.css" rel="stylesheet">
<link href="css/infopic.css" rel="stylesheet">
<link href="css/m.css" rel="stylesheet">
<script src="js/jquery.min.js" type="text/javascript"></script>
<script src="js/piccontent.min.js" type="text/javascript"></script>
<script type="text/javascript" src="js/hc-sticky.js"></script>
<script type="text/javascript" src="js/comm.js"></script>
<script type="text/javascript" src="js/tagcloud.js"></script>
<script src="js/spotUtil.js" type="text/javascript"></script>	
	<style type="text/css">
		#infoText div{
			margin-bottom: 4px;
		}
		.source_left{
			font-size: 20px;
		}
		#infoText{
			margin-bottom: 10px;
			font-size: 20px;
		}
	</style>
<!--[if lt IE 9]>
<script src="js/modernizr.js"></script>
<![endif]-->
</head>
<body>
	<script>
		! spotRun();
    </script>
<%@ include file="head_top.jsp"%>
<article>
  <aside class="l_box">
  	<div class="cloud">
				<h2>标签云</h2>
				<div class="tagcloud">
					<a href="seachByFour?diary.classify=自驾游"
						style="padding:${zijiayou2}px">自驾游</a> <a
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
            <div class="links">
        <h2>友情链接<br>
        <a href="http://how2j.cn/">java教程资源</a>
        </h2>
      </div>
      <div class="guanzhu">
        <h2>关注作者</h2>
        <ul>
          <img src="img/erWeiMa.png">
        </ul>
      </div>
   <%--  <div class="tuijian">
				<h2>
					相关目的地游记：
					<a href="seachCityByCountryRegion?destinationName=${info.province }"
						style="color: coral">${session.info.province }</a> <a
						href="seachCityByCountryRegion?destinationName=${info.city }" style="color: coral">${session.info.city }</a>
				</h2>
			</div> --%>
      <%-- <div class="wdxc">
        <h2>我的相册</h2>
        <ul>
        <c:forEach items="${diaryList}"  end = "5" var = "diary">
          <li><a href="share"><img src="${diary.image}"></a></li>
          
          </c:forEach>
        </ul>
      </div>
      <div class="search">
        <form action="seach" method="post" name="searchform" id="searchform">
          <input name="seach" id="keyboard" class="input_text" value="请输入关键字词" style="color: rgb(153, 153, 153);" onfocus="if(value=='请输入关键字词'){this.style.color='#000';value=''}" onblur="if(value==''){this.style.color='#999';value='请输入关键字词'}" type="text">
          <input name="show" value="title" type="hidden">
          <input name="tempid" value="1" type="hidden">
          <input name="tbname" value="news" type="hidden">
          <input name="Submit" class="input_submit" value="搜索" type="submit">
        </form>
      </div>
      <div class="fenlei">
        <h2>文章分类</h2>
         <ul>
          <li><a href="list4?type=shenghuo">生活彩屏（${session.shengHuo }）</a></li>
          <li><a href="list4?type=lvTu">旅途浏览（${session.lvTu }）</a></li>
          <li><a href="list4?type=youQing">友情互联（${session.youQing }）</a></li>
          <li><a href="list4?type=xueHai">学海冲浪（${session.xueHai }）</a></li>
          <li><a href="list4?type=qingXu">情绪下载（${session.qingXu }）</a></li>
          <li><a href="list4?type=xiaoYuan">校园琐记（${session.xiaoYuan}）</a></li>
        </ul>
      </div>
      <div class="tuijian">
        <h2>站长推荐</h2>
        <ul>
      <c:forEach items="${diaryList3}" var = "diary3">
        <li><a href="info?id=${diary3.did}">${diary3.title}</a></li>
        </c:forEach>
      </ul>
      </div>
      <div class="links">
        <h2>友情链接<br>
        <a href="http://how2j.cn/">java教程资源</a>
        </h2>
      </div>
      <div class="guanzhu">
        <h2>打赏作者</h2>
        <ul>
          <img src="images/2018.jpg">
        </ul>
      </div> --%>
  </aside>
  <main>
  <div class="picsbox">
    <div class="bodymodal"></div>
    <!--播放到第一张图的提示-->
    <div class="firsttop">
      <div class="firsttop_right">
        <div class="close2"> <a class="closebtn1" title="关闭" href="javascript:void(0)"></a> </div>
        <div class="replay">
          <h2 id="div-end-h2"> 已到第一张图片了。 </h2>
          <p> <a class="replaybtn1" href="javascript:;">重新播放</a> </p>
        </div>
      </div>
    </div>
    <!--播放到最后一张图的提示-->
    <div class="endtop">
      <div class="firsttop_right">
        <div class="close2"> <a class="closebtn2" title="关闭" href="javascript:void(0)"></a> </div>
        <div class="replay">
          <h2 id="H1"> 已到最后一张图片了。 </h2>
          <p> <a class="replaybtn2" href="javascript:;">重新播放</a> </p>
        </div>
      </div>
    </div>
    <!--弹出层结束--> 
    <!--图片特效内容开始-->
    <div class="piccontext">
      <h2> ${info.name }<span style="color: #f60;font-size: 18px">${info.level }</span> </h2>
      <div id="infoText">
        <div>
            简介:${info.intro }
        </div>
        <div>
            位置:${info.addr }
        </div>
        <div>
            参考点评:${info.score }
        </div>
        <div>
            今日天气:${info.weather }
        </div>
      </div>
      
      <div class="source">
        <div class="source_left">参考票价:<span style="color: #f60">${info.price.equals("")?"无":info.price}</span> </div>
        <div class="source_right"> <a href="javascript:;" class="list">列表查看图片</a> </div>
        <div class="source_right1"> <a href="javascript:;" class="gaoqing">高清查看图片</a> </div>
      </div>
      <!--大图展示-->
      <div class="picshow">
        <div class="picshowtop"> <a href="#"><img src="" alt="" id="pic1" curindex="0" /></a> <a id="preArrow" href="javascript:void(0)" class="contextDiv" title="上一张"><span id="preArrow_A"></span></a> <a id="nextArrow" href="javascript:void(0)" class="contextDiv" title="下一张"><span id="nextArrow_A"></span></a> </div>
        <div class="picshowtxt">
          <div class="picshowtxt_left"><span>1</span>/<i>${fn:length(info.imgs)}</i></div>
          <div class="picshowtxt_right"></div>
        </div>
        <div class="picshowlist">
          <div class="picshowlist_mid">
            <div class="picmidleft"> <a href="javascript:void(0)" id="preArrow_B"><span class="sleft"></span></a> </div>
            <div class="picmidmid">
              <ul>
              	<c:forEach items="${info.imgs}" var="img">
              		<li> <a href="javascript:void(0);"><img src="${img}" alt="" bigimg="${img}" text="" /></a></li>
              	</c:forEach>
              </ul>
            </div>
            <div class="picmidright"> <a href="javascript:void(0)" id="nextArrow_B"><span class="sright"></span></a> </div>
          </div>
        </div>
      </div>
      
      <!--列表展示-->
      <div class="piclistshow">
        <ul>
        	<c:forEach items="${info.imgs}" var="img" varStatus="index">
              		<li>
			            <div class="picimg"><img src="${img}" alt="" /></div>
			            <div class="pictxt">
			              <h3><span>(${index.count}/${fn:length(info.imgs)})</span></h3>
			            </div>
			        </li>
             </c:forEach>
        </ul>
      </div>
    </div>
    <fieldset class="layui-elem-field layui-field-title" style="margin-top: 30px;">
      <legend><i class="layui-icon layui-icon-reply-fill" style="font-size: 30px; color: #009688;">
      </i>详细简介</legend>
      
    </fieldset>
     
    <blockquote class="layui-elem-quote">
    	${info.introduce}
    </blockquote>
    <fieldset class="layui-elem-field layui-field-title" style="margin-top: 30px;">
      <legend><i class="layui-icon layui-icon-date" style="font-size: 30px; color: #009688;">
      </i>开放时间</legend>
    </fieldset>
     
    <blockquote class="layui-elem-quote">
    	${info.times}
    </blockquote>
    
    <c:forEach items="${info.tipData.keySet()}" var="key" varStatus="go">
              <fieldset class="layui-elem-field layui-field-title" style="margin-top: 30px;">
			      <legend>
			        <i class="layui-icon layui-icon-tips" style="font-size: 30px; color: #009688;">
			        </i>${key}</legend>
			    </fieldset>
			    <blockquote class="layui-elem-quote">
			    	<c:forEach items="${info.tipData.get(key).keySet()}" var="tipKey">
				     	<fieldset class="layui-elem-field" style="background-color: white;">
					      <legend>${tipKey}</legend>
					      <div class="layui-field-box">
					      		${info.tipData.get(key).get(tipKey)}
					      </div>
					    </fieldset>
				     </c:forEach>
			    </blockquote>
     </c:forEach>
  </main>
</article>
</body>
<script src="js/love.js" type="text/javascript"></script>
</html>