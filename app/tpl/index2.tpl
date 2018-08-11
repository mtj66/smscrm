<title>smscrm</title>
<code>
	<main>
	
	<div id="right">
		<div class="modal fade" tabindex="-1" role="dialog" id="sms">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title">发送短信</h4>
      </div>
      <div class="panel-body">
      	{{smstxt2}}
      </div>
      	<li class="list-group-item" ng-repeat="item in smsOrders">
      		<span class="pull-right" ng-if="item.smsok">发送完成</span>
      		{{item.customer_phone}}

      		{{item.customer_name}}
      	</li> 
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" ng-click="sendSmsSubmit(sending=true)" ng-disabled="sending"><span ng-if="sending">正在</span>发送</button>
      </div> 
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

	<div class="panel panel-default">
      <div class="panel-heading">
      系统正在自动运行并同步数据，无需F5<!-- 
      <span style="color:red" ng-if="doing" ng-bind="doing"></span> -->
  </div>
<div class="panel-body">
	<!-- <button type="button" class="btn btn-danger btn-block" ng-click="excel('ta')">导出今日已完成数据(共{{(orders|filter:{state:40}).length}}条)</button>
	<hr> -->
	<!-- <input type="checkbox" ng-false-value='' ng-true-value="40" ng-model="$root.states">仅显示已完成{{$root.states}} -->

	<div class="btn-group btn-group-sm">
		<a href="#" class="btn"  ng-class="{'btn-warning': teamid==0, 'btn-default': teamid!=0}" ng-click="showOrder(0)">全部</a>
		<a ng-repeat="team in teams" class="btn" ng-class="{'btn-warning': teamid==team.teamId, 'btn-default': teamid!=team.teamId}" ng-click="showOrder(team.teamId)" style="height: 66px">
		{{team.teamName}}
<br>
<span ng-if="kpi[team.teamId]">好评{{kpi[team.teamId]}}%</span>
<br>
<span ng-if="count[team.teamId]>=0">完成{{count[team.teamId]}}单</span>
	</a>
	</div>
	<p></p>
	<button class="btn btn-danger btn-block" ng-click="showOrder(teamid)">手动刷新数据（已完成未评价手机号码正确）</button>

</div>
<table class="table  table-bordered table-hover">
        <thead>
          <tr>
            <th width="150">运单ID</th>
            <th width="120">顾客姓名</th>
            <th width="120">顾客手机</th>
            <th width="110">状态</th>
			<th width="110">完成时间</th>
            <th width="110">评价</th>
            <th width="110">短信</th>
            <th>
			<input type="checkbox" ng-model="checkedall" ng-click="checkall()">
            <button type="button" class="btn btn-xs btn-danger" ng-click="sendSms()">批量发送</button>
        	</th>
          </tr>
        </thead>
<!-- <tr>
	<td></td>
	<td></td>
	<td></td>
	<td></td>
	<td></td>
	<td>已评价<span class="badge" ng-bind="getScoreCount(orders, teamid)"></span></td>
	<td>已发送<span class="badge" ng-bind="getSmsCount(orders, teamid)"></span></td>
	<td></td>
</tr> -->
           <tr ng-repeat="order in filterOrders = (orders | filter: {team_id: teamid||''}| orderBy: complete_minutes)" ng-class="{'warning': order.checked}">
            <td>{{order.tracking_id}}</td>
            <td>{{order.customer_name}}</td>
            <td>{{order.customer_phone}}</td>
          			<td>{{order.state==40 ? '已完成' : '配送中'}}</td>
          			<td>{{order.state==40?complete_minutes(order):'NaN'}}分钟</td>
            <td>{{order.star}}</td>
            <td>{{order.sms}}</td>
            <td >
            	<input type="checkbox" ng-model="order.checked" ng-checked="order.checked">
            </td>
          </tr> 
      </table>
    </div>
    
      <p ng-if="teamid&&!orders.length" class="alert alert-warning">当前站点暂无可发送订单！</p>
</div>
</main>
</code>
<style>
li{
	list-style: none;
	margin:0;
	padding: 0
}
.$this .teamlist{
	padding: 0
}
.$this .teamlist>li{
	background: #eee;
}
	.$this .nav-pills>li>a{
		background: #f9f9f9;
		color: #337ab7;
	}
	.$this .nav-pills>li.active>a{
		background: #337ab7;
		color:#fff;
	}
</style>
<script>
$export(function($this, $http, $timeout){
	var alldata;
	$this.count={};
	if(!window.fetch)return alert('请切换到极速模式');
	var orders, scores, smsing, today = new Date().toLocaleDateString(), time = new Date().getTime();
	var smstxt='【蜂鸟配送】[name]您好,我是外卖小哥.恳求您帮忙点击“超赞”好评,每一个评价对我的工作至关重要.如有不满意请勿差评，有问题可以拨打我本人电话，第一时间给您解决.祝您用餐愉快~退订回复T';
	var smstxt2='【蜂鸟配送】您好我是送餐员,出门务工不易恳求您点开订单点击“超赞”好评.评价对我至关重要.您的每一个好评都是我坚持下去的动力.如打扰退订回T';
	$this.smstxt2=smstxt2;
	function updateTime(){
		time = new Date().getTime()
	}
	updateTime.timeout();

	require(['html5sql'], function(){
		$this.state = 40;
	$this.score = false;
	$this.sms = false;
	$this.checkall = function(){
		angular.forEach($this.filterOrders, function(order){
			order.checked = !$this.checkedall
		})
	}
	$this.filter = function(){
		angular.forEach($this.orders, function(order){
			$this.checkedall=false;
			order.checked = false
		})
	}
	$this.echo = function(str){
		$this.doing = str
	}
	$this.sendSmsCanel = function(hide){
		if($this.sending)return alert('正在发送请勿关闭')
		if(hide)$('#sms').modal('hide')
		$this.smsOrders=[];
		$this.sending=false;
		smsing=false;
		$this.filter();
	}

	$('#sms').on('hide.bs.modal', function(e){
		if($this.sending){
			alert('正在发送请勿关闭')
			return e.preventDefault()
		}
		$this.$apply.to(function(){
			$this.smsOrders=[];
		$this.sending=false;
		$this.filter();
		smsing=false;
		})
		//$this.sendSmsCanel()
	});

	$this.sendSmsSubmit = function(){
			var mobile=[];
		if(!$this.smsOrders||!$this.smsOrders.length){
			alert('没有选择有效号码')
			$this.sending=false;
			$this.sendSmsCanel(true)
			return;
		}else{
			var ok = false,count=$this.smsOrders.length;
	
		angular.forEach($this.smsOrders, function(order){
			if(order.smsok)return count--;
			mobile.push(order.customer_phone)
		})
		}
		

		window.fetch('https://sh2.ipyy.com/smsJson.aspx', {
				headers:{
					'Content-type':'application/x-www-form-urlencoded; charset=utf-8'
				},
				method: 'post',
				credentials: 'include',
				mode:'no-cors',
				body: 'action=send&account=hxwl1185&password=D7C3121652BBA38B41428C5E700A42EE&mobile='+mobile.join(',')+'&content='+escape(smstxt2)
			}).then(function(response){
				alert('发送完成')
$this.$apply.to(function(){

			$this.sending=false;
					angular.forEach($this.smsOrders, function(order){
						if(alldata[order.tracking_id])alldata[order.tracking_id].sms++;
						console.log(alldata[order.tracking_id].sms)
					})
					saveOrder()
					$this.sendSmsCanel(true)
					$this.showOrder($this.teamid)
			})
})


	}
	$this.sendSms = function(order){

		if(smsing){
			$('#sms').modal('show')
			return;
		}
		var smslist = [];
		if(order)order.checked=true;
		angular.forEach(order ? [order] : $this.filterOrders, function(order){
			if(($this.score?order.score>0:(order.score||0)<=0)&&($this.sms?order.sms>0:(order.sms||0)<=0)){
				//if(!order.checked||!order.customer_phone)return;
				//if(order.customer_phone.toString().indexOf('950')==0)return;
				
			}
			if(order.checked)smslist.push(order);
		})
		if(!smslist.length){
			//$this.filter();
			return alert('没有选择有效号码')
		}
		if(window.confirm('共选择'+smslist.length+'条有效号码，确定发送？')){
			smsing=true;
			$('#sms').modal('show')
			$this.smsOrders = smslist;
		}
	}
	$this.complete_minutes = function(e){
		return parseInt((time - e.complete_time)/60000);
	}
$this.getScoreCount=function(orders,teamid){
	var count=0;
	angular.forEach(orders, function(order){
		if(order.score>0&&order.team_id==(teamid||order.team_id))count++;
	})
		return count;
}
$this.showOrder = function(teamid){
if(arguments.length)$this.teamid=teamid;
//if(!$this.teamid)return alert('先从上面选择站点');
NProgress.start()
				$this.orders = [];
				var orders=locals.get(today+'/'+$this.user.org_id, {});
				var i=0;
				angular.forEach(orders, function(order){
					if($this.orders[order.tracking_id])return;
					if(order.star>0)return;
					if(order.sms>0)return;
					if(order.state!=40)return;
					if(!order.customer_phone)return;
					if(order.customer_phone.toString().indexOf('950')==0)return;
					if($this.teamid&&$this.teamid!=order.team_id)return;
					i++;
					//if(i==100)return;
					$this.orders.push(order)
				})
				NProgress.done()
				//alert('共选出 ' +i+ ' 条可发送订单')
}
$this.getSmsCount=function(orders, teamid){
	var count=0;
	angular.forEach(orders, function(order){
		if(order.sms>0&&order.team_id==(teamid||order.team_id))count++;
	})
		return count;
}
		function init(){
			$http.get('https://app2-edu.ele.me/talaris-svr/webapi/sso/init', {
				withCredentials: true
			}).success(function(data){
				if(200 != data.err_code)return alert('授权失败请重试！');
				//var data = locals.get(today.replace(/\//g, '_')+'_'+data.data.org_id)
				$this.user = data.data
				alldata=locals.get(today+'/'+$this.user.org_id, {});
				getTeam();
			}).error(function(){
				alert('登录失败')
			})
		}
		function saveOrder(){
			locals.set(today+'/'+$this.user.org_id, alldata);
			return;
			var count = 0,
				index = 0,
				sql='insert into orders (tracking_id, org_id, org_name, team_id, team_name, customer_name, customer_phone, customer_address, complete_time, state, score, date, sms) values ',
				values = [];
				angular.forEach(orders, function(order){
				count++;
				if(!order.__id){
					values.push('('+[
						'"'+order.tracking_id+'"', 
						'"'+order.org_id+'"', 
						'"'+order.org_name+'"', 
						'"'+order.team_id+'"', 
						'"'+order.team_name+'"', 
						order.customer_name||'null', 
						order.customer_phone||'null', 
						order.customer_address||'null', 
						order.complete_time||0, 
						order.state, 
						order.score||0, 
						order.date, 
						order.sms||0
						].join(',')+')');
					}
				});
				html5sql.process([{
						sql: sql + values.join(','),
						success: function(){
							index++;
							$this.$apply.to(function(){
								alert(values.length)
								//$this.echo('insert success: '+ order.tracking_id)
								//order.__id=true;
								//if(index>=count)$this.echo('')
							})
						}
					}])

			return
			var count = 0,
				index = 0;
			angular.forEach(orders, function(order){
				count++;
				if(!order.__id){
					html5sql.process([{
						sql: 'insert into orders (tracking_id, org_id, org_name, team_id, team_name, customer_name, customer_phone, customer_address, complete_time , state, score, date, sms) values (?,?,?,?,?,?,?,?,?,?,?,?,?)',
						data: [order.tracking_id, order.org_id, order.org_name, order.team_id, order.team_name, order.customer_name, order.customer_phone, order.customer_address, order.complete_time, order.state, order.score, order.date, order.sms],
						success: function(){
							index++;
							$this.$apply.to(function(){
								$this.echo('insert success: '+ order.tracking_id)
								order.__id=true;
								if(index>=count)$this.echo('')
							})
						}
					}])
				}else if(order.__dirty){
					index++;
					html5sql.process([{
						sql: sprintf('update orders set complete_time=%s, state=%s, score=%s, sms=%s where tracking_id="%s"', 
							order.complete_time,
							order.state,
							order.score >= 0 ? order.score : -1,
							order.sms,
							order.tracking_id
							),
						success: function(){
							$this.$apply.to(function(){
								$this.echo('update success: '+ order.tracking_id)
							order.__dirty=false;
								if(index>=count)$this.echo('')
							})
						}
					}])
				} else {
					index++;
					$this.echo('')
				}
			})
		}
		function getTeam(){
			$http.get('https://app2-edu.ele.me/kunkka-svr/aeolus/homePage/getTeamList', {
				withCredentials: true
			}).success(function(data){
				if(200 != data.err_code)return alert('请求失败请重试！');
				$this.teams = data.data;
				getOrder.timeout(60000*3);
				
			})
		}
		function getKpi(team){
			$this.kpi={};
			$http.get('https://app2-edu.ele.me/kunkka-svr/agency/kpi/list/single/team/data?teamId='+team.teamId+'&ruleId=561&timeType=2', {
				withCredentials: true
			}).success(function(data){

				var value=data.data.teamDataDTO.qosDimensionData.agencyKpiIndexDataDTOList[3].indexValue*100;
				console.log(value.fixed(2))
				$this.kpi[team.teamId]=value.fixed(2)
			})
		}
		function getScore(){
			function update(){
				if(!scores)return;
				var i=0,total=0;
				angular.forEach(scores, function(order){
					total++;
					if(order.star>2)i++;
					var id = order.trackingId;
					if(alldata[id]){
						alldata[id].star = order.star;
					}
					if(!orders[order.trackingId] || orders[order.trackingId].score == order.star)return;

					angular.extend(orders[order.trackingId], {
						score: order.star,
						__dirty: true
					});
				})
				console.log(i)
				$this.echo('同步评价数据成功！');
				saveOrder()
			}
			if(arguments.length)return update();
			var startTime = new Date(today).getTime(),
			endTime = startTime  + 86400000;
			$http.get('https://stargate.ele.me/lpd_quality.dashboard/stargate/quality/evaluate/list?evaluateType=0&startTime='+startTime+'&endTime='+endTime+'&pageCount=1&pageSize=10000', {
				withCredentials: true
			}).success(function(data){
				if(200 != data.code)return $this.echo('请求失败请重试！');
				scores = data.data.detailList;
				update()
			})

		}
		function getOrder(){

			getScore()
			angular.forEach($this.teams, function(team){
				getKpi(team);
				$http.get('https://app2-edu.ele.me/talaris-svr/webapi/web/dispatch/shippingorder/query?teamId='+team.teamId+'&status=30,40&pageIndex=1&pageSize=10000', {
					withCredentials: true
				}).success(function(data){
					var count=0;
					if(200 != data.err_code)return $this.echo('请求失败请重试！');
					if(!data.data || !data.data.data)return;
					angular.forEach(data.data.data, function(order){
						if(order.state=40){
							count++
						}
						var id = order.trackingId;
						//alldata[order.trackingId]=order;
						if(!alldata[id]){
							alldata[id]={
								tracking_id: order.trackingId,
								team_id: team.teamId,
								customer_name: order.customerName,
								customer_phone: order.customerPhone,
								customer_address: order.customerAddress,
								complete_time: order.completeTime,
								state: order.state,
								star: 0,
								sms: 0
							}
						}else{
							alldata[id]=$.extend(alldata[id], {
								complete_time: order.completeTime,
								state: order.state,
							})
						}
						//console.log(alldata[id].complete_time,9)
						if(!orders[order.trackingId]){
							orders[order.trackingId] = {
								tracking_id: order.trackingId,
								org_id: $this.user.org_id,
								org_name: $this.user.org_name,
								team_id: team.teamId,
								team_name: team.teamName,
								customer_name: order.customerName,
								customer_phone: order.customerPhone,
								customer_address: order.customerAddress,
								complete_time: order.completeTime,
								state: order.state,
								date: today,
								sms: 0
							}
							//$this.orders.push(orders[order.trackingId])
						}else{
							if(orders[order.trackingId].complete_time != order.completeTime || orders[order.trackingId].state != order.state){

								angular.extend(orders[order.trackingId], {
									complete_time: order.completeTime,
									state: order.state,
									__dirty: true
								})
							}
							
						}
					});
					$this.count[team.teamId]=count;
					//console.log(alldata)
					getScore(true);
					saveOrder()
				})
			})
		}
		html5sql.openDatabase('smscrm', 'smscrm database', 512 * 1024 * 1024);
		html5sql.process([
		{
	  		sql: 'create table IF NOT EXISTS orders (__id integer primary key autoincrement, org_id text, org_name text, team_id text, team_name text, tracking_id text, customer_name text, customer_phone text, customer_address text, complete_time text, state integer, score integer, date text, sms integer)'
		}, {
			sql: 'select * from orders where date = "' +today +'"',
			success: function(){
				
				orders = {};
				angular.forEach(arguments[2], function(order){
					orders[order.tracking_id] = order
				});
				init()
			}
		}]);
	})
	return;
	var idTmr;
        function  getExplorer() {
            var explorer = window.navigator.userAgent ;
            //ie
            if (explorer.indexOf("MSIE") >= 0) {
                return 'ie';
            }
            //firefox
            else if (explorer.indexOf("Firefox") >= 0) {
                return 'Firefox';
            }
            //Chrome
            else if(explorer.indexOf("Chrome") >= 0){
                return 'Chrome';
            }
            //Opera
            else if(explorer.indexOf("Opera") >= 0){
                return 'Opera';
            }
            //Safari
            else if(explorer.indexOf("Safari") >= 0){
                return 'Safari';
            }
        }
        function method1(tableid) {//整个表格拷贝到EXCEL中
            if(getExplorer()=='ie') {
                var curTbl = document.getElementById(tableid);
                var oXL = new ActiveXObject("Excel.Application");

                //创建AX对象excel
                var oWB = oXL.Workbooks.Add();
                //获取workbook对象
                var xlsheet = oWB.Worksheets(1);
                //激活当前sheet
                var sel = document.body.createTextRange();
                sel.moveToElementText(curTbl);
                //把表格中的内容移到TextRange中
                sel.select;
                //全选TextRange中内容
                sel.execCommand("Copy");
                //复制TextRange中内容
                xlsheet.Paste();
                //粘贴到活动的EXCEL中
                oXL.Visible = true;
                //设置excel可见属性

                try {
                    var fname = oXL.Application.GetSaveAsFilename("Excel.xls", "Excel Spreadsheets (*.xls), *.xls");
                } catch (e) {
                    print("Nested catch caught " + e);
                } finally {
                    oWB.SaveAs(fname);

                    oWB.Close(savechanges = false);
                    //xls.visible = false;
                    oXL.Quit();
                    oXL = null;
                    //结束excel进程，退出完成
                    //window.setInterval("Cleanup();",1);
                    idTmr = window.setInterval("Cleanup();", 1);
                }
            } else {
                tableToExcel('ta')
            }
        }
        function Cleanup() {
            window.clearInterval(idTmr);
            CollectGarbage();
        }

        /*
            template ： 定义文档的类型，相当于html页面中顶部的<!DOCTYPE> 声明。（个人理解，不确定）
            encodeURIComponent:解码
            unescape() 函数：对通过 escape() 编码的字符串进行解码。
            window.btoa(window.encodeURIComponent(str)):支持汉字进行解码。
            \w ：匹配包括下划线的任何单词字符。等价于’[A-Za-z0-9_]’
            replace()方法：用于在字符串中用一些字符替换另一些字符，或替换一个与正则表达式匹配的子串。
            {(\w+)}：匹配所有 {1个或更多字符} 形式的字符串；此处匹配输出内容是 “worksheet”
            正则中的() ：是为了提取匹配的字符串。表达式中有几个()就有几个相应的匹配字符串。
            讲解(/{(\w+)}/g, function(m, p) { return c[p]; } ：
                /{(\w+)}/g 匹配出所有形式为“{worksheet}”的字符串；
                function参数：  m  正则所匹配到的内容，即“worksheet”；
                                p  正则表达式中分组的内容,即“(\w+)”分组中匹配到的内容，为“worksheet”；
                c ：为object，见下图3
                c[p] : 为“worksheet”

        */
        var tableToExcel = (function() {
            var uri = 'data:application/vnd.ms-excel;base64,',
            template = '<html xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:x="urn:schemas-microsoft-com:office:excel" xmlns="http://www.w3.org/TR/REC-html40"><head><!--[if gte mso 9]><xml><x:ExcelWorkbook><x:ExcelWorksheets><x:ExcelWorksheet><x:Name>{worksheet}</x:Name><x:WorksheetOptions><x:DisplayGridlines/></x:WorksheetOptions></x:ExcelWorksheet></x:ExcelWorksheets></x:ExcelWorkbook></xml><![endif]--></head><body><table>{table}</table></body></html>',
            base64 = function(s) {
                return window.btoa(unescape(encodeURIComponent(s)))
            },
            // 下面这段函数作用是：将template中的变量替换为页面内容ctx获取到的值
            format = function(s, c) {
                    return s.replace(/{(\w+)}/g,
                                    function(m, p) {
                                        return c[p];
                                    }
                    )
            };
            return function(table, name) {
                if (!table.nodeType) {
                    table = document.getElementById(table)
                }
                // 获取表单的名字和表单查询的内容
                var ctx = {worksheet: name || 'Worksheet', table: table.innerHTML};
                // format()函数：通过格式操作使任意类型的数据转换成一个字符串
                // base64()：进行编码
                window.location.href = uri + base64(format(template, ctx))
            }
        })();
$this.excel = method1;
	$this.teams = [];
	$this.orders = [];
	$this.teamid = 0;
	$this.timer = 60;
	function timeout(){
		$this.timer--;
		if($this.timer<0)$this.timer=60;
		$timeout(timeout, 1000)
	}
	var date = new Date().toLocaleDateString();
	function logout(){
		alert('授权失败请重新登录！');
		window.location.href='https://passport.ele.me/#!domain=AGENTS&from='+escape(window.location.href);
	}
	function $apply(todo){
		($this.$$phase || $this.$root.$$phase) ? todo() : $this.$apply(todo);
	}
	function run(){
		function each(){
			var orders = angular.copy(locals.get(date, []));
			$apply(function(){
				$this.orders = orders
			});
			if(!$this.teams || !$this.teams.length)return;
			timeout();
			angular.forEach($this.teams, function(team){
				orderQuery(team, 30, pushOrder);
			})
		}
		each();
		window.setInterval(each, 60000);
	}
	function getTeamList(){
		window.fetch('https://app2-edu.ele.me/kunkka-svr/aeolus/homePage/getTeamList', {
			method: 'GET',
	  		credentials: 'include'
		}).then(function(response){
			if(!response.ok||200!=response.status)return;
			return response.json()
		}).then(function(data){
			if(!data || !data.data || 400==data.code)return logout();
			$this.$apply($this.teams = data.data)
			run();
		}).catch(function(){
			alert('Error-2')
		})
	}
	function pushOrder(team, data){
		var orders = angular.copy(locals.get(date, [])),
			ordersObj = {};
		angular.forEach(orders, function(item){
			ordersObj[item.trackingId] = item;
		})
		angular.forEach(data, function(item){
			if(ordersObj[item.trackingId])return;
			orders.push({
				'teamId': team.teamId,
				'teamName': team.teamName,
				'trackingId': item.trackingId,
				'customerName': item.customerName,
				'customerPhone': item.customerPhone,
				'customerAddress': item.customerAddress
			});
		})
			//locals.remove().set(date, orders);
			$this.$apply($this.orders = orders);
		orderQuery(team, 40, doneOrder);
	}
	function doneOrder(team, data){
		var ordersObj = {},now=new Date().getTime();
		angular.forEach($this.orders, function(item){
			ordersObj[item.trackingId] = item;
		})

		angular.forEach(data, function(item){
			var order =ordersObj[item.trackingId]; 
			if(!order)return
			order.state=40;
			order.completeTime=item.completeTime;
			order.completeMinutes=parseInt((item.completeTime-now)/60000);
		})

		var neworders=[];
		angular.forEach(ordersObj, function(item){
			neworders.push(item)
		})
			locals.remove().set(date, neworders);
			$this.$apply($this.orders = neworders);
	}
	function orderQuery(team, status, success){
		window.fetch('https://app2-edu.ele.me/talaris-svr/webapi/web/dispatch/shippingorder/query?teamId='+team.teamId+'&pageSize=500&status='+status+'&shippingOrderSort=acceptTime&sort=2', {
			method: 'GET',
	  		credentials: 'include'
		}).then(function(response){
			if(!response.ok||200!=response.status)return;
			return response.json()
		}).then(function(data){
			if(!data || !data.data || !data.data.data || 400==data.code)return logout();
			success(team, data.data.data)
		}).catch(function(){
			//alert('Error-1')
		})
	}

	return getTeamList();
	$this.getTeamList = function(){
		window.fetch('https://app2-edu.ele.me/kunkka-svr/aeolus/homePage/getTeamList', {
			method: 'GET',
	  		credentials: 'include'
		}).then(function(response){
			if(!response.ok||200!=response.status)return;
			return response.json()
		}).then(function(data){
			if(!data || !data.data)return alert('授权失败');
			$this.$apply($this.teams = data.data)
		}).catch(function(){
			alert('系统错误')
		})
	}
	$this.filterOrders = function(team){
		$this.filterTeam = team;
		if(!$this.teams || !$this.teams.length)return;
		$this.orders = [];
		if(!team){
			angular.forEach($this.teams, function(team){
				$this.orders = $this.orders.concat(tream.orders);
			})
			angular.forEach($this.orders, function(order){
				order.team = team;
			})
		}else{
			$this.orders = team.orders;
			angular.forEach($this.orders, function(order){
				order.team = team;
			})
		}
	}
	$this.getOrderList = function(team, status){
		var callee = arguments.callee;
		if(!team || callee.state)return;
		callee.state = !callee.state;
		window.fetch('https://app2-edu.ele.me/talaris-svr/webapi/web/dispatch/shippingorder/query?teamId='+team.teamId+'&pageSize=500&status=30&shippingOrderSort=acceptTime&sort=2', {
			method: 'GET',
	  		credentials: 'include'
		}).then(function(response){
			if(!response.ok||200!=response.status)return;
			return response.json()
		}).then(function(data){
			if(!data)return alert(99);
			$this.$apply(callee.state = !callee.state, data.orders = data.data.data)
			$this.filterOrders($this.filterTeam);
		}).catch(function(){
			alert('系统错误')
			$this.$apply(callee.state = !callee.state, data.orders = [])
		})
	}
$this.getTeamList();

window.setInterval(function(){
	if(!$this.teams || !$this.teams.length)return;
	angular.forEach($this.teams, function(team){
		//$this.getOrderList(team);
	})
}, 6000)
	
})
</script>