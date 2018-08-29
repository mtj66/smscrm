<code>
<div style="width:300px;min-height:200px" ng-click="layer.close()">{{name}}111111111111</div>
</code>
<script>
function($this) {
	$this.$delay = function(layer){
		layer.yes(function(){
			layer.msg(88)
		}).no(function(){
			layer.msg(99)
		})
	}
}
</script>