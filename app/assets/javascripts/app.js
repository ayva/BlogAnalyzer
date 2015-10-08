var grandma = angular.module('grandma', ['restangular', 'ui.router', 'ui.bootstrap', 'chart.js'])


  .config(function($stateProvider, $urlRouterProvider) {

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

<<<<<<< HEAD
          'navbar':{
            templateUrl: 'templates/partials/navbar.html',
            controller: 'navbarCtrl'
          }
=======
>>>>>>> 56791aba2c51b50a5ec9884c6a4e06119b02a07f
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

<<<<<<< HEAD
          'navbar':{
            templateUrl: 'templates/partials/navbar.html',
            controller: 'navbarCtrl'
          }
=======
>>>>>>> 56791aba2c51b50a5ec9884c6a4e06119b02a07f
        }
      });




    $urlRouterProvider.otherwise('/');

  })


  // enable error handling
  .run(function($rootScope){
    $rootScope.$on("$stateChangeError", console.log.bind(console));
  });