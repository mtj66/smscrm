<code>
<div id="left">
<ul class="nav nav-pills nav-stacked">
<li id="index" ng-repeat="item in menus" ng-class="{'active': item[0] == $attr.active}">
<a href="#" ng-route="item[0]">{{item[1]}}</a>
</li>
</ul>
</div>
</code>
<script>
$export(function($this) {
	$this.$set({
		menus:[
			['index', '列表'],
			['add', '添加'],
		]
	}).$run(function(){

	});
})
</script>