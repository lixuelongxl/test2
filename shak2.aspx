<%@ page language="C#" autoeventwireup="true" inherits="shak2, App_Web_3onrd2db" %>

<!DOCTYPE html>

<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=320px,height=device-height,inital-scale=1.0,maximum-scale=1.0,user-scalable=no;">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="description" content="@fmRADIO8">
    <meta name="format-detection" content="telephone=no">
    <title></title>
    <link href="css/activity-style.css" rel="stylesheet" />
    <script src="js/jquery-1.9.1.min.js"></script>
    <script src="js/alert.js"></script>
    <script src="js/jquery-1.9.0.js"></script>
    <script src="js/msgBox.js"></script>
    <script src="js/Common.js"></script>
    <style>
        @-webkit-keyframes topani /* Safari 和 Chrome */
        {
            0% {
                top: 0px;
            }

            50% {
                top: -100px;
            }

            100% {
                top: 0px;
            }
        }

        .list li {
            overflow: hidden;
            display: block;
            padding: 2px;
            border-bottom: 1px dotted #000;
        }

        .item-time {
            float: right;
            width: 75px;
            text-align: center;
            height: 60px;
            line-height: 60px;
            color: white;
            font-size: 80%;
            opacity: 0.5;
        }

        .item-intro {
            color: #F8F8F8;
            margin-left: 5px;
            margin-top: 2px;
            margin-bottom: 5px;
            text-align: left;
        }

            .item-intro h3 {
                font-size: 110%;
                font-weight: bold;
                margin-bottom: 0px;
                width: 95%;
                white-space: nowrap;
                word-break: keep-all;
                overflow: hidden;
                color: #3B577D;
            }

            .item-intro p {
                color: black;
                font-size: 100%;
                opacity: 0.8;
                width: 100%;
            }

        #shakeInfo p {
            color: white;
        }

        .loading-mask {
            width: 100%;
            height: 200%;
            position: fixed;
            background: rgba(0,0,0,0.6);
            z-index: 1000;
            left: 0;
            top: 0;
            display: none;
        }

            .loading-mask img.gimg {
                display: block;
                margin: 160px auto 0;
            }
    </style>
    <script type="text/javascript" src="js/fmradio8common.js">
    </script>
   <%-- <script>
        if (location.href.indexOf('radio.unitrue.com.cn') >= 0) {
            location.replace(location.href.replace("radio.unitrue.com.cn", "112.124.38.246"));
        }
        //
    </script>--%>
</head>
<body class="activity-lottery-winning" style="background: #1d1d1d no-repeat top;">
    <div class="main1" style="height: 100%; position: fixed; width: 100%; position: fixed; text-align: center; background: #1d1d1d; text-align: center;">

        <img id="shakehideimg" src="images/shakehideimg.png" style="width: 320px;" />

        <div id="halftop" style="text-align: center; height: 50%; background: #4c4c4c; width: 100%; position: fixed; top: 0px;">
            <div style="position: relative; height: 100%; width: 100%; text-align: center;">
                <img id="halftopimg" src="images/shake_logo_up.png" style="position: absolute; bottom: 0px; display: block; margin: auto; width: 124px;" />
            </div>
        </div>



        <div id="halfbottom" style="text-align: center; height: 50%; background: #4c4c4c; width: 100%; top: 50%; position: fixed;">
            <img id="halfbottomimg" src="images/shake_logo_down.png" style="width: 124px;" />
        </div>





        <div id="loading" class="loading-mask">
            <img class="gimg" src="images/ajax-loader.gif">
        </div>
        <div id="prizelist" style="width: 100%; position: fixed; top: 10000px">
            <img id="dragbtn" src="images/shake_report_dragger_up_normal.png" />
            <img src="images/shake_line_up.png" style="width: 100%; height: 8px; position: relative; top: -15px; z-index: 100;" />
            <div style="height: 1000px; background-color: #F8F8F8; top: -25px; position: relative;">
            </div>
        </div>

     
    </div>



    <audio id="audio" preload="auto" src="images/shake_sound.mp3"></audio>
    <script type="text/javascript">
        var msgBox = null;
        function ajustPosition() {
            var clientWidth = document.body.clientWidth < 500 ? document.body.clientWidth : document.body.clientWidth / 2;
            var clientHeight = document.documentElement.clientHeight < 600 ? document.documentElement.clientHeight : document.documentElement.clientHeight / 2;
            var magrinleft = (clientWidth - 124) / 2;
            //  alert(document.documentElement.clientWidth);
            $("#halftopimg").css("margin-left", magrinleft + "px");
            var magrintop = (clientHeight - 320) / 2 + 20;

            $("#shakehideimg").css("margin-top", magrintop + "px");

            if (navigator.userAgent.indexOf('iPhone') > -1) {

                magrintop = clientHeight - 115;
            }
            else {

                magrintop = clientHeight;
            }


        }

        $(function () {
            msgBox = new MsgBox({ imghref: "/images/" });
            ajustPosition();
            $(document).on('ajaxBeforeSend', function (e, xhr, options) {


            }).on("ajaxComplete ", function (e, xhr, options) {
                $("#loading").hide();
            });
            alert("亲,欢迎您参加我们的摇一摇抽奖活动奥！~~~");


        });

        var shaking = false;
        
        function shaked() {
            // 增加判断 判断主持人当前是否抽奖开始了
            // alert("ok1");
            //$.post("/ChouJiang.ashx","type=q", function (obj) {

            //    alert("ok2");
            //    switch (obj.statu) {
            //        case "s":
            //            msgBox.showMsgOk(obj.msg);
            //            break;
            //        case "t":
            //            alert("ok3");
            //            msgBox.showMsgOk(obj.msg);
            //            return false;
            //            break;
            //    }
            //},"json");
            //alert("o3");
            AjaxHelper.doPost("/ChouJiang.ashx", "type=q", true, function (xhrObj) {
                var res = xhrObj.responseText;
                var jsondata = JSON.parse(res);
                // alert("1");
                if (jsondata.statu == "t") {
                   // alert(jsondata.msg + jsondata.statu);
                    sharnum = 0;
                    alert("亲!别急奥,请等待主持人宣布开始!");
                    // return;
                   // shaking = true;

                } else {

                    if (shaking) {
                        return;
                    }

                    if (lastDate != null) {

                        var dateEnd = new Date();
                        var dateDiff = dateEnd.getTime() - lastDate.getTime();
                        if (dateDiff / 1000 < 180) {
                            alert("亲，您这次已摇过了，请锁定广播等待主持人宣布开始哦~");
                           // return;
                        }

                    }
                    shaking = true;
                    prize = 0;
                   // alert("ok");
                    $("#audio").get(0).load("images/shake_sound.mp3");
                    $("#audio").get(0).play();


                    $("#halftop").animate({
                        top: "-100px"

                    }, 1000, function () {
                        $("#halftop").animate({ top: "0px" }, function () {
                            var time = Math.floor(Math.random() * 5 + 1);
                            $("#loading").show();
                            // setTimeout("getShakeResult()", time * 1000);
                            getShakeResult();
                        });
                    });

                    $("#halfbottom").animate({
                        top: $("#halfbottom").offset().top + 100 + "px"

                    }, 1000, function () {
                        $("#halfbottom").animate({ top: "50%" });
                    });

                     
                }

            });

            //if (shaking) {
            //    return;
            //}

            //if (lastDate != null) {

            //    var dateEnd = new Date();
            //    var dateDiff = dateEnd.getTime() - lastDate.getTime();
            //    if (dateDiff / 1000 < 180) {
            //        alert("亲，您这次已摇过了，请锁定广播等待主持人宣布开始哦~");
            //        return;
            //    }

            //}
            //shaking = true;
            //prize = 0;
            //$("#audio").get(0).load("images/shake_sound.mp3");
            //$("#audio").get(0).play();


            //$("#halftop").animate({
            //    top: "-100px"

            //}, 1000, function () {
            //    $("#halftop").animate({ top: "0px" }, function () {
            //        var time = Math.floor(Math.random() * 5 + 1);
            //        $("#loading").show();
            //       // setTimeout("getShakeResult()", time * 1000);
            //        getShakeResult();
            //    });
            //});

            //$("#halfbottom").animate({
            //    top: $("#halfbottom").offset().top + 100 + "px"

            //}, 1000, function () {
            //    $("#halfbottom").animate({ top: "50%" });
            //});

            // $("#halftop").css("-webkit-animation","topani 2s");

        }



    </script>

    <script type="text/javascript">
        var prize = 0;
        var lastDate = null;
        var sharnum = 0;
        function getShakeResult() {
            //$("#audio").get(0).load("images/shake_sound.mp3");
            //$("#audio").get(0).play();
            $("#loading").hide();
            shaking = false;
            var name = '<%=uname%>';
            var phone = '<%=uphone%>';
            alert("接着使劲摇啊摇~!\n"+name+"你摇了" +sharnum+"次了,加油奥！");

           

        }
        if (window.DeviceMotionEvent) {
            window.addEventListener('devicemotion', deviceMotionHandler, false);
        }
            //手机不支持摇一摇
        else {
            $("#halfbottom").bind("click",
              function () {
                  shaked();
              }

            );
            $("#halftop").bind("click",
              function () {
                  shaked();
              }

            );
            alert("亲您的手机不支持摇一摇，您可以直接点击屏幕中间的图案参与抽奖");
        }


        var SHAKE_THRESHOLD = 400;
        var lastUpdate = 0;

        var x, y, z, last_x, last_y, last_z;

        var canShake = 1; //Gorden 130718,  

        function deviceMotionHandler(eventData) {
            var acceleration = eventData.accelerationIncludingGravity;

            var curTime = new Date().getTime();
            if ((curTime - lastUpdate) > 200) {

                var diffTime = (curTime - lastUpdate);
                lastUpdate = curTime;

                x = acceleration.x;
                y = acceleration.y;
                z = acceleration.z;

                var speed = Math.abs(x + y + z - last_x - last_y - last_z) / diffTime * 8000;


                if (speed > SHAKE_THRESHOLD && canShake == 1) {//Gorden 130718
                    canShake = 0;//Gorden 130718
                    setTimeout('canShake=1', 2000)//Gorden 130718
                    sharnum = sharnum + 1;
                    //if (!GameStart()) {
                    //    msgBox.showMsgErr("请耐心等待主持人宣布开始奥！");
                    //    return;
                    //} else {
                    //    shaked();
                    //}
                    // window.location.reload();
                    shaked();
                }
                last_x = x;
                last_y = y;
                last_z = z;


            }

        }

        function GameStart() {
            var istart = true;
            AjaxHelper.doPost("/ChouJiang.ashx", "type=q", true, function (xhrObj) {
                var res = xhrObj.responseText;
                var jsondata = JSON.parse(res);
                switch (jsondata.statu) {
                    case "t":
                        istart = false;

                        break;
                    case "s":

                        break;

                }
            });
            return istart;
        }

            </script>
</body>
</html>