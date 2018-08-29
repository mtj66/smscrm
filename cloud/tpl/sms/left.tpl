<code>
<div id="left">
<ul class="nav nav-pills nav-stacked">
<li id="index" ng-repeat="item in menus" ng-class="{'active': item[0] == $attr.active}" ng-if="item[2]||(item[0]==$attr.active&&!item[2])">
<a href="#" ng-route="item[2]">{{item[1]}}</a>
</li>
</ul>
</div>
</code>
<script>
function($this) {
  $this.$set({
    menus:[
      ['index', '我的模板', 'index'],
      ['edit', '修改模板'],
      ['add', '添加模板', 'add'],
    ]
  }).$run(function(){

  });
}
</script>