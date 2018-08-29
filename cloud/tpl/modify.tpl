<code>
	<form name="modify" action="/aeolus/user/modify">
  <div class="form-group">
  <input type="password" class="form-control" required name="password" ng-model="modify.$$data.password" placeholder="旧密码">
  </div>
  <div class="form-group">
  <input type="password" class="form-control" required name="password2" ng-model="modify.$$data.password2"  placeholder="新密码">
  </div>
  <div class="form-group">
  <input type="password" class="form-control" required name="password22" ng-model="modify.$$data.password22" placeholder="确认新密码">
  </div>
    </form>
</code>
<script>
function($this) {
	$this.$delay = function(layer){
		layer.yes(function(){
			var form = $this.$$_modify;
			if(form.$$submited)return;
			if(form.$invalid)return layer.msg('密码不能为空');
			var load=layer.load();
        	form.$submit(function(data){
          		layer.msg(data.msg, load.close, function(){
          			layer.close.when(200==data.code);
          		});
        	}, 
        	function(){
      			layer.msg('网络异常', load.close);
    		});
		});
	}
}
</script>