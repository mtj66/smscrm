<title>短信模板</title>
<code>
	<main>
	<template data-path="'/public/header'" data-active="sms"></template>
  <template id="left" data-path="'left'" data-active="add"></template>
	<div id="right">
	<div class="panel panel-default">
    <div class="panel-heading"><h4 class="panel-title">添加模板</h4></div>
   <div class="panel-body">
    <form name="form" action="/aeolus/sms/add" method="post" class="form" ng-submit="add(form)">
      <div class="form-group">
        <label class="control-label">模板名*</label>
        <input type="text" name="name" required="" ng-model="form.$$data.name" maxlength="20" class="form-control">
      </div>
      <div class="form-group">
        <label class="control-label">模板内容*</label>
        <textarea name="text" id="" cols="30" rows="3" required="" class="form-control" ng-model="form.$$data.text" maxlength="70"></textarea>
        <p class="help-block">字数{{form.$$data.text.length||0}}/70</p>
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
  $this.add=function(form){
    if(form.$invalid)return $layer.msg('表单填写有误');
    var load = $layer.load()
    form.$submit(function(data){
      $layer.msg(data.msg, load.close)
      $location.path('/sms/index')
    })
  }
}
</script>