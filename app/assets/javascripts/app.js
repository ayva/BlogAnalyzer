var grandma = angular.module('grandma', ['restangular', 'ui.router', 'ui.bootstrap'])


  .config(function($stateProvider, $urlRouterProvider) {

    $stateProvider

      .state('main', {
        url: '/',
        controller: 'landingCtrl',
        views: {
          'navbar': {
            templateUrl: 'templates/partials/navbar-main.html',
            controller: 'navbarCtrl'
          },

          '': {
            templateUrl: 'templates/welcome.html'
          }


        },
      })
      .state('leaderboards', {
        url: '/leaderboards',
        
        //templateUrl: 'templates/leaderboards.html'
        views: {
          '':{
            templateUrl: 'templates/leaderboards.html',
            controller: 'boardsCtrl'
          },

          'navbar':{
            templateUrl: 'templates/partials/navbar.html',
            controller: 'navbarCtrl'
          }
        }
        
      })
      .state('blogger', {
        url: '/blogger/:username',
        views: {
          '':{
            templateUrl: 'templates/blogger.html',
            controller: 'bloggerCtrl'
          },

          'navbar':{
            templateUrl: 'templates/partials/navbar.html',
            controller: 'navbarCtrl'
          }
        }
      });




    $urlRouterProvider.otherwise('/');

  })


  // enable error handling
  .run(function($rootScope){
    $rootScope.$on("$stateChangeError", console.log.bind(console));
  });