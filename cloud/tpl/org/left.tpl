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
      ['index', '我的客户', 'index'],
      ['edit', '修改客户'],
      ['add', '添加客户', 'add'],
      ['removed', '已删除', 'removed'],
    ]
  }).$run(function(){

  });
}
</script>