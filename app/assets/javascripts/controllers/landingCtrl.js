grandma.controller('landingCtrl', ['$scope', 'Restangular', function($scope, Restangular) {

  $scope.landing = true;

  Restangular.all("authors").customGET('totalbloggers').then(function(response){
    $scope.TotalBloggers = response;
  });

  Restangular.all("posts").customGET('totalarticles').then(function(response){
    $scope.TotalArticles = response;
  });

  Restangular.all("posts").customGET('totalissues').then(function(response){
    $scope.TotalIssues = response;
  });

}]);