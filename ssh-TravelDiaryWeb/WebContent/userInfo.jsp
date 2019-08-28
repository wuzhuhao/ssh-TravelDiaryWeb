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
    <link rel="stylesheet" href="css/Cooldog.css">
    <link rel="stylesheet" href="css/iconfont.css">
    <title>个人信息</title>
    
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="css/base.css" rel="stylesheet">
    <link href="css/index.css" rel="stylesheet">
    <link href="css/m.css" rel="stylesheet">
    <script type="text/javascript" src="js/comm.js"></script>
    <script src="js/spotUtil.js" type="text/javascript"></script>
    <script type="text/javascript">
    function checkName(){
    	var name = document.getElementById("userName");
    	var nv = name.value;
    	if(typeof nv == "undefined" || nv == null || nv == ""){
    		alert("用户名不能为空");
    		return;
    	}
    	  htmlobj=$.ajax({
    				url:"checkNameByLogined",async:false,
    	  			type: "POST",
    	  			data:{
    	  				"user.userName":name.value
    	  			},
    	  			dataType:"json",
    	  			success: function(data) {  
    	                if(data == true){
    	                	alert("用户名已被占用，请重新输入");
    	                	name.value = "";
    	                	return;
    	                }   
    	  			}
    			  });
    	  /* $("#myDiv").html(htmlobj.responseText);  */
    }
    function checkEmail()
    { 
    	 
    	  var accemail = document.getElementById("email");    //获取email控件对象
          if (!accemail.value == "") {
                    var reg =/^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/;

                    var bool = reg.test(accemail.value);
                    if (bool == false) {
                            alert("邮箱格式错误，请重新输入！");
                            window.location.href='#small-dialog';
                            return;
                    }
          }     

    }
    </script>


    <script type="text/javascript">
    function update() {
    	 var data = $("#forms_").serialize();
    	 var accemail = document.getElementById("email"); 
    	 var passwd = document.getElementById("passwd").value; 
    	 var flag = true;
    	 if(passwd.length<1){
    		 alert("密码不能为空")
    		 flag=false;
    	 } if (!accemail.value == "") {
             var reg =/^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/;

             var bool = reg.test(accemail.value);
             if (bool == false) {
                     alert("邮箱格式错误，请重新输入！");
                     flag=false;
             }
   }     
    	 if(flag){
    	$.ajax({
        	
        	url: "users_update",
            async: false,
            type: "POST",
    		data: data,
            dataType: "json",
            success: function(data) {
            	if(data == false){
                	alert("修改失败,请检查用户名");
                } else {
                	alert("修改成功");
                	window.location.href='users_userInfo';
                }
            }
        });

    	 }
    }
    </script>
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
            <div class="detailedIinformation">
                <h2>用户信息</h2>
		<div class="MAvaImg">
			<img src="${user.image} " height="120" width="120"
				id="headImg"> <span style="display: inline-block;"> ${user.userName} <c:if
					test="${user.sex=='men'}">
					<img src="images/man.png" alt=""
						style="width: 20px; height: 20px; float: right; clear: right;">
				</c:if> <c:if test="${user.sex!='men'}">
					<img src="images/girl.png" alt=""
						style="width: 20px; height: 20px; float: right; clear: right;">
				</c:if>
			</span><br>${user.email}
			<br>个人简介:${user.individualResume} <!--<i class="MGenderMale">性别</i>-->
			<br>
		</div>

        </aside>
        <main class="r_box">
            <div id="infor">
          		<!-- <form  action="users_image" method="post" enctype = "multipart/form-data">
               		 <input type="file" name="upload"/>
                 	
            		<input type="submit" value="提交"  />    
          
                </form> -->
                   <form id="form_face" enctype="multipart/form-data" style="width:auto;" action="users_image" method='post'>
            			<input type="file" name="upload" id="fileToUpload" onchange="fileSelected();" style="display:none;">
        			</form>
        			
                 <div style="width: 100%">
                 	<div style="position: relative;left:35%">
                 		<img src="${user.image}" height="120" width="120" id="headImg" onclick="fileSelect();">
                 	</div>
                 </div>
                 <%--   <br><center>点击浏览选择图片</center> <br> --%>
                <div id="forms">
                    <form id="forms_" method="post" action="users_update" >
                        <table>

                            <tr style="line-height:35px" >

                                <td>用户名:</td><br>

                                <td>
                                    <input type="text" name="user.userName" id="userName" value="${user.userName}" onblur="checkName()"/>                 </td>
                            </tr>
						
                            <tr style="line-height:35px" >

                                <td>密码:</td>

                                <td>
                                    <input type="password" name="user.passwd" id="passwd"  value="${user.passwd}"/>                 </td>
                            </tr>

                            <tr style="line-height:35px" >

                                <td>性别：</td>

                                <td>
                                <c:if test="${user.sex=='men'}">
                                	<input type="radio" name="user.sex" id="sex" value="men" checked="checked" /> 男
                                	<input type="radio" name="user.sex" id="sex" value="girl" /> 女
                                </c:if> 
                                <c:if test="${user.sex!='men'}">
                                	<input type="radio" name="user.sex" id="sex" value="men" /> 男
                                	<input type="radio" name="user.sex" id="sex" value="girl" checked="checked" /> 女
								</c:if>
                                </td>
                            </tr>
                            <tr style="line-height:35px" >

                                <td>邮箱:</td>

                                <td>
                                    <input type="user.email" name="user.email" id="email" value="${user.email}"  onblur="checkEmail()"/>                 </td>
                            </tr>
                             <tr style="line-height:35px" >

                                <td>地址:</td>

                                <td>
                                    <input type="text" name="user.site" id="site" value="${user.site}"/>                 </td>
                            </tr>
                            <tr style="line-height:35px" >
								
                                <td>个人<br>简介：</td>

                                <td>

                                    <!-- 文本域 -->
                                    <textarea name ="user.individualResume" id="individualResume" rows="6" cols="50" style="width: 160px">${user.individualResume}</textarea>                 </td>
                            </tr>

                            <tr style="text-align: center" style="line-height:35px" >
                                <td colspan="2">

                                    <!-- 恢复按钮 -->
                                    <input type="reset" value="恢复" class="button blue" />
                                    <!-- 提交按钮 -->
                                    <!-- <input type="submit" value="提交"   class="button blue"  /> -->
                                    <input type="button" value="提交"   class="button blue" onclick="update()" />                 </td>
                            		
                            </tr>
                        </table>
                    </form>
                </div>
            </div>

        </main>
    </article>

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
<script type="text/javascript">
        function fileSelect() {
            document.getElementById("fileToUpload").click();
        }

        function fileSelected() {
            document.getElementById("form_face").submit();
        }

    </script>

</html>
