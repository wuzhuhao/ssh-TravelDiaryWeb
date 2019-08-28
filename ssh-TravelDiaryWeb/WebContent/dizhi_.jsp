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
<title>旅游网|游玩攻略</title>
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
	window.onload = function () {
		//导航栏定位
		$("#ywgl").addClass("layui-this");
		//筛选框内容初始化
        $('#monthTime').siblings("div.layui-form-select").find('dl').find('dd[lay-value="${pageBean.params.monthTime}"]').click();
        $('#classify').siblings("div.layui-form-select").find('dl').find('dd[lay-value="${pageBean.params.classify}"]').click();
        if("${pageBean.params.totalTime!=0 }"=="true"){
        	$('input[name="diary.totalTime"]').attr("value",'${pageBean.params.totalTime }');
        }
        $('input[name="diary.countryRegion"]').attr("value",'${pageBean.params.countryRegion }');
      	//筛选框内容初始化end
	    var flag = "${pageBean.list==null||pageBean.list.size()==0}";
	    if (flag != "true"){
	        flag = "${pageBean.params.size()==4}";
	        if (flag != "true") {
	            flag = "${pageBean.totalPage!=0}";
	            if (flag == "true") {
	                flag = "${pageBean.page != 1}";
	                if (flag == "true") {
	                    $('.pagelist').append("<span id=\"nextPage\"><a style=\"cursor: default\"\
	onclick=\"findPage(1,'${pageBean.params.seach}','${pageBean.params.countryRegion}')\">首页</a></span>\
						<span id=\"nextPage\"><a style=\"cursor: default\"\
					onclick=\"findPage(${pageBean.page-1},'${pageBean.params.seach}','${pageBean.params.countryRegion}')\">上一页</a></span>");
	                }
	            }
	            $('.pagelist').append('<span>第${pageBean.page}/${pageBean.totalPage}页 </span>');
	            flag = "${pageBean.page != pageBean.totalPage}";
	            if (flag == "true") {
	                $('.pagelist').append('<span id=\"nextPage\"><a style=\"cursor: default\"\
	onclick=\"findPage(${pageBean.page+1},\'${pageBean.params.seach}\',\'${pageBean.params.countryRegion}\')\">下一页</a></span>');
	            }
	        } else {
	            flag = "${pageBean.totalPage!=0}";
	            if (flag == "true") {
	                flag = "${pageBean.page != 1}";
	                if (flag == "true") {
	                    $('.pagelist').append("<span id=\"nextPage\"><a style=\"cursor: default\"\
	onclick=\"findPage2(1,'${pageBean.params.classify}','${pageBean.params.countryRegion}',${pageBean.params.monthTime},${pageBean.params.totalTime})\">首页</a></span>\
						<span id=\"nextPage\"><a style=\"cursor: default\"\
					onclick=\"findPage2(${pageBean.page-1},'${pageBean.params.classify}','${pageBean.params.countryRegion}',${pageBean.params.monthTime},${pageBean.params.totalTime})\">上一页</a></span>");
	                }
	            }
	            $('.pagelist').append('<span>第${pageBean.page}/${pageBean.totalPage}页 </span>');
	            flag = "${pageBean.page != pageBean.totalPage}";
	            if (flag == "true") {
	                $('.pagelist').append("<span id=\"nextPage\"><a style=\"cursor: default\"\
	onclick=\"findPage2(${pageBean.page+1},'${pageBean.params.classify}','${pageBean.params.countryRegion}',${pageBean.params.monthTime},${pageBean.params.totalTime})\">下一页</a></span>");
	            }
	        }
	    }
	}

	function findPage2(page, classify, countryRegion, monthTime, totalTime) {
	    $.ajax({
	        url: "seachByFourForJson",
	        async: true,
	        type: "POST",
	        data: {
	            "page": page,
	            "diary.classify": classify,
	            "diary.monthTime": monthTime,
	            "diary.countryRegion": countryRegion,
	            "diary.totalTime": totalTime
	        },
	        dataType: "json",
	        success: function (data) {
	            var str = ""
	            var str2 = "1"
	            var pages = 0;
	            var talPages = 0;
	            var pagelist = "";
	            var uid = 0;
	            var userName = '';
	            var list;
	            $.each(data, function (name, value) {
	                if (name == "countryRegion") {
	                    countryRegion = value;
	                } else if (name == "classify") {
	                    classify = value;
	                } else if (name == "monthTime") {
	                    monthTime = value;
	                } else if (name == 'totalTime') {
	                    totalTime = value;
	                } else if (name == "page") {
	                    pages = value;
	                } else if (name == 'talPage') {
	                    talPages = value;
	                } else {
	                    list = value;

	                }
	            });
	            var totalSize = parseInt(list.length);
	            var middle;
	            if (totalSize != 0) {
	                if (totalSize % 2 == 1) {
	                    middle = totalSize / 2;
	                } else {
	                    middle = totalSize / 2-1;
	                }
	                str = '<ul style="width: 48.5%;">';
	                $.each(list, function (index, values) {
	                    str2 += "1";
	                    str += '<li data-scroll-reveal="enter bottom over 1s"><a\
						href="info?id=' + values.did + '"><i><img src="' + values.image + '"></i>\
							<div class="picinfo">\
								<h3>\
									类型：' + values.classify + '<br /> 月份：' + values.monthTime + '月<br />\
									时间：' + values.totalTime + '天<br /> 目的地：' + values.province + values.city +'<br /></h3></a></li>';
	                    if (index == middle) {
	                        str += '</ul><ul style="width: 48.5%;">';
	                    }
	                });
	                str += '</ul>';
	            }
	            if (pages != 1) {
	                pagelist += "<span id=\"nextPage\"><a style=\"cursor: default\" onclick=\"findPage2(1,'" + classify + "','" + countryRegion + "'," + monthTime + "," + totalTime + ")\">首页</a></span><span id=\"nextPage\"><a style=\"cursor: default\" onclick=\"findPage2(" + (pages - 1) + ",'" + classify + "','" + countryRegion + "'," + monthTime + "," + totalTime + ")\">上一页</a></span>";
	            }
	            pagelist += "<span>第" + pages + "/" + talPages + "页 </span>";

	            if (pages != talPages) {
	                pagelist += "<span id=\"nextPage\"><a style=\"cursor: default\" onclick=\"findPage2(" + (pages + 1) + ",'" + classify + "','" + countryRegion + "'," + monthTime + "," + totalTime + ")\">下一页</a></span>";
	            }

	            if (str2 == "1") {
	                alert("已经是最后一页了啊我的哥");
	            } else {
	                $('.picbox').html(str);
	                if (talPages == 0) {
	                    $('.pagelist').html("无结果");
	                } else {
	                    $('.pagelist').html(pagelist);
	                }
	            }


	        }
	    });


	}

	

        function findPage(page,seach,countryRegions) {
            $.ajax({
                url: "findByCountryRegionForJson",
                async: true,
                type: "POST",
                data: {
                    "page": page,
                    "seach": seach,
                    "countryRegion": countryRegions
                },
                dataType: "json",
                success: function(data) {	
     				var str=""
    					var str2="1"
    					var str3="<a style=\"cursor: default\"  onclick=\"nextPage(" + (page+1) + ",1)\">下一页</a>"
    					var pages = 0;
    					var seachs = "";
    					var countryRegion = "";
    					var talPages = 0;
    					var pagelist = "";
    					var uid = 0;
    					var userName = '';
    					$.each(data,function(name,value){
    						if(name=="seach"){
    							seachs = value;
    						}
    						else if(name=="page"){
    							pages = value;
    						}
    						else if(name=="talPage"){
    							talPages = value;
    						}
    						else if(name=='countryRegion'){
    							countryRegion = value;
    						}
    						else{
    							$.each(value,function(names,values){
    				  				str2+="1";
    				  				uid = values.user.id;
				  					userName = values.user.userName;
    				  				str+="<li><i><a  href=\"info?id=" + values.did + "\"  onclick=\"\"><img src=" + values.image  + "></a></i><h3><a class = \"text-hide\" href=\"info?id=" + values.did + "\">" +  values.title + "</a></h3><p class = \"text-hide\">" + values.content + "</p><br><img src=\"images/dibiao.png\" alt=\"\" style=\"width:20px;height:20px;float:left;clear:right;\">&nbsp;<a href=\"\">"+ values.province+values.city+"<a>&nbsp;&nbsp;by&nbsp;<a href=\"findUserById?u_id="+uid+"\">"+userName+"</a></li>";
    				  				});
    						}
    					});	
    					if(pages!=1){
    						pagelist += "<span id=\"nextPage\"><a style=\"cursor: default\" onclick=\"findPage(1,'"+seachs+"','"+countryRegion+"')\">首页</a></span><span id=\"nextPage\"><a style=\"cursor: default\" onclick=\"findPage("+(pages-1)+",'"+seachs+"','"+countryRegion+"')\">上一页</a></span>";
    					}
    					pagelist +="<span>第"+pages+"/"+talPages+"页 </span>";
    					
    					if(pages!=talPages){
    						pagelist +="<span id=\"nextPage\"><a style=\"cursor: default\" onclick=\"findPage("+(pages+1)+",'"+seachs+"','"+countryRegion+"')\">下一页</a></span>";
    					}
    					
    					if(str2=="1"){
    	  					alert("已经是最后一页了啊我的哥")
    					}
    	  				else{
    			  			$('#List').html(str);
    			  			/* $('#nextPage').html(str3); */
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

	<!-- <header class="header-navigation" id="header"> -->
	<%@ include file="head_top.jsp"%>
	<!-- </header> -->
	<!-- <article id="cleanArticle"></article> -->
	<article id="indexArticle"
		style="overflow: visible;margin: 60px auto 0;"> <aside
		class="l_box" style="overflow: visible">
	<div class="seacher_">
		<h2>条件筛选</h2>
		<form class="layui-form layui-form-pane" action="seachByFour"
			method="post">
			<div class="layui-form-item"
				style="margin-bottom: 15px; overflow: visible">
				<label class="layui-form-label" style="width: 100px">旅游类型</label>
				<div class="layui-input-inline"
					style="margin-bottom: 0px; overflow: visible">
					<select name="diary.classify" id="classify">
						<option value="" selected="">全部</option>
						<option>自驾游</option>
						<option>海边游</option>
						<option>出境游</option>
						<option>跟团游</option>
						<option>自由行</option>
						<option>穷游</option>
					</select>
				</div>
			</div>
			<div class="layui-form-item"
				style="margin-bottom: 15px; overflow: visible">
				<label class="layui-form-label" style="width: 100px">月份</label>
				<div class="layui-input-inline"
					style="margin-bottom: 0px; overflow: visible">
					<select name="diary.monthTime" id="monthTime">
						<option value="0" selected="">全部</option>
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
			</div>
			<div class="layui-form-item"
				style="margin-bottom: 15px; overflow: visible">
				<label class="layui-form-label" style="width: 100px">目的地</label>
				<div class="layui-input-inline"
					style="margin-bottom: 0px; overflow: visible">
					<input type="text" name="diary.countryRegion" placeholder="请输入目的地"
						autocomplete="off" class="layui-input">
				</div>
			</div>
			<div class="layui-form-item"
				style="margin-bottom: 15px; overflow: visible">
				<label class="layui-form-label" style="width: 100px">旅游时间</label>
				<div class="layui-input-inline"
					style="margin-bottom: 0px; overflow: visible">
					<input type="text" name="diary.totalTime" placeholder="请输入筛选时间"
						autocomplete="off" class="layui-input">
				</div>
			</div>

			<div class="layui-form-item"
				style="margin-bottom: 15px; overflow: visible">
				<button class="layui-btn" lay-submit="" lay-filter="demo2">进行条件查找</button>
			</div>
		</form>
	</div>
	<div class="tuijian">
		<h2>推荐游记</h2>
		<ul>
			<c:forEach items="${recommendedDiary}" var="diaryList">
				<li><a href="info?id=${diaryList.did}">${diaryList.title}</a></li>
			</c:forEach>
		</ul>
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
	<div class="picbox">
		<%-- <ul >
				<c:forEach items="${pageBean.list}" end="2" var="recommend">
					<li data-scroll-reveal="enter bottom over 1s"><a
						href="recommend_findById?id_=${recommend.did}"><i><img
								src="${recommend.image }"></i>
							<div class="picinfo">
								<h3>${recommend.classify }</h3></a></li>
				</c:forEach>
			</ul>
			<ul >
				<c:forEach items="${pageBean.list}" begin="3" end="5" var="recommend">
					<li data-scroll-reveal="enter bottom over 1s"><a
						href="recommend_findById?id_=${recommend.did}"><i><img
								src="${recommend.image }"></i>
							<div class="picinfo">
								<h3>${recommend.classify }</h3></a></li>
				</c:forEach>
			</ul> --%>
		<c:if test="${pageBean.list.size()==0 }">
			<p style="text-align: center;">无结果</p>
		</c:if>
		<c:if test="${pageBean.list.size()!=0 }">
			<ul style="width: 48.5%;">
			<c:forEach items="${pageBean.list}" end="${pageBean.list.size()%2==1?pageBean.list.size()/2:pageBean.list.size()/2-1}" var="recommend">
				<li data-scroll-reveal="enter bottom over 1s"><a
					href="info?id=${recommend.did}"><i><img
							src="${recommend.image }"></i>
						<div class="picinfo">
							<h3>
								类型：${recommend.classify }<br /> 月份：${recommend.monthTime }月<br />
								时间：${recommend.totalTime }天<br /> 目的地：${recommend.province }${recommend.city }<br />
							</h3></a></li>
			</c:forEach>
		</ul>
		<ul style="width: 48.5%;">
			<c:forEach items="${pageBean.list}" begin="${pageBean.list.size()%2==1?pageBean.list.size()/2+1:pageBean.list.size()/2}" end="7" var="recommend">
				<li data-scroll-reveal="enter bottom over 1s"><a
					href="info?id=${recommend.did}"><i><img
							src="${recommend.image }"></i>
						<div class="picinfo">
							<h3>
								类型：${recommend.classify }<br /> 月份：${recommend.monthTime }月<br />
								时间：${recommend.totalTime }天<br /> 目的地：${recommend.province }${recommend.city }<br />
							</h3></a></li>
			</c:forEach>
		</ul>
		</c:if>


	</div>
	<%-- <div id="List">
		<c:forEach items="${pageBean.list}" var="diary">
			<li><i><a href="info?id=${diary.did}"><img
						src="${diary.image}"></a></i>
				<h3>
					<a class="text-hide" href="info?id=${diary.did}">${diary.title}</a>
				</h3>
				<p class="text-hide">${diary.content}</p> <br> <!--<i style="background-size: 200px;"></i>-->
					<img src="images/dibiao.png" alt=""
					style="width: 20px; height: 20px; float: left; clear: right;">&nbsp;
						<a href="seachCity?seach=${diary.city}">${diary.province}${diary.city}</a>&nbsp;&nbsp;by&nbsp;
						<a href="findUserById?u_id=${diary.user.id}">${diary.user.userName}</a></li>


		</c:forEach>
	</div> --%>
	<div class="pagelist">
		<%-- <c:if test="${pageBean != null}">
			<c:if test="${pageBean.totalPage != 0}">
				<c:if test="${pageBean.page != 1}">
					<span id="nextPage"><a style="cursor: default"
						onclick="findPage(1,'${pageBean.params.seach}','${pageBean.params.countryRegion}')">首页</a></span>
					<span id="nextPage"><a style="cursor: default"
						onclick="findPage(${pageBean.page-1},'${pageBean.params.seach}','${pageBean.params.countryRegion}')">上一页</a></span>
				</c:if>
				<span>第${pageBean.page}/${pageBean.totalPage}页 </span>
				<c:if test="${pageBean.page != pageBean.totalPage}">
					<span id="nextPage"><a style="cursor: default"
						onclick="findPage(${pageBean.page+1},'${pageBean.params.seach}','${pageBean.params.countryRegion}')">下一页</a></span>
				</c:if>
			</c:if>
			<c:if test="${pageBean.totalPage == 0}">
				<span>无结果</span>
			</c:if>
		</c:if>
		<c:if test="${pageBean == null}">
			<span>无结果</span>
		</c:if> --%>

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
<script src="js/love.js" type="text/javascript"></script>
<script src="js/layui-v2.4.5/layui/layui.js" charset="utf-8"></script>
<!-- 注意：如果你直接复制所有代码到本地，上述js路径需要改成你本地的 -->
<script>
        layui.use(['form', 'layedit', 'laydate','element'], function() {
        	var element = layui.element; //导航的hover效果、二级菜单等功能，需要依赖element模块

            //监听导航点击
            element.on('nav(demo)', function(elem) {
                //console.log(elem)
                layer.msg(elem.text());
            });
            var form = layui.form,
                layer = layui.layer,
                layedit = layui.layedit,
                laydate = layui.laydate;
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
            /* $("#classify").find("option[value='${pageBean.params.classify}']").prop("selected",true);
            $("#monthTime").find("option[value='${pageBean.params.monthTime}']").prop("selected",true);
            form.render();
            alert($("#classify").find("option[value='${pageBean.params.classify}']"))
            alert("测试${pageBean.params.classify}") */


        });

    </script>
</html>
