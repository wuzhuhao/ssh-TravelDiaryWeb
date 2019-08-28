
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta charset="gbk">
<title>文章评论</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="css/base.css" rel="stylesheet">
<link href="css/index.css" rel="stylesheet">
<link href="css/m.css" rel="stylesheet">
<script src="js/jquery.min.js" type="text/javascript"></script>
<script type="text/javascript" src="js/comm.js"></script>
<script src="js/spotUtil.js" type="text/javascript"></script>
<!--[if lt IE 9]>
<script src="js/modernizr.js"></script>
<![endif]-->

<script type="text/javascript">
function Delete(id) {				  
if(confirm("是否确认删除")){
	
	window.location.href="deleteId?id=" + id + "";
	}
}

function DeleteAll(id) {				  
	if(confirm("是否确认删除")){
		
		window.location.href="deleteAll";
		}
	}
</script>

<script type="text/javascript">
function findPage(page) {
    $.ajax({
        url: "findCommentForJson",
        async: true,
        type: "POST",
        data: {
            "page": page
        },
        dataType: "json",
        success: function (data) {
            var str = ""
            var str2 = "1"
            var pagelist = "";
            if (data == true) {
                window.location.href = "/login.jsp";
                return;
            }
            $.each(data.list, function (name, value) {
                str2 += "1";
                str += '<li><i><a href="info?id=' + value.diary.did + '"><img\
                src = "' + value.diary.image + '" > < /a></i >\
                    <h3 >\
                    <a class = "text-hide"\
                href = "info?id=' + value.diary.did + '" > ' + value.diary.title + '</a> </h3> <p class = "text-hide">' + value.diary.content + '</p> <br><h3>\
                    评论： <span style = "float: right;" >' + value.time + '</span> </h3> <\p>\
                    <strong>' + value.user.userName + '： </strong>' + value.content + '</p> </li>';
            });
            var pages = data.page;
            var talPages = data.totalPage;
            if (data.page != 1) {
                pagelist += "<span id=\"nextPage\"><a style=\"cursor: default\" onclick=\"findPage(1)\">首页</a></span><span id=\"nextPage\"><a style=\"cursor: default\" onclick=\"findPage(" + (pages - 1) + ")\">上一页</a></span>";
            }
            pagelist += "<span>第" + pages + "/" + talPages + "页 </span>";

            if (pages != talPages) {
                pagelist += "<span id=\"nextPage\"><a style=\"cursor: default\" onclick=\"findPage(" + (pages + 1) + ")\">下一页</a></span>";
            }
            console.log(str);
            if (str2 == "1") {
                alert("已经是最后一页了啊我的哥")
            } else {
                $('#List').html(str);
                if (talPages == 0) {
                    $('.pagelist').html("无结果");
                } else {
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
	<article id="cleanArticle"></article>
	<main class="r_box" style="float: none;left: 0;right: 0;margin: auto;">
	<div id="List">
		<c:forEach items="${commentPageBean.list}" var="comment">
			<li><i><a href="info?id=${comment.diary.did}"><img
						src="${comment.diary.image}"></a></i>
				<h3>
					<a class="text-hide" href="info?id=${comment.diary.did}">${comment.diary.title}</a>
				</h3>
				<p class="text-hide">${comment.diary.content}</p>
				<br>
				<h3>
					评论：<span style="float: right;">${comment.time}</span>
				</h3>
				<p>
					<strong>${comment.user.userName}：</strong>${comment.content}</p></li>
		</c:forEach>
	</div>

	<div class="pagelist">

		<c:if test="${commentPageBean.totalPage != 0}">
			<c:if test="${commentPageBean.page != 1}">
				<span id="nextPage"><a style="cursor: default"
					onclick="findPage(1)">首页</a></span>
				<span id="nextPage"><a style="cursor: default"
					onclick="findPage(${commentPageBean.page-1})">上一页</a></span>
			</c:if>
			<span>第${commentPageBean.page}/${commentPageBean.totalPage}页 </span>
			<c:if test="${commentPageBean.page != commentPageBean.totalPage}">
				<span id="nextPage"><a style="cursor: default"
					onclick="findPage(${commentPageBean.page+1})">下一页</a></span>
			</c:if>
		</c:if>
		<c:if test="${commentPageBean.totalPage == 0}">
			<span>无结果</span>
		</c:if>
	</div>

	</main>
	

	<a class="cd-top">Top</a>
</body>
<script>		
	const oList = document.getElementById('List');
	
	[...oList.querySelectorAll('li')]
		.forEach((item, index) => {
			if(index === 0 || index === 1) {
				console.log(item.querySelectorAll('img'));
			}
		});
		
			
</script>
<script src="js/love.js" type="text/javascript"></script>
</html>
