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
<title>旅游网|反馈社区</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="css/base.css" rel="stylesheet">
<link href="css/index.css" rel="stylesheet">
<link href="css/m.css" rel="stylesheet">
<script src="js/jquery.min.js" type="text/javascript"></script>
<script type="text/javascript" src="js/hc-sticky.js"></script>
<script type="text/javascript" src="js/comm.js"></script>
<script src="js/spotUtil.js" type="text/javascript"></script>
<script type="text/javascript">
function Reply(id) {	
	alert(id)
	var reply = document.getElementById("reply");
	alert(reply)
	 $.ajax({
			url:"reply",async:false,
			type: "POST",
			data:{"message.reply":page,"message.id":id},
			dataType:"json",
			success: function(data) {
             if(data ==false){
             	alert("回复失败")
             } else {
            	 alert(123)
            	 var str="<p class=\"zzhf\"><font color=\"#FF0000\">站长回复:</font>" + reply +  "</p>"
            	 $('#replyDiv').html(str);
             }    
			}
		  });


	
}
</script>
<script type="text/javascript">
	function Message(){	
		
		 var data1 = $("#form1").serialize();
		
		 $.ajax({
				url:"gbook1",async:false,
	  			type: "POST",
	  			data:data1,
	  			dataType:"json",
	  			success: function(data) {
	                if(data==true){
	                	alert("你暂无权限留言啊，请先登陆")
	                } else {
	                	window.location.href="gbook";
	                }    
	  			}
			  });
	 
		
		 
	  }
</script>
<script type="text/javascript">
window.onload = function () {
	$("#fksq").addClass("layui-this");
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
  <%@ include file="head_top.jsp" %>
</header>
<article>
  <aside class="l_box">
    <div class="about_me">
      <h2>关于我</h2>
     <ul>
          <c:if test="${user.userName!=null&&user.userName.length()!=0}">
          	<i><img src="${user.image}"></i>
          <p><b>用户名：${user.userName},</b><br>自我介绍：${user.individualResume}</p>
          </c:if>
          <c:if test="${user.userName==null||user.userName.length()==0}">
          	<p><b>请登录</b></p>
          </c:if>
        </ul>

    </div>
    
    <div class="guanzhu">
        <h2>关注作者</h2>
        <ul>
          <img src="img/erWeiMa.png">
        </ul>
      </div>
  </aside>
  <main class="r_box">
   
<div class="gbook">
    <c:forEach items="${messageList}" var = "message">
      <div class="fb">
        <ul>
          <p class="fbtime"><span> ${message.dTime} </span> ${message.user.userName } </p>
          <p class="fbinfo"> ${message.content }</p>
        </ul>
      </div>
      <div class="hf">
       
        <c:choose>
     <c:when test="${empty message.reply }">
     </c:when>
     <c:otherwise>
     		<ul>
         	<p class="zzhf"><font color="#FF0000">回复:</font>${message.reply }</p>
         	</ul>
     </c:otherwise>
</c:choose>
          
        
        
      </div>
      </c:forEach>
      <div class="gbox">
        <form  method="post"  id="form1">
          <p> <strong>来说点儿什么吧...</strong></p>
          <%-- <p><span> 您的姓名:</span>
            <input name="message.name" type="text" value="${user.userName}" readonly="readonly" >
            *</p>
          <p><span>联系邮箱:</span>
            <input name="message.email" type="text" value="${user.email}" readonly="readonly" >
            *</p> --%>
          <p><span class="tnr">留言内容:</span>
            <textarea name="message.content" cols="60" rows="12" id="lytext"></textarea>
          </p>
           </form>
          <p>
            <input type="submit" name="Submit3" onclick="Message()" value="提交">
            <input name="enews" type="hidden" id="enews" value="AddGbook">
          </p>
        </form>
      </div>
    </div>
  </main>
</article>
</body>
<script src="js/love.js" type="text/javascript"></script>
</html>
