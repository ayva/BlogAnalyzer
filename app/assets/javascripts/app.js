var grandma = angular.module('grandma', ['restangular', 'ui.router', 'ui.bootstrap'])


  .config(function($stateProvider, $urlRouterProvider) {

    $stateProvider

      .state('main', {
        url: '/',

        views: {
          'navbar': {
            templateUrl: 'templates/partials/navbar.html',
            controller: 'landingCtrl'
          },

          '': {
            templateUrl: 'templates/welcome.html'
          }


        },
      })


      .state('leaderboards', {
        url: '/leaderboards',
        views: {
          '':{
            templateUrl: 'templates/leaderboards.html',
            controller: 'boardsCtrl'
          },

          'navbar':{
            templateUrl: 'templates/partials/navbar.html'
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
            templateUrl: 'templates/partials/navbar.html'
          }
        }
      });



    $urlRouterProvider.otherwise('/');

  })


  // enable error handling
  .run(function($rootScope){
    $rootScope.$on("$stateChangeError", console.log.bind(console));
  });