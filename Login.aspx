<%@ page language="C#" autoeventwireup="true" inherits="Login, App_Web_0cuiirgj" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>抽奖登录
    </title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0;" />
    <meta content="yes" name="apple-mobile-web-app-capable" />
     
    <link href="css/bootstrap.min.css" rel="stylesheet" />
    <link href="css/NewGlobal.css" rel="stylesheet" />
     <script src="js/jquery-1.9.0.js"></script>
    <script type="text/javascript" src="js/zepto.js"></script>
  
    <script src="js/msgBox.js"></script>
    <script type="text/javascript">
        var msgBox = null;
        $(function () {
            msgBox = new MsgBox({ imghref: "/images/" });
            //$("#btnsub").click(function () {
            //    if (!checkValidate()) {
            //        return;
                  
            //    }
            //    alert("ok");
            //    var fomdata = $("#aspnetForm").serialize();

            //    //发送请求判断当前用户是否存在
            //    $.post("/LoginHander.ashx", "type=l&" + fomdata, function (obj) {
            //        switch (obj.statu) {
            //            case "y"://当前用户存在
            //                //msgBox.showMsgOk(obj.msg);
            //                alert(obj.msg);
            //                window.location = '/shark.aspx?' + fomdata;
            //                break;
            //            case "n"://当前用户不存在
            //                msgBox.showMsgOK(obj.msg);
            //                window.location = '/shark.aspx?' + fomdata;
            //                break;
            //        }


            //    }, "json");
            //});



        });

        function checkValidate() {
            var regPartton = /1[3-8]+\d{9}/;
            var isValidate = true;
            if ($("#uphone").val() == "") {
                msgBox.showMsgErr("手机号不能为空！");
                isValidate = false;
                $("#uphone").focus();
            } else if (!regPartton.test($("#uphone").val())) {

                msgBox.showMsgErr("输入的手机号码格式不正确！");
                isValidate = false;
                $("#uphone").focus();
            } else if ($("#uname").val() == "") {
                msgBox.showMsgErr("姓名不能为空！");
                isValidate = false;
                $("#uname").focus();
            }
            return isValidate;

        }
    </script>
</head>
<body>
    <div class="header">

        <div class="title" id="titleString">登陆</div>
    </div>
    <div class="container width80 pt20">
        <form id="aspnetForm" runat="server"  class="form-horizontal"  >



            <div>
            </div>
            <div class="control-group">
                手机号:<input name="uphone" type="text" id="uphone" runat="server" class="input width100 " style="background: none repeat scroll 0 0 #F9F9F9; padding: 8px 0px 8px 4px" placeholder="请输入手机号" />
            </div>
            <div class="control-group">
                姓名:<input name="uname" runat="server" type="text" id="uname" class="width100 input" style="background: none repeat scroll 0 0 #F9F9F9; padding: 8px 0px 8px 4px" placeholder="请输入姓名" />
            </div>
            <div class="control-group">
                
            </div>
            <div class="control-group">
                <span class="red"></span>
            </div>
            <div class="control-group">
                <asp:Button ID="btnsub" runat="server" Text="提交"  OnClientClick="return checkValidate();" style=" background:#6ac134; width:100%;height:100%; height:48px;" value="提交" OnClick="Button1_Click" />
              <%--  <input type="button" id="btnsub"   style=" background:#6ac134; width:100%;height:100%; height:48px;" value="提交" />--%>
            </div>
            <div class="control-group">
            </div>
            <div class="control-group">
            </div>
        </form>
    </div>


    <div class="footer">
    </div>

</body>
</html>

