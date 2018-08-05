<code>
	<main>
	<div class="right">
	<div class="panel panel-default">
      <div class="panel-heading">

      系统正在自动运行，<span ng-bind="timer" style="color:Red"></span>秒后会重新拉取新的数据，无需F5
	
  </div>
<div class="panel-body">
	<button type="button" class="btn btn-danger btn-block" ng-click="excel('ta')">导出今日已完成数据(共{{(orders|filter:{state:40}).length}}条)</button>
	<hr>
	<!-- <input type="checkbox" ng-false-value='' ng-true-value="40" ng-model="$root.states">仅显示已完成{{$root.states}} -->
	<span class="btn-group">
		<button type="button" class="btn btn-default" ng-class="{'btn-warning':!teamid}" ng-click="teamid=0">全部</button>
		<button type="button" class="btn btn-default" ng-class="{'btn-warning':$parent.teamid==team.teamId}" ng-repeat="team in teams" ng-click="$parent.teamid=team.teamId">{{team.teamName}}</button>
	</span>
</div>
<table class="table" id=ta>
        <thead>
          <tr>
            <th>支队</th>
            <th>状态</th>
			<th>完成时间</th>
            <th>运单ID</th>
            <th>顾客姓名</th>
            <th>顾客手机</th>
            <th>顾客地址</th>
          </tr>
        </thead>

          <tr ng-repeat="order in orders | filter: {state:40, teamId: teamid||''} | orderBy: '-completeMinutes'">
            <td>{{order.teamName}}</td>
			<td>{{order.state?'已完成':'配送中'}}{{order.completeMinutes}}分钟</td>
			<td>{{order.completeTime | date : 'yyyy-MM-dd HH:mm:ss'}}</td>
            <td>'{{order.trackingId}}</td>
            <td>{{order.customerName}}</td>
            <td>{{order.customerPhone}}</td>
            <td>{{order.customerAddress}}</td>
          </tr>
      </table>
    </div>
</div>
</main>
</code>
<style>
	
</style>
<script>
$export(function($this, $http, $timeout){
	if(!window.fetch)return alert('请切换到极速模式');
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
	
}, '抓单系统')
</script>