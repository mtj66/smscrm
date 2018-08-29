<code>
	<main>
	<template data-path="'/public/header'" data-active="index"></template>
	<template id="left" data-path="'/home/left'" data-active="index"></template>
	<div id="right">
	<div class="panel panel-default">
      <div class="panel-heading">角色列表</div>
      <div class="panel-body">
      	{{teams}}
      	<hr>
      	{{formdata}}
      	<ui:form class="form-default" :model="formdata" :rule="formrule">
		<ui:form-group :label="用户名" :help="必填项" :name="name">
			<ui:input type="text" placeholder="请输入内-容" ng-model="model.name"></ui:input>
		</ui:form-group>
      </ui:form>
      	<form class="form-horizontal">
  <div class="form-group">
    <label for="inputEmail3" class="col-sm-2 control-label">Email</label>
    <div class="col-sm-10">
      <input type="email" class="form-control" id="inputEmail3" placeholder="Email">
    </div>
  </div>
  <div class="form-group">
    <label for="inputPassword3" class="col-sm-2 control-label">Password</label>
    <div class="col-sm-10">
      <input type="password" class="form-control" id="inputPassword3" placeholder="Password">
    </div>
  </div>
  <div class="form-group">
    <div class="col-sm-offset-2 col-sm-10">
      <div class="checkbox">
        <label>
          <input type="checkbox"> Remember me
        </label>
      </div>
    </div>
  </div>
  <div class="form-group">
    <div class="col-sm-offset-2 col-sm-10">
      <button type="submit" class="btn btn-default">Sign in</button>
    </div>
  </div>
</form>

      	<dl class="tree" ui-tree="tree">
      		
      	</dl>
      	<!-- <div ng-map style="width: 500px; height: 400px;"></div> -->
        <button class="btn btn-primary" ng-click="$route.location.search({id:99})">搜索</button>
      </div>

    </div>
</div>
</main>
</code>
<style>
	
</style>
<script>
$export(function($this, $http, $timeout){

	
	$this.formrule = {
		'name': [{
			required:true,
			message: '必须',
			trigger: 'change'
		}]
	}
	$this.formdata={
		name:'999@qq.com'
	}
	$this.tree=[{
		label: '阶段1',
		children: [{
			label: '节点123'
		},{
			label: '节点223',
			children: [{
				label: '幽幽'
			}]
		},{
			label: '节点323'
		}]
	}]
}, '列表')
</script>