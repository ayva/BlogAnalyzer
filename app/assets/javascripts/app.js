

var grandma = angular.module('grandma', ['restangular', 'ui.router', 'ui.bootstrap', 'chart.js','metatags','ngRoute'])
  //Custom colors for Chart js
  // .config(function(ChartJsProvider){
  //   ChartJsProvider.setOptions({
  //     colours: ['#74B8F3','#ECEDF5', '#A3D864', '#B7ABA9', , '#5B5A79', '#E199AD', '#87A269']

  //   });
  // })
  // .config(['$routeProvider','MetaTagsProvider', function($routeProvider, MetaTagsProvider) {
  //   MetaTagsProvider.when('/blogger/:username?id',{":twitter:card": 'summary_large_image', "twitter:site": "@grandmacheck", "twitter:title" : "My score is 99", "twitter:image:src" : "http://www.upfyre.com/wp-content/uploads/2014/02/puppies-and-kittens-pictures.jpg", "twitter:domain": "http://grandma.space/"});
  // }])
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
      });




    $urlRouterProvider.otherwise('/');

  }])


  // enable error handling
  .run([ '$rootScope', function($rootScope){
    $rootScope.$on("$stateChangeError", console.log.bind(console));
  }]);
