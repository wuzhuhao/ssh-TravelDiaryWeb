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
<meta charset="utf-8">
<!--<script type="text/javascript" src="js/Cooldog.js"></script>-->
<script src="js/jquery.min.js" type="text/javascript"></script>
<link rel="stylesheet" href="css/Cooldog.css">
<link rel="stylesheet" href="css/iconfont.css">
<title>旅游网|景点</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="css/base.css" rel="stylesheet">
<link href="css/index.css" rel="stylesheet">
<link href="css/m.css" rel="stylesheet">
<script type="text/javascript" src="js/comm.js"></script>
<script type="text/javascript" src="js/tagcloud.js"></script>
<script src="js/spotUtil.js" type="text/javascript"></script>
<!--[if lt IE 9]>
<script src="js/modernizr.js"></script>
<![endif]-->


<script type="text/javascript">
	var sort = "";
	var city = "";
	var subject = "";
	var city_info;
	function infos(url) {
        // 创建Form  
        var form = $('<form style="display:none;"></form>');  
        // 设置属性  
        form.attr('action', 'Recommendation_dataInfo');  
        form.attr('method', 'post');  
        // form的target属性决定form在哪个页面提交  
        // _self -> 当前页面 _blank -> 新页面  
        form.attr('target', '_blank');  
        // 创建Input  
        var my_input = $('<input type="text" name="id" />');  
        my_input.attr('value', "http://piao.qunar.com"+url);  
        // 附加到Form  
        form.append(my_input);
        $(document.body).append(form);
        // 提交表单  
        form.submit();
        // 注意return false取消链接的默认动作  
        return false;  
    }

	function loadAjax(page){
		return $.ajax({
			url: "Recommendation_listToJson",
	        async: false,
	        type: "POST",
	        data: {
	            "param.page": page,
	            "param.sort": sort,
	            "param.city": city,
	            "param.subject": subject,
	        },
	        dataType: "json",
	        success: function (data) {
	        	/* alert(data.result.data_list) */
	        	return data;
	        }
		})
	}
	
	function findPage(page,sort,city,subject){
		return $.ajax({
			url: "Recommendation_getDataListToJson",
	        async: false,
	        type: "POST",
	        data: {
	            "param.page": page,
	            "param.sort": sort,
	            "param.city": city,
	            "param.subject": subject,
	        },
	        dataType: "json",
	        success: function (data) {
	        	/* alert(data.result.data_list) */
	        	return data;
	        }
		})
	}
	
	
	function loadSubjectAjax(page){
		return $.ajax({
			url: "Recommendation_getCitySubjectToJson",
	        async: false,
	        type: "POST",
	        data: {
	            "param.page": page,
	            "param.sort": sort,
	            "param.city": city,
	            "param.subject": subject,
	        },
	        dataType: "json",
	        success: function (data) {
	        	/* alert(data.result.data_list) */
	        	return data;
	        }
		})
	}
	
    </script>
</head>

<body>
	<script>
		! spotRun();
    </script>

	<!-- <header class="header-navigation" id="header"> -->
	<%@ include file="head_top.jsp"%>
	<!-- </header> -->
	<!-- <article id="cleanArticle"></article> -->
	<article id="indexArticle"
		style="overflow: visible;margin: 60px auto 0;"> <aside
		class="l_box" style="overflow: visible">
	<div class="seacher_">
		<h2>条件筛选</h2>
		<div style="margin-bottom: 15px;">
			    <button id="TJ" class="layui-btn layui-btn-primary" style="width: 30%">推荐</button>
			    <button id="RQ" class="layui-btn layui-btn-primary" style="width: 30%" title="按人气从高到低排序">人气</button>
			    <button id="JG" class="layui-btn layui-btn-primary" style="width: 30%" title="按价格从低到高排序">
			    	价格
			    	<i id="jiantou" class="layui-icon layui-icon-up" style="display:inline-block; color:#000000;height:auto; max-width: 30%"></i>
			    </button>
	  	</div>
		<form class="layui-form layui-form-pane" action="seachByFour"
			method="post" target="_blank">
			<div class="layui-form-item"
				style="margin-bottom: 15px; overflow: visible">
				<label class="layui-form-label" style="width: 100px">首字母</label>
				<div class="layui-input-inline"
					style="margin-bottom: 0px; overflow: visible">
					<select id="city_ABC" lay-filter="city_ABC">
						<option value="" selected="selected">请选择</option>
					</select>
				</div>
			</div>
			<div class="layui-form-item"
				style="margin-bottom: 15px; overflow: visible">
				<label class="layui-form-label" style="width: 100px">景点地区</label>
				<div class="layui-input-inline"
					style="margin-bottom: 0px; overflow: visible">
					<select id="city" lay-filter="city">
						<option value="" selected="selected">不限</option>
					</select>
				</div>
			</div>
			
			<div class="layui-form-item"
				style="margin-bottom: 15px; overflow: visible">
				<label class="layui-form-label" style="width: 100px">景点类型</label>
				<div class="layui-input-inline"
					style="margin-bottom: 0px; overflow: visible">
					<select id="subject" lay-filter="subject">
						<option value="" selected="selected">不限</option>
					</select>
				</div>
			</div>

			<div class="layui-form-item"
				style="margin-bottom: 15px; overflow: visible">
				<button class="layui-btn" lay-submit="" lay-filter="demo2">进行条件查找</button>
			</div>
		</form>
	</div>
	<div class="cloud">
		<h2>标签云</h2>
		<div class="tagcloud">
			<a href="seachByFour?diary.classify=自驾游" style=" padding:${zijiayou2}px">自驾游</a>
			<a href="seachByFour?diary.classify=海边游" style=" padding:${haibianyou2}px">海边游</a>
			<a href="seachByFour?diary.classify=出境游" style=" padding:${chujingyou2}px">出境游</a>
			<a href="seachByFour?diary.classify=跟团游" style=" padding:${gentuanyou2}px">跟团游</a>
			<a href="seachByFour?diary.classify=自由行" style=" padding:${ziyouxing2}px">自由行</a>
			<a href="seachByFour?diary.classify=穷游" style=" padding:${qiongyou2}px">穷游</a>
			<a href="seachByFour?diary.classify=自驾游" style=" padding:${zijiayou2}px">自驾游</a>
			<a href="seachByFour?diary.classify=海边游" style=" padding:${haibianyou2}px">海边游</a>
			<a href="seachByFour?diary.classify=出境游" style=" padding:${chujingyou2}px">出境游</a>
			<a href="seachByFour?diary.classify=跟团游" style=" padding:${gentuanyou2}px">跟团游</a>
			<a href="seachByFour?diary.classify=自由行" style=" padding:${ziyouxing2}px">自由行</a>
			<a href="seachByFour?diary.classify=穷游" style=" padding:${qiongyou2}px">穷游</a>
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

            </script> </aside> <main class="r_box">
            	<div id="List"></div>
	<div id="pagelist" style="text-align: center;"></div>
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
<script src="js/layui-v2.4.5/layui/layui.js" charset="utf-8"></script>
<!-- 注意：如果你直接复制所有代码到本地，上述js路径需要改成你本地的 -->
<script>
        layui.use(['form', 'layedit', 'laydate','element','flow','laypage', 'layer'], function() {
        	var element = layui.element; //导航的hover效果、二级菜单等功能，需要依赖element模块
        	var flow = layui.flow;
        	var form = layui.form,
	            layer = layui.layer,
	            layedit = layui.layedit,
	            laydate = layui.laydate,
	            laypage = layui.laypage;
        	
        	function initParam(result){
        		sort = result.param.sort;
        		city = result.param.city;
        		subject = result.param.subject;
        	}
        	
        	function initCityCat_1(city_list){
        		city_info = city_list
        		//清除CityCat_1选项
        	    var city_ABC = document.getElementById("city_ABC");
        		city_ABC.options.length = 1;
        		for(var key in city_list){
        			//创建subject option节点
        	        var city_ABCOpt = document.createElement("option")
        	        var city_ABCtName = key
        	        //为option添加文本        
        	        city_ABCOpt.appendChild(document.createTextNode(city_ABCtName));
        	        //添加到父节点中  
        	        city_ABC.appendChild(city_ABCOpt);
        		}
        		form.render('select');
        	}
        	
        	function initCityCat_2(cityInfo){
        		//清除CityCat_2选项
        	    var city = document.getElementById("city");
        		city.options.length = 1;
        		for(var i=0,l=cityInfo.length;i<l;i++){
        			//创建subject option节点
        	        var city_ABCOpt = document.createElement("option")
        	        var city_ABCtName = cityInfo[i];
        	        //为option添加文本        
        	        city_ABCOpt.appendChild(document.createTextNode(city_ABCtName));
        	        //添加到父节点中  
        	        city.appendChild(city_ABCOpt);
        		}
        		form.render('select');
        	}
        	
        	function initSubject(subject_list){
        	    //清除subject选项
        	    var subjectDocument = document.getElementById("subject");
        	    subjectDocument.options.length = 0;
        	    for(var i=0,l=subject_list.length;i<l;i++){
        	        //创建subject option节点
        	        var subjectOpt = document.createElement("option")
        	        var subjectName = subject_list[i]
        	        //为option添加文本        
        	        subjectOpt.appendChild(document.createTextNode(subjectName));
        	        //添加到父节点中  
        	        subjectDocument.appendChild(subjectOpt);
        	    }
        	    form.render('select');
        	}
        	
        	function initPage(result){
        	    var data_list = result.data_list;
        	    var list_html = "";
        	    for(var i=0,l=data_list.length;i<l;i++){
        	        var li_html = '<li><i><a href="javascript:infos(\''+data_list[i].url+'\')"><img\
        	            src="'+data_list[i].img+'"></a></i>\
        	        <h3>\
        	        <a class="text-hide" href="javascript:infos(\''+data_list[i].url+'\')" >'+data_list[i].name+'</a>\
        	        </h3>\
        	        <div class="datas" style="margin-top: 3px;margin-bottom: 2px;">\
        	            <span style="color:#f60">'+data_list[i].districts+'</span>\
        	            <span>'+data_list[i].level+'</span>\
        	            <span>热度：'+data_list[i].product_star_level+'</span>\
        	        </div>\
        	        <div class="address" style="margin-top: 2px;margin-bottom: 2px;">\
        	            <span>地址：'+data_list[i].address+'</span>\
        	        </div>\
        	        <div class="intrrp" style="margin-top: 2px;margin-bottom: 2px;">\
        	            描述：<p class="text-hide" style="margin-top: 0px;height: auto;max-height: 45px">'+data_list[i].intro+'</p>\
        	        </div><div style="margin-top: 2px;margin-bottom: 2px;">参考票价:<span style="color: #f60">'+data_list[i].price+'</span></div>\
        	        </li>'
        	        /* <img src="images/dibiao.png" alt=""\
        	        style="width: 20px; height: 20px; float: left; clear: right;">&nbsp;\
        	            <a href="seachCity?seach='+data_list[i].districts.split("·")[1]+'">'+data_list[i].districts.split("·")[1]+'</a>&nbsp;&nbsp;\ */
        	        list_html +=li_html
        	        
        	    }
        	    $('#List').html(list_html)
        	}
        	
        	form.on("select(city_ABC)",function () {
        		var city_ABC = $("#city_ABC").val();
        		var cityInfo = city_info[city_ABC];
        		if(city_ABC==""){
        			cityInfo =new Array();
        		}
        		city = "";
        		initCityCat_2(cityInfo);
        	})
        	
        	form.on("select(city)",function () {
        		city = $("#city").val();
        		subject = "";
        		var subject_list = JSON.parse(loadSubjectAjax(1).responseText).result.subject_list;
        		initSubject(subject_list);
        	})
        	
        	form.on("select(subject)",function () {
        		if($("#subject").val()=="不限"){
        			subject = "";
        		}else{
        			subject = $("#subject").val().split("(")[0];
        		}
        	})
        	
        	form.on("submit(demo2)",function () {
        		console.log("sort:"+sort);
        		console.log("city:"+city);
        		console.log("subject:"+subject);
        		var data = findPage(1,sort,city,subject);
		    	var json = JSON.parse(data.responseText);
		    	var result = json.result;
        		//总页数大于页码总数
		    	laypage.render({
		    	    elem: 'pagelist'
		    	    ,count: json.result.pageCount*15 //数据总数
		    	    ,limit:15
		    	    ,jump: function(obj){
		    	    	var result_f = result;
		    	    	if(obj.curr!=1){
		    	    		var temp = findPage(obj.curr,result.param.sort,result.param.city,result.param.subject).responseText;
		    	    		console.log(temp)
		    	    		result_f = JSON.parse(temp).result;
		    	    	}
		    	    	//修改页面内容 --数据列表
		    	    	initPage(result_f);
		    	    }
		    	  });
        		return false;
        	})
        	
        	/* form.on("select(city)",function () {
        		city = $("#city").val();
        	}) */
        	
        	window.onload = function () {
        		$("#TJ").attr("class","layui-btn");
        		$("#jd").addClass("layui-this");
        		var data = loadAjax(1);
		    	var json = JSON.parse(data.responseText);
		    	var result = json.result;
		    	//初始化类型下拉框
    	    	initSubject(result.subject_list);
    	    	//初始化城市下拉框
    	    	initCityCat_1(result.city_list);
		    	//初始化页面参数
		    	initParam(result)
        		//总页数大于页码总数
		    	laypage.render({
		    	    elem: 'pagelist'
		    	    ,count: json.result.pageCount*15 //数据总数
		    	    ,limit:15
		    	    ,jump: function(obj){
		    	    	var result_f = result;
		    	    	if(obj.curr!=1){
		    	    		result_f = JSON.parse(findPage(obj.curr,result.param.sort,result.param.city,result.param.subject).responseText).result;
		    	    	}
		    	    	//修改页面内容 --数据列表
		    	    	initPage(result_f);
		    	    }
		    	  });
        	}
        	
            //监听导航点击
            element.on('nav(demo)', function(elem) {
                //console.log(elem)
                layer.msg(elem.text());
            });
            
            //日期
            laydate.render({
                elem: '#date'
            });
            laydate.render({
                elem: '#date1'
            });

            //创建一个编辑器
            var editIndex = layedit.build('LAY_demo_editor');

            //自定义验证规则
            form.verify({
                title: function(value) {
                    if (value.length < 5) {
                        return '标题至少得5个字符啊';
                    }
                },
                pass: [
                    /^[\S]{6,12}$/, '密码必须6到12位，且不能出现空格'
                ],
                content: function(value) {
                    layedit.sync(editIndex);
                }
            });

            //监听指定开关
            form.on('switch(switchTest)', function(data) {
                layer.msg('开关checked：' + (this.checked ? 'true' : 'false'), {
                    offset: '6px'
                });
                layer.tips('温馨提示：请注意开关状态的文字可以随意定义，而不仅仅是ON|OFF', data.othis)
            });

            //监听提交
            form.on('submit(demo1)', function(data) {
                layer.alert(JSON.stringify(data.field), {
                    title: '最终的提交信息'
                })
                return false;
            });
            $("#TJ").on("click",function () {
            	sort = "";
            	resetBtn()
            	$("#TJ").attr("class","layui-btn")
            });
            $("#RQ").on("click",function () {
            	sort = "pp";
            	resetBtn()
            	$("#RQ").attr("class","layui-btn")
            });
            $("#JG").on("click",function () {
            	if(!($("#JG").attr("class")==="layui-btn")){
            		/* 第一次点击了价格按钮 */
            		resetBtn();
	            	$("#JG").attr("class","layui-btn");
	            	if($("#jiantou").is(".layui-icon-up")){
	            		sort = "pu";
	            	}
	            	else{
	            		sort = "pd";
	            	}
	            	/* $("#jiantou").attr("class","layui-icon layui-icon-up") */
            	}
            	else{
            		if($("#jiantou").is(".layui-icon-up")){
            			//原本排序是升序的
            			//修改成降序图标
            			$("#jiantou").attr("class","layui-icon layui-icon-down")
            			$("#jiantou").attr("title","按价格从高到低排序")
            			/* 下面进行降序请求 */
            			sort = "pd";
            		}
            		else{
            			//原本排序是降序的
            			//修改成升序图标
            			$("#jiantou").attr("class","layui-icon layui-icon-up")
            			$("#jiantou").attr("title","按价格从低到高排序")
            			sort = "pu";
            			/* 下面进行升序请求 */
            		}
            	}
            	$("#jiantou").css("color","#FFFFFF")
            });
            function resetBtn() {
            	$("#TJ").attr("class","layui-btn layui-btn-primary");
            	$("#RQ").attr("class","layui-btn layui-btn-primary");
            	$("#JG").attr("class","layui-btn layui-btn-primary");
            	$("#jiantou").css("color","#000000")
			}
            function checkForm() {
				alert("表单没有提交吗")
			}
            
            


        });

    </script>
</html>
