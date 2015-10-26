

var grandma = angular.module('grandma', ['restangular', 'ui.router', 'ui.bootstrap', 'chart.js', 'metatags', 'angularSmoothscroll'])
  .config(['RestangularProvider', function(RestangularProvider) {

    RestangularProvider.setBaseUrl('/api/v1');
    RestangularProvider.setRequestSuffix('.json');
    RestangularProvider.setDefaultHttpFields({
      "content-type": "application/json"
    });
  }])

  .config([ '$stateProvider', '$urlRouterProvider', function($stateProvider, $urlRouterProvider){

    $stateProvider
      .state('main', {
        url: '/',

        views: {
          'navbar': {

            templateUrl: 'templates/partials/navbar.html',
            controller: 'navbarCtrl'

          },

          '': {
            templateUrl: 'templates/welcome',
            controller: 'landingCtrl'
          },

        },
      })


      .state('leaderboards', {
        url: '/leaderboards',
        views: {
          'navbar':{
            templateUrl: 'templates/partials/navbar',
            controller: 'navbarCtrl'
          },

          '':{
            templateUrl: 'templates/leaderboards',
            controller: 'boardsCtrl'
          }

        }

      })


      .state('blogger', {
        url: '/blogger/:username?id',
        views: {
          'navbar':{
            templateUrl: 'templates/partials/navbar',
            controller: 'navbarCtrl'
          },

          '':{
            templateUrl: 'templates/blogger',
            controller: 'bloggerCtrl'
          }
        }
      })
      .state('about', {
        url: '/about',
        views: {
          'navbar':{
            templateUrl: 'templates/partials/navbar',
            controller: 'navbarCtrl'
          },

          '':{
            templateUrl: 'templates/about'
            
          }
        }
      });




    $urlRouterProvider.otherwise('/');

  }])


  // enable error handling
  .run([ '$rootScope', function($rootScope){
    $rootScope.$on("$stateChangeError", console.log.bind(console));
  }]);
