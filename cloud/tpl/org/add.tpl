<title>客户管理</title>
<code>
	<main>
	<template data-path="'/public/header'" data-active="org"></template>
  <template id="left" data-path="'left'" data-active="add"></template>
	<div id="right">
	<div class="panel panel-default">
    <div class="panel-heading"><h4 class="panel-title">添加客户</h4></div>
   <div class="panel-body">
    <form name="form" action="/aeolus/org/add" method="post" class="form" data="form_data" ng-submit="add(form)">
      <div class="form-group">
        <label class="control-label control-required">帐号</label>
        <input type="text" name="mobile" required="" ng-model="form.$$data.mobile" maxlength="11" class="form-control form-control-inline">
      </div>
      <div class="form-group">
        <label class="control-label control-required">密码</label>
        <input type="password" class="form-control form-control-inline" required="" name="password" ng-model="form.$$data.password">
      </div>
      <div class="form-group">
        <label class="control-label">状态</label>
        <label>
        <input type="radio" name="type" ng-value=1 ng-model="form.$$data.type">
        签约</label>
        <label>
        <input type="radio" name="type" ng-value=0 ng-model="form.$$data.type">
        测试</label>
      </div>
      <div class="form-group">
        <label class="control-label">云服务</label>
        <label>
        <input type="radio" name="status" ng-value=1 ng-model="form.$$data.status">
        开启</label>
        <label>
        <input type="radio" name="status" ng-value=0 ng-model="form.$$data.status">
        关闭</label>
      </div>
      <div class="form-group">
        <label class="control-label">防踢</label>
        <label>
        <input type="radio" name="kick" ng-value=1 ng-model="form.$$data.kick">
        开启</label>
        <label>
        <input type="radio" name="kick" ng-value=0 ng-model="form.$$data.kick">
        关闭</label>
      </div>
      <div class="form-group">
        <label class="control-label">短信模板</label>
        <select name="sms_text_id" class="form-control" ng-model="form.$$data.sms_text_id">
          <option ng-repeat="item in form.$$data.sms_text_list" value="{{item.__id}}"  ng-selected="item.__id==form.$$data.sms_text_id">{{item.name}}</option>
        </select>
      </div>
      <div class="form-group">
        <label class="control-label">短信平台</label>
        <select name="sms_api_id" class="form-control" ng-model="form.$$data.sms_api_id">
          <option ng-repeat="item in form.$$data.sms_api_list" value="{{item.__id}}"  ng-selected="item.__id==form.$$data.sms_api_id">{{item.name}}</option>
        </select>
      </div>
      <div class="form-group">
        <label class="control-label control-required">目标好评率</label>
        <input type="number" step="0.01" min="0" name="kpi_score" required="" ng-model="form.$$data.kpi_score" maxlength="4" class="form-control form-control-inline">
      </div>
      <div class="form-group">
        <label class="control-label control-required">价格</label>
        <input type="number" step="0.01" min="0" name="price" required="" ng-model="form.$$data.price" maxlength="4" class="form-control form-control-inline">元
      </div>
      <div class="form-group">
        <label class="control-label control-required">业务提成</label>
        <input type="number" step="0.01" min="0" name="fee" required="" ng-model="form.$$data.fee" maxlength="4" class="form-control form-control-inline">元
      </div>
      <div class="form-group">
        <label class="control-label control-required">业务员</label>
        <input type="text" name="saler" required="" ng-model="form.$$data.saler" maxlength="18" class="form-control form-control-inline">
      </div>
      <div class="form-group">
        <label for="" class="control-label"></label>
        <button class="btn btn-primary" ng-disabled="form.$$submited||!form.$dirty||form.$invalid">提交</button>
      </div>
      
    </form>
   </div>
    
</div>
</div>
</main>
</code>
<style>
	
</style>
<script>
function($this, $http, $location, $layer){
  $this.form_data={
    type: 0,
    status: 0,
    kick: 0,
    kpi_score: 0,
    price: 0,
    fee: 0
  }
  $this.add=function(form){
    if(form.$invalid)return layer.msg('表单填写有误');
    var load = layer.load()
    form.$submit(function(data){
      layer.msg(data.msg)
      layer.close(load)
      if(200==data.code){
        $location.path('/org/index')
      }
    }, function(){
      layer.msg('网络异常')
    })
  }
  var load = $layer.load(2);
  $http.get('/aeolus/sms/index').success(function(data){
    load.close()
    $this.form_data.sms_text_list=[{__id:'0', name:'默认'}].concat(data.data);
  })
  $http.get('/aeolus/sms/api').success(function(data){
    load.close()
    $this.form_data.sms_api_list=[{__id:'0', name:'默认'}].concat(data.data);
  })
}
</script>