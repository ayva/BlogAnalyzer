var grandma = angular.module('grandma', ['restangular', 'ui.router', 'ui.bootstrap', 'chart.js'])


  .config(function($stateProvider, $urlRouterProvider) {

    $stateProvider

      .state('main', {
        url: '/',

        views: {
          'navbar': {
            templateUrl: 'templates/partials/navbar',
            controller: 'landingCtrl',
          },

          '': {
            templateUrl: 'templates/welcome',
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
          },

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
          },

        }
      });



    $urlRouterProvider.otherwise('/');

  })


  // enable error handling
  .run(function($rootScope){
    $rootScope.$on("$stateChangeError", console.log.bind(console));
  });