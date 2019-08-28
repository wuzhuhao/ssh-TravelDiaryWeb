$(document).ready(function(){
        $("#up-img-touch").click(function(){
              $("#doc-modal-1").modal({width:'600px'});//点击图片时弹出文件选择框
        });
});
$(function() {
    'use strict';
    // 初始化
    var $image = $('#image');
    $image.cropper({
        aspectRatio: '1',
        autoCropArea:0.8,
        preview: '.up-pre-after',
        
    });

    // 事件代理绑定事件
    $('.docs-buttons').on('click', '[data-method]', function() {
   
        var $this = $(this);
        var data = $this.data();
        var result = $image.cropper(data.method, data.option, data.secondOption);
        switch (data.method) {
            case 'getCroppedCanvas':
            if (result) {
                // 显示 Modal
                $('#cropped-modal').modal().find('.am-modal-bd').html(result);
                $('#download').attr('href', result.toDataURL('image/jpeg'));
            }
            break;
        }
    });
    

    // 上传图片
    var $inputImage = $('#inputImage');
    var URL = window.URL || window.webkitURL;
    var blobURL;

    if (URL) {
        $inputImage.change(function () {
            var files = this.files;
            var file;

            if (files && files.length) {
               file = files[0];

               if (/^image\/\w+$/.test(file.type)) {
                    blobURL = URL.createObjectURL(file);
                    $image.one('built.cropper', function () {
                        // Revoke when load complete
                       URL.revokeObjectURL(blobURL);
                    }).cropper('reset').cropper('replace', blobURL);
                    $inputImage.val('');
                } else {
                   layer.msg("请选择一个图片文件",{icon: 0});
                }
            }

            // Amazi UI 上传文件显示代码
            var fileNames = '';
            $.each(this.files, function() {
                fileNames += '<span class="am-badge">' + this.name + '</span> ';
            });
            $('#file-list').html(fileNames);
        });
    } else {
        $inputImage.prop('disabled', true).parent().addClass('disabled');
    }
    
    //绑定上传事件
    $('#up-btn-ok').on('click',function(){
    	alert(999)
       var $modal = $('#my-modal-loading');
       var $modal_alert = $('#my-alert');
       var img_src=$image.attr("src");
       alert(img_src)
       if(img_src==""){
          set_alert_info("没有选择上传的图片");
          $modal_alert.modal();
          return false;
       }
       
       $modal.modal();
       var url=$(this).attr("url");
       var canvas=$("#image").cropper('getCroppedCanvas');
       var data=canvas.toDataURL("image/jpeg",0.7); //转成base64
       var imgs = data.substring(23);
       alert(imgs);
       alert(url+"测试data!!!!!!"+date+"测试！！"+imgs);
        $.ajax( {  
                url:url,
                dataType:'json',
                type: "POST",  
                data: {"image":imgs},
                
                success: function(data, textStatus){
                   $modal.modal('close');
                   $modal_alert.modal();
                   alert(data);
                   if(data=="ok"){    
                       set_alert_info("上传成功");

                      $("#up-img-touch img").attr("src",data.file); 
                      var img_name=data.file.split('/')[2];
                      $("#pic").text(img_name);
                   }
                },
                error: function(){
                   $modal.modal('close');
                   set_alert_info("上传文件失败了！");
                   $modal_alert.modal();
                   //console.log('Upload error');  
                }  
         });  
       
    });
    
});

function rotateimgright() {
$("#image").cropper('rotate', 90);
}


function rotateimgleft() {
$("#image").cropper('rotate', -90);
}

function set_alert_info(content){
   $("#alert_content").html(content);
}
function closemodel(){
    $("#doc-modal-1").modal('close');
}
