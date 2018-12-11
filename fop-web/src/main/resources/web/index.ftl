<!DOCTYPE html>
<html lang="zh-cmn-Hans">
<head>
    <title>文件预览接入和测试</title>
    <link rel="stylesheet" href="css/viewer.min.css">
    <link rel="stylesheet" href="css/loading.css">
    <link rel="stylesheet" href="http://cdn.static.runoob.com/libs/bootstrap/3.3.7/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-table/1.11.1/bootstrap-table.css" />
    <style type="text/css">
    </style>
</head>

<body>
<h1>文件预览接入和测试</h1>
<div class="panel-group" id="accordion">
    <div class="panel panel-default">
        <div class="panel-heading">
            <h4 class="panel-title">
                <a data-toggle="collapse" data-parent="#accordion"
                   href="#collapseOne">
                    接入说明
                </a>
            </h4>
        </div>
        <div id="collapseOne" class="panel-collapse collapse">
            <div class="panel-body">
                <div>
                    在线文档预览，示例代码：
                    <pre style="background-color: #2f332a;color: #cccccc">
                        var configuration.serverUrl = 'https://mp.jxtobacco.gov.cn/fop';
                        var configuration.previewUrl = configuration.serverUrl + '/previewUrl';
                        $scope.openWin = function (fileUrl) {
                            var url = configuration.previewUrl + encodeURIComponent(fileUrl);
                            var winHeight = window.document.documentElement.clientHeight-10;
                            $window.open(url, "_blank", "height=" + winHeight
                                + ",top=80,left=80,toolbar=no, menubar=no, scrollbars=yes, resizable=yes");
                        };
                    </pre>
                </div>
                <div>
                    新增多图片同时预览功能，示例代码：
                    <pre style="background-color: #2f332a;color: #cccccc">
                        var configuration.serverUrl = 'https://mp.jxtobacco.gov.cn/fop';
                        var fileUrl =url1+"|"+"url2";//多文件使用“|”字符隔开
                        var url = configuration.serverUrl + "/picturesPreview?urls" + encodeURIComponent(fileUrl);
                        var winHeight = window.document.documentElement.clientHeight-10;
                        $window.open(url, "_blank", "height=" + winHeight
                                + ",top=80,left=80,toolbar=no, menubar=no, scrollbars=yes, resizable=yes");
                    </pre>
                </div>
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading">
            <h4 class="panel-title">
                <a data-toggle="collapse" data-parent="#accordion"
                   href="#collapseTwo">
                    预览测试
                </a>
            </h4>
        </div>
        <div id="collapseTwo" class="panel-collapse collapse">
            <div class="panel-body">
                <p style="color: red;">因为是测试所以一种文件只允许上传一个</p>
                <div style="padding: 10px">
                    <form enctype="multipart/form-data" id="fileUpload">
                        <input type="file" name="file" />
                        <input type="button" id="btnsubmit" value=" 上 传 " />
                    </form>
                </div>
                <div>
                    <table id="table" data-pagination="true"></table>
                </div>
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading">
            <h4 class="panel-title">
                <a data-toggle="collapse" data-parent="#accordion"
                   href="#collapseThree">
                    项目特性
                </a>
            </h4>
        </div>
        <div id="collapseThree" class="panel-collapse collapse in">
            <div class="panel-body">
                <div>
                    1、支持office，pdf等办公文档<br>
                    2、支持txt,java,php,py,md,js,json,css等所有纯文本<br>
                    3、支持zip,rar,jar,tar,gzip等压缩包<br>
                    4、支持jpg，jpeg，png，gif等图片预览（翻转，缩放，镜像）<br>
                    5、rest接口提供服务，跨平台特性(java,php,python,go,php，....)都支持，应用接入简单方便<br><br>
                </div>
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading">
            <h4 class="panel-title">
                <a data-toggle="collapse" data-parent="#accordion"
                   href="#collapse4">
                    更新记录
                </a>
            </h4>
        </div>
        <div id="collapse4" class="panel-collapse collapse">
            <div class="panel-body">
                <div>
                    2018年12月11日 ：<br>
                    1.新增多图片同时预览<br>
                    2.支持压缩包内图片轮番预览<br>
                    3.引入pdf.js预览doc等文件，支持doc标题生成pdf预览菜单，支持手机端预览<br><br>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="loading_container">
    <div class="spinner">
        <div class="spinner-container container1">
            <div class="circle1"></div>
            <div class="circle2"></div>
            <div class="circle3"></div>
            <div class="circle4"></div>
        </div>
        <div class="spinner-container container2">
            <div class="circle1"></div>
            <div class="circle2"></div>
            <div class="circle3"></div>
            <div class="circle4"></div>
        </div>
        <div class="spinner-container container3">
            <div class="circle1"></div>
            <div class="circle2"></div>
            <div class="circle3"></div>
            <div class="circle4"></div>
        </div>
    </div>
</div>
<script src="js/jquery-3.0.0.min.js" type="text/javascript"></script>
<script src="https://cdn.bootcss.com/jquery.form/3.09/jquery.form.min.js" type="text/javascript"></script>
<script src="http://cdn.static.runoob.com/libs/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-table/1.11.1/bootstrap-table.js"></script>
<script>
    function deleteFile(fileName) {
        $.ajax({
            url: '${baseUrl}deleteFile?fileName=' + encodeURIComponent(fileName),
            success: function (data) {
                // 删除完成，刷新table
                if (1 == data.code) {
                    alert(data.msg);
                }else{
                    $('#table').bootstrapTable('refresh', {});
                }
            },
            error: function (data) {
                console.log(data);
            }
        })
    }
    $(function () {
        $('#table').bootstrapTable({
            url: 'listFiles',
            columns: [{
                field: 'fileName',
                title: '文件名'
            }, {
                field: 'action',
                title: '操作'
            },]
        }).on('pre-body.bs.table', function (e,data) {
            // 每个data添加一列用来操作
            $(data).each(function (index, item) {
                item.action = "<a class='btn btn-default' target='_blank' href='${baseUrl}onlinePreview?url="
                    + encodeURIComponent('${baseUrl}' + item.fileName ) +"'>预览</a>" +
                    "<a class='btn btn-default' target='_blank' href='javascript:void(0);' onclick='deleteFile(\""+item.fileName+"\")'>删除</a>";
            });
            return data;
        }).on('post-body.bs.table', function (e,data) {
            return data;
        });

        /**
         *
         */
        function showLoadingDiv() {
            var height = window.document.documentElement.clientHeight - 1;
            $(".loading_container").css("height", height).show();
        }

        $("#btnsubmit").click(function () {
            showLoadingDiv();
            $("#fileUpload").ajaxSubmit({
                success: function (data) {
                    // 上传完成，刷新table
                    if (1 == data.code) {
                        alert(data.msg);
                    }else{
                        $('#table').bootstrapTable('refresh', {});
                    }
                    $(".loading_container").hide();
                },
                error: function (error) { alert(error); $(".loading_container").hide();},
                url: 'fileUpload', /*设置post提交到的页面*/
                type: "post", /*设置表单以post方法提交*/
                dataType: "json" /*设置返回值类型为文本*/
            });
        });
    });
</script>
</body>
</html>