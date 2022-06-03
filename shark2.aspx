<%@ page language="C#" autoeventwireup="true" inherits="shak2, App_Web_0cuiirgj" %>



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
    <script>
        if (location.href.indexOf('radio.unitrue.com.cn') >= 0) {
            location.replace(location.href.replace("radio.unitrue.com.cn", "112.124.38.246"));
        }
        //
    </script>
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
            //alert(document.documentElement.clientHeight);
            //$("#prizelist").css("top", magrintop + "px");

        }

        $(function () {
            //if (0 == 0) {
            //    $("#prize2").css("visibility", "hidden");
            //}
            //if (0 == 0) {
            //    $("#prize3").css("visibility", "hidden");
            //}


            ajustPosition();
            $(document).on('ajaxBeforeSend', function (e, xhr, options) {


            }).on("ajaxComplete ", function (e, xhr, options) {
                $("#loading").hide();
            });

            //if ('13865933462' != '') {
            //    $("#listheader").html('<p >我的中奖纪录</p>');
            //}
            //else {
            //    var bindurl = '/radio/common/bind.aspx?openid=' + queryString("openid") + "&radioid=" + queryString("radioid") + "&redirect=radio/common/shake.aspx?lid=" + queryString("lid");
            //    $("#listheader").html('<p >我的中奖纪录</p><p id="fillinfo" style="font-size:1.2em ;height:40px"><a href="' + bindurl + '" style="color:orange">填写领奖信息></a></p>');
            //}

            if ('' == '') {
                alert("亲,欢迎您参加我们的摇一摇抽奖活动奥！~~~");
                return;
            }

            try {
                document.addEventListener('WeixinJSBridgeReady', function onBridgeReady() {
                    WeixinJSBridge.call('hideToolbar');

                });
            }
            catch (e) {
            }



            ////活动介绍数据
            //var hdinfojson = JSON.parse('{"ID":null,"bRepeat":null,"beginDate":null,"bigdraw":null,"endDate":null,"followUrl":null,"icon":null,"listCard":null,"listVote":null,"maxVote":null,"otherNames":null,"payitem":null,"queryitem":null,"stoped":null,"summary":null,"tabBlocks":null,"tabNames":null,"tabNum":0,"tel":null,"title":null,"titleBG":null,"type":null,"url":null}');
            //// var ddd="1、抽奖时间：<br/>";  
            ////var hdinfojson = JSON.parse('{"bigdraw":{"desc":"1、抽奖时间：<br\/>     11月10日20：00——11月11日24：00；<br\/>2、每人每天只有一次抽奖机会哦；<br\/>3、凭微信中奖信息领奖；<br\/>4、领奖时间：<br\/>     11月12日——11月17日；<br\/>5、领奖地址：<br\/>     河北人民广播电台（石家庄市裕华东路63号）","num1":"5","num2":"15","num3":"50","title1":"点频收音机+992车生活有声杂志","title2":"点频收音机","title3":"992车生活有声杂志","total":"10000"},"endDate":"2013-11-12 00:00:00","icon":"http:\/\/2.unitrue.com.cn\/radio\/FM992\/hd\/Resources\/Images\/hd_icon.png","listVote":null,"maxVote":null,"summary":"双\"11\"购物，再便宜也要花钱！ 河北交通广播微信，不花钱，也能中奖！ 动动手指，试试你的运气吧！","tabBlocks":[[{"items":[{"content":"抽奖活动只有一个页面，请设置活动属性后，双击下方的抽奖图片进入抽奖内容编辑","type":"Text"}],"title":""},{"items":null,"title":"spBigdraw"}]],"tabNames":["抽奖配置"],"tabNum":1,"title":"992开始抽奖","titleBG":"","type":"bigdraw","url":null}');  

            //var h = hdinfojson.bigdraw.desc;

            //h = h.replace("\u000a", "aa");


            //$("#desc").html(h);


        });
        // var isdown = true;
        // $("#prizelist").bind("click",
        //  function () {
        //      if (isdown) {
        //          isdown = false;
        //          $("#dragbtn").attr("src", "images/shake_report_dragger_down_normal.png");
        //          $("#dragbtn").css("display", "inline");
        //          $("#shakeInfo").css("display", "none");
        //          $("#prizelist").animate({
        //              top: "0px"
        //          }, 500, function () {
        //              getPrizeList();
        //          });
        //      }
        //      else {
        //          isdown = true;
        //          $("#dragbtn").attr("src", "images/shake_report_dragger_up_normal.png");
        //          $("#dragbtn").css("display", "inline");
        //          $("#shakeInfo").css("display", "block");
        //          var magrintop = 0;
        //          if (navigator.userAgent.indexOf('iPhone') > -1) {

        //              magrintop = document.documentElement.clientHeight - 115;
        //          }
        //          else {

        //              magrintop = document.documentElement.clientHeight - 52;
        //          }

        //          $("#prizelist").animate({
        //              top: magrintop + "px"
        //          }, 500, function () {

        //          });


        //      }

        //  }

        //);
        // var isshow = false;
        // $("#shakeInfo").bind("click",
        //   function () {

        //       if (isshow) {
        //           isshow = false;

        //           $("#shakeInfo").animate({
        //               right: "-250px"
        //           }, 500, function () {
        //           });
        //       }
        //       else {
        //           isshow = true;
        //           var magrintop = document.documentElement.clientHeight - 52;

        //           $("#shakeInfo").animate({
        //               right: "15px"
        //           }, 500, function () {

        //           });


        //       }

        //   }

        // );


        //$("#save-btn").bind("click",
        //function () {

        //    $("#result").slideToggle(500);
        //    $("#outercont").slideDown(500);
        //});
        var shaking = false;
        function shaked() {
            if (shaking) {
                return;
            }

            if (lastDate != null) {

                var dateEnd = new Date();
                var dateDiff = dateEnd.getTime() - lastDate.getTime();
                if (dateDiff / 1000 < 180) {
                    alert("亲，您这次已摇过了，请锁定广播等待主持人宣布开始哦~");
                    return;
                }

            }
            shaking = true;
            prize = 0;
            $("#audio").get(0).load("images/shake_sound.mp3");
            $("#audio").get(0).play();


            $("#halftop").animate({
                top: "-100px"

            }, 1000, function () {
                $("#halftop").animate({ top: "0px" }, function () {
                    var time = Math.floor(Math.random() * 5 + 1);
                    $("#loading").show();
                    setTimeout("getShakeResult()", time * 1000);
                    //getShakeResult();
                });
            });

            $("#halfbottom").animate({
                top: $("#halfbottom").offset().top + 100 + "px"

            }, 1000, function () {
                $("#halfbottom").animate({ top: "50%" });
            });

            // $("#halftop").css("-webkit-animation","topani 2s");

        }



    </script>

    <script type="text/javascript">
        var prize = 0;
        var lastDate = null;
        function getShakeResult() {


            if (lastDate != null) {
                var dateEnd = new Date();
                var dateDiff = dateEnd.getTime() - lastDate.getTime();
                if (dateDiff / 1000 < 180) {
                    alert("亲，您这次已摇过了，请锁定广播等待主持人宣布开始哦~");
                    shaking = false;
                    return;
                }

            }


            $.ajax({
                type: "POST",
                url: "/service/startShake.ashx",
                dataType: "json",
                contentType: "application/x-www-form-urlencoded; charset=utf-8",
                data: {
                    openid: "oEG8FjwFna0vLYxfq1OSjTeG5vWo",
                    lotteryid: "49upvzdfb2",
                    radioid: "FM1041",
                    comopenid: queryString("comopenid")
                },
                beforeSend: function () {

                },
                success: function (data) {
                    shaking = false;
                    $("#loading").hide();
                    if (data.Err_code == "1") {

                        alert("亲，您这次已摇过了哦，下次再来吧!");



                    }
                    else if (data.Err_code == "2") {
                        alert("亲，你已经中过奖了哦~");
                        prize = data.Err_msg;


                    }
                    else if (data.Err_code == "3") {
                        alert("亲，您需要先绑定基本信息哦~");



                    }
                    else if (data.Err_code == "5") {
                        alert("对不起，本次活动仅限于手机微信终端哦~");


                    }
                    else if (data.Err_code == "7") {
                        alert("对不起，必须从我们的官方微信直接获得抽奖链接才能抽奖哦~");


                    }
                    else if (data.Err_code == "4") {
                        alert("亲您打开的是已结束活动页面，请重新获取最新摇一摇活动哦~~~");


                    }
                    else if (data.Err_code == "6") {
                        alert('亲您来早啦，活动还没开始哦~');


                    }
                    else if (data.Err_code == "8") {
                        alert("亲您太着急啦~请锁定广播, 等待主持人宣布开始哦~");


                    }
                    else if (data.Err_code == "0") {
                        lastDate = new Date();

                        alert("感谢参与，请注意收听主持人开奖哦~");

                    } else {
                        alert("感谢参与，请注意收听主持人开奖哦~");
                    }
                    running = false;

                },
                error: function () {
                    $("#loading").hide();
                    shaking = false;
                    //  alert("亲前方人太多，偶木有挤进去，请再摇一下吧~");
                    alert("感谢参与，请注意收听主持人开奖哦~");
                    running = false;

                },
                timeout: 30000
            })
        }
        //返回指定位数的数字，长度不足则在前面补零
        function padLeft(str, lenght) {
            if (str.length >= lenght)
                return str;
            else
                return padLeft("0" + str, lenght);
        }
        function getPrizeList() {


            $.ajax({
                type: "GET",
                url: "/service/GetLotteryResultList.ashx",
                dataType: "json",
                contentType: "application/x-www-form-urlencoded; charset=utf-8",
                data: {
                    openid: "oEG8FjwFna0vLYxfq1OSjTeG5vWo",
                    hdid: "",
                    radioid: "FM1041"
                },
                beforeSend: function () {

                },
                success: function (json) {

                    var l = json.length;

                    if (l == 0) {

                        $(".list").html('<div class="loadding">还没有中奖纪录，继续加油哦！</div>');
                        return;
                    }

                    var h = "";
                    for (var i = 0; i < l; i++) {
                        var title = json[i].hdname;
                        var prize = json[i].prize;
                        var prizename = "：" + json[i].prizeName;
                        if (prizename == "：null" || prizename == "：") {
                            prizename = "";
                        }
                        //  var date = json[i].time;  

                        //  var date =eval('new ' + eval(json[i].time).source) ;                    

                        // var time =padLeft((date.getMonth()+1)+"",2)+"-"+padLeft(date.getDate()+"",2)+" "+padLeft(date.getHours()+"",2)+":"+padLeft(date.getMinutes()+"",2);

                        h += '<li > <div class="item-intro">';
                        h += '<h3 style="">' + title + ' </h3>';

                        h += '<p style="color:gray; margin:0px 0px 0px"> <span style="color:red">' + prize + '等奖' + prizename + '</span><span style="color:gray;float: right;">' + json[i].time + ' </span></p>';
                        h += '</div></li>';
                    }
                    $(".list").html(h);

                },
                error: function () {

                },
                timeout: 5000
            });
        }
        function DeleteParam(url, name) {
            var i = url;
            var reg = new RegExp("([&\?]?)" + name + "=[^&]+(&?)", "g")

            var newUrl = i.replace(reg, function (a, b, c) {
                if (c.length == 0) {
                    return '';
                } else {
                    return b;
                }
            });
            return newUrl;
        }
        var href = DeleteParam(location.href, 'openid');;//分享时要去掉分享人的openid，否则别人会以他的名义操作
        href = DeleteParam(href, 'comopenid');;//分享时要去掉分享人的openid，否则别人会以他的名义操作

        var dataForWeixinimgurl = "";
        dataForWeixinimgurl = dataForWeixinimgurl.replace("\"", "“");
        var dataForWeixintitle = "";
        dataForWeixintitle = dataForWeixintitle.replace("\"", "“");
        var dataForWeixinsummary = '';
        dataForWeixinsummary = dataForWeixinsummary.replace("\"", "“");

        var dataForWeixin = {
            appId: "",
            MsgImg: 'images/shakelogo.png',
            TLImg: 'images/shakelogo.png',
            url: href,
            title: dataForWeixintitle,
            desc: dataForWeixinsummary + "-fmRADIO8",
            fakeid: "",
            callback: function (type) { _$('/service/sharedLog.ashx?radioid=' + queryString("radioid") + '&openid=' + queryString("openid") + '&url=' + encodeURIComponent(location.href) + '&type=' + type, "", ""); }
        };


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
                    shaked();
                }
                last_x = x;
                last_y = y;
                last_z = z;


            }

        }
    </script>
</body>
</html>

