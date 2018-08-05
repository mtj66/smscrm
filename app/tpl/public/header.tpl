<code>
<nav class="navbar navbar-inverse navbar-fixed-top">
  <div class="container-fluid">
    <!-- Brand and toggle get grouped for better mobile display -->
    <div class="navbar-header">
      <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </button>
      <a class="navbar-brand" href="#" data-toggle="modal" data-target="#editbox">易企cms</a>
    </div>
    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
      <ul id="nav" class="nav navbar-nav">
        <li id="index" ng-class="{'active': $attr.active=='index'}"><a href="#">首页</a></li>
        <li id="Website"><a href="#">站点设置</a></li>
        <li id="Catelog"><a href="#">栏目管理</a></li>
        <li id="Content"><a href="#">内容管理</a></li>
        <li id="User"><a href="#">用户管理</a></li>
      </ul>
      <ul class="nav navbar-nav navbar-right">
        <li id="user" class="dropdown">
          <a href="#" class="dropdown-toggle" data-toggle="dropdown">
          	<i class="glyphicon glyphicon-user"></i>
          </a>
          <ul class="dropdown-menu">
            <li><a href="#">修改密码</a></li>
            <li><a href="#/login">注销登录</a></li>
          </ul>
        </li>
      </ul>
    </div><!-- /.navbar-collapse -->
  </div><!-- /.container-fluid -->

</nav>
</code>
<style>
  #ngview>main{
    padding-top: 51px;
  }
</style>
<script>
  $export(function($this) {
    
    // body...
  })
</script>