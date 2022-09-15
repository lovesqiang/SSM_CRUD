
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--引入JSTL核心标签库--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--<%@page isELIgnored="false" %>--%>

<%-- web路径问题
    不以/开始的路径为相对路径，找资源以当前资源的路径为基准，容易出现问题
    以/开始的路径为绝对路径，找资源从服务器根路径【http://localhost:8080】为标准
--%>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 上述3个meta标签必须放在最前面，任何其他内容都必须跟随其后！ -->

    <%--  request.getContextPath() : 获取项目名称，以【/】开始，不以【/】结尾 --%>
    <% pageContext.setAttribute("APP_PATH", request.getContextPath()); %>

    <title>员工列表</title>



    <!--  引入Jquery  -->
    <script type="text/javascript" src="${APP_PATH}/static/js/jquery-3.4.1.min.js"></script>

    <!--  bootstrap  -->
    <link href="${APP_PATH}/static/bootstrap-3.4.1-dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="${APP_PATH}/static/bootstrap-3.4.1-dist/js/bootstrap.min.js"></script>

</head>
<body>

<!-- Modal:修改模态框 -->
<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">新增员工</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <!-- 员工姓名 -->
                    <div class="form-group">
                        <label class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="empName_update_static">empName</p>
                            <span  class="help-block"></span>
                        </div>
                    </div>
                    <!-- 员工邮件 -->
                    <div class="form-group">
                        <label class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input name="email" type="text" class="form-control" id="email_update" placeholder="king@qiang.com">
                            <span  class="help-block"></span>
                        </div>
                    </div>
                    <!-- 员工性别 默认：男 -->
                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="update_gender1" value="M" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="update_gender2" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <!-- 部门列表 -->
                    <div class="form-group">
                        <label class="col-sm-2 control-label">dId</label>
                        <div class="col-sm-4">
                            <select class="form-control" name="dId" id="dept_update_btn">

                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="save_update_btn">更新</button>
            </div>
        </div>
    </div>
</div>


<!-- Modal:新增模态框 -->
<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">新增员工</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <!-- 员工姓名 -->
                    <div class="form-group">
                        <label class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <input name="empName" type="text" class="form-control" id="empName_add" placeholder="Name">
                            <span  class="help-block"></span>
                        </div>
                    </div>
                    <!-- 员工邮件 -->
                    <div class="form-group">
                        <label class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input name="email" type="text" class="form-control" id="email_add" placeholder="king@qiang.com">
                            <span  class="help-block"></span>
                        </div>
                    </div>
                    <!-- 员工性别 默认：男 -->
                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="add_gender1" value="M" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="add_gender2" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <!-- 部门列表 -->
                    <div class="form-group">
                        <label class="col-sm-2 control-label">dId</label>
                        <div class="col-sm-4">
                            <select class="form-control" name="dId" id="dept_add_btn">

                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="save_emp_btn">保存</button>
            </div>
        </div>
    </div>
</div>


<div class="container">
    <!-- 项目标题SSM-CRUD -->
    <div class="row">
        <div class="col-md-12">
            <h1>SSM-CRUD</h1>
        </div>
    </div>
    <!-- 两个按钮：新增、删除 -->
    <div class="row">
        <div class="col-md-4 col-md-offset-8">
            <button class="btn btn-primary" id="emp_add_model_btn">新增</button>
            <button class="btn btn-danger" id="emp_delete_all_btn">删除</button>
        </div>
    </div>
    <!-- 员工信息 -->
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover table-bordered" id="emps_table" >
                <thead>
                    <tr>
                        <th>
                            <input type="checkbox" id="check_all"/>
                        </th>
                        <th>编号</th>
                        <th>姓名</th>
                        <th>性别</th>
                        <th>电子邮件</th>
                        <th>部门</th>
                        <th>操作</th>
                    </tr>
                </thead>
                <tbody>

                </tbody>


            </table>
        </div>
    </div>
    <!-- 分页信息 -->
    <div class="row">
        <!--  分页文字的信息  -->
        <div class="col-md-6" id="page_info_area">

        </div>
        <!--  分页条的信息  -->
        <div class="col-md-6" id="page_nav_area">

        </div>
    </div>

    <script type="text/javascript">

        var total_end;  //  用于添加数据时，跳转到最后一页
        var currentPage;    //当前第几页

        $(function () {
            //一进入页面，到首页
            to_page(1)
        });

        function to_page(pn) {
            $.ajax({
                url:"${APP_PATH}/emps",
                data:"pn="+pn,
                type:"GET",
                success: function (result) {    //result表示服务器返回给浏览器的【json】数据
                    // console.log(result)
                    // 解析并显示员工数据
                    build_emps_table(result);
                    //解析分页信息
                    bulid_page_info(result)
                    //解析并显示分页条
                    bulid_page_nav(result)
                }
            })
        }

        function build_emps_table(result) {
            //清空table数据
            $("#emps_table tbody").empty()
            var emps = result.data.pageInfo.list;   //获取所有的员工数据
            //遍历员工
            $.each(emps,function (index, item) {
                //alert(item.empName)
                let checkBoxTd = $("<td><input type='checkbox' class='check_item'/></td>");
                let empIdTd = $("<td></td>").append(item.empId);
                let empNameTd = $("<td></td>").append(item.empName);
                let genderTd = $("<td></td>").append(item.gender == 'M' ? "男" : "女");
                let emailTd = $("<td></td>").append(item.email);
                let deptNameTd = $("<td></td>").append(item.department.deptName);
                let editBtn = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
                    .append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("编辑");
                //为编辑按钮添加一个自定义的属性，来表示当前员工id
                 editBtn.attr("edit-id", item.empId);
                let delBtn = $("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
                    .append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("删除");
                 delBtn.attr("del-id", item.empId);
                let btnTd = $("<td></td>").append(editBtn).append(" ").append(delBtn);
                //append方法执行完成以后还是会返回原来的元素
                $("<tr></tr>").append(checkBoxTd).append(empIdTd).append(empNameTd).append(genderTd).append(emailTd)
                    .append(deptNameTd).append(btnTd).appendTo("#emps_table tbody");


            })
        }


        function bulid_page_info(result) {
            //清空table数据
            $("#page_info_area").empty()
            //1.获取有关分页的信息
            var pageInfo = result.data.pageInfo
            //2.将数据显示到页面上
            $("#page_info_area").append("当前第" + pageInfo.pageNum+"  页,总共 "+pageInfo.pages+" 页,总共 "+pageInfo.total+" 条记录")

            total_end = result.data.pageInfo.total
            currentPage = result.data.pageInfo.pageNum

        }

        function bulid_page_nav(result) {
            //清空table数据
            $("#page_nav_area").empty()
            //构建一个ul
            var ul = $("<ul></ul>").addClass("pagination")

            //构建首页的一个<li></li>
            var firstPageLi =  $("<li></li>").append($("<a></a>").append("首页").attr("href","#"))    //attr():用来添加属性
            var prePageLi =  $("<li></li>").append($("<a></a>").append("&laquo;"))
            if(result.data.pageInfo.hasPreviousPage == false){  //没有上一页，不能点击首页和上一页
                firstPageLi.addClass("disabled")
                prePageLi.addClass("disabled")
            }else {
                firstPageLi.click(function () {
                    to_page(1)
                })

                prePageLi.click(function () {
                    to_page(result.data.pageInfo.pageNum-1)
                })
            }



            //将li添加到ul
            ul.append(firstPageLi).append(prePageLi)

            //构建页码1、2、3、4
            $.each(result.data.pageInfo.navigatepageNums,function (index,page_num) {
                var numPageLi =  $("<li></li>").append($("<a></a>").append(page_num))
                if(result.data.pageInfo.pageNum == page_num){
                    numPageLi.addClass("active")
                }
                numPageLi.click(function () {       //不要写成onclick
                    to_page(page_num)
                })
                ul.append(numPageLi)
            })

            var nextPageLi =  $("<li></li>").append($("<a></a>").append("&raquo;"))
            var lastPageLi =  $("<li></li>").append($("<a></a>").append("末页").attr("href","#"))    //attr():用来添加属性
            if(result.data.pageInfo.hasNextPage == false){  //没有下一页，不能点击首页和上一页
                nextPageLi.addClass("disabled")
                lastPageLi.addClass("disabled")
            }else{
                nextPageLi.click(function () {
                    to_page(result.data.pageInfo.pageNum+1)
                })

                lastPageLi.click(function () {
                    to_page(result.data.pageInfo.pages)
                })
            }

            ul.append(nextPageLi).append(lastPageLi)

            //构建一个nav
            var nav = $("<nav></nav>")

            //将ul添加到nav标签中
            nav.append(ul)

            //将nav添加到要显示的div中
           nav.appendTo("#page_nav_area")
        }
        
        //清空表单样式及内容
        function reset_form(ele) {
            $(ele)[0].reset();
            //清空表单样式
            $(ele).find("*").removeClass("has-error has-success")
            //清空表单的辅助信息
            $(ele).find(".help-block").text("")
        }


        //点击新增按钮弹出模态框
        $("#emp_add_model_btn").click(function () {
            //清除表单中的数据(表单完整重置（表单数据、表单样式）)
            //$("#empAddModal form")[0].reset();  //jQuery中没有reset()方法，该方法dom中有
            reset_form("#empAddModal form")

            //发送一个Ajax请求，将部门信息显示到下拉列表中
            getDepts("#dept_add_btn");

            $("#empAddModal").modal({
                    backdrop:"static"
            }
            )
        })

        function getDepts(ele) {
            //清空select中的数据
            $("#dept_add_btn").empty();
            $.ajax({
                url: "${APP_PATH}/depts",
                type: "GET",
                success:function (result) {     //result就是服务器返回给浏览器部门数据
                    //console.log(result)
                    //显示部门信息在下拉列表中
                    $.each(result.data.depts,function () {
                        //构建一个option标签
                        var optionEle = $("<option></option>").append(this.deptName).attr("value",this.deptId);
                        //将optionEle添加到select 标签中
                        optionEle.appendTo(ele)
                    })
                }
            })
        }
        
        
        function show_validate_msg(ele, status, msg) {
            //清除当前元素的校验状态
            $(ele).parent().removeClass("has-error", "has-success")     //到这些控件的父元素即可
            $(ele).next("span").text("");
            if(status == "success"){
                $(ele).parent().addClass("has-success")
                $(ele).next("span").text(msg)
            }else if(status == "error"){
                $(ele).parent().addClass("has-error")
                $(ele).next("span").text(msg)
            }
        }
        

        //校验表单数据的方法
        function volidate_add_from() {
            //校验用户名
            //1.获取文本框中empName的值
            var empName = $("#empName_add").val();
            //2.empName的校验正则表达式
            var regName = /(^[a-zA-Z0-9_-]{3,16}$)|(^[\u2E80-\u9FFF]{2,10})/;
            if(!regName.test(empName)){
                //alert("用户名格式不正确")
                //$("#empName_add").parent().addClass("has-error")
                //$("#empName_add").next().text("用户名格式错误")
                show_validate_msg("#empName_add","error","用户名格式错误")
                return false;   //如果校验不通过，返回false
            }else{
                //$("#empName_add").parent().addClass("has-success")
                //$("#empName_add").next().text(" ")
                show_validate_msg("#empName_add","success","")
            }

            //校验邮箱
            //1、获取输入框中的邮箱
            var email = $("#email_add").val()
            //2、email的校验正则表达式
            var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/
            if(!regEmail.test(email)){
                //alert("邮箱格式不正确")
                //$("#email_add").parent().addClass("has-error")
                //$("#email_add").next().text("邮箱格式错误")
                show_validate_msg("#email_add","error","邮箱格式错误")
                return false;
            }else {
                //$("#email_add").parent().addClass("has-success")
                //$("#email_add").next().text(" ")
                show_validate_msg("#email_add","success","")
            }
            return true;
        }


        //检验用户名是否重复
        $("#empName_add").change(function () {
            var empName = this.value;
            $.ajax({
                url:"${APP_PATH}/changeName",
                type:"GET",
                data:"empName="+empName,    //this.value表示输入框中的值，不要写成this.value(),不要忘记【=】
                success:function (result) {
                    if (result.code == 200) {
                        show_validate_msg("#empName_add", "success", "用户名可用");
                        $("#save_emp_btn").attr("ajax-va", "success");  //给保存按钮添加一个属性
                    } else {
                        show_validate_msg("#empName_add", "error", result.data.va_msg);
                        $("#save_emp_btn").attr("ajax-va", "error");
                    }

                }
            })
        })


        //点击保存员工数据
        $("#save_emp_btn").click(function () {
            //alert($("#empAddModal form").serialize())   //将表单数据字符串化

            
            //对用户名和邮箱的校验
            if(!volidate_add_from()){
                return false;
            }

            //检验用户名是否重复
            if($("#save_emp_btn").attr("ajax-va") == "error"){  //如果按钮为error,则不进行下面的操作
                return false;
            }

            //发送Ajax请求保存员工
            $.ajax({
                url:"${APP_PATH}/emp",
                type:"POST",
                data:$("#empAddModal form").serialize(),
                success:function (result) {
                    //alert(result.msg);

                    if(result.code == 200){
                        //自动关闭模态框
                        $('#empAddModal').modal('hide')
                        //来到最后一页
                        to_page(total_end)
                    }else {
                        //显示失败信息
                        if(undefined != result.data.errorFields.email){
                            //显示邮件的错误信息
                            show_validate_msg("#email_add", "error", result.data.errorFields.email);
                        }
                        if(undefined != result.data.errorFields.empName){
                            //显示名字的错误信息
                            show_validate_msg("#empName_add", "error", result.data.errorFields.empName);
                        }
                    }
                }
            })
        })

        //给编辑按钮绑定一个单击事件
        //我们是按钮创建之前就绑定了click，所以绑定不上
        //1.可以在创建的时候绑定  2.绑定点击.live()
        //jQuery新版没有live，使用on进行替代
        $(document).on("click",".edit_btn",function () {
            //清空select中的数据
            $("#dept_update_btn").empty();
            //1.查出部门信息，并显示列表
            getDepts("#empUpdateModal select")
            //2.显示员工信息
            getEmp($(this).attr("edit-id"))
            //把员工的id传递给模态框的更新按钮
            $("#save_update_btn").attr("edit-id",$(this).attr("edit-id"))
            //4.弹出模态框
            $("#empUpdateModal").modal({
                backdrop: "static"
            })
        })

        function getEmp(id) {
            //发送Ajax请求向服务器要员工数据
            $.ajax({
                url:"${APP_PATH}/emp/"+id,
                type:"GET",
                success:function (result) {
                    var empData = result.data.emp;
                    $("#empName_update_static").text(empData.empName);
                    $("#email_update").val(empData.email);
                    $("#empUpdateModal input[name=gender]").val([empData.gender]);  //少了[],导致展示性别一直为默认值
                    $("#empUpdateModal select").val(empData.dId);
                }
            });
        }

        //点击更新按钮，更新员工数据
        $("#save_update_btn").click(function () {

            //1.验证邮箱是否合法
            //校验邮箱
            //1、获取输入框中的邮箱
            var email = $("#email_update").val()
            //2、email的校验正则表达式
            var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/
            if(!regEmail.test(email)){
                show_validate_msg("#email_update","error","邮箱格式错误")
                return false;
            }else {
                show_validate_msg("#email_update","success","")
            }

            //发送Ajax请求，保存数据
            $.ajax({
                url:"${APP_PATH}/emp/"+$(this).attr("edit-id"),
                // type:"POST",
                // data:$("#empUpdateModal form").serialize()+"&_method=PUT",
                type:"PUT",
                data:$("#empUpdateModal form").serialize(),
                success:function (result) {
                    //关闭模态框
                    $("#empUpdateModal").modal("hide")

                    //返回当前页
                    to_page(currentPage)
                }
            })

        })

        //单个删除
        $(document).on("click",".delete_btn",function () {   //动态创建出来的(使用函数添加的样式)使用on
            //alert($(this).parents("tr").find("td:eq(1)").text())
            var empName = $(this).parents("tr").find("td:eq(2)").text();
            var empId = $(this).attr("del-id");     //$(this)表示当前点击的按钮
            if(confirm("确认删除【"+empName+"】吗？")){     //confirm():表示确认框
                //确认，发送Ajax请求删除员工
                $.ajax({
                    url:"${APP_PATH}/emp/"+empId,
                    type:"DELETE",
                    success:function (result) {
                        //回到当前页
                        to_page(currentPage)
                    }
                })
            }
        })

        //完成全选和全不选
        $("#check_all").click(
            function () {
                //$(this).prop("checked")   全选按钮的状态：true 、 false
                $(".check_item").prop("checked",$(this).prop("checked"));   //让每个按钮的"checked"属性值和全选按钮的"checked"的属性值相同
            }
        )

        //check_item  : 每个元素都选中，全选按钮也选中
        $(document).on("click",".check_item",function () {
            //判断是否全选
            var  flag= $(".check_item:checked").length == $(".check_item").length;
            $("#check_all").prop("checked",flag);   //true表示选中 ， false表示未选中
        })

        //点击删除，进行批量删除
        $("#emp_delete_all_btn").click(function () {
            var empNames = "";
            var delstr = "";
            $.each($(".check_item:checked"),function () {
                empNames += $(this).parents("tr").find("td:eq(2)").text()+",";
                delstr +=  $(this).parents("tr").find("td:eq(1)").text()+"-";
            });
            empNames = empNames.substring(0,empNames.length-1)
            delstr = delstr.substring(0,empNames.length-1)
            if (confirm("确认删除【"+empNames+"】吗")){
                //发送ajax进行批量删除
                $.ajax({
                    url:"${APP_PATH}/emp/"+delstr,
                    type:"DELETE",
                    success:function (result) {
                        to_page(currentPage)
                    }
                })
            }
        })


    </script>

</div>
</body>
</html>
