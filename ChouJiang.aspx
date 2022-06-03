<%@ page language="C#" autoeventwireup="true" inherits="ChouJiang, App_Web_5sdikb0r" %>

<!DOCTYPE html>
<html>
<head>
	<title>香港华锋实业有限公司 2012年会抽奖系统</title>
	<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
	<style type="text/css">
		body{background:url(images/BG_01.jpg) no-repeat center top; color:white;font-weight:bold; width:100%;}
		.main{width:880px; height:250px;margin:0 auto;padding-top:10px;position:relative;
			background:none; top:250px;border:1px solid #b6ff00;

		}
		.main .ra-list{position:absolute;top:-15px;right:10px;}
		.main .ra-list i{color:yellow;}
		.mian .current-div{width:800px;height:200px;margin:0 auto;}
		#current{width:900px;height:150px;border:none;background:none;display:block;margin:0 auto;
			font-size:90px;font-weight:bold;color:white;text-align:center;margin-left:-20px;
		}
		#texes{display:block;width:800px;height:50px;border:none;background:none;margin:0 auto;
			font-size:40px;font-weight:bold;color:white;text-align:center;
		}
		#start{display:inline-block;width:337px;height:180px;background:url() no-repeat left top;
			position:absolute;bottom:-200px;left:0px;text-indent:-9999px;
		}
		#stop{display:inline-block;width:337px;height:180px;background:url() no-repeat left top;
			position:absolute;bottom:-200px;right:0px;text-indent:-9999px;
            left: 543px;
        }
		#list-phones{width:900px;height:200px;margin:0 auto;overflow:hidden;font-size:30px;font-weight:bold;
			text-align:center;position:absolute;top:20px;left:0px;
		}
		input{outline:none;}
	   
        </style>
      <script src="js/jquery-1.9.0.js"></script>
<script type="text/javascript">
    var timer;
    var randnum;
    var cellnum = 1;
    //定义一个存放手机号码的数组
    var mobile = new Array();
    $(function () {
        var phones;
        var list_phones;
          
        //加载列表数据
        $.post("/LoginHander.ashx", "type=q", function (obj) {
            alert(obj);
        }, "text");
        //生成表格数据
        function MakeData(data)
        {  
            for (var i = 0; i < data.length;i++)
            {
                list_phones += data[i].uname+"\t\t"+data[i].uphone+"<br/>";
   
            }
            
        }

        //$.ajax({
        //    url: './get_set.php',
        //    type: 'POST',
        //    dataType: 'text',
        //    data: { 'action': 'get' },
        //    success: function (data) {
        //        if (data && data != '') {
        //            phones = data;
        //            phones = phones.split(',');
        //            //开始将参与名单滚动

        //            for (var j = 0; j < phones.length; j++) {
        //                list_phones += phones[j] + '<br />';
        //            }
                   
        //            //alert($('#list-phones').html());
        //            //alert($('.list-div').height());
        //        }
        //    }
        //});

        //list-phones : height=3162 - 200;

        var list_phones_h = 0;
        var list_start = setInterval(
			function () {
			    if (parseInt($('.list-div').position().top) < -2962) {
			        $('.list-div').animate({ top: 0 });
			        list_phones_h = 0;
			    }
			    $('.list-div').animate({ top: '-' + list_phones_h + 'px' }, function () { list_phones_h += 34; });


			}, 1000
		);

        //各奖项数量
        var ran0 = 1; 	//特等奖1名
        var ran1 = 2; 	//一等奖2名
        var ran2 = 5; 	//二等奖5名
        var ran3 = 15; 	//三等奖15名
        var ran4 = 50; 	//四等奖50名
        var ran5 = 5; 	//幸运奖5名


        var start;

        //中奖名单
        var $s = '';
        //奖项
        var jx;
        //是否开始
        var flag = false;

        $('#start').click(function () {
            start_chou();
        });

        $('#stop').click(function () {
            stop_chou();
        });

        $(window).bind('keydown', function (event) {
            if (event.keyCode === 32) {
                !flag ? start_chou() : stop_chou();
            }
        });

        //开始抽奖
        function start_chou() {
            if (phones.length == 0) {
                $('#texes').val('error: 都抽完了，没有可参与的抽奖名单了！');
                $('#current').val('');
                return;
            }
            //关闭滚动
            clearInterval(list_start);
            $('#list-phones').detach();
            jx = $("input[name='jx']:checked").val();
            if (!jx || jx == '') {
                $('#texes').val('您还没有设置本次抽奖奖项！');
                return;
            }

            //中奖名单显示框清空
            $('#current').val('');
            $('#texes').val('正在随机抽取，请耐心等待......');

            if (!flag) {
                switch (jx) {

                    case 'tex':
                        //判断该奖项是否已抽完
                        if (ran0 <= 0) {
                            $('#texes').val('特等奖已抽完了！');
                            return;
                        } else {
                            ran0 -= 1;
                        }
                        break;
                    case 'one':
                        //判断该奖项是否已抽完
                        if (ran1 <= 0) {
                            $('#texes').val('一等奖已抽完了！');
                            return;
                        } else {
                            ran1 -= 1;
                        }
                        break;
                    case 'two':
                        //判断该奖项是否已抽完
                        if (ran2 <= 0) {
                            $('#texes').val('二等奖已抽完了！');
                            return;
                        } else {
                            ran2 -= 1;
                        }
                        break;
                    case 'three':
                        //判断该奖项是否已抽完
                        if (ran3 <= 0) {
                            $('#texes').val('三等奖已抽完了！');
                            return;
                        } else {
                            ran3 -= 1;
                        }
                        break;
                    case 'four':
                        //判断该奖项是否已抽完
                        if (ran4 <= 0) {
                            $('#texes').val('四等奖已抽完了！');
                            return;
                        } else {
                            ran4 -= 1;
                        }
                        break;
                    case 'five':
                        //判断该奖项是否已抽完
                        if (ran5 <= 0) {
                            $('#texes').val('幸运奖已抽完了！');
                            return;
                        } else {
                            ran5 -= 1;
                        }
                        break;
                }


                flag = true;
                setTimeout(function () {
                    start = setInterval(function () {
                        $('#rrss').val(function () {
                            var len = phones.length;
                            var rand = Math.floor(Math.random() * len);
                            //console.log(rand);
                            return phones[rand];
                        });
                        $('#current').val(Math.floor(Math.random() * 100000000000000000));
                    }, 1);
                }, 500);
            }
        }

        //停止抽奖
        function stop_chou() {
            if (flag) {
                flag = false;
                clearInterval(start);
                $('#current').val($('#rrss').val());
                if (jx === 'tex') {
                    $s += '特等奖：  ' + $('#current').val() + ',';
                    $('#texes').val('特等奖！');
                } else if (jx === 'one') {
                    $s += '一等奖：  ' + $('#current').val() + ',';
                    $('#texes').val('一等奖！');
                } else if (jx === 'two') {
                    $s += '二等奖：  ' + $('#current').val() + ',';
                    $('#texes').val('二等奖！');
                } else if (jx === 'three') {
                    $s += '三等奖：  ' + $('#current').val() + ',';
                    $('#texes').val('三等奖！');
                } else if (jx === 'four') {
                    $s += '四等奖： ' + $('#current').val() + ',';
                    $('#texes').val('四等奖！');
                } else if (jx === 'five') {
                    $s += '幸运奖： ' + $('#current').val() + ',';
                    $('#texes').val('幸运奖！');
                } else {
                    $s += '';
                    $('#texes').val('您还没有设置本次抽奖奖项！');
                }
                //本次抽奖完成后，自动移出本次获奖名单，不参与之后的抽奖
                getIndex(phones, $('#current').val());
                //将获奖名单写入到rs.txt文件中,记录获奖名单
                set($s);

                //alert($s);
            }
        }


        function getIndex(arr, val) {
            var index = -1;
            for (var i = 0; i < arr.length; i++) {
                if (arr[i] == val)
                    index = i;
            }
            arr.splice(index, 1);
            //alert(index);
        }

        //将中奖信息写入
        function set(rs) {
            $.ajax({
                url: 'get_set.php',
                type: 'POST',
                dataType: 'text',
                data: { 'action': 'set', 'rs': rs },
                success: function (data) { return true; }
            });
        }

        $(document).ready(function () {
            $(window).bind('keydown', function (event) {
                if (event.keyCode === 37 || event.keyCode === 38) {
                    window.location.href = 'index.html';
                }
            });
        });

    });
</script>
</head>

<body oncontextmenu="window.event.returnValue=false;">
	<script type="text/javascript">
	    document.oncontextmenu = function () { return false; }
	    document.onselectstart = function () { return false; }
	</script>
	<div class="main">
         <div>请选择奖项:<input type="radio" id="r0" class="ra" name="jx" value="tex"/>特等奖
			<input type="radio" id="r1" class="ra" name="jx" value="one" />一等奖
			<input type="radio" id="r2" class="ra" name="jx" value="two" />二等奖
			<input type="radio" id="r3" class="ra" name="jx" value="three" />三等奖
			<input type="radio" id="r4" class="ra" name="jx" value="four" />四等奖
			<input type="radio" id="r5" class="ra" name="jx" value="five" />幸运奖</div>
		<table style="width:100%;height:100%">
             <tr><td>

              
			请选择奖项：
			
		
                 </td>
                 <td>
          
                 </td>

             </tr>
            <tr>

                <td>	<div class="current-div">
			
			<div id="list-phones">
                   

			</div>
		</div></td>
            </tr>

		<tr>
          <td colspan="2"><input type="button"  value="开始" id="start"/>
        <input type="button" value="停止" id="stop" /></td>

		</tr>
		
	  
		<%--<a id="start" href="javascript:void(0);">开始抽奖</a>
		<a id="stop" href="javascript:void(0)">停止</a>--%>
        
            </table>
	</div>
  
    <div id="info" style="">

cfgfdsfdsf

    </div>
</body>
</html>