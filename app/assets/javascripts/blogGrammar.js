bg = angular.module('bg', ['restangular', 'ui.router', 'ui.bootstrap'])


  .config(function($stateProvider, $urlRouterProvider) {

    $stateProvider

      .state('app', {
        url: '/',
        views: {
          'navbar': {
            templateUrl: 'templates/partials/navbar.html'
          },

          'header': {
            templateUrl: 'templates/partials/header.html',
          },

          'content': {
            templateUrl: 'templates/partials/content.html',
          },

          'footer': {
            templateUrl: 'templates/partials/footer.html'
          },

        },
      })



    $urlRouterProvider.otherwise('/');

  })


  // enable error handling
  .run(function($rootScope){
    $rootScope.$on("$stateChangeError", console.log.bind(console));
  });