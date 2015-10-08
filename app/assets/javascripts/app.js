var grandma = angular.module('grandma', ['restangular', 'ui.router', 'ui.bootstrap', 'chart.js'])
  

  .config(['RestangularProvider', function(RestangularProvider) {

    RestangularProvider.setBaseUrl('/api/v1');
    RestangularProvider.setRequestSuffix('.json');
    RestangularProvider.setDefaultHttpFields({
      "content-type": "application/json"
    });

    // RestangularProvider.setResponseExtractor(function(response, operation){
    //   return response;
    // });
  }])

  .config(function($stateProvider, $urlRouterProvider){
    $stateProvider
      .state('main', {
        url: '/',

        views: {
          'navbar': {

            templateUrl: 'templates/partials/navbar-main.html',
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
            templateUrl: 'templates/partials/navbar'
          },

          '':{
            templateUrl: 'templates/leaderboards',
            controller: 'boardsCtrl'
          }

        }

      })


      .state('blogger', {
        url: '/bloggers/:username',
        views: {
          'navbar':{
            templateUrl: 'templates/partials/navbar'
          },

          '':{
            templateUrl: 'templates/blogger',
            controller: 'bloggerCtrl'
          }
        }
      });




    $urlRouterProvider.otherwise('/');

  })


  // enable error handling
  .run(function($rootScope){
    $rootScope.$on("$stateChangeError", console.log.bind(console));
  });