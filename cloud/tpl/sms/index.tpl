<title>短信模板</title>
<code>
	<main>
	<template data-path="'/public/header'" data-active="sms"></template>
  <template id="left" data-path="'left'" data-active="index"></template>
	<div id="right">
	<div class="panel panel-default">
    <div class="panel-heading"><h4 class="panel-title">我的模板</h4></div>
   <div class="panel-body" ng-if="!list.length">
    <p class="text-center">没有数据</p>
   </div>
    <ul class="list-group" ng-if="list.length>0">
      <li class="list-group-item" ng-repeat="item in list">
        <a href="#" class="btn btn-xs btn-link pull-right" ng-route="'edit'" data-search="{id:item.__id}">修改</a>
        <p>{{$index+1}}、{{item.name}}</p>
        <p class="well">{{item.text}}</p>
      </li>
    </ul>
    
</div>
</div>
</main>
</code>
<style>
	
</style>
<script>
function($root, $this, $http, $location, $layer){
  $root.init();
  var load=$layer.load();
  $http.get('/aeolus/sms/index').success(function(data){
    load.close()
    $this.list = data.data;
  })
}
</script>