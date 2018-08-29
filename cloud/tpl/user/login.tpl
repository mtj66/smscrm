<title>蜂云台登录</title>
<code>
	<main>
	<div class="login">
	<div class="panel panel-info">
      <div class="panel-heading text-center">蜂云台登录</div>
      <div class="panel-body">
      	<form action="/aeolus/index/login" method="post" name="form" ng-submit="login(form)">
      		<div class="form-group">
      		<label ng-click="debug(form)">帐号</label>
      		<input type="text" class="form-control" name="mobile" required ng-model="form.$$data.username">
      		</div>
      		<div class="form-group">
      		<label>密码</label>
      		<input type="password" class="form-control" required name="password" ng-model="form.$$data.password">
      		</div>
      		<div class="form-group text-right">
      			<button type="submit" class="btn btn-success" ng-disabled="form.$invalid">登录</button>
      		</div>
      	</form>
      </div>

    </div>
</div>
</main>
</code>
<style>
      #ngview>main.$this{
            display: none;
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
function($root, $this, $location, $http){
      $this.debug=function(form){
            console.log(form, form.$parent)
      }
      $this.$run(function(){

            $this.$element.fadeIn();
           // $root.init(true);
      })
$root.init('/index');
}
</script>