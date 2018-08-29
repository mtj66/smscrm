<title>首页</title>
<code>

	<main>

	<template data-path="'/public/header'" data-active="index"></template>

	  <div class="container-fluid card">
<ul class="row text-center">
	<li class="col-sm-4" ng-repeat="item in data">
		<a href="#" ng-route="item.path">
			<h5 ng-bind="item.name"></h5>
			<h1 ng-bind="item.value"></h1>
		</a>
	</li>
</ul>

  </div>
<button type="button" ng-click="test()" class="btn btn-default" data-toggle="tooltip" data-placement="right" title="Tooltip on right">Tooltip on right</button>
  </main>

</code>
<style>
.$this .card>ul>li{
padding:10px;
height: 120px;
background: #fff;
border:1px solid #eee;
text-decoration: none;
	}
.$this .card>ul>li:hover{
	background: #f9f9f9;
	text-decoration: none;
}
.$this .card>ul>li>a{
	display: block;
	position: relative;
	height: 100%;
	overflow: hidden;
}
.$this .card>ul>li>a>h5{
	color:#999;
}

</style>
<script>
function($root,$this,$compile, $templateCache, $http, $layer){
	$root.init();
$this.name=999;
	$this.test=function(){
		$layer.input(3,4).done(function(layer, value){

this.close.when(2==value)
		})
		return;
		$layer.alert('8999').yes(function(){

			//this.layer.alert(88)
			//this.msg(889)
			//this.close()
		})
		return;
		$layer.input('标--题', 4, 0, function(value, index){
			this.close();
		})
		return;
		var html=$templateCache.get('test.html').trim();
		html=$compile($(html))($this);
		$layer.open('add', null, null, [600,400])($this);
		return;
return $layer.confirm('????').yes(function(layer){
layer.close()
})
	$layer.alert(5).yes(function(e){
		alert(e)
	}).no(function(e){
		console.log(e.close)
		e.close()
	});
	}
//var load=$layer.load();
$http.get('/aeolus/index/amount').success(function(data){
	$this.data=data.data
//	load.close()
})
	}
</script>