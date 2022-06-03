<%@ page language="C#" autoeventwireup="true" inherits="_Default, App_Web_0cuiirgj" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
   
    <title></title>
    <script src="js/jquery-1.9.0.js"></script>
    <script src="js/jquery.tmpl.js"></script>
    <script src="js/msgBox.js"></script>
    
    <script type="text/javascript">
        var timer;
        var randnum;
        var cellnum = 1;
        //定义一个存放手机号码的数组
        var mobile = new Array();
        var msgBox = null;
        //根据获得的随机数从而显示出随机的手机号码
        function getRandNum() {
            var num = mobile.length - 1;//数组的"最大下标"是"数组长度减一"
            document.getElementById("result").value = mobile[GetRnd(0, num)];//调用"GetRnd"随机函数
           // document.getElementById("res").value = mobile[GetRnd(0, num)];
             
        }

        //获得随机数
        function GetRnd(min, max) {
            randnum = parseInt(Math.random() * (max - min + 1));//其中"parseInt"是将随机数转换成整数
            return randnum;
        }

        //点击"开始"按钮->需调用的函数
        function setTimer() {
            timer = setInterval("getRandNum();", 5);//过0.01秒就执行一次"getRandNum"函数,随机显示手机号码
            document.getElementById("btnstart").disabled = true;//点击开始时->开始按钮变灰色
            document.getElementById("btnstop").disabled = false;//停止按钮可以使用
        }

        //点击"停止"按钮->需调用的函数
        function clearTimer() {
            noDupNum();//调用"noDupNum"函数,移除显示的手机号码
            clearInterval(timer);//取消赋值给"timer"间隔要执行的函数
            document.getElementById("btnstart").disabled = false;//开始按钮可以使用
            document.getElementById("btnstop").disabled = true;//点击停止时->停止按钮变灰色
        }

        //移除那些出现过的手机号码
        function noDupNum() {
            mobile.removeEleAt(randnum);//点击"停止"按钮出现的号码给移除
            var o = 0;
            for (p = 0; p < mobile.length; p++) {
                if (typeof mobile[p] != "undefined") {//其中"typeof"是返回"mobile[p]"的类型,有"number","string","boolean" "object","function"和"undefined"这6种返回类型,用字符串来显示
                    mobile[o] = mobile[p];
                    o++;
                }
            }
            num = mobile.length - 1;//移除一个号码时,其"数组长度减一"重新赋值给"数组下标"
        }
        Array.prototype.removeEleAt = function (dx) {
            if (isNaN(dx) || dx > this.length) {
                return false;
            }
            this.splice(dx, 1);//其中"splice"是从dx开始一个一个移除
        }

        //将随机产生的手机号码显示到中奖区域
        function setValues() {
            document.getElementById(cellnum).value = document.getElementById("result").value;
            cellnum++;//从1开始递增到50的文本框ID,这里是从"三等奖"开始显示
        }

        $(function () {
            msgBox = new MsgBox({ imghref: "/images/" });
            $("#light").css("display","none");
            $.post("/LoginHander.ashx", "type=q", function (obj) {
                //定义抽奖数组
                mobile = obj.split(',');
                //alert(mobile.length);
            }, "text");
           
            //var jx = $("input[name='jx']:checked").val();
            //if (!jx || jx == '') {
            //    alert("请您设置当前所抽奖项！");
            //    return;
            //}

            //点击开始按钮加载事件

           
            $("#btnstart").click(function () {
                // alert(namearr.length);
                //m_name = arr;
                var jx = $("input[name='jx']:checked").val();
                if (!jx || jx == '') {
                    msgBox.showMsgErr("请您设置当前所抽奖项！");
                    return;
                }
                $.post("/ChouJiang.ashx", "type=s", function (obj) {
                    //  alert("ok");
                    switch (obj.statu) {
                        case "err":

                            break;
                        case "ok":
                           //   msgBox.showMsgOk(obj.msg);

                            break;
                    }

                }, "json");
                setTimer();
                document.getElementById('light').style.display = 'none';
               

            });
            //点击停止按钮加载事件
            $("#btnstop").click(function () {
                // m_name = namearr;
               
                $.post("/ChouJiang.ashx", "type=t", function (obj) {
                    // alert("ok");
                     switch (obj.statu) {
                          case "err":

                            break;
                          case "ok":
                         //    msgBox.showMsgOk(obj.msg);
                            
                            break;
                    }

                }, "json");
                clearTimer();
                document.getElementById('light').style.display = 'block';
                var s=document.getElementById('result').value + $("input[name='jx']:checked").val();
                document.getElementById('light').innerHTML = "恭喜!" + "</br>" + document.getElementById('result').value + "<br/>获得" + $("input[name='jx']:checked").val();
                //"<br/>获得" + $("input[name='jx']:checked").val(); + '<a href = "javascript:void(0)" onclick = "document.getElementById(\'light\').style.display=\'none\';">关闭本窗口</a>';
                //document.getElementById('light').innerText = "sdfdsf";
                // window.location.reload();
                var phone = document.getElementById('result').value;
                var jiangci = $("input[name='jx']:checked").val();
              //  alert(phone + jiangci);
                $.post("/ChouJiang.ashx", "type=d&phone=" + phone + "&jiangci="+jiangci, function (obj) {
                    // alert("ok");
                    switch (obj.statu) {
                        case "err":

                            break;
                        case "ok":
                            //    msgBox.showMsgOk(obj.msg);

                            break;
                    }

                }, "json");
            });


        });

        function doClick()
        {
            alert("ok");
        }


        ////加载消息表格
        //function makeTable(tbData) {
        //    //调用 jq模版对象 的 模版方法，遍历数组 tbData 为每个数组元素 生成模版里的 html元素 并追加到 表格 msgList中
        //      $("#tmplMsg").tmpl(tbData).appendTo("#con1");
        //     $("#tmplMsg").tmpl(tbData).appendTo("#con2");
        //}
    </script>
    <style type="text/css">
             
        body{background:url(images/bg1.jpg) center top; height:650px; color:white;font-weight:bold; width:100%;}
		.main{width:880px; height:350px;margin:0 auto;position:relative;
			   background:none; top:250px;margin-left:50px;
               
               
          
		}

        .head {
        
          width:880px; height:30px;margin:0 auto;position:relative;padding-top:10px;
			background:none; top:0px;border:0px solid #b6ff00;text-align:right;
        }
        .content {
         
            width:880px; height:328px;position:relative;
			background:none;border:0px solid #b6ff00;text-align:right; 
           border:0px solid #b6ff00;
        }

        .left {
              float:left; width:148px; height:100%; 
              border:0px solid #b6ff00;
             }
        .cen {
            float:left;
            
            width:480px;
            height:100%;
            text-align:center;
             vertical-align: middle;
             
        }
        .right {
           float:right; width:248px;
            height:100%;
            border:0px solid orange;
        
        }
        #btnlist {

         margin-left:0px;
         list-style:none;
         text-align:center;
         margin-top:50px;
        
        }
       #btnlist li{

         margin-left:0px;
        
        
        }
        .auto-style1 {
            height: 20px;
        }
        #info{
           margin-left:auto;
           margin-right:auto;
           border:1px solid #ffd800;
           background-color:yellow;
           width:150px;
           height:80px;
           z-index:9999;
           position:absolute;
        }
      
        .white_content { 
            display: none; 
            position: absolute; 
            top:400px; 
            margin-left:280px;
            width: 290px; 
            height: 140px; 
            padding: 20px; 
            font-family:'雅黑';
            font-size:40px;
            font-weight: bold;
            text-align:center;
            color:orange;
            border: 10px solid orange; 
            background-color:white; 
            z-index:1002; 
            overflow: auto; 
             -moz-opacity: 0.5; 
            opacity:.50; 
            filter: alpha(opacity=88);
        } 
    </style>
   
</head>
<body>
     <div id="main" class="main">
         <div id="head" class="head">
            请选择奖项:<%--<input type="radio" id="r0" class="ra" name="jx" value="特等奖"/>特等奖--%>
			<input type="radio" id="r1" class="ra" name="jx" value="一等奖"  />一等奖
			<input type="radio" id="r2" class="ra" name="jx" value="二等奖" />二等奖
			<input type="radio" id="r3" class="ra" name="jx" value="三等奖" />三等奖
			<%--<input type="radio" id="r4" class="ra" name="jx" value="四等奖" />四等奖--%>
			<%--<input type="radio" id="r5" class="ra" name="jx" value="幸运奖" />幸运奖</div>--%>
         <div id="content" class="content" >
                <div id="left" class="left">
                     <ul id="btnlist"  >
                         <li><input  type="button" value="开始"  id="btnstart" style="width:120px;height:60px; margin-left:0px; ruby-align:left;font-size:25px;font-weight:bold; font-family:'雅黑';" />

                          </li>
                         <li style="margin-top:25px;" ><input  type="button" value="停止" id="btnstop" style="width:120px;height:60px;font-size:25px;font-weight:bold;"/></li>
                      <%--    <li style="margin-top:25px;" ><input  type="button" value="清空数据" id="Button1" style="width:120px;height:60px;font-size:25px;font-weight:bold;"/></li>--%>

                     </ul>
                 

                </div> 
                <div id="cen" class="cen">
                 <input  id="result"  type="text" style="width:320px;height:40px;font-size:40px;font-family:STKaiti
; text-align :center;margin-top:50px;font-weight:bold;left:60px;" value="XXXXXXXXXXX"/> 
                   <div  id="light"   style="width:100%;height:180px;font-size:50px;font-family:'雅黑'
; text-align :center;margin-top:30px;font-weight:bold;text-align:center;vertical-align:middle;  font-weight: bold; text-align:center; color:red;" ></div>
            
                 </div>
                 <div id="right" class="right">
                  <marquee id="marque" ruant="server" onmouseover="this.stop()" onmouseout="this.start()"    direction="up" 
 scrollamount="4" style="text-align:left;margin-top:0px; height:320px" >
<br />
                  <table id="con1" style="width:100%;height:100%">
                      <asp:Repeater ID="userlist" runat="server">
                          <ItemTemplate>
                              <tr>
                                  <td  style="text-align:center;font-size:23px;height:20px;font-weight: bold;font-family:'雅黑';color:orange;"><%#Eval("uphone")%></td><td style="text-align:center;font-size:23px;height:20px;font-weight: bold;font-family:'雅黑';color:orange;"><%#Eval("uname")%></td><td></tr>

                          </ItemTemplate>

                      </asp:Repeater>
                       
                      </table>
                      </marquee>
              
               </div>
             </div>
         </div>
     <%--<div id="light" class="white_content">
           <font style="font-size:20px;"></font>
         </div> 
         --%>
</body>
</html>
