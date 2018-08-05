<code>
<div class="system-message">
<h1>:(</h1>
<p class="message">页面错误！请稍后再试~</p>
<p class="jump" ng-if="$location.$$search.path">
页面自动 <a ng-route="$location.$$search.path">跳转</a> 等待时间： <b ng-bind="waitSecond"></b>
</p>
</div>
</code>
<style>
*{ padding: 0; margin: 0; }
body{ background: #fff; font-family: '微软雅黑'; color: #333; font-size: 16px; }
.system-message{ padding: 24px 48px; }
.system-message h1{ font-size: 100px; font-weight: normal; line-height: 120px; margin-bottom: 12px; }
.system-message .jump{ padding-top: 10px}
.system-message .jump a{ color: #333;}
.system-message .message{ line-height: 1.8em; font-size: 36px }
.system-message .detail{ font-size: 12px; line-height: 20px; margin-top: 12px; }
</style>
<script>
	$export(function($this, $location, $timeout){
		function wait(){
			console.log($location.path)
			$this.$apply.to(function(){
				if($this.waitSecond == 0)return wait.timeoff($location.path($location.$$search.path).search({}))
				$this.waitSecond ? $this.waitSecond-- : $this.waitSecond = 5;
			$this.setTitle($this.waitSecond)
			})
		}
		if($location.$$search.path)wait.timeout()
		//$location.path('/success').search('id=99')
		//$this.info = $location.$$search.info || '页面错误！请稍后再试～'
	})
</script>