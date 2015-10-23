grandma.controller('landingCtrl', ['$scope', 'storage', '$timeout', function($scope, storage, $timeout) {

  $scope.landing = true;
  storage.getTotals();
  $scope.totals = storage.totals;

  $scope.checkBlog = function(){
    $timeout(function(){
      storage.formSubmitted.b = false; },
      4000);
    storage.checkBlog($scope.blogUrl);
  };

  // Initialize input field model
  $scope.blogUrl = "https://medium.com/@samplebloggername";
  $scope.formSubmitted = storage.formSubmitted;
  $scope.blogSubmitted = storage.checkBlogReply;




}]);