
require.config({
	baseUrl: './',
	paths: {
		'bootstrap': 'static/js/bootstrap.min',
		'respond': 'static/js/respond.min'
	},
	shim: {
		bootstrap: ['respond']
	}
})
$.getStyle('static/css/style.css');
require(['bootstrap'], function(){
	angular.module('app', ['ngApp']).run(function($root, $location){
		$root.$on('$routeChangeError', function(){
			$location.path('/message/404').search({form: $location.$$path})
		})
		$root.$on('$templateParseError', function(){
			console.log(arguments)
		})
	})
	angular.run('app');
})