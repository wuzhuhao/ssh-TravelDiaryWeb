<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
 <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%> 
<!doctype html>
<html>
<head>
<meta charset="gbk">
<title>旅游网|推荐详情</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="css/base.css" rel="stylesheet">
<link href="css/index.css" rel="stylesheet">
<link href="css/infopic.css" rel="stylesheet">
<link href="css/m.css" rel="stylesheet">
<script src="js/jquery.min.js" type="text/javascript"></script>
<script src="js/piccontent.min.js" type="text/javascript"></script>
<script type="text/javascript" src="js/hc-sticky.js"></script>
<script type="text/javascript" src="js/comm.js"></script>
<script src="js/spotUtil.js" type="text/javascript"></script>
<script type="text/javascript">


	function likenum(id) {	
		 $.ajax({
					url:"likenum",async:false,
		  			type: "POST",
		  			data:{"diaryId":id},
		  			dataType:"json",
		  			success: function(data) {
		                if(data !=null){
		                	var num = data;
		                	$('#num').html(num);
		                } else {
		                	window.location.href='index2';
		                }    
		  			}
				  });
		 
	  }
	
	function findPower1() {	
		 $.ajax({
					url:"findPower",async:false,
		  			type: "POST",
		  			
		  			dataType:"json",
		  			success: function(data) {
		                if(data ==false){
		                	alert("你暂无权限编写日记，请登录再进行此操作")
		                } else {
		                	window.location.href="write.jsp";
		                }    
		  			}
		 			});
				  }
	function findPower(id) {	
		 $.ajax({
					url:"findPower",async:false,
		  			type: "POST",
		  			
		  			dataType:"json",
		  			success: function(data) {
		                if(data ==false){
		                	alert("你暂无权限删除日记，请联系文章作者")
		                } else {
		                	if(confirm("是否确认删除")){
		
		                	window.location.href="delete?id=" + id;
		                	}
		                }    
		  			}
				  });
		 
	  }
	
	</script>	
	<script type="text/javascript">
	function Comment(){	
		 var data1 = $("#comment").serialize();
		
		 $.ajax({
					url:"comment",
					async:false,
		  			type: "POST",
		  			data:data1,
		  			dataType:"json",
		  			success: function(data) {
		                if(data ==true){
		                	alert("你暂无权限评论啊，请先登陆")
		                } else {
		                	
		                	window.location.href="info?id=${session.info.did }";
		                	
		                }   
		  			}
		  			
				  });
		 
	  }
</script>
<!--[if lt IE 9]>
<script src="js/modernizr.js"></script>
<![endif]-->
</head>
<body>
	<script>
		! spotRun();
    </script>
<header class="header-navigation" id="header">
  <nav><div class="logo"><a href="list1?page=1">${session.user.userName}的个人主页</a></div>
    <h2 id="mnavh"><span class="navicon"></span></h2 >
     <ul id="starlist">
      <li><a href="list1?page=1">网站首页</a></li>
     <li><a style="cursor: default" onclick="findPower()">写日记</a></li>
    <li><a style="cursor: default" onclick="findPower1()"><span style="color:#000000b3"> 草稿箱</span></a></li>
     <li><a href="share?page=1"  style="color:#f65a8a">我的相册</a></li>
       <li><a href="list3?page=1">我的日记</a></li>
      <li><a href="gbook">留言</a></li>
      
      <li><a href="exit">退出</a></li>
    </ul>
</nav>
</header>
<article>
  <aside class="l_box">
    <div class="about_me">
        <h2>关于我</h2>
        <ul>
          <i><img src="images/4.jpg"></i>
          <p><b>${session.user.userName},</b>${session.user.individualResume}</p>
        </ul>
      </div>
      <div class="wdxc">
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
      </div>
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
      <h2> ${session.info.title } </h2>
      <div class="source">
        <div class="source_left"><span>${session.info.title}</span> </div>
        <div class="source_right"> <a href="javascript:;" class="list">列表查看</a> </div>
        <div class="source_right1"> <a href="javascript:;" class="gaoqing">高清查看</a> </div>
      </div>
      <!--大图展示-->
      <div class="picshow">
        <div class="picshowtop"> <a href="#"><img src="" alt="" id="pic1" curindex="0" /></a> <a id="preArrow" href="javascript:void(0)" class="contextDiv" title="上一张"><span id="preArrow_A"></span></a> <a id="nextArrow" href="javascript:void(0)" class="contextDiv" title="下一张"><span id="nextArrow_A"></span></a> </div>
        <div class="picshowtxt">
          <div class="picshowtxt_left"><span>1</span>/<i>${fn:length(session.photoList)}</i></div>
          <div class="picshowtxt_right"></div>
        </div>
        <div class="picshowlist">
          <div class="picshowlist_mid">
            <div class="picmidleft"> <a href="javascript:void(0)" id="preArrow_B"><span class="sleft"></span></a> </div>
            <div class="picmidmid">
              <ul>
             <c:forEach   items="${session.photoList}" var = "photo">
                <li> 
                <a href="javascript:void(0);"><img src="${photo.image }" alt="" bigimg="${photo.image }" text= ${session.info.title } /></a></li>
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
         <c:forEach   items="${session.photoList}" var = "photo">
          <li>
          
            <div class="picimg"><img src="${photo.image}" alt="" /></div>
            <div class="pictxt">
              <h3>${session.info.title }<span>(1/${fn:length(session.photoList)})</span></h3>
            </div>
          </li>
          </c:forEach>
          
          <br>
          &nbsp; </div>
      </div>
      <div class="share">
        <p class="diggit"><a onclick="findPower(${session.info.did})"> 删除日记 </a></p>
      </div>
      <div class="share">
        <p class="diggit"><a onclick = "likenum(${session.info.did})"> 很赞哦！ </a>(<b id="diggnum">
        <script type="text/javascript" src="/e/public/ViewClick/?classid=2&id=20&down=5"></script><span id = "num" >${likenum}</span></b>)</p>
      </div>
 <div class="nextinfo">
        <p>下一篇：<a href="index2">返回列表</a></p>
      </div>
      <div class="news_pl">
        <h2>文章评论</h2>
        <div class="gbko"> 
          <c:forEach items="${commentList}" var = "comment">
          <script src="/e/pl/more/?classid=77&amp;id=106&amp;num=20"></script>
          <div class="fb">
            <ul>
              <p class="fbtime"><span>${comment.time}</span>${comment.userName}</p>
              <p class="fbinfo">${comment.content}</p>
            </ul>
          </div>
          
          </c:forEach>

          
          <script>
		  function CheckPl(obj)
		  {
		  if(obj.saytext.value=="")
		  {
		  alert("您没什么话要说吗？");
		  obj.saytext.focus();
		  return false;
		  }
		  return true;
		  }
		  </script>
          <form id = "comment" method="post">
            <div id="plpost">
              <p class="saying"><span><a>共有<script type="text/javascript" src="/e/public/ViewClick/?classid=77&amp;id=106&amp;down=2"></script>${fn:length(commentList)}条评论</a></span>来说两句吧...</p>
              <p class="yname"><span>用户名:</span>
                <input name="comment.userName" type="text" class="inputText"  value="${session.general.userName}" size="16" unselectable="on" readonly="readonly" >
              </p>
              <p class="yzm"><span>邮&nbsp;&nbsp;&nbsp;箱:</span>
                <input name="key" type="text" value="${session.general.email}" class="inputText" size="16"  disabled="readonly "  >
              </p>
              <input name="nomember" type="hidden" id="nomember" value="1" checked="checked">
              <textarea name="comment.content" rows="6" id="saytext"></textarea>
                <input type="hidden"  name = "diaryId" value="${session.info.did}">
              <input name="imageField" type="submit" onclick="Comment()" value="提交">
              <
              <input type="hidden" name="ecmsfrom" value="/joke/talk/2018-07-23/106.html">
            </div>
          </form>
        </div>
      </div>
    </div>
  </main>
</article>
</body>
<script src="js/love.js" type="text/javascript"></script>
</html>