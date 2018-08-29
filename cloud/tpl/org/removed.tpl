<title>客户管理</title>
<code>
	<main>
	<template data-path="'/public/header'" data-active="org"></template>
  <template id="left" data-path="'left'" data-active="removed"></template>
	<div id="right">
	<div class="panel panel-default">
    <div class="panel-heading"><h4 class="panel-title">已删除客户</h4></div>
   <div class="panel-body" ng-if="!list.length">
    <p class="text-center">没有数据</p>
   </div>
    <table class="table table-bordered" ng-if="list.length>0">
        <thead>
          <tr>
            <th width="50">#</th>
            <th class="nowrap">公司称</th>
            <th class="nowrap" width="100">操作</th>
          </tr>
        </thead>
        <tbody>
          <tr ng-repeat="item in list">
            <td ng-bind="$index+1"></td>
            <td ng-bind="item.org_name"></td>
            <td>
              <a href="#" ng-click="recover(item)">恢复</a>
            </td>
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
function($this, $http, $location, $layer){
  $this.recover=function(e){
    $layer.confirm('确定？').yes(function(layer){
      var load=layer.load()
      $http.get('/aeolus/org/recover/id/'+e.org_id).success(function(data){
        layer.msg(data.msg, load.close, function(){
          if(200==data.code)layer.close(),$location.path('/org/index').search({});
        });
      }).error(function(){
        layer.msg('网络异常', load.close);
      })
    })
  }
  $http.get('/aeolus/org/removed').success(function(data){
    $this.list = data.data;
  })
}
</script>