<code>
<div id="left">
<div class="panel-group" id="{{$classid}}_left">
	<div class="panel panel-success">
    <div class="panel-heading">
      <h4 class="panel-title">
        <a data-toggle="collapse" data-parent="#{{$classid}}_left" data-target="#{{$classid}}_left_11" href="#">
          已签约
      	<span class="badge pull-right">9</span>
        </a>
      </h4>
    </div>

    <div id="{{$classid}}_left_11" class="panel-collapse collapse in">
      <ul class="list-group">
    <li class="list-group-item" ng-repeat="org in org_list" ng-if="org.status>0">{{org.org_name}}</li>
  </ul>
    </div>
  </div>

<div class="panel panel-default">
      <div class="panel-heading" role="tab" id="collapseListGroupHeading1">
        <h4 class="panel-title">
          <a class="" role="button" data-toggle="collapse" data-target="#collapseListGroup1" aria-expanded="true" aria-controls="collapseListGroup1">
            Collapsible list group
          </a>
        </h4>
      </div>
      <div id="collapseListGroup1" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="collapseListGroupHeading1" aria-expanded="true">
        <ul class="list-group">
          <li class="list-group-item">Bootply</li>
          <li class="list-group-item">One itmus ac facilin</li>
          <li class="list-group-item">Second eros</li>
        </ul>
        <div class="panel-footer">Footer</div>
      </div>
    </div>

</div>



</div>
</code>
<script>
function($this) {

	$this.$set({
		menus:[
			['index', '列表'],
			['add', '添加'],
		]
	}).$run(function(){

	});
}
</script>