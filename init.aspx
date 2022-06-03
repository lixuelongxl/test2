<%@ page language="C#" autoeventwireup="true" inherits="init, App_Web_0cuiirgj" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta name="Generator" content="Arc WebSoft" />
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>友通抽奖系统</title>
    <script src="js/jquery-1.9.0.js"></script>
    <script src="js/msgBox.js"></script>
    <link href="images/ini.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="images/co.js"></script>
    <script type="text/javascript">
        var msgBox = null;
        var arr = new Array();    
        $(function () {
            msgBox = new MsgBox({ imghref: "/images/" });
            $.post("/LoginHander.ashx", "type=q", function (obj) {
                // alert(obj.responseText);
                //alert(obj.length+obj);
                switch (obj.statu)
                {
                    case "ok":
                       // alert(obj.data.length);
                        GetName(obj.data);
                        m_name = arr;
                        //alert(namearr);
                        break;
                }
                //alert(obj);
                //namearr = obj.split(',');
                //alert(namearr.length);
                //for (var i ; i < namearr.length; i++)
                //{
                //    alert(namearr[i]);
                //}
            }, "json");

            function GetName(data) {
                for (var i = 0; i < data.length; i++) {
                    var item = data[i];
                    arr[i] = item.uname;
                }

            }

            //点击开始按钮加载事件
            $("#start").click(function () {
               // alert(namearr.length);
                m_name = arr;
                $.post("/ChouJiang.ashx", "type=s", function (obj) {
                    //  alert("ok");
                    switch (obj.statu) {
                        case "err":

                            break;
                        case "ok":
                            //    msgBox.showMsgOk(obj.msg);

                            break;
                    }

                }, "json");

            });
            //点击停止按钮加载事件
            $("#login").click(function () {
                // m_name = namearr;
                m_name = arr;
                $.post("/ChouJiang.ashx", "type=t", function (obj) {
                    // alert("ok");
                    switch (obj.statu) {
                        case "err":

                            break;
                        case "ok":
                            // msgBox.showMsgOk(obj.msg);

                            break;
                    }

                }, "json");

            });
        });
    </script>
    <script type="text/JavaScript">
        /*--------------------------------------------
          程序编写：张坤  美工：陈银萍 
          调试策划：友通数码港网络部
          交流邮箱: arc.zhang@ytsmg.com  arc@archn.cn
          --------------------------------------------*/

        //====  参数配置区域 ↓ ================================================================

        var m = [1,20];//按号码范围抽 m_name必须为[];
        //var m_name = ["大乔", "小乔", "张辽", "孙权", "关羽", "曹操", "诸葛亮", "周瑜", "司马懿", "杨志", "鲁智深", "孙尚香","张三","王思","张天","王妃"];//人员名单 本数组有值“号码范围”自动失效
        var m_name = arr;
        //var m_name;
        var r = [1, 2, 3];//奖品分组数量
        var r_name = ["一等奖", "二等奖奖", "三等奖"];//奖品分组名称
        window.rep = 0; //是否允许号码重复出现
        window.obo = 1; //一次抽一（组0/个1）
        window.arr = []; //排除号码数组 例子 [0,1,2,3,4]

        //==================================================================================
        ////////////////////////////////////////////////////////////////////////////////////////
        //----以下静态代码已被优化，结构请勿破坏有js关联事件，非专业研究者请勿修改
    </script>
</head>
<body scroll="no" style="background-color: #2C0001" onload="group()">
    <div class="oneOut">
        <div></div>
    </div>
    <div class="OFF" title="关闭本程序" onclick="closeie()">关闭</div>
    <div class="Top">
        <div id="Go">
            <fieldset class="MainBG">
                <div id="Main">
                    <h2 class="title">加载奖项...</h2>
                    <div class="input">列表加载...</div>
                </div>
                <div id="input">
                    <input id="start" name="start" type="button" value="开始(空格)" />
                    <input id="end" name="end" type="button" value="停止(空格)" />
                    <input id="login" name="login" type="button" value="下一组(回车)" />
                </div>
            </fieldset>
        </div>
        <div id="out">
            <fieldset>
                <legend>中奖结果 </legend>
                <ul id="tableOUT">
                    <li style="display: none"></li>

                </ul>

            </fieldset>

        </div>
    </div>
    <div class="End" align="center">
        <ul></ul>
    </div>
</body>
</html>
