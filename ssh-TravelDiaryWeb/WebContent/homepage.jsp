<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>

<head>
<meta charset="utf-8">
<link rel="stylesheet" href="css/testListCss.css">
<link rel="stylesheet" type="text/css"
	href="js/layui-v2.4.5/layui/css/layui.css" media="all">
<script src="js/jquery.min.js" type="text/javascript"></script>
<link rel="stylesheet" href="css/Cooldog.css">
<link rel="stylesheet" href="css/iconfont.css">
<title>个人主页</title>

<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="css/base.css" rel="stylesheet">
<link href="css/index2_.css" rel="stylesheet">
<link href="css/m.css" rel="stylesheet">
<script type="text/javascript" src="js/comm.js"></script>
<script src="js/spotUtil.js" type="text/javascript"></script>
<!--[if lt IE 9]>
<script src="js/modernizr.js"></script>
<![endif]-->
<script type="text/javascript">
function findPage(page,uid) {
    $.ajax({
        url: "getJson",
        async: true,
        type: "POST",
        data: {
            "page": page,
            "u_id": uid,
        },
        dataType: "json",
        success: function(data) {	
				var str=""
				var str2="1"
				var pages = 0;
				var seachs = "";
				var talPages = 0;
				var pagelist = "";
				var uid = 0;
				var userName = '';
				$.each(data,function(name,value){
					if(name=="page"){
						pages = value;
					}
					else if(name=="talPage"){
						talPages = value;
					}
					else if(name=='uid'){
						uid = value;
					}
					else{
						$.each(value,function(names,values){
			  				str2+="1";
			  				userName = values.user.userName;
			  				str+="<li><i><a  href=\"info?id=" + values.did + "\"  onclick=\"\"><img src=" + values.image  + "></a></i><h3><a class = \"text-hide\" href=\"info?id=" + values.did + "\">" +  values.title + "</a></h3><p class = \"text-hide\">" + values.content + "</p><br><img src=\"images/dibiao.png\" alt=\"\" style=\"width:20px;height:20px;float:left;clear:right;\">&nbsp;<a href=\"seachCityByCountryRegion?destinationName="+values.city+"\">"+ values.province+values.city+"<a>&nbsp;&nbsp;by&nbsp;<a href=\"findUserById?u_id="+uid+"\">"+userName+"</a></li>";
			  				});
					}
				});	
				if(pages!=1){
					pagelist += "<span id=\"nextPage\"><a style=\"cursor: default\" onclick=\"findPage(1,"+uid+")\">首页</a></span><span id=\"nextPage\"><a style=\"cursor: default\" onclick=\"findPage("+(pages-1)+","+uid+")\">上一页</a></span>";
				}
				pagelist +="<span>第"+pages+"/"+talPages+"页 </span>";
				
				if(pages!=talPages){
					pagelist +="<span id=\"nextPage\"><a style=\"cursor: default\" onclick=\"findPage("+(pages+1)+","+uid+")\">下一页</a></span>";
				}
				
				if(str2=="1"){
  					alert("已经是最后一页了啊我的哥")
				}
  				else{
		  			$('#List').html(str);
		  			if(talPages==0){
		  				$('.pagelist').html("无结果");
		  			}else{
		  				$('.pagelist').html(pagelist);
		  			}
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
	<header class="header-navigation" id="header"> <%@ include
		file="head_top.jsp"%> </header>

	<article> <aside class="l_box">
	<div class="detailedIinformation" style="margin-bottom: 20px">
		<h2>用户信息</h2>
		<div class="MAvaImg">
			<img src="${user1.image} " height="120" width="120" 
				id="headImg"> <span style="display: inline-block;"> ${user1.userName} <c:if
					test="${user1.sex=='men'}">
					<img src="images/man.png" alt=""
						style="width: 20px; height: 20px; float: right; clear: right;">
				</c:if> <c:if test="${user1.sex!='men'}">
					<img src="images/girl.png" alt=""
						style="width: 20px; height: 20px; float: right; clear: right;">
				</c:if>
			</span><br>${user1.email} <br>个人留言:${user1.individualResume}
			<!--<i class="MGenderMale">性别</i>-->
			<br>
			<!-- <button style="background-color: bisque; width: 100px">关注</button> -->
		</div>
		<div class="top-end">
					<div id="inputFrom_LY">
						<input type="hidden" value="${user1.id}" id="inputLYId" /> <input
							type="text" name="username" lay-verify="title" autocomplete="off"
							placeholder="请输入留言内容" class="layui-input" id="inputLY"
							style="display: inline-block; width: 65%; outline: none;"/>
						<button class="layui-btn" lay-submit="" lay-filter="demo1"
							id="btnLY" style="width: 30%">留言</button>
					</div>
				</div>

	</div>
	<div>
		<div class="MAvaImg">
			<div id="divContent" onscroll="KeepScrollBar()">
				<div class="comment_list">
					<h2>全部留言</h2>
					<hr>
					<div class="listContent">
						<c:forEach items="${userMessagePageBean.list }" var="userMessage">
							<div class="comment">
								<div class="imgdiv">
									<img class="imgcss" src="${userMessage.sender.image }" />
								</div>
								<div class="conmment_details" id='coment${userMessage.id }'>
									<span class="comment_name"><a
										href="findUserById?u_id=${userMessage.sender.id }">${userMessage.sender.userName }</a></span>
									    <span>${userMessage.sendTime }</span>
									<div class="comment_content">  ${userMessage.content }</div>

									<div class="del">
										<c:if
											test="${userMessage.sendee.userName.equals(user.userName) || userMessage.sender.userName.equals(user.userName) }">
											<a class="del_comment" data-id="${userMessage.id }"> <i
												class="icon layui-icon">删除</i></a>
										</c:if>
										<c:if
											test="${userMessage.sendee.userName.equals(user.userName) }">
											<c:if
												test="${userMessage.replyContent == null|| userMessage.replyContent.length() == 0 }">
												<a class="commentInput" data-id="${userMessage.id }"> <i
													class="icon layui-icon layui-icon-edit">回复</i>
												</a>
											</c:if>

										</c:if>
									</div>
									<c:if
										test="${userMessage.replyContent != null && userMessage.replyContent.length() != 0 }">
										<div class="comment_content layui-bg-gray">
											  回复：${userMessage.replyContent }</div>
									</c:if>
								</div>
								<hr>
							</div>
						</c:forEach>
					</div>
					<div id="topLast">
						<c:if
							test="${userMessagePageBean.page>=userMessagePageBean.totalPage }">
							<div class="comment_last">没有更多留言了</div>
						</c:if>
						<!-- style="background-color: #D2DCEA;cursor:pointer;" -->
						<c:if
							test="${userMessagePageBean.page<userMessagePageBean.totalPage }">
							<div class="comment_add"
								data-id="${userMessagePageBean.params.uid }"
								data-page="${userMessagePageBean.page+1}">点击加载更多</div>
						</c:if>
					</div>
				</div>
				<div class="top-end">
					<div id="inputFrom" style="display: none">
						<input type="hidden" value="12" id="inputId" /> <input
							type="text" name="username" lay-verify="title" autocomplete="off"
							placeholder="请输入回复的内容" class="layui-input" id="inputF"
							style="display: inline-block; width: 65%; outline: none;">
						<button class="layui-btn" lay-submit="" lay-filter="demo1"
							id="btnF" style="width: 30%">回复</button>
					</div>
				</div>
			</div>

		</div>
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
					onclick="findPage(1,${uid})">首页</a></span>
				<span id="nextPage"><a style="cursor: default"
					onclick="findPage(${pageBean.page-1},${uid})">上一页</a></span>
			</c:if>
			<span>第${pageBean.page}/${pageBean.totalPage}页 </span>
			<c:if test="${pageBean.page != pageBean.totalPage}">
				<span id="nextPage"><a style="cursor: default"
					onclick="findPage(${pageBean.page+1},${uid})">下一页</a></span>
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
<!-- <script src="js/love.js" type="text/javascript"></script> -->
<script type="text/javascript" src="js/layui-v2.4.5/layui/layui.js"></script>
<script type="text/javascript" src="js/homepages.js"></script>
<script type="text/javascript">
var addCount = 0;
layui.use(['form', 'layer', 'jquery', 'element', 'laypage', 'form'], function() {
    var form = layui.form;
    window.layer = layui.layer;
    layedit = layui.layedit;
    window.jQuery = window.$ = layui.jquery;
    var element = layui.element,
        form = layui.form,
        laypage = layui.laypage;
   /* 删除留言动作begin */
    $(document).on('click', '.del_comment', function() {
    	if(confirm("是否确认删除")){
    		var id = $(this).attr("data-id");
            //提交删除ajax
            var flag = delComment(id);
            if(flag==true){
            	alert('删除成功');
            	window.addCount--;
            	if(window.addCount==-3){
            		//获取加载按钮的page参数
        			var page = $(".comment_add").getAttribute("data-page");
        			//page+1
        			page = parseInt(page)-1;
        			//设置加载按钮page参数
        			$(".comment_add").setAttribute("data-page",page);
        			//重置页面偏差量
        			window.addCount = 0;
            	}
            	$(this).closest('.comment').css("display", "none");
            }else{
            	alert('删除失败');
            }
    	}
    });
    /* 删除留言动作end */
    
    /* ajax删除留言操作begin */
    function delComment(id) {
    	var flag;
    	$.ajax({
            url: "users_delUserMessage",
            async: false,
            type: "POST",
            data: {
                "userMessage.id": id,
            },
            dataType: "json",
            success: function (data) {
            	flag = data;
            }
        });
    	return flag;
    }
    /* ajax删除留言操作end */

    /*点击回复事件begin*/
    $(document).on('click', '.commentInput', function(e) {
    	var id = $(this).attr("data-id");
        if ($("#inputFrom").is(":hidden")) {
        	$('#inputId').val(id);
            $("#inputFrom").show();
        } else {
            $("#inputFrom").hide();
        }

        e.stopPropagation();
    });
    /*回复点击事件end*/
    

    /*点击提交回复事件begin*/
    $(document).on('click', '#btnF', function(e) {
        var elment = $('#inputF');
        var idElment = $('#inputId');
        var reply = elment.val();
        var id = idElment.val();
        if (reply == 'null' || reply == '') {
            alert('回复内容不可为空')
        } else {
        	/* alert(id)
            alert(reply)
            replyUserMessage(); */
        	var flag = replyUserMessage(id,reply);
            if(flag==true){
            	alert('回复成功');
            	var divHtml = '<div class="comment_content layui-bg-gray">回复：'+reply+'</div>';
            	$("#coment"+id).append(divHtml);
            	$(".commentInput[data-id='"+id+"']").css("display", "none");
            }else{
            	alert('回复失败');
            }
        }

        e.stopPropagation();
    });
    /*点击提交回复事件end*/
    
    /* ajax回复操作begin */
    function replyUserMessage(id,replyContent) {
    	var flag;
    	$.ajax({
            url: "users_replyUserMessage",
            async: false,
            type: "POST",
            data: {
                "userMessage.id": id,
                "userMessage.replyContent": replyContent,
            },
            dataType: "json",
            success: function (data) {
            	flag = data;
            }
        });
    	return flag;
    }
    /* ajax回复操作end */
    
    /*点击提交留言事件begin*/
    $(document).on('click', '#btnLY', function(e) {
        var elment = $('#inputLY');
        var idElment = $('#inputLYId');
        var reply = elment.val();
        var id = idElment.val();
        if (reply == 'null' || reply == '') {
            alert('留言内容不可为空')
        } else {
        	var flag = addUserMessage(id,reply);
            if(typeof(flag)!='undefined'&&flag!=null){
            	var divHtml = '';
            	//id
                var messId = flag.id;
                //头像
                var senderImage = flag.sender.image;
                //留言人id
                var sender_id = flag.sender.id;
                //被留言人id
                var sendee_id = flag.sendee.id;
                //留言人name
                var sender_name = flag.sender.userName;
                //留言时间
                var sendTime = flag.sendTime;
                //留言内容
                var content = flag.content;
                //回复内容
                var replyContent = flag.replyContent;
                divHtml += '<div class="comment">';
                divHtml += '<div class="imgdiv"><img class="imgcss"  src="' + senderImage + '"/></div>';
                divHtml += '<div class="conmment_details" id="coment'+messId+'">';
                divHtml += '<span class="comment_name"><a href="findUserById?u_id=' + sender_id + '">'+sender_name+'</a></span>     <span>' + sendTime + '</span>';
                divHtml += '<div class="comment_content" >  ' + content + '</div>';
                divHtml += '<div class="del">';
                //判断删除按钮区域
                divHtml += '<a class="del_comment"  data-id="' + messId + '"><i class="icon layui-icon" >删除</i></a>';
                //判断回复按钮区域
                /* if ((!(replyContent != undefined&& replyContent != "" && replyContent.length != 0))) {
                    divHtml += '<a class="commentInput" data-id="' + messId + '"> <i class="icon layui-icon layui-icon-edit">回复</i></a>';
                } */
                divHtml += '</div>';
                //判断回复内容显示区域
                if (replyContent != undefined&& replyContent != "" && replyContent.length != 0) {
                    divHtml += '<div class="comment_content layui-bg-gray">  回复：' + replyContent + '</div></div>';
                }
                divHtml += '<hr></div>';
            	alert('留言成功');
            	window.addCount++;
            	if($('div').hasClass('comment_add')){
            		if(window.addCount==3){
            			//获取加载按钮的page参数
            			var page = $(".comment_add").getAttribute("data-page");
            			//page+1
            			page = parseInt(page)+1;
            			//设置加载按钮page参数
            			$(".comment_add").setAttribute("data-page",page);
            			//重置页面偏差量
            			window.addCount = 0;
            		}
            	}
            	$('.listContent').prepend(divHtml);
            }else{
            	alert('留言失败，未登陆请先登陆');
            }
        }

        e.stopPropagation();
    });
    /*点击提交留言事件end*/
    
    /* ajax增加留言操作begin */
    function addUserMessage(uid,content) {
    	var flag;
    	$.ajax({
            url: "users_addUserMessage",
            async: false,
            type: "POST",
            data: {
                "userMessage.sendee.id": uid,
                "userMessage.content": content,
            },
            dataType: "json",
            success: function (data) {
            	flag = data;
            }
        });
    	return flag;
    }
    /* ajax增加留言操作end */

    /*点击其他区域事件begin*/
    $(document).bind('click', function(e) {
        var e = e || window.event;
        var elem = e.target || e.srcElement;
        while (elem) {
            /*点击了from*/
            if (elem.className && elem.className == 'top-end') {
                return;
            }
            elem = elem.parentNode;
        }
        $("#inputFrom").hide();
    });
    /*点击其他区域事件end*/

    //点击加载事件
    $(document).on('click', '.comment_add', function() {
    	//主页用户id
    	var id = $(this).attr("data-id");
    	//页数
    	var page = $(this).attr("data-page");
    	//加载ajax
        add(page,id);
    });


  	//增加节点方法
    function add(page, u_id) {
    	//增加页面字符
        var divHtml = " ";
        //判断有无数据的标志
        var flag = "1"
        //页数
        var pages = 0;
        //总页数
        var talPages = 0;
        //下一页页面字符
        var pagelist = "";
        //主页用户id
        var uid = 0;
        //已登陆用户id
        var loginUid = 0;
        //list的数据
        var lists;
        $.ajax({
        	url: "findUserMessageByUidToJson",
            async: false,
            type: "POST",
            data: {
                "page": page,
                "u_id": u_id,
                "addCount":window.addCount,
            },
            dataType: "json",
            success: function (data) {
                $.each(data, function (name, value) {
                    if (name == "page") {
                        pages = value;
                    } else if (name == "talPage") {
                        talPages = value;
                    } else if (name == 'uid') {
                        uid = value;
                    } else if (name == 'loginUid') {
                        loginUid = value;
                    } else {
                    	lists = value;
                    }
                });
                //遍历list里面的数据
                $.each(lists, function (names, values) {
                    flag += "1";
                    //id
                    var messId = values.id;
                    //头像
                    var senderImage = values.sender.image;
                    //留言人id
                    var sender_id = values.sender.id;
                    //被留言人id
                    var sendee_id = values.sendee.id;
                    //留言人name
                    var sender_name = values.sender.userName;
                    //留言时间
                    var sendTime = values.sendTime;
                    //留言内容
                    var content = values.content;
                    //回复内容
                    var replyContent = values.replyContent;
                    divHtml += '<div class="comment">';
                    divHtml += '<div class="imgdiv"><img class="imgcss"  src="' + senderImage + '"/></div>';
                    divHtml += '<div class="conmment_details" id="coment'+messId+'">';
                    divHtml += '<span class="comment_name"><a href="findUserById?u_id=' + sender_id + '">'+sender_name+'</a></span>     <span>' + sendTime + '</span>';
                    divHtml += '<div class="comment_content" >  ' + content + '</div>';
                    divHtml += '<div class="del">';
                    //判断删除按钮区域
                    if (sender_id == loginUid || sendee_id == loginUid) {
                        divHtml += '<a class="del_comment"  data-id="' + messId + '"><i class="icon layui-icon" >删除</i></a>';
                    }
                    //判断回复按钮区域
                    if (sendee_id == loginUid && (!(replyContent != undefined&& replyContent != "" && replyContent.length != 0))) {
                        divHtml += '<a class="commentInput" data-id="' + messId + '"> <i class="icon layui-icon layui-icon-edit">回复</i></a>';
                    }
                    divHtml += '</div>';
                    //判断回复内容显示区域
                    if (replyContent != undefined&& replyContent != "" && replyContent.length != 0) {
                        divHtml += '<div class="comment_content layui-bg-gray">  回复：' + replyContent + '</div></div>';
                    }
                    divHtml += '<hr></div>';
                });
                /* if (pages != 1) {} */
                if (pages >= talPages) {
                    pagelist += '<div class = "comment_last" > 没有更多留言了 </div>';
                } else {
                    pagelist += '<div class="comment_add" data-id="'+uid + '" data-page="' + (pages+1) + '">点击加载更多</div>'; 
                }
                if (flag != "1") {
                    $('.listContent').append(divHtml);
                }
                $('#topLast').html(pagelist);
            }
        });

    }

});
</script>
<script>
    function KeepScrollBar() {
        var scrollPos;
        if (typeof window.pageYOffset != 'undefined') {
            scrollPos = window.pageYOffset;
        } else if (typeof document.body != 'undefined') {
            scrollPos = document.getElementById('divContent').scrollTop;
        }
        document.cookie = "scrollTop=" + scrollPos;
    }
	function initMessageList() {
		var listFlag = "${userMessagePageBean.list == null||userMessagePageBean.list.size() == 0}";
		if(listFlag=='true'){
			
		}
	}
    window.onload = function() {
        if (document.cookie.match(/scrollTop=([^;]+)(;|$)/) != null) {
            var arr = document.cookie.match(/scrollTop=([^;]+)(;|$)/);
            document.getElementById('divContent').scrollTop = parseInt(arr[1]);
        }
    }
</script>
</html>
