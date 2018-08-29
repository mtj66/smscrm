

require.config({
	baseUrl: './',
	paths: {
		'css': 'lib/require-css.min',
		'jquery':['https://cdn.bootcss.com/jquery/1.9.1/jquery.min', 'static/js/jquery.min'],
		'bootstrap': 'static/js/bootstrap.min',
		'respond': 'static/js/respond.min',
		'layer': 'static/layer/layer',
		'layer-css': 'static/layer/theme/default/layer',
		'laydate': 'static/laydate/laydate',
		'laydate-css': 'static/laydate/theme/default/laydate'
	},
	shim: {
		'bootstrap': ['respond'],
		'laydate': ['css!laydate-css'],
		'layer': ['css!layer-css']
	}
})
$.getStyle(['static/css/style.css']);
require(['bootstrap', 'layer', 'laydate'], function(undefined, layer, laydate){
	window.layer = window.layer || layer;
	window.laydate = window.laydate || laydate;
	var app = angular.module('app', ['ngApp']);
	/*app.directive('laydate', function(){
		return function(scope, element, attr){
			laydate.render({
  				elem: element[0],
  				type: attr.laydate,
  				min: parseInt(attr.min) || -365,
  				max: parseInt(attr.max) || 365,
  				showBottom: !!attr.btns,
  				btns: [attr.btns],
  				done: function(){
  					scope.$apply.to(function(){
						scope[attr.ngModel] = element.val();
  					})
  				}
			});
		}
	})*/

	app.run(function($root, $location, $http, $layer){
      $root.init = function(success, search){
      	$root.init.success = success;
      	$root.init.search = search;
      	if($root.init.ing)return;
      		$root.$emit('$routeChangeWait', $root.init.ing = true);
            $http.get('/aeolus/user/init').success(function(data){
            	$root.$emit('$routeChangeWait', $root.init.ing=false);
	              if(200==data.code){
	                    $root.user = data.data;
	                    if($root.init.success)$location.path($root.init.success).search($root.init.search||{});
	              }else{
	              		$layer.msg(data.msg);
	              		delete $root.user;
	                    $location.path('/user/login').search({});
	              }
            }).error(function(){
            	$root.$emit('$routeChangeWait', $root.init.ing=false);
            	$layer.msg('网络错误');
            	$location.path('/user/login').search({});
            })
      }
      $root.login=function(form){
            var load=$layer.load();
            form.$submit(function(data){
                  load.close();
                  if(200==data.code){
                    $root.init('/index');
                  }else{
                  	$layer.msg(data.msg);
                  }
            }, function(){
            	load.close();
            	$layer.msg('网络错误')
            	$location.path('/user/login').search({});
            })
      }
      $root.logout=function(){
      	$layer.confirm('即将注销本次登录').yes(function(layer){
      		$http.get('/aeolus/user/logout').success(function(data){
	        layer.msg(data.msg, layer.close);
	      	if(200==data.code){
	      		$location.path('/user/login').search({});
		       // window.location.reload();
		      }
		    }).error(function(){
		    	$layer.msg('网络错误')
		    	$location.path('/user/login').search({});
		    })
      	});
	  }
	  $root.init();
		$root.$on('$routeChangeError', function(){
			$location.path('/msg/404').search({form: $location.$$path})
		})
		$root.$on('$templateParseError', function(){
			console.log(arguments)
		})
	});
angular.run(app);
})
