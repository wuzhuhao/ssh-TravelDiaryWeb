<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!--
	Author: W3layouts

-->

<!DOCTYPE html>
<html>
<head>
<title>登录和注册</title>
<link rel="stylesheet" href="css/style.css">
<link href="css/popup-box.css" rel="stylesheet" type="text/css"
	media="all" />
<!--<link href='//fonts.googleapis.com/css?family=Open+Sans:400,300italic,300,400italic,600,600italic,700,700italic,800,800italic' rel='stylesheet' type='text/css'>
	<link href='//fonts.googleapis.com/css?family=Montserrat:400,700' rel='stylesheet' type='text/css'>
-->
<meta name="viewport" content="width=device-width, initial-scale=1" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="keywords"
	content="Sign In And Sign Up Forms  Widget Responsive, Login Form Web Template, Flat Pricing Tables, Flat Drop-Downs, Sign-Up Web Templates, Flat Web Templates, Login Sign-up Responsive Web Template, Smartphone Compatible Web Template, Free Web Designs for Nokia, Samsung, LG, Sony Ericsson, Motorola Web Design" />
<script type="application/x-javascript"> addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false); function hideURLbar(){ window.scrollTo(0,1); } </script>

<script src="js/jquery.min.js"></script>
<script src="js/jquery.magnific-popup.js" type="text/javascript"></script>
<script type="text/javascript" src="js/modernizr.custom.53451.js"></script>
<script src="js/checkUtil.js" type="text/javascript"></script>
<script src="js/spotUtil.js" type="text/javascript"></script>
<script type="text/javascript">
$(document).ready(function() {
	$('.popup-with-zoom-anim').magnificPopup({
		type: 'inline',
		fixedContentPos: false,
		fixedBgPos: true,
		overflowY: 'auto',
		closeBtnInside: true,
		preloader: false,
		midClick: true,
		removalDelay: 300,
		mainClass: 'my-mfp-zoom-in'
	});
																	
	
	
	$('#b01').click(function(){
		var flag = true;
		$('#login').find("input").each(function() {
		    if (isEmpty($(this).val())) {
		    	flag = false;
		    	return;
		    }
		  });
		if(!flag){
			alert("账号密码不能为空");
			return;
		}
		  var data = $("#login").serialize();
		  $.ajax({
					url:"login",async:false,
		  			type: "POST",
		  			data:data,
		  			dataType:"json",
		  			success: function(data) {
		                if(data.result == "Error"){
		                	alert("登陆失败，请检查账号密码");
		                }else if(data.result=="stateError"){
		                	alert("登录失败,系统检测你的账号有非法操作，已对账号封停")
		                }else {
		                	window.location.href='index2';
		                } 
		  			}
				  });
	  });
	
});

</script>

<script>

function checkName(){
	var name = document.getElementById("userName");
	var nv = name.value;
	var flag = false;
	if(isEmpty(nv)){
		alert("用户名不能为空");
		flag = false;
	}else{
		$.ajax({
			url:"checkName",async:false,
  			type: "POST",
  			data:{
  				"user.userName":name.value
  			},
  			dataType:"json",
  			success: function(data) {  
                if(data == true){
                	alert("用户名已被占用，请重新输入");
                	name.value = "";
                	flag = false;
                }else{
                	flag = true;
                }
  			}
		  });
	}
	return flag;
}
function KeyDown()
{
  if (event.keyCode == 13)
  {
    event.returnValue=false;
    event.cancel = true;
    Form1.btnsubmit.click();
  }
}
function register1()
{
	  	var accemail = document.getElementById("email");    //获取email控件对象
		 var passwd = document.getElementById("passwd").value;  
		 var passwd2 = document.getElementById("passwd2").value;  
		 if(!checkName()){
			 return false;
		 }
	      if(isEmpty(passwd)){
	    	  alert("密码不可为空,请重新输入");
	    	  document.getElementById("passwd").value = "";
	    	  return false;
	      } 
	      if(isEmpty(passwd2)){
	    	  alert("二次密码不可为空,请重新输入");
	    	  document.getElementById("passwd2").value = "";
	    	  return false;
	      } if(passwd!=passwd2){
	    	  alert("两次密码不一致,请确认密码");
	    	  return false;
	      }
	      if(!isEmpty(accemail.value)) {
              if (!isEmail(accemail.value)) {
                      alert("邮箱格式错误，请重新输入！");
                      accemail.value = "";
                      return false;
              }
    		}else{
    			alert("邮箱不可为空,请重新输入！");
                accemail.value = "";
                return false;
    		}
	      var data = $("#register").serialize();
		  $.ajax({
					url:"register",async:false,
		  			type: "POST",
		  			data:data,
		  			dataType:"json",
		  			success: function(data) {  
		                if(data ==true){
		                	alert("注册成功");
		                	window.location.href='login.jsp';
		                } else {
		                	alert("注册失败,用户名可能已存在")
		                	window.location.href='login.jsp';
		                }    
		  			}
				  });
}

</script>
</head>
<body>
	<script>
		! spotRun();
    </script>
	<h1>登录和注册</h1>
	<div class="w3layouts">
		<div class="signin-agile">
			<center><h2 style="align:center">登录</h2></center>
			<form action="login" id="login" method="post" onsubmit="return false">
				<input type="text" name="user.userName" id="loginUserName"
					class="name" placeholder="账号" required=""> <input
					type="password" name="user.passwd" class="password"
					id="loginPasswd" placeholder="密码" required="">
			</form>
			<input id="b01" type="submit" value="登录">
			<form action="fangKe">
				<input id="b02" type="submit" value="暂不登陆，游客访问">
			</form>
			<div class="clear"></div>



		</div>
		<div class="signup-agileinfo">
			<h3></h3>
			<p>这是有各种各样的旅游攻略，有你想去却未曾到达的远方...</p>
			<div class="more">
				<a class="book popup-with-zoom-anim button-isi zoomIn animated"
					data-wow-delay=".5s" href="#small-dialog">点击注册</a>
			</div>
		</div>
		<div class="clear"></div>
	</div>
	<div class="footer-w3l">
		<p class="agileinfo">
			登录和注册
		</p>
	</div>
	<div class="pop-up">
		<div id="small-dialog" class="mfp-hide book-form">
			<h3><center>注册</center></h3>
			<form action="register" method="post" id = "register" onsubmit="return false">
				<input type="text" name="user.userName"  id = "userName" required="true" placeholder="用户名（必填)" /><!-- onblur="checkName()" --> 
				<input type="password" name="user.passwd" class="email"  id = "passwd"  required="true" placeholder="密码（必填)" /> 
				<input type="password" name="passwd2" class="password"  id = "passwd2"  required="true" placeholder="重复密码（必填)""  /> 
				<input type="text" name="user.email" placeholder="Email"   id="email" onblur="checkEmail()" /> 
				<font size=5px">您的性别:</font> <select
					style="font-size: 17px" name="user.sex" required="">
					<option style="font-size: 17px" value="men">男</option>
					<option style="font-size: 17px" value="girl">女</option>
				</select><br> <br>
				<textarea rows="4" name="user.individualResume" cols="50"
					style="font-size: 20px;width: 100%;" placeholder="个人简介"  /></textarea>


				<input type="submit" onclick="register1()" value="点击注册">

			</form>
		</div>
	</div>
<body>
	<script src="js/love.js" type="text/javascript"></script>
	s
</html>