function loadXMLFile(xmlFile) {
    var xmlDoc = null;
    var agent = navigator.userAgent.toLowerCase();

    //判断浏览器的类型
    //支持IE浏览器
    if (agent.indexOf("msie") > 0) {
        var xmlDomVersions = ['MSXML.2.DOMDocument.6.0', 'MSXML.2.DOMDocument.3.0', 'Microsoft.XMLDOM'];
        for (var i = 0; i < xmlDomVersions.length; i++) {
            try {
                xmlDoc = new ActiveXObject(xmlDomVersions[i]);
                break;
            } catch (e) {

            }
        }
    }
    //支持firefox浏览器
    else if (agent.indexOf("firefox") > 0) {
        try {
            xmlDoc = document.implementation.createDocument('', '', null);
        } catch (e) {}
    } else { //谷歌浏览器
        var oXmlHttp = new XMLHttpRequest();
        oXmlHttp.open("GET", xmlFile, false);
        oXmlHttp.send(null);
        return oXmlHttp.responseXML;
    }
    if (xmlDoc != null) {
        xmlDoc.async = false;
        xmlDoc.load(xmlFile);
    }
    return xmlDoc;
}

function onloadXml_() {
    //加载XML文件。
    var xmlDom = loadXMLFile("../xml/city.xml");
    
    var provinces2 = xmlDom.getElementsByTagName("province");
  //获取province节点
    var province = document.getElementById("province");
    for (var i = 0; i < provinces2.length; i++) {
        //获取省节点的name属性的值 
        // alert(provinces.length); 
        var name = provinces2[i].getAttribute("name");
        //创建一个option  
        var opt = document.createElement("option");

        //为option添加文本  
        opt.appendChild(document.createTextNode(name));
        //添加到父节点中  
        province.appendChild(opt);
    }
    //获取cities节点
    var cities = document.getElementById("cities");
    province.onchange = function () {
        var pce = document.getElementById("province");

        var opts = pce.options;
        var opt1 = opts[pce.selectedIndex];
        //获取省份的名字
        var name = opt1.innerHTML;
        for (var i = 0; i < provinces2.length; i++) {
            //获取省节点的name属性的值  
            var name1 = provinces2[i].getAttribute("name");
            // alert(name1+"haha");
            // alert(name==name1);
            if (name == name1) {
                cities.length = 1; //每次改变的时候清空  

                var pros = provinces2[i];

                var citys = pros.getElementsByTagName("item");
                for (var j = 0; j < citys.length; j++) {
                    //创建一个option  
                    var opt1 = document.createElement("option");
                    //为option添加文本           
                    opt1.appendChild(document.createTextNode(citys[j].firstChild.nodeValue));
                    //添加到父节点中  
                    cities.appendChild(opt1);
                }
                break;
            }
        }
    }
}

function loadCountryRegion(){
	$("input[value='${draftsDiary.classify}']").prop('checked', 'checked');
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
                	cityItem = provinceItem[j].getElementsByTagName("State")[0]
                	.getElementsByTagName("City");
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
        	provinceItem = countryRegionItem[0].getElementsByTagName("State");
        	haveCount(1);
        }
        else if(name=='外国'){
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
