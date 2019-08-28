function findPage(page) {
            $.ajax({
                url: "list5",
                async: true,
                type: "POST",
                data: {
                    "page": page,
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
    						else{
    							$.each(value,function(names,values){
    				  				str2+="1";
    				  				uid = values.user.id;
				  					userName = values.user.userName;
    				  				str+="<li><i><a  href=\"info?id=" + values.did + "\"  onclick=\"\"><img src=" + values.image  + "></a></i><h3><a class = \"text-hide\" href=\"info?id=" + values.did + "\">" +  values.title + "</a></h3><p class = \"text-hide\">" + values.content + "</p><br><img src=\"images/dibiao.png\" alt=\"\" style=\"width:20px;height:20px;float:left;clear:right;\">&nbsp;<a href=\"seachCityByCountryRegion?destinationName="+values.city+"\">"+ values.province+values.city+"<a>&nbsp;&nbsp;by&nbsp;<a href=\"findUserById?u_id="+uid+"\">"+userName+"</a></li>";
    				  				});
    						}
    					});	
    					if(pages!=1){
    						pagelist += "<span id=\"nextPage\"><a style=\"cursor: default\" onclick=\"findPage(1)\">首页</a></span><span id=\"nextPage\"><a style=\"cursor: default\" onclick=\"findPage("+(pages-1)+")\">上一页</a></span>";
    					}
    					pagelist +="<span>第"+pages+"/"+talPages+"页 </span>";
    					
    					if(pages!=talPages){
    						pagelist +="<span id=\"nextPage\"><a style=\"cursor: default\" onclick=\"findPage("+(pages+1)+")\">下一页</a></span>";
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


        };
        
        function findSeachPage(page,seach) {
            	var flag = false;
            	$.ajax({
                        url:"findDiarybySeachForJson",
                        async:false,
                         type: "POST",
                         data:{"page":page,"seach":seach},
                         dataType:"json",
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
                                    if(name=="seach"){
                                        seachs = value;
                                    }
                                    else if(name=="page"){
                                        pages = value;
                                    }
                                    else if(name=="talPage"){
                                        talPages = value;
                                    }
                                    else{
                                        $.each(value,function(names,values){
                                              str2+="1"
                                              uid = values.user.id;
                                              userName = values.user.userName;
                                              str+="<li><i><a  href=\"info?id=" + values.did + "\"  onclick=\"\"><img src=" + values.image  + "></a></i><h3><a class = \"text-hide\" href=\"info?id=" + values.did + "\">" +  values.title + "</a></h3><p class = \"text-hide\">" + values.content + "</p><br><img src=\"images/dibiao.png\" alt=\"\" style=\"width:20px;height:20px;float:left;clear:right;\">&nbsp;<a href=\"seachCityByCountryRegion?destinationName="+values.city+"\">"+ values.province+values.city+"<a>&nbsp;&nbsp;by&nbsp;<a href=\"findUserById?u_id="+uid+"\">"+userName+"</a></li>";
                                              });
                                    }
                                });	
                                if(pages!=1){
                                    pagelist += "<span id=\"nextPage\"><a style=\"cursor: default\" onclick=\"findSeachPage(1,'"+seachs+"')\">首页</a></span><span id=\"nextPage\"><a style=\"cursor: default\" onclick=\"findSeachPage("+(pages-1)+",'"+seachs+"')\">上一页</a></span>";
                                }
                                pagelist +="<span>第"+pages+"/"+talPages+"页 </span>";
                                
                                if(pages!=talPages){
                                    pagelist +="<span id=\"nextPage\"><a style=\"cursor: default\" onclick=\"findSeachPage("+(pages+1)+",'"+seachs+"')\">下一页</a></span>";
                                }
                                if(str2=="1"||talPages==0){
                                	flag = false;
                                }
                                else{
                                      $('#List').html(str);
                                      $('.pagelist').html(pagelist);
                                      flag = true;
                                }
                    		}
                  })
                  return flag;
            }
        
        
            function seachSubmit(){
                var page = 1;
                var seach = $('#seachInput').val();
                if(isEmpty(seach)){
                    alert("搜索信息不能为空")
                }
                if(!findSeachPage(page,seach)){
                	alert("搜索结果为空")
                }
            }