// JavaScript代码区域
layui.use('element', function(){
    var element = layui.element;
});
// Table
var util;
var getListUrl = contextPath + '/getUsers';
layui.use(['table','util','layer'], function(){
    var table = layui.table;
    util = layui.util;
    // 第一个实例
    table.render({
        elem: '#demo',
        id: 'demo'
        // 列宽自动分配
        ,cellMinWidth: 80
        ,height: 'full-200'
        ,limits: [5, 15, 30]
        ,limit: 15
        ,url: getListUrl
        // 开启分页
        ,page: true
        ,cols: [[
            {type:'checkbox'}
            ,{field: 'id', title: 'ID', align: 'center', sort: true}
            ,{field: 'account', title: '帐号', align: 'center', sort: true}
            ,{field: 'password', title: '密码', align: 'center', sort: true}
            ,{field: 'username', title: '用户名', align: 'center', sort: true}
            ,{field: 'regtime', title: '注册时间', align: 'center', sort: true}
        ]]
    });

    // 监听表格复选框选择
    table.on('checkbox(demo)', function(obj){
        console.log(obj);
    });

    var $ = layui.$, active = {
        // 获取选中数据
        getCheckData: function(){
            var checkStatus = table.checkStatus('demo')
                ,data = checkStatus.data;
            layer.alert(JSON.stringify(data));
        }
        // 获取选中数目
        ,getCheckLength: function(){
            var checkStatus = table.checkStatus('demo')
                ,data = checkStatus.data;
            layer.msg('选中了：'+ data.length + ' 个');
        }
        // 验证是否全选
        ,isAll: function(){
            var checkStatus = table.checkStatus('demo');
            layer.msg(checkStatus.isAll ? '全选': '未全选')
        }
    };
    $('.toolBar .layui-btn').on('click', function(){
        var type = $(this).data('type');
        active[type] ? active[type].call(this) : '';
    });

    /**
     * 添加
     */
    $("#addRow").on("click", function () {
        layer.open({
            type: 1,
            title: '添加用户',
            area: ['400px', '300px'],
            // 点击遮罩关闭
            shadeClose: false,
            content: $('#addOrUpdate'),
            btn: ['确定', '取消'],
            yes: function (index, layero) {
                // $("#addOrUpdateForm").submit();
                layer.close(index);
                $.ajax({
                    type: 'POST',
                    url: contextPath + '/addOrUpdate',
                    data: $('#addOrUpdateForm').serialize(),
                    // dataType: 'json',
                    success: function (data) {
                        // layer.close(index);
                        // layer.closeAll();
                        layer.msg('添加成功');
                        /*layer.open({
                            type: 1
                            ,content: '<div style="padding: 20px 100px;">添加成功</div>'
                            ,btn: '确定'
                            // 按钮居中
                            ,btnAlign: 'c'
                            // 不显示遮罩
                            ,shade: 0
                            ,yes: function(){
                                layer.closeAll();
                                window.location.href = contextPath + '/';
                            }
                        });*/
                        // 重新加载表格
                        table.reload('demo', {
                            page: {
                                // 重新从第1页开始
                                curr: 1
                            }/*,where: {
                            key: {
                                id: demoReload.val()
                            }
                        }*/
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
        });
    });

    /**
     * 修改
     */
    $("#editRow").on("click", function () {
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
            // 点击遮罩关闭
            shadeClose: false,
            content: $('#addOrUpdate'),
            btn: ['确定', '取消'],
            success: function(layero, index){
                $.ajax({
                    type: 'POST',
                    url: contextPath + '/findById',
                    data: {
                        jsons : JSON.stringify(data)
                    },
                    dataType: 'json',
                    success: function (data) {
                        // layer.msg(data.obj.id);
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
                // console.log(layero, index);
            },
            yes: function (index, layero) {
                layer.close(index);
                $.ajax({
                    type: 'POST',
                    url: contextPath + '/addOrUpdate',
                    data: $('#addOrUpdateForm').serialize(),
                    // dataType: 'json',
                    success: function (data) {
                        layer.msg('修改成功');
                        // 重新加载表格
                        table.reload('demo', {
                            page: {
                                // 重新从第1页开始
                                curr: 1
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
        });
    });

    /**
     * 删除
     */
    $("#deleteRow").on("click", function () {
        var checkStatus = table.checkStatus('demo')
            ,data = checkStatus.data;
        if(data.length < 1){
            layer.msg('请选择一条以上数据');
            return;
        }
        layer.confirm('真的删除行么', function(){
            // layer.alert(JSON.stringify(data));
            // layer.msg('删除了：'+ data.length + ' 个');
            $.ajax({
                type: 'POST',
                url: contextPath + '/delete',
                data: {
                    jsons : JSON.stringify(data)
                },
                // dataType: 'json',
                success: function (data) {
                    layer.msg('删除成功');
                    // 重新加载表格
                    table.reload('demo', {
                        page: {
                            // 重新从第1页开始
                            curr: 1
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
    });

});