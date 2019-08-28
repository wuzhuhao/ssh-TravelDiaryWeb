function loadhomepage() {
    var form = layui.form;
    window.layer = layui.layer;
    layedit = layui.layedit;
    window.jQuery = window.$ = layui.jquery;
    var element = layui.element,
        form = layui.form,
        laypage = layui.laypage;
    //删除用户
    $(document).on('click', '.del_comment', function () {
        var id = $(this).attr("data-id");
        //            alert(typeof id);
        $(this).closest('.comment').css("display", "none");
    });

    /*点击回复事件begin*/
    $(document).on('click', '.commentInput', function (e) {
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

    /*点击提交回复ajax事件begin*/
    $(document).on('click', '.layui-btn', function (e) {
        var elment = $('#inputF');
        var reply = elment.val();
        if (reply == 'null' || reply == '') {
            alert('回复内容不可为空')
        } else {
            alert(reply)
        }

        e.stopPropagation();
    });
    /*点击提交回复ajax事件end*/

    /*点击其他区域事件begin*/
    $(document).bind('click', function (e) {
        var e = e || window.event;
        var elem = e.target || e.srcElement;
        while (elem) {
            /*点击了from*/
            if (elem.className && elem.className == 'top-end') {
                /*alert("inputFrom")*/
                return;
            }
            elem = elem.parentNode;
        }
        $("#inputFrom").hide();
    });
    /*点击其他区域事件end*/

    //点击加载事件
    $(document).on('click', '.comment_add', function () {
        var id = $(this).attr("data-id");
        var page = $(this).attr("data-page");
        add(page, id);
        $(this).html("点击加载更多");
    });


    //删除节点方法
    function delComment(id) {
        alert(id);
    }

    //增加节点方法
    function add(page, uid) {
        $.ajax({
            url: "findUserMessageByUidToJson",
            async: true,
            type: "POST",
            data: {
                "page": page,
                "u_id": uid,
            },
            dataType: "json",
            success: function (data) {
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
                        $.each(value, function (names, values) {
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
                            divHtml += '<div class="conmment_details">';
                            divHtml += '<span class="comment_name"><a href="findUserById?u_id=' + sender_id + '"></span>     <span>' + sendTime + '</span>';
                            divHtml += '<div class="comment_content" >  ' + content + '</div>';
                            divHtml += '<div class="del">';
                            //判断删除按钮区域
                            if (sender_id == loginUid || sendee_id == loginUid) {
                                divHtml += '<a class="del_comment"  data-id="' + messId + '"><i class="icon layui-icon" >删除</i></a>';
                            }
                            //判断回复按钮区域
                            if (sendee_id == loginUid && (replyContent == "" || replyContent.length == 0)) {
                                divHtml += '<a class="commentInput" data-id="' + messId + '"> <i class="icon layui-icon layui-icon-edit">回复</i></a>';
                            }
                            divHtml += '</div>';
                            //判断回复内容显示区域
                            if (replyContent != "" && replyContent.length != 0) {
                                divHtml += '<div class="comment_content layui-bg-gray">  回复：' + replyContent + '</div></div>';
                            }
                            divHtml += '<hr></div>';
                        });
                    }
                });
                if (pages != 1) {}

                if (pages >= talPages) {
                    pagelist += '<div class = "comment_last" > 没有更多评论了 < /div>';
                } else {
                    pagelist += '<div class="comment_add" data-id="' + messId + '" data-page="' + pages + '">点击加载更多</div>';
                }

                if (flag != "1") {
                    $('.listContent').append(divHtml);
                }
                $('#topLast').html(pagelist);
            }
        });

    }

}
