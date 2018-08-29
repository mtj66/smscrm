<title>客户管理</title>
<code>
	<main>
	<template data-path="'/public/header'" data-active="org"></template>
  <template id="left" data-path="'left'" data-active="index"></template>
	<div id="right">
	<div class="panel panel-default">
    <div class="panel-heading"><h4 class="panel-title">我的客户</h4></div>
   <div class="panel-body" ng-if="!list.length">
    <p class="text-center">没有数据</p>
   </div>

    <table class="table table-bordered" ng-if="list.length>0" ng-init="org_type=1">
        <thead>
          <tr>
            <th width="50">#</th>
            <th width="100">
<div class="dropdown" style="display: inline-block;">
                <a href="#" data-toggle="dropdown" class="glyphicon glyphicon-filter"></a>
                <ul class="dropdown-menu">
                  <li><a href="#" ng-click="org_type=1">签约
                    <span class="badge" ng-bind="(list | filter: {'type': 1}).length">0</span></a></li>
                  <li><a href="#" ng-click="org_type=0">测试
                    <span class="badge" ng-bind="(list | filter: {'type': 0}).length">0</span></a></li>
                </ul>
              </div>
              {{org_type==1?'签约':'测试'}}
            </th>
            <th class="nowrap">公司称</th>
            <th class="nowrap" width="80">站点个数</th>
            <th class="nowrap" width="80">云服务</th>
            <th class="nowrap" width="80">防踢</th>
            <th class="nowrap" width="80">推送</th>
            <th class="nowrap" width="150">手机号</th>
            <th class="nowrap" width="150">密码</th>
            <th class="nowrap" width="150"></th>
          </tr>
        </thead>
        <tbody>
          <tr ng-if="!org_list.length"><td colspan="8" class="text-center">筛选
            <b>{{org_type==1?'签约':'测试'}}</b>
          结果为空</td></tr>
          <tr ng-repeat="item in org_list=(list | filter: {'type': org_type})">
            <td ng-bind="$index+1"></td>
            <td ng-bind="item.type==1?'签约':'测试'"></td>
            <td ng-bind="item.org_name"></td>
            <td>
              {{item.team_count}}
              <div class="pull-right">
              <a href="#" class="glyphicon glyphicon-refresh" ng-click="pull_team(item)" title="更新站点信息"></a>
              
              <div class="dropdown" style="display: inline-block;">
                <a href="#" data-toggle="dropdown" class="glyphicon glyphicon-th-list" ng-click="show_team(item)" title="查看站点详情"></a>
                <ul class="dropdown-menu" ng-if="item.teams.length">
                  <li ng-repeat="team in item.teams"><a href="#">{{$index+1}}:{{team.team_name}}</a></li>
                </ul>
              </div>

              </div>
            </td>
            <td><a href="#" ng-bind="item.status==1?'开':'关'" ng-click="org_save(item, {id:item.org_id, status: item.status==1?0:1})"></a></td>
            <td><a href="#" ng-bind="item.kick==1?'开':'关'" ng-click="org_save(item, {id:item.org_id, kick: item.kick==1?0:1})"></a></td>
            <td><a href="#" ng-bind="item.send==1?'开':'关'" ng-click="org_save(item, {id:item.org_id, send: item.send==1?0:1})"></a></td>
            <td ng-bind="item.mobile"></td>
            <td><a href="#" ng-bind="item.peep?item.password:'******'" ng-click="item.peep=!item.peep">******</a></td>
            <td>
              <a href="#" ng-route="'/org/edit'" data-search="{id:item.org_id}">修改</a>
              |
              <a href="#" ng-click="remove(item)">删除</a>
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
function($root, $this, $http, $location, $route, $layer){
  $this.org_save = function(e, save){
    var load = $layer.load();
    $http.submit('/aeolus/org/save', save).success(function(data){
        $layer.msg(data.msg, load.close);
        if(200==data.code){
          angular.extend(e, save);
          //$route.reload()
        }
      }).error(function(){
        $layer.msg('网络异常', load.close);
      })
  }
  $this.switch_send=function(e){
    var send = e.send==1?0:1;
    var load = $layer.load();
    $http.get('/aeolus/org/switch_send/id/%s/send/%s'.sprintf(e.org_id, send)).success(function(data){
        $layer.msg(data.msg, load.close, function(){
            if(200==data.code){
            e.send=send;
            //$route.reload()
          }
        });
        
      }).error(function(){
        $layer.msg('网络异常', load.close);
      })
  }
  $this.pull_team=function(e){
    var load = $layer.load();
    $http.get('/aeolus/org/pull_team/id/%s'.sprintf(e.org_id)).success(function(data){
        $layer.msg(data.msg, load.close, function(){
          $route.reload.__when(200==data.code);
        });
      }).error(function(){
        $layer.msg('网络异常', layer.close);
      })
  }
  $this.show_team=function(e){
    if(e.teams)return;
    var load = $layer.load();
    $http.get('/aeolus/org/show_team/id/%s'.sprintf(e.org_id)).success(function(data){
        $layer.msg(data.msg, load.close, function(){
          if(200==data.code)e.teams = data.data;
        });
      }).error(function(){
        $layer.msg('网络异常', load.close);
      })
  }
  $this.remove=function(e){
    $layer.confirm('确定？').yes(function(layer){
        var load=$layer.load();
        $http.get('/aeolus/org/remove/id/%s'.sprintf(e.org_id)).success(function(data){
          $layer.msg(data.msg, load.close, function(){
            if(200==data.code)layer.close(),$route.reload()
          });
        }).error(function(){
          $layer.msg('网络异常', load.close);
        })
    })
  }
var load=$layer.load()
  $http.get('/aeolus/org/index').success(function(data){
    load.close()
    $this.list = data.data;
  })
  $root.init();
}
</script>