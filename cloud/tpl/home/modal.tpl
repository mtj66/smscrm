<code>
<div class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title">高德地图</h4>
      </div>
      <div class="modal-body">
        <div id="amap"></div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
        <button type="button" class="btn btn-primary" ng-click="submit()">确定</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div>
</code>
<style>
	.$this #amap{
		display: block;
		position: relative;
		height: 500px;
    border:1px solid red;
	}
	.$this #amap:empty::before{
		content: '正在加载地图'
	}
</style>
<script>
$export(function($this) {
  $this.submit = function(){
  if(!confirm('?'))return;
$this.$element.modal('hide')
  }
$this.$element.on('shown.bs.modal', function () {

  $this.$emit('$routeChangeWait', true)
  $this.$emit('$routeChangeLock', true);
	require(['http://webapi.amap.com/maps?v=1.4.6'], function(){
		var map = new AMap.Map('amap', {
        	resizeEnable: true,
        	zoom:11,
        	center: [116.397428, 39.90923]
    	});
     map.on('complete', function() { 
     $this.$emit('$routeChangeWait', false)
   })
   
	})
}).on('hidden.bs.modal', function(e){
   $this.$emit('$routeChangeWait', false)
      $this.$emit('$routeChangeLock', false)
	$('#amap').empty().removeAttr('class').removeAttr('style')
})
})
</script>