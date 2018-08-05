<code>
	<main>
	<template data-path="'/public/header'" data-active="index"></template>
	<template id="left" data-path="'/home/left'" data-active="add"></template>
	<div id="right">
	<template data-path="'modal'" id="addnew"></template>
	<div class="panel panel-default">
      <div class="panel-heading">角色列表</div>
      <div class="panel-body">
      	<form name="form" class="form-default" action="/Api/role/save" data-src="/Api" ng-submit="submit(form)">
          {{form.$data}}
      		<div class="form-group">
      			<label class="control-label">姓名</label>
      			<input type="text" class="form-control" name="name" ng-model="form.$data.name" required>
      			<button type="button" class="btn btn-default">检查</button>
            {{form.$data.name.isLen(1,3)}}
      			<span class="text-danger" ng-if="form.$validate('name')">姓名不能为空</span>
      		</div>
      		<div class="form-group">
      			<label class="control-label">多选list</label>
      			<label class="checkbox-inline" ng-repeat="item in list">
                <input type="checkbox" name="list[]" value="{{item.value}}" ng-checked="form.$data.list.isExist(item.value)" ng-click="form.$data.list.toggle(item.value)"> {{item.label}}
            </label>
      		</div>
          <div class="form-group">
            <label for="" class="control-label">日期</label>
            <input type="text" name="date" class="form-control" ng-date="yyyy-MM-dd HH:mm:ss" ng-model="form.$data.date" required>
            <span class="text-danger" ng-if="form.$validate('date')">日期不能为空</span>
          </div>
          <div class="form-group">
              <label class="control-label">列表</label>
              <select name="" id="" class="form-control" ng-model="form.$data.pass">
                <option value="">选择</option>
                <option ng-repeat="item in ops" value="{{item.value}}">{{item.label}}</option>
              </select>
            </div>
          <div class="form-group">
            <label class="control-label">单选list</label>
            <label class="radio-inline">
                <input type="radio" name="pass" value="123456" ng-model="form.$data.pass">
                1
            </label>
            <label class="radio-inline">
                <input type="radio" name="pass" value="1256" ng-model="form.$data.pass">
                2
            </label>
          </div>
      		<div class="form-group">
      			<label></label>
      			<button type="submit" class="btn btn-default btn-submit" ng-disabled="form.$submited"></button>
      		</div>
      	</form>
        <button class="btn btn-primary" data-toggle="modal" data-target="#addnew">打开地图</button>
      </div>

    </div>
</div>


</main>
</code>
<script>
$export(function($this){

  $this.ops=[{
    value: '123456',
    label: '我-的'
  },{
    value: '1256',
    label: '他的'
  }]
  $this.list = [{value:'aa',
  label:'美女'},{value:'bb9',label: '帅哥'}]
	$this.submit = function(form){
    return console.log(form, form.$data);
    form.$submit(function(info){
        //alert(info)
        //$this.$route.path('/login')
    }, function(info){
        alert(info)
    });
  }
}, '添加角色')
</script>