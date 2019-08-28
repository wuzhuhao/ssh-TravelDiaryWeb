<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>写游记</title>

<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="css/base.css" rel="stylesheet">
<link href="css/index.css" rel="stylesheet">
<link href="css/m.css" rel="stylesheet">
<!--[if lt IE 9]>
<script src="js/modernizr.js"></script>
<![endif]-->
<script src="js/jquery.min.js" type="text/javascript"></script>
<script type="text/javascript" src="js/comm.js"></script>
<script type="text/javascript" src="js/xml.js"></script>
<script src="js/spotUtil.js" type="text/javascript"></script>
<script src="js/scrollReveal.js"></script>
<style type="text/css">

.r_box #drafts, .r_box #w_tip,.r_box #w_tip .writeTextDiv {
	width: 80%;
	left: 0;
	right: 0;
	margin: auto;
}
.r_box #w_tip .writeTextDiv{
	margin: 3px auto;
}
.r_box #w_top {
	color: green;
	margin-bottom: 7px;
	text-align: center;
	font-size: 20px;
}

.r_box #drafts div {
	width: 90%;
	color: green;
	margin-bottom: 7px;
	font-size: 18px
}
</style>
<script type="text/javascript">
        /*
                            提交表单时将编辑器内容同步到textarea
                            */
        function modifyContent() {
        
        	  var introduce = document.getElementById("testText");
              introduce.value = editor.txt.text();
              var introduce2 = document.getElementById("testText2");
              introduce2.value = editor.txt.html();
        }
        
        
        function Drafts(){
        	
        	  var introduce = document.getElementById("testText");
            introduce.value = editor.txt.text();
            var introduce2 = document.getElementById("testText2");
            introduce2.value = editor.txt.html();
        	var data = $("#drafts").serialize();
        	document.drafts.action="drafts?page=1"; 
        	document.drafts.submit(); 
        }
    </script>

</head>
<body>
	<script>
		! spotRun();
    </script>
	<script language="javascript">
window.onload = function(){
	//获取类别的值
	var classifyList = '${draftsDiary.classify}';
	$.each(classifyList.split("-"),function(index,obj){
		$("input[value='"+obj+"']").prop('checked', 'checked');
	});
	var keyLandscape = '${draftsDiary.keyLandscape}';
	var monthTime = '${draftsDiary.monthTime}';
	var image = '${draftsDiary.image}';
	$('input[name="diary.totalTime"]').val('${draftsDiary.totalTime}');
	if(keyLandscape!=''){
		$("select option:contains('${draftsDiary.keyLandscape}')").attr("selected","selected");
	}
	if(monthTime!=''){
		$("select option:contains('${draftsDiary.monthTime}')").attr("selected","selected");
	}
	$("input[id=image]").val(image);
	/* alert($("input[id=image]").val()) */
	
	//加载XML文件。
    var xmlDom = loadXMLFile("xml/city-all.xml");
    var countryRegionValue = "${draftsDiary.countryRegion}";
    var provinceValue = "${draftsDiary.province}";
    var cityValue = "${draftsDiary.city}";
  	//获取国家数据
    var countryRegionItem = xmlDom.getElementsByTagName("CountryRegion");
  	//获取CountryRegion节点
    var countryRegionElement = document.getElementById("CountryRegion");
  	//province节点
  	var provinceElement = document.getElementById("province");
  	//city节点
  	var cityElement = document.getElementById("cities");
  	//二级数据
  	var provinceItem = null;
    if(countryRegionValue=='中国'){
    	$('#CountryRegion').prop('selectedIndex', 1);
    	provinceItem = countryRegionItem[0].getElementsByTagName("State");
    	haveCount(1);
    }
    else if(countryRegionValue=='外国'){
    	$('#CountryRegion').prop('selectedIndex', 2);
    	provinceItem = countryRegionItem;
    	haveCount(0);
    }
    function haveCount(tagType){
    	var j = 0;
    	if(tagType!=1){
    		j = 1;
    	}
    	for (; j < provinceItem.length; j++) {
            //创建一个option  
            var opt1 = document.createElement("option");
            var provinceName = provinceItem[j].getAttribute("Name");
            if (provinceName == provinceValue) {
                opt1.setAttribute('selected', 'selected');
              	//市数据
                var cityItem = null;
                if(tagType==1){
                	cityItem = provinceItem[j].getElementsByTagName("City");
                }else{
                	var temp = provinceItem[j].getElementsByTagName("State");
                	if(temp.length==0){
                		cityItem = provinceItem[j].getElementsByTagName("State");
                	}else{
                		cityItem = provinceItem[j].getElementsByTagName("State")[0]
                    	.getElementsByTagName("City");
                	}
                }
                if(cityItem.length==0){
                	//创建一个市option  
                    var cityOpt = document.createElement("option");
                    var cityName = provinceName;
                    if(cityName==cityValue){
                    	cityOpt.setAttribute('selected', 'selected');
                    }
                  	//为option添加文本        
                    cityOpt.appendChild(document.createTextNode(cityName));
                    //添加到父节点中  
                    cityElement.appendChild(cityOpt);
                }
                for(var k=0;k<cityItem.length;k++){
                	//创建一个市option  
                    var cityOpt = document.createElement("option");
                    var cityName = cityItem[k].getAttribute("Name");
                    if(cityName==cityValue){
                    	cityOpt.setAttribute('selected', 'selected');
                    }
                  	//为option添加文本        
                    cityOpt.appendChild(document.createTextNode(cityName));
                    //添加到父节点中  
                    cityElement.appendChild(cityOpt);
                }
            }
            //为option添加文本        
            opt1.appendChild(document.createTextNode(provinceName));
            //添加到父节点中  
            provinceElement.appendChild(opt1);
        }
    }
    //第一级的事件设置
    countryRegionElement.onchange = function () {
        var opts = countryRegionElement.options;
        var opt1 = opts[countryRegionElement.selectedIndex];
        //获取国家类型的名字
        var name = opt1.innerHTML;
        //每次改变第一级都清空其他两级
        provinceElement.options.length = 1;
        cityElement.options.length = 1;
        //每次改变清空其他两级的缓存
        provinceValue = '';
        cityValue = '';
        if(name=='中国'){
        	provinceElement.options[0].text = '请选择省';
        	cityElement.options[0].text = '请选择市';
        	provinceItem = countryRegionItem[0].getElementsByTagName("State");
        	haveCount(1);
        }
        else if(name=='外国'){
        	provinceElement.options[0].text = '请选择国家';
        	cityElement.options[0].text = '请选择州';
        	provinceItem = countryRegionItem;
        	haveCount(0);
        }
    }
    //第二级的事件设置
    provinceElement.onchange = function () {
    	var opts = provinceElement.options;
        var opt1 = opts[provinceElement.selectedIndex];
        //获取第二级的值
        var name = opt1.innerHTML;
      	//每次改变清空最后一级的缓存，以及设置第二级的缓存
        provinceValue = name;
        cityValue = '';
        //每次改变第一级都清空其他两级
        provinceElement.options.length = 1;
        cityElement.options.length = 1;
        var countOpts = countryRegionElement.options;
        var countOpt1 = countOpts[countOpts.selectedIndex];
        //获取国家类型的名字
        var countName = countOpt1.innerHTML;
        if(countName=='中国'){
        	provinceItem = countryRegionItem[0].getElementsByTagName("State");
        	haveCount(1);
        }
        else if(countName=='外国'){
        	provinceItem = countryRegionItem;
        	haveCount(0);
        }
    }
}
   </script>

	<header class="header-navigation" id="header">
		<%@ include file="head_top.jsp"%>
	</header>
	<article id="cleanArticle"></article>
	<main class="r_box" style="float: none;left: 0;right: 0;margin: auto;">
	<div id="w_top">写游记</div>
	<div id="w_tip">
		<div
			style="color: green; margin-bottom: 1px;font-size: 18px">提示：</div>
		<div class="writeTextDiv">①
			写完游记后，务必先将游记复制、保存，然后再提交,以免提交失败造成游记丢失！</div>
		<div class="writeTextDiv">②
			您提交游记时，无论您实事上是否已经阅读《游记协议》及《游记规则》，只要您点击"提交"按钮成功提交了游记，您的行为仍然表示您无条件接受了《游记协议》及《游记规则》。</div>
		<div class="writeTextDiv">③ 游记标题不多于15字，游记内容不多于5000字。</div>
		<div class="writeTextDiv">④ 游记应当是写自己的真实生活和真情实感</div>
		<div class="writeTextDiv">⑤
			对违反本网站《游记规则》公开发表的文章，本网站有权不经作者同意予以隐藏或删除</div>
		<div class="writeTextDiv">⑦
			写完游记后，务必先将游记复制、保存，然后再提交,以免提交失败造成游记丢失！体推荐其作品；未经网站转授权，其他媒体一律不得转载本网站公开发表的作品。</div>
	</div>

	<form action="write" method="post" name="drafts" id="drafts"
		enctype="multipart/form-data" onsubmit="modifyContent()">
		<div>
			<label>标题：</label> <input name="diary.title"
				style="width: 70%; height: 25px; font-size: 25px" required=""
				value="${draftsDiary.title }">
		</div>
		<div>
			<label>目的地：</label> <select id="CountryRegion"
				name="diary.countryRegion" style="width: 25%;">
				<option>请选择国内外</option>
				<option>中国</option>
				<option>外国</option>
			</select> <select id="province" name="diary.province" style="width: 25%;">
				<option>请选择省</option>
			</select> <select id="cities" name="diary.city" style="width: 25%;">
				<option>请选择市</option>
			</select>
		</div>
		<div>
			<label>月份：</label> <select id="monthTime" name="diary.monthTime"
				style="width: 25%;">
				<option>请选择月份</option>
				<option>1</option>
				<option>2</option>
				<option>3</option>
				<option>4</option>
				<option>5</option>
				<option>6</option>
				<option>7</option>
				<option>8</option>
				<option>9</option>
				<option>10</option>
				<option>11</option>
				<option>12</option>
			</select>
		</div>
		<div>
			<label>总时间：</label> <input style="width: 15%" type="text"
				id="totalTime" name="diary.totalTime" />&nbsp;天
		</div>
		<div>
			<label>关键景点：</label> <select id="keyLandscape"
				name="diary.keyLandscape">
				<option>请选择关键景点</option>
				<option>人文景观</option>
				<option>自然景观</option>
				<option>风俗民情</option>
				<option>传统饮食</option>
				<option>文化资源</option>
				<option>田园风光</option>
				<option>特种专项</option>
				<option>其他</option>
			</select>
		</div>
		<input id='image' name="image1" type="hidden">
		<div class="classify">
			<label>类型：</label>
			<div
				style="width: 80%; display: inline-block; *display: inline;*zoom=1;">
				<label
					style="color: green; margin-bottom: 7px; margin-left: 3%; font-size: 18px; width: 30%">自驾游<input
					type="checkbox" name="diary.classify" value="自驾游" checked="checked" /></label>
				<label
					style="color: green; margin-bottom: 7px; margin-left: 3%; font-size: 18px; width: 30%">海边游<input
					type="checkbox" name="diary.classify" value="海边游" /></label> <label
					style="color: green; margin-bottom: 7px; margin-left: 3%; font-size: 18px; width: 30%">出境游<input
					type="checkbox" name="diary.classify" value="出境游" /></label> <br> <label
					style="color: green; margin-bottom: 7px; margin-left: 3%; font-size: 18px; width: 30%">跟团游<input
					type="checkbox" name="diary.classify" value="跟团游" /></label> <label
					style="color: green; margin-bottom: 7px; margin-left: 3%; font-size: 18px; width: 30%">自由行<input
					type="checkbox" name="diary.classify" value="自由行" /></label> <label
					style="color: green; margin-bottom: 7px; margin-left: 3%; font-size: 18px; width: 30%">穷游<input
					type="checkbox" name="diary.classify" value="穷游" /></label>
			</div>
		</div>


		<div id="div1"
			style="color: green; margin-bottom: 5px; width: 100%; height: auto">
			<p>${draftsDiary.content2 }</p>

		</div>
		<script type="text/javascript" src="js/wangEditor.min.js"></script>
		<script type="text/javascript">
            var E = window.wangEditor
            var editor = new E('#div1')
                // 忽略粘贴内容中的图片
            editor.customConfig.showLinkImg = false
                //	 /uploadServlet   是我的后台Servlet
            editor.customConfig.uploadImgServer = 'uploadServlet';
            editor.create()
        </script>


		<textarea id="testText" name="diary.content" style="display: none" /></textarea>
		<textarea id="testText2" name="diary.content2" style="display: none" /></textarea>
		<div style="left: 0;right: 0;margin: 3px auto;">
			<input type="button" value="存入草稿"
			style="margin-left: 25%; font-size: 20px; width: 18%"
			onclick="Drafts()"> <input type="submit" value="发表游记"
			style="margin-left: 10%; font-size: 20px; width: 18%">
		</div>
	</form>
	</main>
</body>
<script src="js/love.js" type="text/javascript"></script>
</html>