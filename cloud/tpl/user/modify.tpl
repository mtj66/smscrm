<title>个人中心-修改资料</title>
<code>
      <main>
      <template data-path="'/public/header'" data-active="cloud"></template>
      <div id="right">
      <div class="panel panel-default">
     <!--  <div class="panel-heading"><h4 class="panel-title">实况</h4></div> -->
   <div class="panel-body">
    <input type="text" class="form-control form-control-inline" laydate="date" data-btns="confirm" data-min=-30 data-max=0 ng-model="today" data-format="yyyy-MM-dd">
    <select ng-init="org_id=0" ng-model="org_id" ng-options="item.org_id as item.org_name group by org_type[item.type] for item in org_list" class="form-control form-control-inline">
      <option value="">所有代理商</option>
    </select>
     <button type="button" class="btn btn-primary" ng-click="load()">查询</button>
   </div>
    <table class="table table-bordered">
      <thead>
        <tr>
          <th width="50">#</th>
          <th width="150">代理商</th>
          <th class="nowrap">站点</th>
          <th class="nowrap" width="100">当天完成</th>
          <th class="nowrap" width="100">当天发送</th>
          <th class="nowrap" width="100">当天好评率</th>
          <th class="nowrap" width="100">周期好评率</th>
          <th class="nowrap" width="80">操作</th>
        </tr>
      </thead>
      <tbody>
        <tr class="v-middle">
          <td>1</td>
          <td rowspan="2" class="v-middle">公司</td>
          <td>Otto</td>
          <td>0</td>
          <td>0</td>
          <td>3%</td>
          <td>22%</td>
          <td><a href="#">导出</a></td>
        </tr>
        <tr>
          <td>1</td>

          <td>Otto</td>
          <td>0</td>
          <td>0</td>
          <td>3%</td>
          <td>22%</td>
          <td>导出</td>
        </tr>
        <tr>
          <td colspan="3"></td>
          <td>0</td>
          <td>0</td>
          <td colspan="3"></td>
        </tr>
      </tbody>
    </table>
</div>
</div>
</main>
</code>
<style>
      
</style>
<script>
function($this, $http, $location){

$this.today=new Date().format('yyyy-MM-dd');


$this.load=function(){
  
  alert(laydate)
}
  //var load=layer.load();
  $this.org_type = {
    '0': '使用',
    '1': '签约'
  }
  $this.org_id=$location.$$search.org_id;
  $this.team_id = $location.$$search.team_id;
  $this.org_list=[{
    type: 1,
    org_id: 1,
    org_name:'1111'
  }, {
    type: 1,
    org_id: 1,
    org_name:'1111'
  }]
  $this.get_org_list = function(){
    $this.org_list=[];
    $http.get('/api/aeolus/get_org_list').success(function(data){
      $this.org_list=data;
      layer.close(load)
      $this.get_team_list($this.org_id);
    })
  }
  $this.get_team_list=function(org_id){
    if(!org_id)return $this.team_list=[];
  var load=layer.load();
    $http.get('/api/aeolus/get_team_list?org_id=%s'.sprintf(org_id)).success(function(data){
      $this.team_list=data;
      layer.close(load)
    })
  }
//$this.get_org_list()
}
</script>