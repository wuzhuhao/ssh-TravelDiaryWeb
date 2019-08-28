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
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"> 
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
<title>目的地搜索</title>
<link rel="stylesheet" type="text/css" href="css/default.css">
<link rel="stylesheet" type="text/css" href="css/search-form.css">
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
window.onload = function () {
	$("#mdd").css("color","#f65a8a");
}
</script>
<!-- <link href="css/base.css" rel="stylesheet"> -->
<link href="css/index.css" rel="stylesheet">
<link href="css/m.css" rel="stylesheet">
<script type="text/javascript" src="js/comm.js"></script>
</head>
<body>
<header class="header-navigation" id="header">
	<%@ include file="head_top.jsp" %>
	</header>
	<form onsubmit="submitFn(this, event);">
		<div class="search-wrapper">
			<div class="input-holder">
				<input type="text" class="search-input" placeholder="Type to search" />
				<button class="search-icon" onclick="searchToggle(this, event);"><span></span></button>
			</div>
			<span class="close" onclick="searchToggle(this, event);"></span>
			<div class="result-container">
			</div>
		</div>
	</form>
<script src="js/jquery.min.js" type="text/javascript"></script>
<script type="text/javascript">
	function searchToggle(obj, evt){
		var container = $(obj).closest('.search-wrapper');
		if(!container.hasClass('active')){
			  container.addClass('active');
			  evt.preventDefault();
		}
		else if(container.hasClass('active') && $(obj).closest('.input-holder').length == 0){
			  container.removeClass('active');
			  // clear input
			  container.find('.search-input').val('');
			  // clear and hide result container when we press close
			  container.find('.result-container').fadeOut(100, function(){$(this).empty();});
		}
	}
	function submitFn(obj, evt){
		value = $(obj).find('.search-input').val().trim();
		_html = "请输入目的地";
		if(!value.length){
			_html = "请输入目的地";
		}
		else{
			get('seachCity',{'seach':value});
		}
		$(obj).find('.result-container').html('<span>' + _html + '</span>');
		$(obj).find('.result-container').fadeIn(100);
		evt.preventDefault();
	}
	function get(URL, PARAMS)
                        {
                            var data = "?";
                            for (var x in PARAMS)
                            {
                                data += x + "=" + PARAMS[x] + "&";
                            }
                            data = data.slice(0, data.length-1);
                            URL = URL + data;
                            location.assign(URL);
                        }
</script>
<div style="text-align:center;margin:50px 0; font:normal 14px/24px 'MicroSoft YaHei';">
</div>
</body>
</html>