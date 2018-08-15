<code>
	<main>
	<div class="login">
	<div class="panel panel-info">
      <div class="panel-heading text-center">管理员登录</div>
      <div class="panel-body">
      	<form action="">
      		<div class="form-group">
      		<label>用户名</label>
      		<input type="text" class="form-control">
      		</div>
      		<div class="form-group">
      		<label>密码</label>
      		<input type="text" ng-password class="form-control">
      		</div>
                  <div class="form-group">
                  <label>验证码</label>
                  <input type="text" class="form-control">
                  </div>
      		<div class="form-group text-right">
      			<button type="button" class="btn btn-primary" ng-click="$location.path('/home/index')">提交</button>
      		</div>
      	</form>
      </div>

    </div>
</div>
</main>
</code>
<style>
      #ngview>main.$this{
            background: #333;
      }
	#ngview>main.$this>div.login{
		position: relative;
		min-width: 0;
		width: 330px;
            height: 340px;
		margin: auto;
            top: 50%;
            margin-top:-180px;
	}
</style>
<script>
$export(function($this){
	$this.$apply.to()
}, '登录')
</script>