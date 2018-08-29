<code>
<nav class="navbar navbar-inverse navbar-fixed-top">
  <div class="container-fluid">
    <!-- Brand and toggle get grouped for better mobile display -->
    <div class="navbar-header">
      <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#nav" aria-expanded="false">
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </button>
      <a class="navbar-brand" href="#" data-toggle="modal" data-target="#editbox">
        蜂云台<sup><small>beta2</small></sup>
      </a>
    </div>
    <div class="collapse navbar-collapse" id="nav">
      <ul class="nav navbar-nav">
        <li id="index"><a href="#/index">首页</a></li>
        <li id="cloud"><a href="#/cloud">工作台</a></li>
        <li id="org"><a href="#/org/index">客户管理</a></li>
        <li id="sms"><a href="#/sms/index">短信管理</a></li>
        <li id="bill"><a href="#/sms/index">账单</a></li>
      </ul>
      <ul class="nav navbar-nav navbar-right">
        <li id="user" class="dropdown">
          <a href="#" class="dropdown-toggle" data-toggle="dropdown">
          	<i class="glyphicon glyphicon-user"></i>
            {{user.nick_name}}
          </a>
          <ul class="dropdown-menu">
            <li><a href="#" ng-click="modify_handle()">修改密码</a></li>
            <li><a href="#" ng-click="logout()">注销登录</a></li>
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
function($this, $location, $http, $layer) {
  $this.test=function(form){
    console.log(form)
  }
  $this.modify_handle = function(){
    $layer.open('/modify', '修密码', ['确定'], [310, 275])($this);
  }
    $this.$element.find('li#'+$this.$attr.active).addClass('active')
    // body...
  }
</script>