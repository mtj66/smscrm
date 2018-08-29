<title>工作台</title>
<code>
	<main>
	<template data-path="'/public/header'" data-active="cloud"></template>
	<div id="right">
	<div class="panel panel-default">
     <!--  <div class="panel-heading"><h4 class="panel-title">实况</h4></div> -->
   <div class="panel-body">
    <input type="text" class="form-control form-control-inline" laydate="date" data-btns="confirm" data-min=-30 data-max=0 ng-model="today" data-format="yyyy-MM-dd">
    <select ng-init="org_id=0" ng-model="org_id" ng-options="item.org_id as item.org_name group by org_type[item.type] for item in org_list" class="form-control form-control-inline">
      <option value="">所有客户</option>
    </select>
     <button type="button" class="btn btn-primary" ng-click="load()">查询</button>
   </div>
    <table class="table table-bordered">
      <thead>
        <tr>
          <th width="50">#</th>
          <th width="190">客户名</th>
          <th class="nowrap">站点</th>
          <th class="nowrap" width="80">推送</th>
          <th class="nowrap" width="100">当天完成</th>
          <th class="nowrap" width="100">当天发送</th>
          <th class="nowrap" width="100">当天好评率</th>
          <th class="nowrap" width="100">周期好评率</th>
        </tr>
      </thead>
      <tbody>
        <tr ng-repeat="item in team_list | filter: {'org_id': org_id||''}">
          <td>{{$index+1}}</td>
          <td>{{item.org_name}}
          </td>
          <td>{{item.team_name}}</td>
          <td><a href="#" ng-click="switch_send(item)">
              {{item.send==1?'开':'关'}}</a></td>
          <td>{{item.done_count}}</td>
          <td>{{item.send_count}}</td>
          <td>{{100*item.today_score|number:2}}%</td>
          <td>{{100*item.period_score|number:2}}%</td>
        </tr>
        <tr>
          <td colspan="4"></td>
          <td>0</td>
          <td>0</td>
          <td colspan="2"></td>
        </tr>
      </tbody>
    </table>
</div>
</div>
</main>
</code>
<style>
	
</style>
<script>
function($root,$this, $http, $location, $layer){
$this.switch_send=function(e){
  var send = e.send==1?0:1;
  $http.get('/aeolus/index/switch_send/id/%s/send/%s'.sprintf(e.team_id, send)).success(function(data){
    layer.msg(data.msg);
    if(200==data.code){
      e.send=send
    }
  })
}
$this.today=new Date().format('yyyy-MM-dd');
$this.org_list=[];
$this.team_list=[];
var org_list={};
var load=$layer.load();
$http.get('/aeolus/org/data').success(function(data){
  load.close()
  data.data.forEach(function(item){
    org_list[item.org_id]=item;
    $this.team_list.push(item);

  });
  $this.org_list=org_list.valueOf(Array);
})
$this.load=function(){
  
  alert(laydate)
}
  //var load=layer.load();
  $this.org_type = {
    '0': '使用',
    '1': '签约'
  }
  $this.org_id=$location.$$search.org_id;
  $this.team_id = $location.$$search.team_id;
  $this.org_listq=[{
    type: 1,
    org_id: 1,
    org_name:'1111'
  }, {
    type: 1,
    org_id: 1,
    org_name:'1111'
  }]
  $this.get_org_list = function(){
    $this.org_list=[];
    $http.get('/api/aeolus/get_org_list').success(function(data){
      $this.org_list=data;
      layer.close(load)
      $this.get_team_list($this.org_id);
    })
  }
  $this.get_team_list=function(org_id){
    if(!org_id)return $this.team_list=[];
  var load=layer.load();
    $http.get('/api/aeolus/get_team_list?org_id=%s'.sprintf(org_id)).success(function(data){
      $this.team_list=data;
      layer.close(load)
    })
  }
  $root.init();
//$this.get_org_list()
}
</script>