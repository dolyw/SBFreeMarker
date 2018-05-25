<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>layout 后台大布局 - Layui</title>
    <link rel="stylesheet" href="${springMacroRequestContext.contextPath}/vendor/layui/css/layui.css">
</head>
<body>
<div class="layui-layout layui-layout-admin">
    <div class="layui-header">
        <div class="layui-logo">layui 后台布局</div>
        <!-- 头部区域（可配合layui已有的水平导航） -->
        <ul class="layui-nav layui-layout-left">
            <li class="layui-nav-item"><a href="">控制台</a></li>
            <li class="layui-nav-item"><a href="">商品管理</a></li>
            <li class="layui-nav-item"><a href="">用户</a></li>
            <li class="layui-nav-item">
                <a href="javascript:;">其它系统</a>
                <dl class="layui-nav-child">
                    <dd><a href="">邮件管理</a></dd>
                    <dd><a href="">消息管理</a></dd>
                    <dd><a href="">授权管理</a></dd>
                </dl>
            </li>
        </ul>
        <ul class="layui-nav layui-layout-right">
            <li class="layui-nav-item">
                <a href="javascript:;">
                    <img src="http://t.cn/RCzsdCq" class="layui-nav-img"/>
                    贤心
                </a>
                <dl class="layui-nav-child">
                    <dd><a href="">基本资料</a></dd>
                    <dd><a href="">安全设置</a></dd>
                </dl>
            </li>
            <li class="layui-nav-item"><a href="">退了</a></li>
        </ul>
    </div>

    <div class="layui-side layui-bg-black">
        <div class="layui-side-scroll">
            <!-- 左侧导航区域（可配合layui已有的垂直导航） -->
            <ul class="layui-nav layui-nav-tree"  lay-filter="test">
                <li class="layui-nav-item layui-nav-itemed">
                    <a class="" href="javascript:;">所有商品</a>
                    <dl class="layui-nav-child">
                        <dd><a href="javascript:;">列表一</a></dd>
                        <dd><a href="javascript:;">列表二</a></dd>
                        <dd><a href="javascript:;">列表三</a></dd>
                        <dd><a href="">超链接</a></dd>
                    </dl>
                </li>
                <li class="layui-nav-item">
                    <a href="javascript:;">解决方案</a>
                    <dl class="layui-nav-child">
                        <dd><a href="javascript:;">列表一</a></dd>
                        <dd><a href="javascript:;">列表二</a></dd>
                        <dd><a href="">超链接</a></dd>
                    </dl>
                </li>
                <li class="layui-nav-item"><a href="">云市场</a></li>
                <li class="layui-nav-item"><a href="">发布商品</a></li>
            </ul>
        </div>
    </div>

    <div class="layui-body">
        <!-- 内容主体区域 -->
        <div style="padding: 15px;">
            <div class="layui-btn-group toolBar">
                <button class="layui-btn" data-type="getCheckData">获取选中行数据</button>
                <button class="layui-btn" data-type="getCheckLength">获取选中数目</button>
                <button class="layui-btn" data-type="isAll">验证是否全选</button>
                <button class="layui-btn" data-type="add">添加</button>
                <button class="layui-btn" data-type="edit">修改</button>
                <button class="layui-btn" data-type="delete">删除</button>
            </div>
            <table id="demo" lay-filter="test"></table>
        </div>
    </div>

    <div class="layui-footer" style="display:none;">
        <!-- 底部固定区域 -->
        底部固定区域
    </div>
</div>

<div id="addOrUpdate" style="padding-top:30px;padding-right: 70px;display: none">
    <form id="addOrUpdateForm" class="layui-form">
        <input type="hidden" id="id" name="id">
        <div class="layui-form-item">
            <label class="layui-form-label">帐号</label>
            <div class="layui-input-block">
                <input type="text" id="account" name="account" lay-verify="title" autocomplete="off" placeholder="请输入帐号" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">密码</label>
            <div class="layui-input-block">
                <input type="password" id="password" name="password" placeholder="请输入密码" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">昵称</label>
            <div class="layui-input-block">
                <input type="text" id="username" name="username" lay-verify="title" autocomplete="off" placeholder="请输入昵称" class="layui-input">
            </div>
        </div>
    </form>
</div>

<script src="${springMacroRequestContext.contextPath}/vendor/layui/layui.js"></script>
<script type="text/html" id="timeTpl">
    {{ timeFormat(d.regtime) }}
</script>
<script>

//JavaScript代码区域
layui.use('element', function(){
    var element = layui.element;
});
// Table
var util;
var getListUrl = '${springMacroRequestContext.contextPath}/getUsers';
    layui.use(['table','util','layer'], function(){
        var table = layui.table;
        util = layui.util;
        //第一个实例
        table.render({
            elem: '#demo'
            ,cellMinWidth: 80 // 列宽自动分配
            ,height: 'full-200' //
            ,limits: [5, 15, 30]
            ,limit: 15 //每页默认显示的数量
            ,url: getListUrl //数据接口
            ,page: true //开启分页
            ,cols: [[ //表头
                {type:'checkbox'}
                ,{field: 'id', title: 'ID', align: 'center', sort: true}
                ,{field: 'account', title: '帐号', align: 'center', sort: true}
                ,{field: 'password', title: '密码', align: 'center', sort: true}
                ,{field: 'username', title: '用户名', align: 'center', sort: true}
                ,{field: 'regtime', title: '注册时间', align: 'center', sort: true, templet: '#timeTpl'}
            ]]
        });

        //监听表格复选框选择
        table.on('checkbox(demo)', function(obj){
            console.log(obj)
        });

        var $ = layui.$, active = {
            getCheckData: function(){ //获取选中数据
                var checkStatus = table.checkStatus('demo')
                        ,data = checkStatus.data;
                layer.alert(JSON.stringify(data));
            }
            ,getCheckLength: function(){ //获取选中数目
        var checkStatus = table.checkStatus('demo')
                ,data = checkStatus.data;
        layer.msg('选中了：'+ data.length + ' 个');
    }
            ,isAll: function(){ //验证是否全选
        var checkStatus = table.checkStatus('demo');
        layer.msg(checkStatus.isAll ? '全选': '未全选')
    },add: function(){ //添加
                var checkStatus = table.checkStatus('demo')
                        ,data = checkStatus.data;
                layer.open({
                        type: 1,
                        title: '添加用户',
                        area: ['400px', '300px'],
                        shadeClose: false, //点击遮罩关闭
                        content: $('#addOrUpdate'),
                        btn: ['确定', '取消'],
                        yes: function (index, layero) {
                            //$("#addOrUpdateForm").submit();
                            $.ajax({
                                type: 'POST',
                                url: '${springMacroRequestContext.contextPath}/addOrUpdate',
                                data: $('#addOrUpdateForm').serialize(),
                                //dataType: 'json',
                                success: function (data) {
                                    //layer.close(index);
                                    //layer.closeAll();
                                    //layer.msg('添加成功');
                                    layer.open({
                                        type: 1
                                        ,content: '<div style="padding: 20px 100px;">添加成功</div>'
                                        ,btn: '确定'
                                        ,btnAlign: 'c' //按钮居中
                                        ,shade: 0 //不显示遮罩
                                        ,yes: function(){
                                            layer.closeAll();
                                            window.location.href = '${springMacroRequestContext.contextPath}/';
                                        }
                                    });
                                },
                                error: function (jqXHR, textStatus, errorThrown) {
                                    /*弹出jqXHR对象的信息*/
                                    alert(jqXHR.responseText);
                                    alert(jqXHR.status);
                                    alert(jqXHR.readyState);
                                    alert(jqXHR.statusText);
                                    /*弹出其他两个参数的信息*/
                                    alert(textStatus);
                                    alert(errorThrown);
                                }
                            });


                        }
                    }
                );
            },edit: function(){ //修改
                var checkStatus = table.checkStatus('demo')
                        ,data = checkStatus.data;
                if(data.length != 1){
                    layer.msg('请选择一条数据');
                    return;
                }
                layer.open({
                        type: 1,
                        title: '添加用户',
                        area: ['400px', '300px'],
                        shadeClose: false, //点击遮罩关闭
                        content: $('#addOrUpdate'),
                        btn: ['确定', '取消'],
                        success: function(layero, index){
                            $.ajax({
                                type: 'POST',
                                url: '${springMacroRequestContext.contextPath}/findById',
                                data: {
                                    jsons : JSON.stringify(data)
                                },
                                dataType: 'json',
                                success: function (data) {
                                    //layer.msg(data.obj.id);
                                    $('#id').val(data.obj.id);
                                    $('#account').val(data.obj.account);
                                    $('#password').val(data.obj.password);
                                    $('#username').val(data.obj.username);
                                },
                                error: function (jqXHR, textStatus, errorThrown) {
                                    /!*弹出jqXHR对象的信息*!/
                                    alert(jqXHR.responseText);
                                    alert(jqXHR.status);
                                    alert(jqXHR.readyState);
                                    alert(jqXHR.statusText);
                                    /!*弹出其他两个参数的信息*!/
                                    alert(textStatus);
                                    alert(errorThrown);
                                }
                            });
                            //console.log(layero, index);
                        },
                        yes: function (index, layero) {
                            //$("#addOrUpdateForm").submit();
                            $.ajax({
                                type: 'POST',
                                url: '${springMacroRequestContext.contextPath}/addOrUpdate',
                                data: $('#addOrUpdateForm').serialize(),
                                //dataType: 'json',
                                success: function (data) {
                                    //layer.close(index);
                                    //layer.closeAll();
                                    //layer.msg('添加成功');
                                    layer.open({
                                        type: 1
                                        ,content: '<div style="padding: 20px 100px;">修改成功</div>'
                                        ,btn: '确定'
                                        ,btnAlign: 'c' //按钮居中
                                        ,shade: 0 //不显示遮罩
                                        ,yes: function(){
                                            layer.closeAll();
                                            window.location.href = '${springMacroRequestContext.contextPath}/';
                                        }
                                    });
                                },
                                error: function (jqXHR, textStatus, errorThrown) {
                                    /*弹出jqXHR对象的信息*/
                                    alert(jqXHR.responseText);
                                    alert(jqXHR.status);
                                    alert(jqXHR.readyState);
                                    alert(jqXHR.statusText);
                                    /*弹出其他两个参数的信息*/
                                    alert(textStatus);
                                    alert(errorThrown);
                                }
                            });
                        }
                    }
                );
            },delete: function(){ //是否删除
                var checkStatus = table.checkStatus('demo')
                        ,data = checkStatus.data;
                if(data.length < 1){
                    layer.msg('请选择一条以上数据');
                    return;
                }
                layer.confirm('真的删除行么', function(){
                    //layer.alert(JSON.stringify(data));
                    //layer.msg('删除了：'+ data.length + ' 个');
                    $.ajax({
                        type: 'POST',
                        url: '${springMacroRequestContext.contextPath}/delete',
                        data: {
                            jsons : JSON.stringify(data)
                        },
                        //dataType: 'json',
                        success: function (data) {
                            //layer.close(index);
                            //layer.closeAll();
                            //layer.msg('添加成功');
                            layer.open({
                                type: 1
                                ,content: '<div style="padding: 20px 100px;">删除成功</div>'
                                ,btn: '确定'
                                ,btnAlign: 'c' //按钮居中
                                ,shade: 0 //不显示遮罩
                                ,yes: function(){
                                    layer.closeAll();
                                    window.location.href = '${springMacroRequestContext.contextPath}/';
                                }
                            });
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            /*弹出jqXHR对象的信息*/
                            alert(jqXHR.responseText);
                            alert(jqXHR.status);
                            alert(jqXHR.readyState);
                            alert(jqXHR.statusText);
                            /*弹出其他两个参数的信息*/
                            alert(textStatus);
                            alert(errorThrown);
                        }
                    });
                });
            }
        };
        $('.toolBar .layui-btn').on('click', function(){
            var type = $(this).data('type');
            active[type] ? active[type].call(this) : '';
        });
    });

    // 时间格式化
    function timeFormat(t){
        return util.toDateString(t);
    }
</script>
</body>
</html>